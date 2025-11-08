#using script_4cdabcd91a92977;
#using scripts\common\devgui;
#using scripts\engine\utility;
#using scripts\mp\utility\connect_event_aggregator;
#using scripts\mp\utility\script;

#namespace namespace_11161030531bb10d;

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x210
// Size: 0xa
function autoexec main()
{
    thread _main();
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 0
// Checksum 0x0, Offset: 0x222
// Size: 0x86
function _main()
{
    if ( getdvarint( @"scr_br_mood_manager", 1 ) == 1 )
    {
        if ( isbr() )
        {
            moodset = getdvar( @"hash_814a58e4f810f2d8", "" );
            moodlist = getdvar( @"scr_br_moodlist_set", "" );
            
            if ( moodset != "" )
            {
                thread setup( moodset );
                return;
            }
            
            if ( moodlist != "" )
            {
                thread init( moodlist );
            }
        }
    }
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 1
// Checksum 0x0, Offset: 0x2b0
// Size: 0x17e
function init( moodlist )
{
    if ( !isdefined( moodlist ) || moodlist == "" )
    {
        return;
    }
    
    scriptbundle = getscriptbundle( hashcat( %"hash_2bbcecc836419d0b", moodlist ) );
    
    if ( !isdefined( scriptbundle ) )
    {
        return;
    }
    
    moodlist = scriptbundle.var_ef1866c5d314a352;
    
    if ( !isdefined( moodlist ) || moodlist.size == 0 )
    {
        return;
    }
    
    totalweight = 0;
    weightoverrides = strtok( getdvar( @"hash_8422039c51781bf1", "" ), " " );
    
    for ( k = 0; k < moodlist.size ; k++ )
    {
        if ( weightoverrides.size > 0 )
        {
            moodlist[ k ].weight = int( default_to( weightoverrides[ k ], 0 ) );
        }
        
        if ( !isdefined( moodlist[ k ].weight ) )
        {
            moodlist[ k ].weight = 0;
        }
        
        totalweight += moodlist[ k ].weight;
    }
    
    randomnumber = randomfloat( totalweight );
    cumulativeweight = 0;
    
    for ( i = 0; i < moodlist.size ; i++ )
    {
        nextweight = cumulativeweight + moodlist[ i ].weight;
        
        if ( nextweight > randomnumber )
        {
            var_41368388d296a0d0 = moodlist[ i ];
            setup( var_41368388d296a0d0.moodset );
            return;
        }
        
        cumulativeweight = nextweight;
    }
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 1
// Checksum 0x0, Offset: 0x436
// Size: 0x231
function setup( moodset )
{
    if ( !isdefined( moodset ) || moodset == "" )
    {
        return;
    }
    
    scriptbundle = getscriptbundle( hashcat( %"hash_7d9482f6248686c3", moodset ) );
    
    if ( !isdefined( scriptbundle ) )
    {
        return;
    }
    
    if ( !isdefined( scriptbundle.moods ) || scriptbundle.moods.size == 0 )
    {
        return;
    }
    
    level.var_e198c297ceb14c19 = getdvarint( @"hash_37763c7311e5b8da", 256 );
    level.var_fbca612d854a3975 = getdvarfloat( @"hash_d1676be1e671f038", 0.306 );
    level.var_ae361b9fc9ed6213 = getdvarfloat( @"hash_8eebbbe30d21a94a", 1 );
    level.var_8ee11212ceb130ef = getdvarfloat( @"hash_64e3e719e88b3ffa", 0.922347 );
    level.var_f8397ff86c4282e8 = getdvarfloat( @"hash_2b9d51c935985eff", 0.870588 );
    level.var_7a5d55a09a3e77c8 = getdvarint( @"hash_62d527faf49570ed", 30 );
    level.var_7a5d55a09a3e77c8 *= 1000;
    level.var_5c0ae670b3d932f3 = [];
    level.moods = scriptbundle.moods;
    
    for ( i = 0; i < level.moods.size ; i++ )
    {
        level.moods[ i ].state = getscriptbundle( hashcat( %"hash_6b3d349b362ec62", level.moods[ i ].state ) );
    }
    
    initialmood = function_ba1ac5101c4b8b85();
    
    if ( isdefined( initialmood ) && isdefined( initialmood.state ) )
    {
        level thread function_5d6d8ec8b7599cfd( initialmood );
    }
    
    thread function_464132facdf4a21f();
    
    if ( getdvarint( @"hash_826be4f15ac0748e", 1 ) == 1 )
    {
        level thread watchcircles();
        level thread watchtime();
    }
    
    /#
        level thread debug_init();
    #/
    
    level thread onsetupmoodset();
    
    if ( function_3a1b9192a1f0b3c4() )
    {
        level thread function_6954edb9716497e3();
    }
    
    thread overridedvars( scriptbundle.dvars );
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 0
// Checksum 0x0, Offset: 0x66f
// Size: 0x40
function onsetupmoodset()
{
    level endon( "game_ended" );
    level waittill( "global_logic_mp_init" );
    
    if ( scripts\engine\utility::issharedfuncdefined( "mood", "onSetupMoodSet" ) )
    {
        [[ scripts\engine\utility::getsharedfunc( "mood", "onSetupMoodSet" ) ]]( level.moods );
    }
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 1
// Checksum 0x0, Offset: 0x6b7
// Size: 0x14b
function setmood( mood )
{
    if ( !isdefined( mood ) )
    {
        return;
    }
    
    if ( isdefined( level.currentmood ) )
    {
        if ( level.currentmood.transitiontype == "circles" && mood.transitiontype == "circles" )
        {
            circleindexa = scripts\engine\utility::default_to( mood.circleindex, 0 );
            circleindexb = scripts\engine\utility::default_to( level.currentmood.circleindex, 0 );
            
            if ( circleindexa == circleindexb )
            {
                return;
            }
        }
    }
    
    if ( !isdefined( mood.state ) )
    {
        return;
    }
    
    oldmood = level.currentmood;
    level.currentmood = mood;
    
    if ( getdvarint( @"hash_9e046b4cbe0b3242", -1 ) > -1 )
    {
        level.currentmood.transitiontime = getdvarint( @"hash_9e046b4cbe0b3242" );
    }
    
    thread switchvisionsets();
    function_519c36cfe2838f8a();
    function_24427ed3f5c1ccc3();
    thread function_d579bab00a3ef871();
    thread function_2ef05a1df426a720();
    
    if ( scripts\engine\utility::issharedfuncdefined( "mood", "onSetMood" ) )
    {
        [[ scripts\engine\utility::getsharedfunc( "mood", "onSetMood" ) ]]( mood, oldmood );
    }
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 0
// Checksum 0x0, Offset: 0x80a
// Size: 0xa2
function switchvisionsets()
{
    suffix = level.currentmood.state.visionsetsuffix;
    
    if ( !isdefined( suffix ) )
    {
        suffix = "";
    }
    
    duration = 0;
    
    if ( isdefined( level.currentmood.transitiontime ) && level.currentmood.transitiontime >= 0 )
    {
        duration = level.currentmood.transitiontime;
    }
    
    /#
        if ( istrue( level.var_5872a7af669d9983 ) )
        {
            duration = 0;
        }
    #/
    
    replacevisionset( duration, suffix );
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 1
// Checksum 0x0, Offset: 0x8b4
// Size: 0x7a
function function_5d6d8ec8b7599cfd( mood )
{
    level endon( "game_ended" );
    
    if ( !isdefined( mood.state ) )
    {
        return;
    }
    
    scripts\mp\utility\connect_event_aggregator::registeronconnectcallback( &function_67b078e888405ebf );
    level.currentmood = mood;
    thread function_d579bab00a3ef871();
    thread function_2ef05a1df426a720( 1 );
    thread switchvisionsets();
    
    if ( scripts\engine\utility::issharedfuncdefined( "mood", "onSetMood" ) )
    {
        [[ scripts\engine\utility::getsharedfunc( "mood", "onSetMood" ) ]]( mood, undefined );
    }
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 0
// Checksum 0x0, Offset: 0x936
// Size: 0x1b
function function_464132facdf4a21f()
{
    level scripts\engine\utility::flag_wait( "StartGameTypeCallbackFinished" );
    namespace_bf9ffd2b22c7d819::function_8fe6d6539ed31a88( &function_5c79b3df3d147f51 );
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 1
// Checksum 0x0, Offset: 0x959
// Size: 0x15
function function_5c79b3df3d147f51( player )
{
    player function_67b078e888405ebf( 1 );
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 1
// Checksum 0x0, Offset: 0x976
// Size: 0x1f
function function_67b078e888405ebf( isrejoining )
{
    thread function_519c36cfe2838f8a( self, isrejoining );
    thread function_24427ed3f5c1ccc3( self, isrejoining );
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 0
// Checksum 0x0, Offset: 0x99d
// Size: 0x51
function watchcircles()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "br_circle_set" );
        newmood = function_8725cc1e47d95528( level.br_circle.circleindex );
        
        if ( isdefined( newmood ) )
        {
            setmood( newmood );
            continue;
        }
        
        continue;
    }
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 0
// Checksum 0x0, Offset: 0x9f6
// Size: 0xc0
function watchtime()
{
    level endon( "game_ended" );
    level waittill( "prematch_fade_done" );
    
    if ( !isdefined( level.starttime ) )
    {
        level.starttime = gettime();
    }
    
    waittime = 60;
    newmood = undefined;
    var_35963274858b5330 = 1;
    
    if ( function_3a1b9192a1f0b3c4() )
    {
        var_35963274858b5330 = 0;
    }
    
    while ( true )
    {
        if ( isdefined( newmood ) )
        {
            setmood( newmood );
            newmood = undefined;
            waittime = 60;
            continue;
        }
        else
        {
            newmood = function_12f05fef0df24cd7( waittime, var_35963274858b5330 );
            var_35963274858b5330 = 0;
        }
        
        if ( isdefined( newmood ) )
        {
            waittime = newmood.starttime * 60 - ( gettime() - level.starttime ) / 1000;
            waittime = max( waittime, 0 );
        }
        
        wait waittime;
    }
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 1
// Checksum 0x0, Offset: 0xabe
// Size: 0xa8
function function_8725cc1e47d95528( index )
{
    foreach ( mood in level.moods )
    {
        if ( mood.transitiontype != "circles" )
        {
            continue;
        }
        
        if ( !isdefined( mood.circleindex ) )
        {
            if ( index == 0 )
            {
                mood.circleindex = index;
                return mood;
            }
            
            continue;
        }
        
        if ( mood.circleindex == index )
        {
            return mood;
        }
    }
    
    return undefined;
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 2
// Checksum 0x0, Offset: 0xb6f
// Size: 0x11b
function function_12f05fef0df24cd7( timedelta, var_35963274858b5330 )
{
    if ( function_3a1b9192a1f0b3c4() )
    {
        if ( !isdefined( level.starttime ) )
        {
            level.starttime = gettime();
        }
    }
    
    currenttime = gettime() - level.starttime;
    currenttime *= 0.001;
    
    foreach ( mood in level.moods )
    {
        if ( mood.transitiontype != "time" )
        {
            continue;
        }
        
        if ( !isdefined( mood.starttime ) )
        {
            mood.starttime = 0;
        }
        
        if ( istrue( var_35963274858b5330 ) && mood.starttime == 0 )
        {
            return mood;
        }
        
        moodtime = mood.starttime * 60;
        
        if ( moodtime > currenttime && moodtime - currenttime <= timedelta )
        {
            return mood;
        }
    }
    
    return undefined;
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 2
// Checksum 0x0, Offset: 0xc93
// Size: 0x71
function function_519c36cfe2838f8a( player, isrejoining )
{
    exploders = level.currentmood.state.exploders;
    
    if ( !isdefined( exploders ) || exploders.size == 0 )
    {
        return;
    }
    
    for ( i = 0; i < exploders.size ; i++ )
    {
        exploders[ i ] thread handleexploder( i, player, isrejoining );
    }
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 3
// Checksum 0x0, Offset: 0xd0c
// Size: 0x16b
function handleexploder( index, player, isrejoining )
{
    level endon( "game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    explodersdelay = level.currentmood.explodersdelay;
    
    if ( isdefined( explodersdelay ) && explodersdelay.size > 0 && isdefined( explodersdelay[ index ] ) && isdefined( explodersdelay[ index ].delay ) )
    {
        delay = explodersdelay[ index ].delay;
        
        /#
            if ( istrue( level.var_5872a7af669d9983 ) )
            {
                delay = 0;
            }
        #/
        
        wait delay;
    }
    
    if ( istrue( self.active ) )
    {
        if ( isdefined( level.var_5c0ae670b3d932f3 ) && istrue( level.var_5c0ae670b3d932f3[ self.name ] ) )
        {
            return;
        }
        
        if ( isdefined( player ) && isplayer( player ) )
        {
            if ( !istrue( isrejoining ) )
            {
                player waittill( "spawned_player" );
            }
            
            activateclientexploder( self.name, player, gettime(), level.var_e198c297ceb14c19 );
        }
        else
        {
            activateclientexploder( self.name, level.players, gettime(), level.var_e198c297ceb14c19 );
            level.var_5c0ae670b3d932f3[ self.name ] = 1;
        }
        
        return;
    }
    
    stopclientexploder( self.name );
    level.var_5c0ae670b3d932f3[ self.name ] = undefined;
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 0
// Checksum 0x0, Offset: 0xe7f
// Size: 0xae
function function_5dd4a6bdc5a18a0f()
{
    exploders = level.currentmood.state.exploders;
    
    if ( !isdefined( exploders ) || exploders.size == 0 )
    {
        return;
    }
    
    if ( !isdefined( level.var_5c0ae670b3d932f3 ) )
    {
        level.var_5c0ae670b3d932f3 = [];
    }
    
    for ( i = 0; i < exploders.size ; i++ )
    {
        if ( istrue( exploders[ i ].active ) )
        {
            level.var_5c0ae670b3d932f3[ exploders[ i ].name ] = 1;
            continue;
        }
        
        level.var_5c0ae670b3d932f3[ exploders[ i ].name ] = undefined;
    }
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 2
// Checksum 0x0, Offset: 0xf35
// Size: 0x71
function function_24427ed3f5c1ccc3( player, isrejoining )
{
    soundeffects = level.currentmood.state.soundeffects;
    
    if ( !isdefined( soundeffects ) || soundeffects.size == 0 )
    {
        return;
    }
    
    for ( i = 0; i < soundeffects.size ; i++ )
    {
        soundeffects[ i ] thread function_6fad46877de34a3b( i, player, isrejoining );
    }
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 3
// Checksum 0x0, Offset: 0xfae
// Size: 0xf9
function function_6fad46877de34a3b( index, player, isrejoining )
{
    level endon( "game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    id = scripts\engine\utility::default_to( self.id, "" );
    state = scripts\engine\utility::default_to( self.state, "" );
    fadetime = 10;
    fadetimes = level.currentmood.var_c55ce35ed96a2d2c;
    
    if ( isdefined( fadetimes ) && isdefined( fadetimes[ index ] ) )
    {
        fadetime = scripts\engine\utility::default_to( fadetimes[ index ].fadetime, fadetime );
    }
    
    /#
        if ( istrue( level.var_5872a7af669d9983 ) )
        {
            fadetime = 0;
        }
    #/
    
    if ( isdefined( player ) && isplayer( player ) )
    {
        if ( !istrue( isrejoining ) )
        {
            player waittill( "spawned_player" );
        }
        
        setaudiotriggerstate( id, state, fadetime, player );
        return;
    }
    
    setaudiotriggerstate( id, state, fadetime );
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 0
// Checksum 0x0, Offset: 0x10af
// Size: 0x20f
function function_d579bab00a3ef871()
{
    level endon( "game_ended" );
    
    if ( level.currentmood.transitiontype == "circles" && isdefined( level.currentmood.circleindex ) && level.currentmood.circleindex == -1 && !istrue( level.debugtransition ) )
    {
        level waittill( "prematch_fade_done" );
        prematch = 1;
    }
    
    if ( !isdefined( level.currentmood.state.sunlight ) )
    {
        return;
    }
    
    sunlight = [];
    
    if ( isdefined( level.currentmood.state.sunlight.color ) && level.currentmood.state.sunlight.color != "" )
    {
        tokens = strtok( level.currentmood.state.sunlight.color, " " );
        red = float( tokens[ 0 ] );
        green = float( tokens[ 1 ] );
        blue = float( tokens[ 2 ] );
        sunlight[ sunlight.size ] = scripts\engine\utility::ter_op( red != 0, red, undefined );
        sunlight[ sunlight.size ] = scripts\engine\utility::ter_op( green != 0, green, undefined );
        sunlight[ sunlight.size ] = scripts\engine\utility::ter_op( blue != 0, blue, undefined );
    }
    
    sunlight[ sunlight.size ] = level.currentmood.state.sunlight.intensity;
    duration = level.currentmood.transitiontime;
    
    if ( istrue( prematch ) )
    {
        duration = 0;
    }
    
    thread function_e926344af0b8a54e( sunlight, duration );
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 2
// Checksum 0x0, Offset: 0x12c6
// Size: 0x321
function function_e926344af0b8a54e( final, time )
{
    level endon( "game_ended" );
    
    if ( !isdefined( final ) )
    {
        return;
    }
    
    /#
        if ( istrue( level.var_5872a7af669d9983 ) )
        {
            time = 0;
        }
    #/
    
    changecolor = isdefined( final[ 0 ] ) && isdefined( final[ 1 ] ) && isdefined( final[ 2 ] );
    changeintensity = isdefined( final[ 3 ] ) || isdefined( final[ 0 ] ) && !changecolor;
    
    if ( !istrue( changecolor ) && !istrue( changeintensity ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_8c4540ab5278f235 ) )
    {
        level.var_8c4540ab5278f235 = [];
    }
    
    initial = [];
    
    if ( changecolor )
    {
        initial[ 0 ] = scripts\engine\utility::default_to( level.var_8c4540ab5278f235[ 0 ], level.var_ae361b9fc9ed6213 );
        initial[ 1 ] = scripts\engine\utility::default_to( level.var_8c4540ab5278f235[ 1 ], level.var_8ee11212ceb130ef );
        initial[ 2 ] = scripts\engine\utility::default_to( level.var_8c4540ab5278f235[ 2 ], level.var_f8397ff86c4282e8 );
    }
    
    if ( changeintensity )
    {
        if ( changecolor )
        {
            index = 3;
        }
        else
        {
            index = 0;
        }
        
        initial[ index ] = scripts\engine\utility::default_to( level.var_8c4540ab5278f235[ 3 ], level.var_fbca612d854a3975 );
    }
    
    if ( isdefined( time ) && time > 0 )
    {
        range = [];
        
        for ( i = 0; i < final.size ; i++ )
        {
            if ( isdefined( final[ i ] ) )
            {
                range[ i ] = final[ i ] - initial[ i ];
            }
        }
        
        next = initial;
        interval = 0.25;
        count = int( time / interval );
        
        if ( count > 0 )
        {
            delta = [];
            
            for ( i = 0; i < range.size ; i++ )
            {
                if ( isdefined( range[ i ] ) )
                {
                    delta[ i ] = range[ i ] / count;
                }
            }
            
            while ( count )
            {
                for ( i = 0; i < delta.size ; i++ )
                {
                    if ( isdefined( delta[ i ] ) )
                    {
                        next[ i ] += delta[ i ];
                    }
                }
                
                if ( changecolor && changeintensity )
                {
                    setsuncolorandintensity( next[ 0 ], next[ 1 ], next[ 2 ], next[ 3 ] );
                }
                else if ( changecolor )
                {
                    setsuncolorandintensity( next[ 0 ], next[ 1 ], next[ 2 ] );
                }
                else
                {
                    setsuncolorandintensity( next[ 0 ] );
                }
                
                wait interval;
                count--;
            }
        }
    }
    
    if ( changecolor && changeintensity )
    {
        setsuncolorandintensity( final[ 0 ], final[ 1 ], final[ 2 ], final[ 3 ] );
        level.var_8c4540ab5278f235[ 0 ] = final[ 0 ];
        level.var_8c4540ab5278f235[ 1 ] = final[ 1 ];
        level.var_8c4540ab5278f235[ 2 ] = final[ 2 ];
        level.var_8c4540ab5278f235[ 3 ] = final[ 3 ];
        return;
    }
    
    if ( changecolor )
    {
        setsuncolorandintensity( final[ 0 ], final[ 1 ], final[ 2 ] );
        level.var_8c4540ab5278f235[ 0 ] = final[ 0 ];
        level.var_8c4540ab5278f235[ 1 ] = final[ 1 ];
        level.var_8c4540ab5278f235[ 2 ] = final[ 2 ];
        return;
    }
    
    setsuncolorandintensity( final[ 0 ] );
    level.var_8c4540ab5278f235[ 3 ] = final[ 0 ];
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 1
// Checksum 0x0, Offset: 0x15ef
// Size: 0x18c
function function_2ef05a1df426a720( prematch )
{
    level endon( "game_ended" );
    
    if ( !isdefined( level.currentmood.state.configuration ) || level.currentmood.state.configuration == "" )
    {
        return;
    }
    
    if ( isdefined( level.var_b50a28b117aa65cd ) )
    {
        hwconfiguratorremoveasset( level.var_b50a28b117aa65cd );
    }
    
    if ( isdefined( level.currentmood.var_e3cf72e793015995 ) )
    {
        delay = level.currentmood.var_e3cf72e793015995;
        
        /#
            if ( istrue( level.var_5872a7af669d9983 ) )
            {
                hwconfiguratoraddasset( level.currentmood.state.configuration );
                level.var_b50a28b117aa65cd = level.currentmood.state.configuration;
                return;
            }
        #/
        
        wait delay;
    }
    
    if ( istrue( prematch ) )
    {
        hwconfiguratoraddasset( level.currentmood.state.configuration );
    }
    else
    {
        hwconfiguratorlerpasset( level.currentmood.state.configuration, level.var_7a5d55a09a3e77c8, "MIDDLE" );
    }
    
    level.var_b50a28b117aa65cd = level.currentmood.state.configuration;
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 0
// Checksum 0x0, Offset: 0x1783
// Size: 0x31
function function_ba1ac5101c4b8b85()
{
    initialmood = undefined;
    
    if ( function_3a1b9192a1f0b3c4() )
    {
        initialmood = function_12f05fef0df24cd7( 0, 1 );
    }
    else
    {
        initialmood = function_8725cc1e47d95528( -1 );
    }
    
    return initialmood;
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 0
// Checksum 0x0, Offset: 0x17bd
// Size: 0x18
function function_6954edb9716497e3()
{
    level endon( "game_ended" );
    level waittill( "prematch_fade_done" );
    function_5dd4a6bdc5a18a0f();
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 1
// Checksum 0x0, Offset: 0x17dd
// Size: 0x10e
function overridedvars( dvars )
{
    if ( getdvarint( @"hash_ad3c6321de2d697f", 1 ) <= 0 )
    {
        return;
    }
    
    if ( !isdefined( dvars ) || dvars.size == 0 )
    {
        return;
    }
    
    foreach ( dvar in dvars )
    {
        if ( isdefined( dvar ) && isdefined( dvar.name ) && isdefined( dvar.value ) )
        {
            if ( isdvardefined( dvar.name ) )
            {
                setdvar( dvar.name, dvar.value );
                continue;
            }
            
            dvarname = getxhashhexname( dvar.name );
            
            /#
                dvarname = getxhashsourcename( dvar.name );
            #/
            
            scripts\mp\utility\script::demoforcesre( "Trying to override an undefined dvar \"" + dvarname + "\". The dvar must either be defined in a playlist, .cfg file or through command line arguments." );
        }
    }
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 0
// Checksum 0x0, Offset: 0x18f3
// Size: 0x2c, Type: bool
function isbr()
{
    gametypebundle = getgametypescriptbundle();
    
    if ( isdefined( gametypebundle ) && istrue( gametypebundle.isbrstylegametype ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
// Params 0
// Checksum 0x0, Offset: 0x1928
// Size: 0x41, Type: bool
function function_3a1b9192a1f0b3c4()
{
    gametypebundle = getgametypescriptbundle();
    
    if ( isdefined( gametypebundle ) && isdefined( gametypebundle.brsubgametype ) && gametypebundle.brsubgametype == "dmz" )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
    // Params 0
    // Checksum 0x0, Offset: 0x1972
    // Size: 0xc, Type: dev
    function debug_init()
    {
        devgui_init();
    }

    // Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
    // Params 0
    // Checksum 0x0, Offset: 0x1986
    // Size: 0x18c, Type: dev
    function devgui_init()
    {
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x1c>" );
        scripts\common\devgui::function_a9a864379a098ad6( "<dev string:x33>", "<dev string:x40>", &function_40c5de300f64bca5 );
        scripts\common\devgui::function_a9a864379a098ad6( "<dev string:x4d>", "<dev string:x6f>", &function_aaadc13812c2ef4b );
        scripts\common\devgui::function_a9a864379a098ad6( "<dev string:x82>", "<dev string:x9d>", &function_abcd11e9abe86202 );
        scripts\common\devgui::function_fe953f000498048f();
        
        for ( i = 0; i < level.moods.size ; i++ )
        {
            if ( isdefined( level.moods[ i ].state ) && isdefined( level.moods[ i ].state.visionsetsuffix ) && level.moods[ i ].state.visionsetsuffix != "<dev string:xb4>" )
            {
                moodname = level.moods[ i ].state.visionsetsuffix;
            }
            else
            {
                moodname = i;
            }
            
            scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:xb8>" + moodname );
            scripts\common\devgui::function_fe953f000498048f();
            scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:xb8>" + moodname + "<dev string:xd4>" );
            scripts\common\devgui::function_b23a59dfb4ca49a1( "<dev string:xb4>", "<dev string:xea>" + i, &function_9fb263cc4b9c7d63 );
            scripts\common\devgui::function_fe953f000498048f();
            scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:xb8>" + moodname + "<dev string:x105>" );
            scripts\common\devgui::function_b23a59dfb4ca49a1( "<dev string:xb4>", "<dev string:x11c>" + i, &function_557893706e808ca5 );
            scripts\common\devgui::function_fe953f000498048f();
        }
    }

    // Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
    // Params 1
    // Checksum 0x0, Offset: 0x1b1a
    // Size: 0x49, Type: dev
    function function_9fb263cc4b9c7d63( params )
    {
        index = int( params[ 0 ] );
        level.debugtransition = 1;
        setmood( level.moods[ index ] );
        level.debugtransition = 0;
    }

    // Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
    // Params 1
    // Checksum 0x0, Offset: 0x1b6b
    // Size: 0x5e, Type: dev
    function function_557893706e808ca5( params )
    {
        level.var_5872a7af669d9983 = 1;
        level.debugtransition = 1;
        index = int( params[ 0 ] );
        setmood( level.moods[ index ] );
        level.var_5872a7af669d9983 = 0;
        level.debugtransition = 0;
    }

    // Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
    // Params 0
    // Checksum 0x0, Offset: 0x1bd1
    // Size: 0xc8, Type: dev
    function function_40c5de300f64bca5()
    {
        if ( !isdefined( level.var_8c4540ab5278f235 ) )
        {
            return;
        }
        
        final = level.var_8c4540ab5278f235;
        resetcolor = isdefined( final[ 0 ] ) && isdefined( final[ 1 ] ) && isdefined( final[ 2 ] );
        resetintensity = isdefined( final[ 3 ] );
        
        if ( resetcolor && resetintensity )
        {
            setsuncolorandintensity( level.var_ae361b9fc9ed6213, level.var_8ee11212ceb130ef, level.var_f8397ff86c4282e8, level.var_fbca612d854a3975 );
            return;
        }
        
        if ( resetcolor )
        {
            setsuncolorandintensity( level.var_ae361b9fc9ed6213, level.var_8ee11212ceb130ef, level.var_f8397ff86c4282e8 );
            return;
        }
        
        if ( resetintensity )
        {
            setsuncolorandintensity( level.var_fbca612d854a3975 );
        }
    }

    // Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
    // Params 0
    // Checksum 0x0, Offset: 0x1ca1
    // Size: 0x28, Type: dev
    function function_aaadc13812c2ef4b()
    {
        replacevisionset( 0, "<dev string:xb4>" );
        
        if ( isdefined( level.currentmood ) )
        {
            level.currentmood = undefined;
        }
    }

    // Namespace namespace_11161030531bb10d / namespace_781727f0de488c93
    // Params 0
    // Checksum 0x0, Offset: 0x1cd1
    // Size: 0x9d, Type: dev
    function function_abcd11e9abe86202()
    {
        function_40c5de300f64bca5();
        function_aaadc13812c2ef4b();
        hwconfiguratorclearassets();
        
        if ( isdefined( level.var_5c0ae670b3d932f3 ) )
        {
            foreach ( explodername, active in level.var_5c0ae670b3d932f3 )
            {
                if ( istrue( level.var_5c0ae670b3d932f3[ explodername ] ) )
                {
                    stopclientexploder( explodername );
                    level.var_5c0ae670b3d932f3[ explodername ] = undefined;
                }
            }
            
            level.var_5c0ae670b3d932f3 = undefined;
        }
    }

#/
