#using scripts\common\utility;
#using scripts\cp\cp_hud_util;
#using scripts\cp\points;
#using scripts\cp\rank;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\utility\script;
#using scripts\cp\utility\spawn_event_aggregator;
#using scripts\engine\utility;

#namespace cp_awards;

// Namespace cp_awards / scripts\cp\cp_awards
// Params 0
// Checksum 0x0, Offset: 0x525
// Size: 0x1e
function init()
{
    scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawned );
    initawards();
    level thread saveaarawardsonroundswitch();
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 0
// Checksum 0x0, Offset: 0x54b
// Size: 0x14
function onplayerconnect()
{
    thread initaarawardlist();
    self.awardqueue = [];
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 0
// Checksum 0x0, Offset: 0x567
// Size: 0xc
function onplayerspawned()
{
    self.awardsthislife = [];
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 0
// Checksum 0x0, Offset: 0x57b
// Size: 0x28
function initawards()
{
    flag_init( "cp_operator_unlock_ids_initted" );
    initmidmatchawards();
    initoperatorunlocks();
    flag_set( "cp_operator_unlock_ids_initted" );
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 0
// Checksum 0x0, Offset: 0x5ab
// Size: 0xd0
function initoperatorunlocks()
{
    level.operator_unlock_ids = [];
    count = 0;
    
    while ( true )
    {
        taskref = tablelookupbyrow( "cp_reward_ids.csv", count, 2 );
        
        if ( isdefined( taskref ) && taskref != "" )
        {
            struct = spawnstruct();
            id = tablelookup( "cp_reward_ids.csv", 2, taskref, 1 );
            unique_id = tablelookup( "cp_reward_ids.csv", 2, taskref, 0 );
            struct.operator_reward_id = int( id );
            struct.id = int( unique_id );
            level.operator_unlock_ids[ taskref ] = struct;
            count++;
        }
        else
        {
            break;
        }
        
        waitframe();
    }
    
    level.juggernaut_kills_tracker = 0;
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 1
// Checksum 0x0, Offset: 0x683
// Size: 0x64
function function_6df0786b01ec7028( ref )
{
    assert( isdefined( ref ) );
    aarpriority = tablelookup( "mp/awardtable.csv", 0, ref, 1 );
    
    if ( isdefined( aarpriority ) && aarpriority > 0 )
    {
        randomvalue = randomfloat( 1 );
        level.var_6d808d6c553c2d9a[ ref ] = float( aarpriority ) + randomvalue;
    }
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 1
// Checksum 0x0, Offset: 0x6ef
// Size: 0x13
function initmidmatchaward( ref )
{
    function_6df0786b01ec7028( ref );
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 0
// Checksum 0x0, Offset: 0x70a
// Size: 0x4c
function initmidmatchawards()
{
    for ( row = 0; true ; row++ )
    {
        ref = tablelookupbyrow( "mp/awardtable.csv", row, 0 );
        
        if ( !isdefined( ref ) || ref == "" )
        {
            break;
        }
        
        initmidmatchaward( ref );
    }
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 1
// Checksum 0x0, Offset: 0x75e
// Size: 0x3d
function incplayerrecord( ref )
{
    recordvalue = self getplayerdata( "common", "awards", ref );
    self setplayerdata( "common", "awards", ref, recordvalue + 1 );
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 10
// Checksum 0x0, Offset: 0x7a3
// Size: 0x16b
function giveaward( ref, objweapon, pointsoverride, xpoverride, immediate, victim, cankillchain, streakinfo, var_ad8c6c5cc50af10b, eventinfo )
{
    if ( !istrue( immediate ) )
    {
        self endon( "disconnect" );
        waitframe();
    }
    
    if ( !scripts\cp\rank::function_34294184e90b96c( ref ) )
    {
        assertmsg( "giveAward() called on \"" + ref + "\" which is not marked as an award in the current score event list. IsAward should be checked." );
        return;
    }
    
    if ( isenumvaluevalid( "mp", "Awards", getxhashhexname( ref ) ) )
    {
        addawardtoaarlist( ref );
    }
    
    xp = xpoverride;
    
    if ( !isdefined( xp ) )
    {
        xp = scripts\cp\rank::getscoreinfoxp( ref );
    }
    
    if ( isdefined( xp ) && xp > 0 )
    {
        scripts\cp\rank::giverankxp( ref, xp, objweapon );
    }
    
    if ( !isdefined( pointsoverride ) )
    {
        points = scripts\cp\rank::getscoreinfovalue( ref );
        pointsoverride = default_to( points, 0 );
    }
    
    if ( pointsoverride > 0 )
    {
        giveunifiedpoints( ref, objweapon, pointsoverride, -1, victim, cankillchain, streakinfo, undefined, eventinfo );
    }
    
    scripts\cp\utility\script::bufferednotify( "earned_award_buffered", ref );
    
    if ( isdefined( self.awardsthislife[ ref ] ) )
    {
        self.awardsthislife[ ref ]++;
    }
    else
    {
        self.awardsthislife[ ref ] = 1;
    }
    
    utility::trycall( level.matchdata_logaward, ref );
    
    /#
    #/
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 11
// Checksum 0x0, Offset: 0x916
// Size: 0x11e
function queuemidmatchaward( ref, objweapon, pointsoverride, xpoverride, var_51bdae03b05bc75e, dontwait, victim, cankillchain, streakinfo, var_ad8c6c5cc50af10b, eventinfo )
{
    awardinfo = spawnstruct();
    awardinfo.ref = ref;
    awardinfo.objweapon = objweapon;
    awardinfo.pointsoverride = pointsoverride;
    awardinfo.xpoverride = xpoverride;
    awardinfo.var_51bdae03b05bc75e = var_51bdae03b05bc75e;
    awardinfo.dontwait = dontwait;
    awardinfo.victim = victim;
    awardinfo.cankillchain = cankillchain;
    awardinfo.streakinfo = streakinfo;
    awardinfo.var_ad8c6c5cc50af10b = var_ad8c6c5cc50af10b;
    awardinfo.eventinfo = eventinfo;
    self.awardqueue[ self.awardqueue.size ] = awardinfo;
    thread flushmidmatchawardqueuewhenable();
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 0
// Checksum 0x0, Offset: 0xa3c
// Size: 0xea
function flushmidmatchawardqueue()
{
    assertex( !shouldqueuemidmatchaward(), "Attempting to flush award queue when the awards can't be dispalyed" );
    
    foreach ( award in self.awardqueue )
    {
        givemidmatchaward( award.ref, award.objweapon, award.pointsoverride, award.xpoverride, award.var_51bdae03b05bc75e, award.dontwait, award.victim, award.cankillchain, award.streakinfo, award.var_ad8c6c5cc50af10b, award.eventinfo );
    }
    
    self.awardqueue = [];
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 0
// Checksum 0x0, Offset: 0xb2e
// Size: 0x35
function flushmidmatchawardqueuewhenable()
{
    self endon( "disconnect" );
    self notify( "flushMidMatchAwardQueueWhenAble()" );
    self endon( "flushMidMatchAwardQueueWhenAble()" );
    
    while ( true )
    {
        if ( !shouldqueuemidmatchaward() )
        {
            break;
        }
        
        waitframe();
    }
    
    thread flushmidmatchawardqueue();
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 1
// Checksum 0x0, Offset: 0xb6b
// Size: 0x40, Type: bool
function shouldqueuemidmatchaward( var_3cda0e0b6a2d1f97 )
{
    if ( level.gameended )
    {
        return false;
    }
    
    if ( !isreallyalive( self ) )
    {
        if ( !istrue( var_3cda0e0b6a2d1f97 ) || isinkillcam() )
        {
            if ( !isusingremote() )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 11
// Checksum 0x0, Offset: 0xbb4
// Size: 0x15b
function givemidmatchaward( ref, objweapon, pointsoverride, xpoverride, var_51bdae03b05bc75e, dontwait, victim, cankillchain, streakinfo, var_ad8c6c5cc50af10b, eventinfo )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    if ( istrue( level.gameended ) )
    {
        isvalidevent = 0;
        
        if ( isarray( ref ) )
        {
            if ( isnumber( level.gameendtime ) )
            {
                if ( ref[ 1 ] <= level.gameendtime )
                {
                    isvalidevent = 1;
                    ref = ref[ 0 ];
                }
            }
        }
        else if ( isdefined( ref ) )
        {
            isvalidevent = 1;
        }
        
        if ( !isvalidevent )
        {
            return;
        }
    }
    else if ( isarray( ref ) )
    {
        ref = ref[ 0 ];
    }
    
    if ( !isxhash( ref ) )
    {
        assertex( 1, ref );
        ref = getxhash( ref );
    }
    
    if ( self ispcplayer() && scripts\cp\utility::gameflag( "prematch_done" ) )
    {
        createnvidiavideo( ref );
    }
    
    if ( shouldqueuemidmatchaward( var_51bdae03b05bc75e ) )
    {
        queuemidmatchaward( ref, objweapon, pointsoverride, xpoverride, var_51bdae03b05bc75e, dontwait, victim, cankillchain, streakinfo );
        return;
    }
    
    thread giveaward( ref, objweapon, pointsoverride, xpoverride, dontwait, victim, cankillchain, streakinfo, var_ad8c6c5cc50af10b, eventinfo );
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 1
// Checksum 0x0, Offset: 0xd17
// Size: 0xce
function createnvidiavideo( ref )
{
    var_7861cc7f1384834e = undefined;
    
    if ( ref == #"five" )
    {
        var_7861cc7f1384834e = 1;
    }
    else if ( ref == #"seven" )
    {
        var_7861cc7f1384834e = 2;
    }
    else if ( ref == #"eight" )
    {
        var_7861cc7f1384834e = 3;
    }
    else if ( ref == #"streak_10" )
    {
        var_7861cc7f1384834e = 4;
    }
    else if ( ref == #"streak_20" )
    {
        var_7861cc7f1384834e = 5;
    }
    else if ( ref == #"streak_30" )
    {
        var_7861cc7f1384834e = 6;
    }
    else if ( ref == #"one_shot_two_kills" )
    {
        var_7861cc7f1384834e = 7;
    }
    else if ( ref == #"item_impact" )
    {
        var_7861cc7f1384834e = 8;
    }
    
    if ( isdefined( var_7861cc7f1384834e ) )
    {
        self setclientomnvar( "nVidiaHighlights_events", var_7861cc7f1384834e );
    }
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 1
// Checksum 0x0, Offset: 0xded
// Size: 0x3b4
function addawardtoaarlist( ref )
{
    if ( !isdefined( self.aarawards ) )
    {
        self.aarawards = [];
        self.aarawardcount = 0;
        
        for ( awardindex = 0; awardindex < 10 ; awardindex++ )
        {
            struct = spawnstruct();
            self.aarawards[ awardindex ] = struct;
            struct.ref = "none";
            struct.count = 0;
        }
    }
    
    foreach ( awardindex, awardinfo in self.aarawards )
    {
        if ( awardinfo.ref == ref )
        {
            awardinfo.count++;
            self setplayerdata( "common", "round", "awards", awardindex, "value", awardinfo.count );
            return;
        }
    }
    
    newpriority = default_to( level.var_6d808d6c553c2d9a[ ref ], 0 );
    
    for ( insertindex = 0; insertindex < self.aarawards.size ; insertindex++ )
    {
        awardinfo = self.aarawards[ insertindex ];
        
        if ( awardinfo.ref == "none" )
        {
            break;
        }
        
        otherpriority = default_to( level.var_6d808d6c553c2d9a[ awardinfo.ref ], 0 );
        
        if ( newpriority > otherpriority )
        {
            break;
        }
    }
    
    if ( insertindex >= self.aarawards.size )
    {
        return;
    }
    
    for ( listindex = self.aarawards.size - 2; listindex >= insertindex ; listindex-- )
    {
        newindex = listindex + 1;
        self.aarawards[ newindex ] = self.aarawards[ listindex ];
        awardinfo = self.aarawards[ newindex ];
        
        /#
            if ( isdefined( awardinfo.ref ) && isxhash( awardinfo.ref ) )
            {
                awardinfo.ref = getxhashsourcename( awardinfo.ref );
            }
        #/
        
        if ( awardinfo.ref != "none" )
        {
            self setplayerdata( "common", "round", "awards", newindex, "award", awardinfo.ref );
            self setplayerdata( "common", "round", "awards", newindex, "value", awardinfo.count );
        }
    }
    
    awardinfo = spawnstruct();
    self.aarawards[ insertindex ] = awardinfo;
    awardinfo.ref = ref;
    awardinfo.count = 1;
    
    /#
        if ( isdefined( awardinfo.ref ) && isxhash( awardinfo.ref ) )
        {
            awardinfo.ref = getxhashsourcename( awardinfo.ref );
        }
    #/
    
    self setplayerdata( "common", "round", "awards", insertindex, "award", awardinfo.ref );
    self setplayerdata( "common", "round", "awards", insertindex, "value", awardinfo.count );
    
    if ( self.aarawardcount < 10 )
    {
        self.aarawardcount++;
        self setplayerdata( "common", "round", "awardCount", self.aarawardcount );
    }
    
    if ( istrue( self.savedaarawards ) )
    {
        saveaarawards();
    }
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 0
// Checksum 0x0, Offset: 0x11a9
// Size: 0xae
function initaarawardlist()
{
    self.aarawards = self.pers[ "aarAwards" ];
    self.aarawardcount = self.pers[ "aarAwardCount" ];
    
    if ( isdefined( self.aarawards ) )
    {
        return;
    }
    
    self setplayerdata( "common", "round", "awardCount", 0 );
    
    for ( awardindex = 0; awardindex < 10 ; awardindex++ )
    {
        self setplayerdata( "common", "round", "awards", awardindex, "award", "none" );
        self setplayerdata( "common", "round", "awards", awardindex, "value", 0 );
    }
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 0
// Checksum 0x0, Offset: 0x125f
// Size: 0x6a
function saveaarawardsonroundswitch()
{
    level waittill( "game_ended" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && !isbot( player ) )
        {
            player saveaarawards();
        }
    }
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 0
// Checksum 0x0, Offset: 0x12d1
// Size: 0x3f
function saveaarawards()
{
    self.pers[ "aarAwards" ] = self.aarawards;
    self.pers[ "aarAwardCount" ] = self.aarawardcount;
    self.savedaarawards = 1;
}

/#

    // Namespace cp_awards / scripts\cp\cp_awards
    // Params 0
    // Checksum 0x0, Offset: 0x1318
    // Size: 0xe8, Type: dev
    function function_c346fd8caa61c2ed()
    {
        for ( awardindex = 0; awardindex < self.aarawards.size ; awardindex++ )
        {
            awardinfo = self.aarawards[ awardindex ];
            pdref = self getplayerdata( "<dev string:x1c>", "<dev string:x23>", "<dev string:x29>", awardindex, "<dev string:x30>" );
            pdcount = self getplayerdata( "<dev string:x1c>", "<dev string:x23>", "<dev string:x29>", awardindex, "<dev string:x36>" );
            assert( awardinfo.ref == pdref );
            assert( awardinfo.count == pdcount );
            println( "<dev string:x3c>" + awardindex + 1 + "<dev string:x47>" + awardinfo.ref + "<dev string:x4a>" + awardinfo.count );
        }
    }

#/

// Namespace cp_awards / scripts\cp\cp_awards
// Params 1
// Checksum 0x0, Offset: 0x1408
// Size: 0xe3
function give_operator_based_on_task( task_reference )
{
    flag_wait( "cp_operator_unlock_ids_initted" );
    assertex( isdefined( task_reference ), "operation_reference value is undefined. Recheck scripts" );
    assertex( isstring( task_reference ), "operation_reference value is NOT a string. Recheck scripts" );
    
    if ( !isdefined( task_reference ) || !isstring( task_reference ) )
    {
        return;
    }
    
    id = int( get_id_based_on_task( task_reference ) );
    
    switch ( task_reference )
    {
        case #"hash_22ab6874bab6b34a":
        case #"hash_3b643889fbf635ad":
        case #"hash_4070ccd227c6f53c":
        case #"hash_4b786afc390db4b3":
        case #"hash_5a71f8bcdbd421e3":
        case #"hash_b380515b5e8a3ea1":
            self reportchallengeuserevent( "cp_complete", id );
            break;
        default:
            /#
                iprintln( "<dev string:x4e>" + task_reference );
            #/
            
            break;
    }
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 1
// Checksum 0x0, Offset: 0x14f3
// Size: 0x1a3
function give_reward_based_on_task( task_reference )
{
    flag_wait( "cp_operator_unlock_ids_initted" );
    assertex( isdefined( task_reference ), "reward_reference value is undefined. Recheck scripts" );
    assertex( isstring( task_reference ), "reward_reference value is NOT a string. Recheck scripts" );
    
    if ( !isdefined( task_reference ) || !isstring( task_reference ) )
    {
        return;
    }
    
    id = int( get_id_based_on_task( task_reference ) );
    
    switch ( task_reference )
    {
        case #"hash_1188473b152561ca":
        case #"hash_1759d8bd3e44beca":
        case #"hash_1f2f1d015fb3374a":
        case #"hash_5611ff81c344f33c":
        case #"hash_6904126b1027902d":
        case #"hash_845b1ccf5acc2c41":
        case #"hash_890afee750c709de":
        case #"hash_9db74a12acd28157":
        case #"hash_a04d08e23c662ed7":
        case #"hash_ab7dbf8c2577ee83":
        case #"hash_bcd76cf2e62c1903":
        case #"hash_c9de151a6a05828b":
        case #"hash_d2899a9e3ea539de":
        case #"hash_d2899c9e3ea53d04":
        case #"hash_d2899d9e3ea53e97":
        case #"hash_d2899f9e3ea541bd":
        case #"hash_d68fb2d05da4feee":
        case #"hash_e7252dc422dff7d7":
        case #"hash_f6dd20f50c4bbe50":
        case #"hash_f71229110ba9bdf4":
        case #"hash_f9814f1ffba35a58":
        case #"hash_fc523cdd48d1414a":
            self reportchallengeuserevent( "cp_complete", id );
            break;
        default:
            /#
                iprintln( "<dev string:x4e>" + task_reference );
            #/
            
            break;
    }
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 1
// Checksum 0x0, Offset: 0x169e
// Size: 0x3c
function get_id_based_on_task( task_reference )
{
    id = level.operator_unlock_ids[ task_reference ].id;
    assertex( isdefined( id ), " Value of ID was undefined. Recheck table ^1 cp_reward_ids.csv" );
    return id;
}

// Namespace cp_awards / scripts\cp\cp_awards
// Params 0
// Checksum 0x0, Offset: 0x16e3
// Size: 0xdd
function challengetrackerforjuggkills()
{
    if ( istrue( level.juggernautchallengedone ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player thread scripts\cp\points::doscoreevent( #"kill_juggernaut" );
    }
    
    level.juggernaut_kills_tracker++;
    
    if ( level.juggernaut_kills_tracker >= 5 )
    {
        foreach ( player in level.players )
        {
            player thread give_operator_based_on_task( "juggernauts" );
        }
        
        level.juggernautchallengedone = 1;
    }
}

