#using scripts\common\utility;
#using scripts\cp_mp\pet_watch;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;

#namespace pet_watch;

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x669
// Size: 0x343
function init()
{
    if ( !isdefined( level.petconsts ) && !utility::iscp() )
    {
        level thread autofeeder();
    }
    
    level.petconsts = [];
    
    for ( i = 0; true ; i++ )
    {
        phasenumber = tablelookupbyrow( "mp/petWatchTable.csv", i, 1 );
        
        if ( !isdefined( phasenumber ) || phasenumber == "" )
        {
            break;
        }
        
        phasenumber = int( phasenumber );
        conststruct = spawnstruct();
        conststruct.phasetime = int( tablelookupbyrow( "mp/petWatchTable.csv", i, 2 ) );
        conststruct.bonustimemax = int( tablelookupbyrow( "mp/petWatchTable.csv", i, 3 ) );
        conststruct.boredomrate = int( tablelookupbyrow( "mp/petWatchTable.csv", i, 4 ) );
        conststruct.dirtyrate = int( tablelookupbyrow( "mp/petWatchTable.csv", i, 5 ) );
        conststruct.unrulyrate = int( tablelookupbyrow( "mp/petWatchTable.csv", i, 6 ) );
        conststruct.hungryrate = int( tablelookupbyrow( "mp/petWatchTable.csv", i, 7 ) );
        conststruct.bonustype = tablelookupbyrow( "mp/petWatchTable.csv", i, 8 );
        conststruct.boredstart = int( tablelookupbyrow( "mp/petWatchTable.csv", i, 9 ) );
        conststruct.dirtystart = int( tablelookupbyrow( "mp/petWatchTable.csv", i, 10 ) );
        conststruct.unrulystart = int( tablelookupbyrow( "mp/petWatchTable.csv", i, 11 ) );
        conststruct.hungrystart = int( tablelookupbyrow( "mp/petWatchTable.csv", i, 12 ) );
        level.petconsts[ phasenumber ] = conststruct;
    }
    
    level.petobjectivefilter = [];
    level.petobjectivefilter[ #"assist" ] = 1;
    level.petobjectivefilter[ #"longshot" ] = 1;
    level.petobjectivefilter[ #"pointblank" ] = 1;
    level.petobjectivefilter[ #"headshot" ] = 1;
    level.petobjectivefilter[ #"avenger" ] = 1;
    level.petobjectivefilter[ #"save_teammate" ] = 1;
    level.petobjectivefilter[ #"posthumous" ] = 1;
    level.petobjectivefilter[ #"revenge" ] = 1;
    level.petobjectivefilter[ #"firstblood" ] = 1;
    level.petobjectivefilter[ #"comeback" ] = 1;
    level.petobjectivefilter[ #"backfire" ] = 1;
    level.petobjectivefilter[ #"quad_feed" ] = 1;
    level.petobjectivefilter[ #"first_place_kill" ] = 1;
    level.petobjectivefilter[ #"gun_butt" ] = 1;
    level.petobjectivefilter[ #"mode_x_wipeout" ] = 1;
    level.petobjectivefilter[ #"grenade_double" ] = 1;
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x9b4
// Size: 0x77
function autofeeder()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player.petwatch ) )
            {
                player feedaction();
            }
        }
        
        wait 1;
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 2
// Checksum 0x0, Offset: 0xa33
// Size: 0x3f
function setstate( state, forceanim )
{
    self setclientomnvar( "ui_pet_watch_action", state * -1 );
    self.petwatch.phase = state;
    updateuistate();
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 1
// Checksum 0x0, Offset: 0xa7a
// Size: 0xc8
function doaction( action )
{
    switch ( action )
    {
        case 1:
            growpet();
            break;
        case 2:
            feedaction();
            break;
        case 3:
            thread updatepetstatesincelastupdate();
            break;
        case 4:
            scripts\cp_mp\pet_watch::initpet( 1 );
            break;
        case 6:
            scripts\cp_mp\pet_watch::initpet( 1, "pet_black" );
            break;
        case 5:
            scripts\cp_mp\pet_watch::initpet( 1, "pet_turbo" );
            break;
        case 7:
            scripts\cp_mp\pet_watch::initpet( 1, "pet_turbo", 1 );
            break;
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0xb4a
// Size: 0x52
function growpet()
{
    targettime = level.petconsts[ self.petwatch.phase ].phasetime;
    self.petwatch.growthtime = targettime;
    debugsetlasttime( targettime );
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0xba4
// Size: 0xc
function onjoinspectators()
{
    self.petwatch = undefined;
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0xbb8
// Size: 0x235
function turbopetchallengewatcher()
{
    self endon( "disconnect" );
    self notify( "turboPetChallengeWatcher()" );
    self endon( "turboPetChallengeWatcher()" );
    
    for ( ;; )
    {
        self waittill( "luinotifyserver", channel, val );
        
        if ( channel == "petwatch_turbo_grow" )
        {
            switch ( val )
            {
                case 1:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_egg" );
                    break;
                case 2:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_baby" );
                    break;
                case 3:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_child" );
                    break;
                case 4:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_teen_a" );
                    break;
                case 5:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_teen_b" );
                    break;
                case 6:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_skunk" );
                    break;
                case 7:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_bear" );
                    break;
                case 8:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_mantis" );
                    break;
                case 9:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_trex" );
                    break;
                case 10:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_octopus" );
                    break;
                case 11:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_fox" );
                    break;
                case 12:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_secret1" );
                    break;
                case 13:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_secret2" );
                    break;
                case 14:
                    self reportchallengeuserevent( "collect_item", "petwatch_turbo_secret3" );
                    break;
                default:
                    break;
            }
            
            continue;
        }
        
        if ( channel == "petwatch_turbo_state" )
        {
            self setclientomnvar( "ui_pet_watch_state", val );
        }
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 3
// Checksum 0x0, Offset: 0xdf5
// Size: 0x86f
function initpet( forceinit, var_f14d8f0fa461ea50, skipreset )
{
    if ( !isdefined( self.petwatch ) )
    {
        self setclientomnvar( "ui_pet_watch_state", 0 );
        self.petwatch = spawnstruct();
        self.petwatch.petwatchtype = var_f14d8f0fa461ea50;
        
        if ( var_f14d8f0fa461ea50 == "pet_black" )
        {
            self.petwatch.playerdatafield = "petWatchDataBlack";
        }
        else if ( var_f14d8f0fa461ea50 == "pet_turbo" )
        {
            self.petwatch.playerdatafield = "petWatchDataTurbo";
            thread turbopetchallengewatcher();
        }
        else
        {
            self.petwatch.playerdatafield = "petWatchData";
        }
        
        if ( forceinit && !istrue( skipreset ) )
        {
            self setclientomnvar( "ui_pet_watch_action", -1 );
            setphase( 0 );
        }
        else
        {
            setphase( self getplayerdata( "common", self.petwatch.playerdatafield, "phase" ) );
        }
    }
    else
    {
        if ( forceinit )
        {
            self setclientomnvar( "ui_pet_watch_action", -1 );
            setphase( 0 );
        }
        
        if ( self.petwatch.phase == 0 )
        {
            resetpet( 1 );
        }
        
        if ( !istrue( forceinit ) )
        {
            return;
        }
    }
    
    self.petwatch.debugtimedelta = 0;
    
    if ( self.petwatch.phase == 0 )
    {
        resetpet( 1 );
    }
    else
    {
        self.petwatch.bonustime = 0;
        self.petwatch.bonustimeapplied = 0;
        self.petwatch.lastupdatetime = self getplayerdata( "common", self.petwatch.playerdatafield, "lastUpdateTime" );
        self.petwatch.bored = self getplayerdata( "common", self.petwatch.playerdatafield, "boredDmg" );
        self.petwatch.dirty = self getplayerdata( "common", self.petwatch.playerdatafield, "dirtyDmg" );
        self.petwatch.unruly = self getplayerdata( "common", self.petwatch.playerdatafield, "unrulyDmg" );
        self.petwatch.hungry = self getplayerdata( "common", self.petwatch.playerdatafield, "hungryDmg" );
        self.petwatch.bonustimeapplied = self getplayerdata( "common", self.petwatch.playerdatafield, "bonusTime" );
        self.petwatch.charged = self getplayerdata( "common", self.petwatch.playerdatafield, "charged" );
        self.petwatch.growthtime = self getplayerdata( "common", self.petwatch.playerdatafield, "growthTime" );
        self.petwatch.reproductionstreak = self getplayerdata( "common", self.petwatch.playerdatafield, "reproductionStreak" );
        self.petwatch.damage = self getplayerdata( "common", self.petwatch.playerdatafield, "damage" );
        self.petwatch.lastbored = self.petwatch.bored;
        self.petwatch.lastdirty = self.petwatch.dirty;
        self.petwatch.lastunruly = self.petwatch.unruly;
        self.petwatch.lasthungry = self.petwatch.hungry;
        var_3f302e5360a8fcec = self.petwatch.reproductionstreak % 10;
        growthfraction = var_3f302e5360a8fcec / 10;
        self.petwatch.growthtime += growthfraction;
        self.petwatch.bonustimeapplied += growthfraction;
        self.petwatch.reproductionstreak = int( self.petwatch.reproductionstreak / 10 );
        self.petwatch.unicornpoints = self getplayerdata( "common", self.petwatch.playerdatafield, "orcaPoints" );
        self.petwatch.vampirepoints = self getplayerdata( "common", self.petwatch.playerdatafield, "apachePoints" );
        self.petwatch.dragonpoints = self getplayerdata( "common", self.petwatch.playerdatafield, "dragonPoints" );
        self.petwatch.bonuskillstreakcharge = self getplayerdata( "common", self.petwatch.playerdatafield, "killstreakCharge" );
        self.petwatch.bonuswingamescharge = self getplayerdata( "common", self.petwatch.playerdatafield, "winGamesCharge" );
        self.petwatch.bonusobjectivescorecharge = self getplayerdata( "common", self.petwatch.playerdatafield, "objectiveScoreCharge" );
        self.petwatch.bonuskillscharge = self getplayerdata( "common", self.petwatch.playerdatafield, "killsCharge" );
        self.petwatch.topkillstreakcharge = self getplayerdata( "common", self.petwatch.playerdatafield, "topKillstreakCharge" );
        self.petwatch.nukecharge = self getplayerdata( "common", self.petwatch.playerdatafield, "nukeCharge" );
        self.petwatch.wingamestop3 = self getplayerdata( "common", self.petwatch.playerdatafield, "winGamesTop3" );
        self.petwatch.plantscharge = self getplayerdata( "common", self.petwatch.playerdatafield, "plantsCharge" );
        self.petwatch.executionscharge = self getplayerdata( "common", self.petwatch.playerdatafield, "executionsCharge" );
        self.petwatch.objectivescorecharge = 0;
        self.petwatch.killstreakcharge = 0;
        self.petwatch.wingamescharge = 0;
        self.petwatch.killscharge = 0;
        self.petwatch.lasthungryscore = 0;
        self.petwatch.lastboredscore = 0;
        self.petwatch.lastunrulyscore = 0;
        self.petwatch.lastdirtyscore = 0;
    }
    
    updateuistate();
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 1
// Checksum 0x0, Offset: 0x166c
// Size: 0x22
function gethours( time )
{
    var_30fecbc8f289eab = 3600;
    return int( time / var_30fecbc8f289eab );
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 1
// Checksum 0x0, Offset: 0x1697
// Size: 0x86
function gethourtime( systime )
{
    var_30fecbc8f289eab = 3600;
    var_663ed12a0431a739 = 24 * var_30fecbc8f289eab;
    var_e63dd21bf38dc550 = var_663ed12a0431a739 * 365.25;
    years = systime / int( var_e63dd21bf38dc550 );
    days = int( systime % var_e63dd21bf38dc550 ) / int( var_663ed12a0431a739 );
    hours = int( systime % var_663ed12a0431a739 ) / int( var_30fecbc8f289eab );
    return int( hours );
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x1726
// Size: 0x193
function testtiming()
{
    now = getsystemtime();
    var_bf86f2c24693e09b = now - 300;
    var_bf81cfc2468d6acb = now - 7200;
    var_c855b34135c24f2b = now - 3480;
    var_f3362e4154f3dec0 = now - 3720;
    var_8ebe16410bb40212 = now - 43200;
    yesterday = now - 86400;
    var_58c1838db2a6595a = yesterday - 43200;
    var_f36bd4bf83ff5bd = now - 604800;
    var_85e9a613d1c4c14f = hoursawakesincelastupdate( now, var_bf86f2c24693e09b ).hours;
    var_ad83e480f7b61231 = hoursawakesincelastupdate( now, var_c855b34135c24f2b ).hours;
    var_24edf68034edb3a8 = hoursawakesincelastupdate( now, var_f3362e4154f3dec0 ).hours;
    var_9c51c091db48ab9f = hoursawakesincelastupdate( now, var_bf81cfc2468d6acb ).hours;
    var_9e33fd315e72164a = hoursawakesincelastupdate( now, var_8ebe16410bb40212 ).hours;
    var_f60fc0867426749e = hoursawakesincelastupdate( now, yesterday ).hours;
    var_39b990d611d4821f = hoursawakesincelastupdate( now, var_58c1838db2a6595a ).hours;
    var_47ccd2ec26d9d794 = hoursawakesincelastupdate( now, var_f36bd4bf83ff5bd ).hours;
    winning = 1;
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x18c1
// Size: 0x82d
function printplayerdatastats()
{
    /#
        phase = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x26>" );
        lastupdatetime = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x2f>" );
        bored = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x41>" );
        dirty = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x4d>" );
        unruly = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x59>" );
        hungry = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x66>" );
        bonustimeapplied = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x73>" );
        charged = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x80>" );
        growthtime = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x8b>" );
        reproductionstreak = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x99>" );
        damage = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:xaf>" );
        unicornpoints = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:xb9>" );
        vampirepoints = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:xc7>" );
        dragonpoints = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:xd7>" );
        killstreakcharge = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:xe7>" );
        wingamescharge = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:xfb>" );
        objectivescorecharge = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x10d>" );
        killscharge = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x125>" );
        topkillstreakcharge = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x134>" );
        nukecharge = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x14b>" );
        wingamestop3 = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x159>" );
        plantscharge = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x169>" );
        executionscharge = self getplayerdata( "<dev string:x1c>", self.petwatch.playerdatafield, "<dev string:x179>" );
        println( "<dev string:x18d>" );
        println( "<dev string:x19b>" + self.petwatch.phase );
        println( "<dev string:x1a9>" + self.petwatch.lastupdatetime );
        println( "<dev string:x1c0>" + self.petwatch.bored );
        println( "<dev string:x1ce>" + self.petwatch.dirty );
        println( "<dev string:x1dc>" + self.petwatch.unruly );
        println( "<dev string:x1eb>" + self.petwatch.hungry );
        println( "<dev string:x1fa>" + self.petwatch.bonustimeapplied );
        println( "<dev string:x213>" + self.petwatch.charged );
        println( "<dev string:x223>" + self.petwatch.growthtime );
        println( "<dev string:x236>" + self.petwatch.reproductionstreak );
        println( "<dev string:x251>" + self.petwatch.damage );
        println( "<dev string:x260>" + self.petwatch.unicornpoints );
        println( "<dev string:x276>" + self.petwatch.vampirepoints );
        println( "<dev string:x28c>" + self.petwatch.dragonpoints );
        println( "<dev string:x2a1>" + self.petwatch.killstreakcharge );
        println( "<dev string:x2ba>" + self.petwatch.wingamescharge );
        println( "<dev string:x2d1>" + self.petwatch.objectivescorecharge );
        println( "<dev string:x2ee>" + self.petwatch.killscharge );
        println( "<dev string:x302>" + self.petwatch.topkillstreakcharge );
        println( "<dev string:x31e>" + self.petwatch.nukecharge );
        println( "<dev string:x331>" + self.petwatch.wingamestop3 );
        println( "<dev string:x346>" + self.petwatch.plantscharge );
        println( "<dev string:x35b>" + self.petwatch.executionscharge );
        println( "<dev string:x374>" );
        println( "<dev string:x19b>" + phase );
        println( "<dev string:x1a9>" + lastupdatetime );
        println( "<dev string:x1c0>" + bored );
        println( "<dev string:x1ce>" + dirty );
        println( "<dev string:x1dc>" + unruly );
        println( "<dev string:x1eb>" + hungry );
        println( "<dev string:x1fa>" + bonustimeapplied );
        println( "<dev string:x213>" + charged );
        println( "<dev string:x223>" + growthtime );
        println( "<dev string:x236>" + reproductionstreak );
        println( "<dev string:x251>" + damage );
        println( "<dev string:x260>" + unicornpoints );
        println( "<dev string:x276>" + vampirepoints );
        println( "<dev string:x28c>" + dragonpoints );
        println( "<dev string:x2a1>" + killstreakcharge );
        println( "<dev string:x2ba>" + wingamescharge );
        println( "<dev string:x2d1>" + objectivescorecharge );
        println( "<dev string:x2ee>" + killscharge );
        println( "<dev string:x302>" + topkillstreakcharge );
        println( "<dev string:x31e>" + nukecharge );
        println( "<dev string:x331>" + wingamestop3 );
        println( "<dev string:x346>" + plantscharge );
        println( "<dev string:x35b>" + executionscharge );
    #/
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 1
// Checksum 0x0, Offset: 0x20f6
// Size: 0x2a7
function testpetdebug( testcode )
{
    if ( testcode > 16 && !isdefined( self.petwatch ) )
    {
        initpet( 1, "pet_turbo" );
    }
    
    if ( !isdefined( self.petwatch ) )
    {
        return;
    }
    
    switch ( testcode )
    {
        case 1:
            testtiming();
            break;
        case 2:
            printplayerdatastats();
            break;
        case 3:
            addkillcharge();
            break;
        case 4:
            addtenkillcharge();
            break;
        case 5:
            addobjectivescorecharge( "debug", 1 );
            break;
        case 6:
            addobjectivescorecharge( "debug", 10 );
            break;
        case 7:
            addwatchchargewin();
            break;
        case 8:
            addplantingcharge();
            break;
        case 9:
            addexecutioncharge();
            break;
        case 10:
            addwatchchargewintop3();
            break;
        case 11:
            addtopkillstreakcharge();
            break;
        case 12:
            addnukecharge();
            break;
        case 13:
            self.petwatch.damage = 0;
            updateuistate();
            break;
        case 14:
            self.petwatch.damage = 900;
            updateuistate();
            break;
        case 15:
            self.petwatch.damage = 500;
            updateuistate();
            break;
        case 16:
            scripts\cp_mp\pet_watch::addkillstreakcharge();
            break;
        case 17:
            self setclientomnvar( "ui_smart_watch_interact", 2 );
            break;
        case 18:
            self setclientomnvar( "ui_smart_watch_interact", 3 );
            break;
        case 19:
            self setclientomnvar( "ui_smart_watch_interact", 4 );
            break;
        case 20:
            self notify( "luinotifyserver", "petwatch_turbo_grow", 1 );
            break;
        case 21:
            self notify( "luinotifyserver", "petwatch_turbo_grow", 2 );
            break;
        case 22:
            self notify( "luinotifyserver", "petwatch_turbo_grow", 3 );
            break;
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 3
// Checksum 0x0, Offset: 0x23a5
// Size: 0x71
function hoursawakesincelastupdate( currenttime, lastupdatetime, var_6ba7d3f06e41be2b )
{
    var_e01aac667d095892 = gethourtime( currenttime );
    var_50c8acb81baf34af = gethours( currenttime - lastupdatetime );
    var_8a2748d84fa9ae30 = max( 0, var_50c8acb81baf34af );
    timestruct = spawnstruct();
    timestruct.hours = var_8a2748d84fa9ae30;
    return timestruct;
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 1
// Checksum 0x0, Offset: 0x241f
// Size: 0x12
function updatepetstatesincelastupdate( var_6ba7d3f06e41be2b )
{
    self endon( "disconnect" );
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x243a
// Size: 0x65
function addthrowingknifecharge()
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype == "pet_turbo" )
    {
        self.petwatch.wingamescharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_0", 80000 + self.petwatch.wingamescharge );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x24a7
// Size: 0x77
function addkillstreakcharge()
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype == "pet_turbo" )
    {
        self.petwatch.bonuskillstreakcharge++;
        self.petwatch.killstreakcharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_1", 30000 + self.petwatch.killstreakcharge );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x2526
// Size: 0x3b
function addallkillstreaksunlockedinonelife()
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype == "pet_turbo" )
    {
        self setclientomnvar( "ui_pet_watch_bonus_earned_2", 20000 );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x2569
// Size: 0x63
function addteabagcharge()
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype == "pet_turbo" )
    {
        self.petwatch.plantscharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_0", 40000 + self.petwatch.plantscharge );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x25d4
// Size: 0x3b
function addplundercarrycredit()
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype == "pet_turbo" )
    {
        self setclientomnvar( "ui_pet_watch_bonus_earned_0", 40000 );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x2617
// Size: 0x63
function addjuggernautcharge()
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype == "pet_turbo" )
    {
        self.petwatch.nukecharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_4", 10000 + self.petwatch.nukecharge );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x2682
// Size: 0x65
function addvehicularmanslaughtercharge()
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype == "pet_turbo" )
    {
        self.petwatch.wingamestop3++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_1", 90000 + self.petwatch.wingamestop3 );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x26ef
// Size: 0x8f
function addtop3brcharge()
{
    subtype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() && ( subtype == "br" || subtype == "aladdin" || subtype == "jugg" || subtype == "mini" || subtype == "mini_mgl" ) )
    {
        if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype == "pet_turbo" )
        {
            self setclientomnvar( "ui_pet_watch_bonus_earned_1", 90000 );
        }
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x2786
// Size: 0x3d
function addwatch2v2topscore()
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype == "pet_turbo" )
    {
        self setclientomnvar( "ui_pet_watch_bonus_earned_0", 80000 );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x27cb
// Size: 0x13a
function update2v2progress()
{
    if ( !scripts\engine\utility::issharedfuncdefined( "game", "getTeamData" ) )
    {
        return;
    }
    
    roundsplayed = game[ "roundsPlayed" ];
    
    foreach ( entry in level.teamnamelist )
    {
        teamroundswon = game[ "roundsWon" ][ entry ];
        ratio = teamroundswon / level.winlimit;
        players = [[ scripts\engine\utility::getsharedfunc( "game", "getTeamData" ) ]]( entry, "players" );
        
        foreach ( player in players )
        {
            if ( isdefined( player.petwatch ) && player.petwatch.petwatchtype == "pet_turbo" )
            {
                player tryupdategenericprogress( ratio, 2 );
            }
        }
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 2
// Checksum 0x0, Offset: 0x290d
// Size: 0x68
function tryupdategenericprogress( progress, code )
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype == "pet_turbo" )
    {
        progress = min( 1, progress );
        self setclientomnvar( "ui_pet_watch_bonus_earned_4", 50000 + int( progress * 10 ) + code * 100 );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 1
// Checksum 0x0, Offset: 0x297d
// Size: 0x122
function trackcarpunches( car )
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype == "pet_turbo" )
    {
        if ( !isdefined( car.carpunchers ) )
        {
            car.carpunchers = [];
            car.carpunchcount = [];
        }
        
        var_4c98940b9e06b7f8 = -1;
        
        foreach ( i, puncher in car.carpunchers )
        {
            if ( puncher == self )
            {
                var_4c98940b9e06b7f8 = i;
                break;
            }
        }
        
        if ( var_4c98940b9e06b7f8 == -1 )
        {
            var_4c98940b9e06b7f8 = car.carpunchers.size;
            car.carpunchers[ var_4c98940b9e06b7f8 ] = self;
            car.carpunchcount[ var_4c98940b9e06b7f8 ] = 1;
        }
        else
        {
            car.carpunchcount[ var_4c98940b9e06b7f8 ]++;
        }
        
        tryupdategenericprogress( car.carpunchcount[ var_4c98940b9e06b7f8 ] / 10, 3 );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x2aa7
// Size: 0xc5
function checkcarpuncherprogressgeneric()
{
    if ( isdefined( self.carpunchers ) )
    {
        punchcount = 0;
        
        foreach ( i, puncher in self.carpunchers )
        {
            var_1e47e3db30463930 = isdefined( puncher.petwatch ) && puncher.petwatch.petwatchtype == "pet_turbo";
            
            if ( !var_1e47e3db30463930 )
            {
                continue;
            }
            
            punchcount = self.carpunchcount[ i ];
            
            if ( punchcount >= 10 )
            {
                puncher setclientomnvar( "ui_pet_watch_bonus_earned_1", 10000 );
            }
        }
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 1
// Checksum 0x0, Offset: 0x2b74
// Size: 0xcb
function checkcarpuncherprogress( car )
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype == "pet_turbo" )
    {
        if ( isdefined( car.carpunchers ) )
        {
            punchcount = 0;
            
            foreach ( i, puncher in car.carpunchers )
            {
                if ( puncher == self )
                {
                    punchcount = car.carpunchcount[ i ];
                    break;
                }
            }
            
            if ( punchcount >= 10 )
            {
                self setclientomnvar( "ui_pet_watch_bonus_earned_1", 10000 );
            }
        }
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x2c47
// Size: 0x75
function addnukecharge()
{
    if ( isdefined( self.petwatch ) )
    {
        self.petwatch.nukecharge++;
        code = 10000 + self.petwatch.nukecharge;
        
        if ( self.petwatch.petwatchtype == "pet_turbo" )
        {
            code += 100;
        }
        
        self setclientomnvar( "ui_pet_watch_bonus_earned_4", code );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x2cc4
// Size: 0x46
function addtopkillstreakcharge()
{
    if ( isdefined( self.petwatch ) )
    {
        self.petwatch.topkillstreakcharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_2", 20000 + self.petwatch.topkillstreakcharge );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x2d12
// Size: 0x1e
function addallkillstreaksunlocked()
{
    if ( isdefined( self.petwatch ) )
    {
        self setclientomnvar( "ui_pet_watch_bonus_earned_2", 20001 );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x2d38
// Size: 0x63
function addplantingcharge()
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype != "pet_turbo" )
    {
        self.petwatch.plantscharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_0", 40000 + self.petwatch.plantscharge );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 3
// Checksum 0x0, Offset: 0x2da3
// Size: 0xfe
function addobjectivescorecharge( event, originalpoints, eventinfo )
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype != "pet_turbo" )
    {
        if ( istrue( level.petobjectivefilter[ event ] ) )
        {
            return;
        }
        
        if ( event == #"kill" )
        {
            return;
        }
        
        if ( isdefined( eventinfo ) )
        {
            if ( istrue( eventinfo.var_e62ceeee8b598809 ) )
            {
                return;
            }
            
            if ( istrue( eventinfo.iskillstreakkill ) )
            {
                return;
            }
        }
        
        self.petwatch.bonusobjectivescorecharge += originalpoints;
        self.petwatch.objectivescorecharge += originalpoints;
        self setclientomnvar( "ui_pet_watch_bonus_earned_3", 50000 + self.petwatch.objectivescorecharge );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x2ea9
// Size: 0x86
function addtenkillcharge()
{
    if ( isdefined( self.petwatch ) )
    {
        self.petwatch.killscharge += 10;
        self.petwatch.bonuskillscharge += 10;
        self setclientomnvar( "ui_pet_watch_bonus_earned_0", 60000 + self.petwatch.killscharge );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x2f37
// Size: 0x5a
function addkillcharge()
{
    if ( isdefined( self.petwatch ) )
    {
        self.petwatch.killscharge++;
        self.petwatch.bonuskillscharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_0", 60000 + self.petwatch.killscharge );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x2f99
// Size: 0x48
function addexecutioncharge()
{
    if ( isdefined( self.petwatch ) )
    {
        self.petwatch.executionscharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_1", 70000 + self.petwatch.executionscharge );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x2fe9
// Size: 0x80
function addwatchchargewin()
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype != "pet_turbo" )
    {
        self.petwatch.bonuswingamescharge++;
        self.petwatch.wingamescharge++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_0", 80000 + self.petwatch.wingamescharge );
        feedaction();
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x3071
// Size: 0x65
function addwatchchargewintop3()
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype != "pet_turbo" )
    {
        self.petwatch.wingamestop3++;
        self setclientomnvar( "ui_pet_watch_bonus_earned_1", 90000 + self.petwatch.wingamestop3 );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x30de
// Size: 0x74
function petplundertimer()
{
    self endon( "disconnect" );
    self endon( "cancel_pet_plunder_timer" );
    self.petwatch.plundertimer = 1;
    totaltime = 180;
    var_ab255606fab17dbc = totaltime / 5;
    
    for ( i = 1; i <= 5 ; i++ )
    {
        wait var_ab255606fab17dbc;
        tryupdategenericprogress( i / 5, 4 );
    }
    
    addplundercarrycredit();
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 1
// Checksum 0x0, Offset: 0x315a
// Size: 0x3f
function updatenukeprogress( progress )
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype == "pet_turbo" )
    {
        tryupdategenericprogress( progress, 1 );
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x31a1
// Size: 0x99
function onplayergetsplunder()
{
    if ( isdefined( self.petwatch ) && self.petwatch.petwatchtype == "pet_turbo" )
    {
        if ( self.plundercount > 5000 )
        {
            if ( !isdefined( self.petwatch.plundertimer ) )
            {
                thread petplundertimer();
            }
            
            return;
        }
        
        if ( isdefined( self.petwatch.plundertimer ) )
        {
            self notify( "cancel_pet_plunder_timer" );
            self.petwatch.plundertimer = undefined;
            tryupdategenericprogress( 0, 0 );
        }
    }
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 1
// Checksum 0x0, Offset: 0x3242
// Size: 0x31
function setphase( phase )
{
    self.petwatch.phase = phase;
    self.pers[ "petWatchData_phase" ] = phase;
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x327b
// Size: 0x127
function updateuistate()
{
    bitfield = 0;
    
    if ( self.petwatch.bored < 0 )
    {
        bitfield += 20;
    }
    
    if ( self.petwatch.dirty < 0 )
    {
        bitfield += 100;
    }
    
    if ( self.petwatch.unruly < 0 )
    {
        bitfield += 1000;
    }
    
    if ( self.petwatch.hungry < 0 )
    {
        bitfield += 10000;
    }
    
    dmgstep = int( self.petwatch.damage / 100 ) - 1;
    dmgstep = int( max( 0, min( dmgstep, 9 ) ) );
    bitfield += 100000 * dmgstep;
    state = bitfield + self.petwatch.phase;
    println( "<dev string:x393>" + bitfield + "<dev string:x3ae>" + self.petwatch.phase );
    self setclientomnvar( "ui_pet_watch_state", state );
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x33aa
// Size: 0x2fb
function resetpetstats()
{
    self.petwatch.bored = level.petconsts[ self.petwatch.phase ].boredstart;
    self.petwatch.dirty = level.petconsts[ self.petwatch.phase ].dirtystart;
    self.petwatch.unruly = level.petconsts[ self.petwatch.phase ].unrulystart;
    self.petwatch.hungry = level.petconsts[ self.petwatch.phase ].hungrystart;
    self.petwatch.lasthungryscore = 0;
    self.petwatch.lastboredscore = 0;
    self.petwatch.lastunrulyscore = 0;
    self.petwatch.lastdirtyscore = 0;
    self.petwatch.charged = 0;
    self.petwatch.growthtime = 0;
    self.petwatch.bonustimeapplied = 0;
    self.petwatch.bonustime = 0;
    self.petwatch.damage = 0;
    self.petwatch.unicornpoints = 0;
    self.petwatch.vampirepoints = 0;
    self.petwatch.dragonpoints = 0;
    self.petwatch.bonuskillstreakcharge = 0;
    self.petwatch.killstreakcharge = 0;
    self.petwatch.bonuswingamescharge = 0;
    self.petwatch.wingamescharge = 0;
    self.petwatch.bonusobjectivescorecharge = 0;
    self.petwatch.objectivescorecharge = 0;
    self.petwatch.bonuskillscharge = 0;
    self.petwatch.killscharge = 0;
    self.petwatch.topkillstreakcharge = 0;
    self.petwatch.nukecharge = 0;
    self.petwatch.wingamestop3 = 0;
    self.petwatch.plantscharge = 0;
    self.petwatch.executionscharge = 0;
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 2
// Checksum 0x0, Offset: 0x36ad
// Size: 0x4c
function resetpet( var_801259433dadb5e0, phaseoverride )
{
    if ( isdefined( phaseoverride ) )
    {
        setphase( phaseoverride );
    }
    else
    {
        setphase( 1 );
    }
    
    self.petwatch.lastupdatetime = getsystemtime();
    resetpetstats();
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 1
// Checksum 0x0, Offset: 0x3701
// Size: 0x18
function debugsetlasttime( hours )
{
    self setclientomnvar( "ui_pet_watch_action", hours );
}

// Namespace pet_watch / scripts\cp_mp\pet_watch
// Params 0
// Checksum 0x0, Offset: 0x3721
// Size: 0x465
function feedaction()
{
    if ( !isdefined( self.petwatch ) )
    {
        return;
    }
    
    if ( self.petwatch.petwatchtype == "pet_turbo" )
    {
        return;
    }
    
    if ( self.petwatch.phase == 15 )
    {
        return;
    }
    
    boredscore = self.petwatch.killstreakcharge * 20;
    dirtyscore = self.petwatch.wingamescharge * 20;
    unrulyscore = self.petwatch.objectivescorecharge * 0.5;
    hungryscore = self.petwatch.killscharge * 1;
    var_e4de697fecf32054 = self.petwatch.lasthungryscore < hungryscore;
    dirtychanged = self.petwatch.lastdirtyscore < dirtyscore;
    var_9635660a6eb2d37f = self.petwatch.lastboredscore < boredscore;
    var_b2f5debac3f6ee00 = self.petwatch.lastunrulyscore < unrulyscore;
    println( "<dev string:x3b9>" + boredscore + "<dev string:x3d1>" + dirtyscore + "<dev string:x3e1>" + unrulyscore + "<dev string:x3f2>" + hungryscore );
    
    if ( !var_e4de697fecf32054 && !dirtychanged && !var_9635660a6eb2d37f && !var_b2f5debac3f6ee00 )
    {
        return;
    }
    
    println( "<dev string:x403>" + self.petwatch.bored + "<dev string:x419>" + self.petwatch.dirty + "<dev string:x424>" + self.petwatch.unruly + "<dev string:x430>" + self.petwatch.hungry );
    boredscore = max( -240, min( boredscore, 240 ) );
    dirtyscore = max( -240, min( dirtyscore, 240 ) );
    unrulyscore = max( -240, min( unrulyscore, 240 ) );
    hungryscore = max( -240, min( hungryscore, 240 ) );
    
    if ( dirtychanged )
    {
        dirtyscore = int( dirtyscore );
        
        if ( dirtyscore == 0 )
        {
            dirtyscore = 1;
        }
        
        self setclientomnvar( "ui_pet_watch_health_dirty", dirtyscore );
    }
    
    if ( var_b2f5debac3f6ee00 )
    {
        unrulyscore = int( unrulyscore );
        
        if ( unrulyscore == 0 )
        {
            unrulyscore = 1;
        }
        
        self setclientomnvar( "ui_pet_watch_health_unruly", int( unrulyscore ) );
    }
    
    if ( var_e4de697fecf32054 )
    {
        hungryscore = int( hungryscore );
        
        if ( hungryscore == 0 )
        {
            hungryscore = 1;
        }
        
        self setclientomnvar( "ui_pet_watch_health_hungry", int( hungryscore ) );
    }
    
    if ( var_9635660a6eb2d37f )
    {
        boredscore = int( boredscore );
        
        if ( boredscore == 0 )
        {
            boredscore = 1;
        }
        
        self setclientomnvar( "ui_pet_watch_health_bored", int( boredscore ) );
    }
    
    self.petwatch.lasthungryscore = hungryscore;
    self.petwatch.lastdirtyscore = dirtyscore;
    self.petwatch.lastboredscore = boredscore;
    self.petwatch.lastunrulyscore = unrulyscore;
    self.petwatch.topkillstreakcharge = 0;
    self.petwatch.nukecharge = 0;
    self.petwatch.wingamestop3 = 0;
    self.petwatch.plantscharge = 0;
    self.petwatch.executionscharge = 0;
    self.petwatch.bored = boredscore;
    self.petwatch.dirty = dirtyscore;
    self.petwatch.unruly = unrulyscore;
    self.petwatch.hungry = hungryscore;
    println( "<dev string:x43c>" + self.petwatch.bored + "<dev string:x419>" + self.petwatch.dirty + "<dev string:x424>" + self.petwatch.unruly + "<dev string:x430>" + self.petwatch.hungry );
}

