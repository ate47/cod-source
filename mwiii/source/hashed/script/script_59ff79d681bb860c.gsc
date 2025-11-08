#using script_27fdece778e999d8;
#using script_40e63dd222434655;
#using script_4c9bd9a3bf3f8cf7;
#using script_72af5a878a9d3397;
#using script_d74ae0b4aa21186;
#using scripts\common\utility;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_util;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\hostmigration;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;

#namespace namespace_dc8eaf12d4db25da;

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 1
// Checksum 0x0, Offset: 0x23e
// Size: 0xa4
function onbotspawnedcommon( nextstatus )
{
    self.onlyscriptenemy = 1;
    namespace_92443376a63aa4bd::function_3283fdac29887de();
    scripts\mp\bots\bots::function_81c6c4218188e7d8();
    bot_set_personality( "run_and_gun" );
    
    if ( !isdefined( self.mind_personality ) )
    {
        self.mind_personality = function_15782eaeb4ab0963();
        assert( isdefined( self.mind_personality ) );
    }
    
    function_142b713a2846f9ac( "Spawned" );
    function_1e8fe34f5dfdea49( nextstatus );
    self botsetflag( "disable_random_goal", 1 );
    self botsetflag( "allow_slide_for_any_script_goal", 1 );
    self botsetflag( "ignore_script_weapon", 1 );
    namespace_56b9cc3deb6e3f5e::initialize();
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 0
// Checksum 0x0, Offset: 0x2ea
// Size: 0x1ca
function function_d55289ceec7cf934()
{
    difficulties = level.bot_difficulties;
    
    if ( !isdefined( difficulties ) )
    {
        var_8c5d55b0ead80abf = getdvarfloat( @"hash_60ae0d4490076046", 1 );
        var_35e09d79ae15a095 = getdvarfloat( @"hash_55ccab727e144f34", 0 );
        var_7aac57efd078c334 = getdvarfloat( @"hash_b3f66372fb38fccb", 0 );
        var_b5873813dd27a2f2 = getdvarfloat( @"hash_ff9490c8b80cf74f", 0 );
        var_f8793c23a0ec47ab = var_8c5d55b0ead80abf + var_35e09d79ae15a095 + var_7aac57efd078c334 + var_b5873813dd27a2f2;
        assert( var_8c5d55b0ead80abf >= 0 );
        assert( var_35e09d79ae15a095 >= 0 );
        assert( var_7aac57efd078c334 >= 0 );
        assert( var_b5873813dd27a2f2 >= 0 );
        assert( var_f8793c23a0ec47ab > 0 );
        difficulties = spawnstruct();
        difficulties.var_85ec8c8fb7e29d44 = var_8c5d55b0ead80abf / var_f8793c23a0ec47ab;
        difficulties.regularsection = var_35e09d79ae15a095 / var_f8793c23a0ec47ab + difficulties.var_85ec8c8fb7e29d44;
        difficulties.var_a206039ee7e144ad = var_7aac57efd078c334 / var_f8793c23a0ec47ab + difficulties.regularsection;
        difficulties.veteransection = var_b5873813dd27a2f2 / var_f8793c23a0ec47ab + difficulties.var_a206039ee7e144ad;
        level.bot_difficulties = difficulties;
    }
    
    randompick = randomfloat( 1 );
    
    if ( randompick < difficulties.var_85ec8c8fb7e29d44 )
    {
        return "recruit";
    }
    
    if ( randompick < difficulties.regularsection )
    {
        return "regular";
    }
    
    if ( randompick < difficulties.var_a206039ee7e144ad )
    {
        return "hardened";
    }
    
    if ( randompick < difficulties.veteransection )
    {
        return "veteran";
    }
    
    assertmsg( "<dev string:x1c>" );
    return "regular";
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 0
// Checksum 0x0, Offset: 0x4bc
// Size: 0x97
function function_15782eaeb4ab0963()
{
    personalities = level.mind.personalities;
    targetvalue = randomfloat( 1 );
    sumvalue = 0;
    
    foreach ( name, personality in personalities )
    {
        sumvalue += personality.proportion;
        
        if ( targetvalue < sumvalue )
        {
            return name;
        }
    }
    
    return undefined;
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 1
// Checksum 0x0, Offset: 0x55c
// Size: 0x125
function function_76ba0b66f2a5ef09( bot )
{
    var_c6895f82adec6365 = 0.3;
    factor = 0;
    addend = var_c6895f82adec6365;
    
    switch ( bot botgetdifficulty() )
    {
        case #"hash_29f66d99d48ef101":
            factor = getdvarfloat( @"hash_27c78d2661500e49", factor );
            addend = getdvarfloat( @"hash_c6db8f289a513376", addend );
            break;
        case #"hash_284b2545dbaa82f7":
            factor = getdvarfloat( @"hash_1ab2939c54efab3f", factor );
            addend = getdvarfloat( @"hash_71720d5fda9ada04", addend );
            break;
        case #"hash_bd9217f8be6084ee":
            factor = getdvarfloat( @"hash_3fe6928216982556", factor );
            addend = getdvarfloat( @"hash_d3f0c08b944e8c3b", addend );
            break;
        case #"hash_b66ed8ef2f4f67f4":
            factor = getdvarfloat( @"hash_9ee861df3ee7281c", factor );
            addend = getdvarfloat( @"hash_cc3a6aab020970df", addend );
            break;
        default:
            assertmsg( "<dev string:x6d>" );
            break;
    }
    
    return ( factor, addend, 0 );
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 6
// Checksum 0x0, Offset: 0x68a
// Size: 0x113
function function_d111733407f6518( meansofdeath, victim, attacker, damage, var_498a2226e5aa47ee, var_dfabe685a74f1b33 )
{
    meansofdeath = default_to( meansofdeath, "" );
    
    if ( meansofdeath == "MOD_TRIGGER_HURT" && isdefined( victim ) && istrue( victim.var_76b390d02672ecea ) )
    {
        return 0;
    }
    
    attackerisbot = isdefined( attacker ) && isbot( attacker );
    
    if ( !attackerisbot )
    {
        return damage;
    }
    
    var_5c83e2a7751cf1fe = isdefined( victim ) && isplayer( victim ) && !isbot( victim );
    
    if ( var_5c83e2a7751cf1fe )
    {
        ratio = function_4be81427cc9844c4( attacker, victim, var_498a2226e5aa47ee );
    }
    else if ( istrue( var_dfabe685a74f1b33 ) )
    {
        var_afcea1a9ddcd5adc = 0.7;
        ratio = getdvarfloat( @"hash_72dce163d860183a", var_afcea1a9ddcd5adc );
    }
    else
    {
        var_9e653cd64bad1cbc = 1.5;
        ratio = getdvarfloat( @"hash_19b1deee03b39dce", var_9e653cd64bad1cbc );
    }
    
    return damage * ratio;
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 3
// Checksum 0x0, Offset: 0x7a6
// Size: 0xfb
function function_4be81427cc9844c4( attackerbot, victimhuman, var_498a2226e5aa47ee )
{
    health = victimhuman.health;
    maxhealth = victimhuman.maxhealth;
    
    if ( istrue( var_498a2226e5aa47ee ) )
    {
        if ( isdefined( victimhuman.maxarmorhealth ) )
        {
            if ( victimhuman scripts\cp_mp\armor::hasarmor() )
            {
                health += victimhuman scripts\cp_mp\armor::function_ac266fc218266d08();
            }
            
            maxhealth += victimhuman.maxarmorhealth;
        }
    }
    
    healthpercentage = health / maxhealth;
    factor = 0;
    addend = 0;
    var_2ae0fccd506b8b92 = 1;
    
    if ( istrue( var_498a2226e5aa47ee ) )
    {
        result = namespace_bc2665cbe6cf4e1f::function_a12de8d6fa23a4d9();
        
        if ( isdefined( result ) )
        {
            factor = result[ 1 ];
            addend = result[ 2 ];
            var_2ae0fccd506b8b92 = 0;
        }
    }
    
    if ( var_2ae0fccd506b8b92 )
    {
        result = function_76ba0b66f2a5ef09( attackerbot );
        factor = result[ 0 ];
        addend = result[ 1 ];
    }
    
    return healthpercentage * factor + addend;
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 5
// Checksum 0x0, Offset: 0x8aa
// Size: 0x38a
function spawnbots( var_50ade409b1e5efcb, team, botcallback, var_a018df45312ba50f, var_dfc67eaaf62bc0 )
{
    level.var_9bb484946bcc49b2 = 1;
    var_f1b03ffe289c1025 = gettime() + 15000;
    num_bots = var_50ade409b1e5efcb.size;
    var_821516dc10ec00f0 = [];
    
    for ( botindex = var_821516dc10ec00f0.size; level.players.size < scripts\mp\bots\bots_util::bot_get_client_limit() && var_821516dc10ec00f0.size < num_bots && gettime() < var_f1b03ffe289c1025 ; botindex++ )
    {
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 0.05 );
        botprofile = var_50ade409b1e5efcb[ botindex ];
        
        if ( isdefined( botprofile.xuid ) )
        {
            bot = addbot( botprofile.name, botprofile.xuid );
        }
        else
        {
            bot = addbot( botprofile.name );
        }
        
        if ( !isdefined( bot ) )
        {
            /#
                if ( gettime() >= var_f1b03ffe289c1025 )
                {
                    println( "<dev string:x88>" );
                }
                else
                {
                    println( "<dev string:xd1>" );
                }
            #/
            
            if ( isdefined( var_a018df45312ba50f ) && var_a018df45312ba50f )
            {
                if ( isdefined( var_dfc67eaaf62bc0 ) )
                {
                    self notify( var_dfc67eaaf62bc0 );
                }
                
                return [];
            }
            
            scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 1 );
            continue;
        }
        
        assert( !isdefined( botprofile.bot ) );
        
        if ( istrue( botprofile.uibot ) )
        {
            namespace_c50b30148766aa59::function_b9c4a50390b0b5eb( bot, botprofile );
        }
        
        bot namespace_92443376a63aa4bd::function_3283fdac29887de();
        bot scripts\mp\bots\bots::function_81c6c4218188e7d8();
        connecting = spawnstruct();
        connecting.bot = bot;
        connecting.ready = 0;
        connecting.abort = 0;
        connecting.index = botindex;
        connecting.difficulty = botprofile.difficulty;
        connecting.mind_personality = botprofile.mind_personality;
        connecting.bot_squad = botprofile.squad;
        var_821516dc10ec00f0[ var_821516dc10ec00f0.size ] = connecting;
        botteam = ter_op( isdefined( team ), team, botprofile.team );
        connecting.bot thread scripts\mp\bots\bots::spawn_bot_latent( botteam, botcallback, connecting );
    }
    
    /#
        if ( gettime() >= var_f1b03ffe289c1025 )
        {
            println( "<dev string:x118>" );
        }
    #/
    
    connectedcomplete = 0;
    var_f1b03ffe289c1025 = gettime() + 60000;
    
    while ( connectedcomplete < var_821516dc10ec00f0.size && gettime() < var_f1b03ffe289c1025 )
    {
        connectedcomplete = 0;
        
        foreach ( connecting in var_821516dc10ec00f0 )
        {
            if ( connecting.ready || connecting.abort )
            {
                connectedcomplete++;
            }
        }
        
        wait 0.05;
    }
    
    botconnected = [];
    
    foreach ( connecting in var_821516dc10ec00f0 )
    {
        if ( isdefined( connecting.bot ) )
        {
            botconnected[ botconnected.size ] = connecting.bot;
        }
    }
    
    if ( isdefined( var_dfc67eaaf62bc0 ) )
    {
        self notify( var_dfc67eaaf62bc0 );
    }
    
    level.var_9bb484946bcc49b2 = undefined;
    return botconnected;
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 2
// Checksum 0x0, Offset: 0xc3d
// Size: 0x86
function selectdestination( radius, center )
{
    center = default_to( center, self.origin );
    radius = default_to( radius, 2500 );
    var_fc8b7e5e0a42ae83 = 60;
    point = function_fcc75af6225b896b( center, radius, 0.85, 1, self.angles[ 1 ] - var_fc8b7e5e0a42ae83, self.angles[ 1 ] + var_fc8b7e5e0a42ae83 );
    reachable_point = function_207ba502560fa1d2( point );
    return reachable_point;
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 6
// Checksum 0x0, Offset: 0xccc
// Size: 0x68
function function_fcc75af6225b896b( origin, radius, percentmin, percentmax, minangle, maxangle )
{
    pos = scripts\mp\gametypes\br_circle::getrandompointincircle( origin, radius, percentmin, percentmax, 0, 0, minangle, maxangle );
    return function_f8350ab882cc2439( ( pos[ 0 ], pos[ 1 ], self.origin[ 2 ] ) );
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 1
// Checksum 0x0, Offset: 0xd3d
// Size: 0x15
function function_142b713a2846f9ac( status )
{
    self.status = status;
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 1
// Checksum 0x0, Offset: 0xd5a
// Size: 0x15
function function_1e8fe34f5dfdea49( status )
{
    self.nextstatus = status;
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 0
// Checksum 0x0, Offset: 0xd77
// Size: 0xb
function function_9230bcb84b43d245()
{
    return self.nextstatus;
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 2
// Checksum 0x0, Offset: 0xd8b
// Size: 0x40
function setscriptgoal( origin, radius )
{
    assert( radius == 0 || radius >= 4 );
    self botclearscriptgoal();
    self botsetscriptgoal( origin, radius, "tactical", undefined, undefined, 1 );
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 2
// Checksum 0x0, Offset: 0xdd3
// Size: 0x81
function function_207ba502560fa1d2( randompoint, maxdistance )
{
    dist2d = distance2d( self.origin, randompoint );
    maxdistance = default_to( maxdistance, 2000 );
    
    if ( dist2d > maxdistance )
    {
        temppos = vectorlerp( self.origin, randompoint, maxdistance / dist2d );
        randompoint = function_f8350ab882cc2439( ( temppos[ 0 ], temppos[ 1 ], self.origin[ 2 ] ) );
    }
    
    return self getclosestreachablepointonnavmesh( randompoint );
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 1
// Checksum 0x0, Offset: 0xe5d
// Size: 0x6c
function setenemy( enemy )
{
    if ( isdefined( enemy ) && isdefined( self.scriptenemy ) && isdefined( self.enemy ) && self.scriptenemy == enemy && self.enemy == enemy )
    {
        return;
    }
    
    if ( isdefined( enemy ) )
    {
        self botsetscriptenemy( enemy );
    }
    else
    {
        self botclearscriptenemy();
    }
    
    self.scriptenemy = enemy;
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 1
// Checksum 0x0, Offset: 0xed1
// Size: 0x28, Type: bool
function isaliveplayer( player )
{
    return isdefined( player ) && istrue( player.connected ) && scripts\mp\utility\player::isreallyalive( player );
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 1
// Checksum 0x0, Offset: 0xf02
// Size: 0x27
function isvalidplayer( player )
{
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        return namespace_bc2665cbe6cf4e1f::isvalidplayerbr( player );
    }
    
    return namespace_da125b44c190d236::isvalidplayermp( player );
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 1
// Checksum 0x0, Offset: 0xf31
// Size: 0x23, Type: bool
function function_f309740bc6350c0e( agent )
{
    if ( !isagent( agent ) )
    {
        return false;
    }
    
    if ( !isalive( agent ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 1
// Checksum 0x0, Offset: 0xf5d
// Size: 0x7f, Type: bool
function isvalidtarget( player )
{
    if ( !isvalidplayer( player ) && !function_f309740bc6350c0e( player ) )
    {
        return false;
    }
    
    if ( isdefined( player.vehicle ) && istrue( player.vehicle.isheli ) )
    {
        var_cea0b2e80126162e = 658;
        
        if ( player.origin[ 2 ] - self.origin[ 2 ] > var_cea0b2e80126162e )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 1
// Checksum 0x0, Offset: 0xfe5
// Size: 0x34
function function_6ddd1f755a24720f( var_6f7ce33fc2a39bcd )
{
    if ( var_6f7ce33fc2a39bcd.var_1cd1b7db5606880e == "main" && isdefined( self ) )
    {
        setenemy( undefined );
        self botclearscriptgoal();
    }
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 1
// Checksum 0x0, Offset: 0x1021
// Size: 0x1f3
function function_cf1a9e98122e3931( target )
{
    primaryequipment = scripts\mp\equipment::getequipmentslotammo( "primary" );
    secondaryequipment = scripts\mp\equipment::getequipmentslotammo( "secondary" );
    hasgrenade = isdefined( primaryequipment ) && primaryequipment > 0 || isdefined( secondaryequipment ) && secondaryequipment > 0;
    
    if ( hasgrenade )
    {
        var_e1dfc5a054b93827 = distancesquared( self.origin, target.origin );
        var_ffe68641c6dc7cd3 = 211600;
        
        if ( var_e1dfc5a054b93827 < var_ffe68641c6dc7cd3 )
        {
            return;
        }
        
        var_962e254e583d9e3 = self botcanseeentity( target );
        
        if ( !var_962e254e583d9e3 )
        {
            var_13c4033676c21c00 = target gettagorigin( "j_spinelower" );
            var_962e254e583d9e3 = scripts\engine\trace::can_see_origin( var_13c4033676c21c00 );
        }
        
        if ( !var_962e254e583d9e3 )
        {
            directiontotarget = vectornormalize( target.origin - self.origin );
            var_dcd388ddc7034fa8 = ( directiontotarget[ 1 ], directiontotarget[ 0 ] * -1, 0 );
            var_95d7facdceab8bb7 = ( directiontotarget[ 1 ] * -1, directiontotarget[ 0 ], 0 );
            var_7a645c4a72dfd237 = [];
            mainroot = target gettagorigin( "j_mainroot" );
            var_7a645c4a72dfd237[ var_7a645c4a72dfd237.size ] = target gettagorigin( "j_head" ) + ( 0, 0, 50 );
            var_7a645c4a72dfd237[ var_7a645c4a72dfd237.size ] = mainroot + var_dcd388ddc7034fa8 * 50;
            var_7a645c4a72dfd237[ var_7a645c4a72dfd237.size ] = mainroot + var_95d7facdceab8bb7 * 50;
            var_7a645c4a72dfd237[ var_7a645c4a72dfd237.size ] = mainroot + var_dcd388ddc7034fa8 * 100;
            var_7a645c4a72dfd237[ var_7a645c4a72dfd237.size ] = mainroot + var_95d7facdceab8bb7 * 100;
            
            foreach ( point in var_7a645c4a72dfd237 )
            {
                if ( scripts\engine\trace::can_see_origin( point ) )
                {
                    self botthrowscriptedgrenade( point, "lethal", 1 );
                    break;
                }
            }
        }
    }
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 1
// Checksum 0x0, Offset: 0x121c
// Size: 0x82
function getentityname( entity )
{
    assert( isent( entity ) );
    
    if ( isplayer( entity ) && !isbot( entity ) )
    {
        return ( "#" + entity getplayerunoid() );
    }
    else if ( isdefined( entity.name ) )
    {
        return entity.name;
    }
    else if ( isdefined( entity.var_8aa9efe6383c1d5a ) )
    {
        return entity.var_8aa9efe6383c1d5a;
    }
    
    return "entity" + entity getentitynumber();
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 1
// Checksum 0x0, Offset: 0x12a7
// Size: 0x15
function function_c73ffcc4d5a2bc9c( notifystr )
{
    waitframe();
    
    if ( isdefined( self ) )
    {
        self notify( notifystr );
    }
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 1
// Checksum 0x0, Offset: 0x12c4
// Size: 0x4f, Type: bool
function function_57195fc2e39f0e10( var_4690ee88748bdf9b )
{
    for ( index = 0; index < var_4690ee88748bdf9b.size - 1 ; index++ )
    {
        current = var_4690ee88748bdf9b[ index ];
        next = var_4690ee88748bdf9b[ index + 1 ];
        
        if ( current > next )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 3
// Checksum 0x0, Offset: 0x131c
// Size: 0xab
function function_9d1ab012058221bb( x, xvalues, yvalues )
{
    assert( function_57195fc2e39f0e10( xvalues ) );
    assert( xvalues.size > 0 && xvalues.size == yvalues.size );
    
    for ( i = 0; i < xvalues.size ; i++ )
    {
        xvalue = xvalues[ i ];
        
        if ( x < xvalue )
        {
            if ( i == 0 )
            {
                return yvalues[ 0 ];
            }
            
            rate = lerp_fraction( xvalues[ i - 1 ], xvalue, x );
            return lerp( yvalues[ i - 1 ], yvalues[ i ], rate );
        }
    }
    
    return yvalues[ yvalues.size - 1 ];
}

// Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
// Params 1
// Checksum 0x0, Offset: 0x13d0
// Size: 0xc1, Type: bool
function function_3569a4bec8b9af17( player )
{
    if ( isdefined( self.attackerdata ) && self.attackerdata.size > 0 )
    {
        foreach ( attacker in self.attackerdata )
        {
            if ( isdefined( attacker ) && isdefined( attacker.attackerent ) && attacker.attackerent == player && !istrue( player.inlaststand ) )
            {
                return ( gettime() - attacker.lasttimedamaged < 5000 );
            }
        }
    }
    
    return false;
}

/#

    // Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
    // Params 0
    // Checksum 0x0, Offset: 0x149a
    // Size: 0x73, Type: dev
    function setupdevgui()
    {
        humanplayer = scripts\mp\bots\bots::get_human_player();
        
        if ( !isdefined( humanplayer ) )
        {
            return;
        }
        
        cmd = "<dev string:x13d>";
        adddevguicmd( cmd );
        cmd = "<dev string:x19f>";
        adddevguicmd( cmd );
        cmd = "<dev string:x201>";
        adddevguicmd( cmd );
        cmd = "<dev string:x261>";
        adddevguicmd( cmd );
        level thread function_a47f77af11ab531d();
        humanplayer thread function_d3d9d9ce8bb3754d();
    }

    // Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
    // Params 1
    // Checksum 0x0, Offset: 0x1515
    // Size: 0x12f, Type: dev
    function adddevguicmd( command )
    {
        finalcommand = "<dev string:x2d1>";
        alltokens = strtok( command, "<dev string:x2d5>" );
        tokensnumber = 0;
        
        foreach ( tok in alltokens )
        {
            token = strtok( tok, "<dev string:x2da>" );
            count = 1;
            size = token.size;
            
            foreach ( new_tok in token )
            {
                if ( count < size )
                {
                    finalcommand = finalcommand + new_tok + "<dev string:x2da>";
                }
                else
                {
                    finalcommand += new_tok;
                }
                
                count++;
            }
            
            tokensnumber++;
            
            if ( tokensnumber < alltokens.size )
            {
                finalcommand += "<dev string:x2d5>";
            }
        }
        
        adddebugcommand( finalcommand );
    }

    // Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
    // Params 0
    // Checksum 0x0, Offset: 0x164c
    // Size: 0x182, Type: dev
    function function_a47f77af11ab531d()
    {
        level endon( "<dev string:x2df>" );
        
        while ( !isdefined( level.players ) )
        {
            wait 1;
        }
        
        setdvarifuninitialized( @"hash_283524741d876bcd", 0 );
        
        for ( showoutline = 0; true ; showoutline = !getdvarint( @"hash_283524741d876bcd", 0 ) )
        {
            if ( showoutline != getdvarint( @"hash_283524741d876bcd", 0 ) )
            {
                showoutline = getdvarint( @"hash_283524741d876bcd", 0 );
                
                if ( showoutline > 0 )
                {
                    foreach ( player in level.players )
                    {
                        if ( !isbot( player ) )
                        {
                            continue;
                        }
                        
                        if ( isdefined( player.enemy ) )
                        {
                            player hudoutlineenable( "<dev string:x2ed>" );
                            continue;
                        }
                        
                        player hudoutlineenable( "<dev string:x304>" );
                    }
                }
                else
                {
                    foreach ( player in level.players )
                    {
                        if ( !isbot( player ) )
                        {
                            continue;
                        }
                        
                        player hudoutlinedisable();
                    }
                }
            }
            
            msg = level waittill_any_in_array_or_timeout( [ "<dev string:x31d>" ], 1 );
            
            if ( msg == "<dev string:x31d>" )
            {
            }
        }
    }

    // Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
    // Params 0
    // Checksum 0x0, Offset: 0x17d6
    // Size: 0x4ca, Type: dev
    function function_d3d9d9ce8bb3754d()
    {
        level endon( "<dev string:x2df>" );
        setdvarifuninitialized( @"hash_2f602ff4fd08630f", 0 );
        setdvarifuninitialized( @"hash_d458c30556bf9e8c", 0 );
        var_de5a5558ba4d830a = ( 1, 0.94902, 0 );
        var_c89cc0d4a5adb6d5 = ( 1, 0.8, 0.5 );
        var_76bf76544f2ff143 = 30;
        
        while ( true )
        {
            drawoption = getdvarint( @"hash_2f602ff4fd08630f", 0 );
            
            if ( drawoption <= 0 )
            {
                wait 1;
                continue;
            }
            
            drawteam = getdvarint( @"hash_d458c30556bf9e8c", 0 );
            
            foreach ( bot in level.players )
            {
                eliminated = scripts\cp_mp\utility\game_utility::isbrstylegametype() && bot namespace_bc2665cbe6cf4e1f::iseliminated();
                
                if ( !isbot( bot ) || eliminated )
                {
                    continue;
                }
                
                if ( drawteam )
                {
                    bots = scripts\mp\utility\teams::getteamdata( bot.team, "<dev string:x32f>" );
                    
                    foreach ( teammate in bots )
                    {
                        if ( teammate == bot || !isvalidplayer( teammate ) )
                        {
                            continue;
                        }
                        
                        line( bot.origin, teammate.origin, ( 0, 0, 1 ), 1, 0, 1 );
                    }
                }
                
                scale = 0.75;
                
                if ( drawoption == 2 )
                {
                    distance = distance( self.origin, bot.origin );
                    scale = distance * 0.65 / 600;
                    
                    if ( scale < 0.4 )
                    {
                        scale = 0.4;
                    }
                }
                
                linespacing = -1 / scale * 10;
                printlocation = bot.origin;
                spectatingplayer = scripts\mp\gametypes\br_spectate::playergetspectatingplayer();
                var_89bee820769f600d = isdefined( spectatingplayer ) && spectatingplayer == bot;
                screenx = 600;
                screeny = 700;
                printstring = "<dev string:x33f>" + bot.team + "<dev string:x349>" + bot.name;
                print3d( printlocation, printstring, var_de5a5558ba4d830a, 1, scale, 1 );
                printlocation += ( 0, 0, linespacing );
                
                if ( var_89bee820769f600d )
                {
                    printtoscreen2d( screenx, screeny, printstring, var_c89cc0d4a5adb6d5, 1.5 );
                    screeny += var_76bf76544f2ff143;
                }
                
                if ( isdefined( bot.status ) && bot.status.size > 0 )
                {
                    printstring = "<dev string:x354>" + bot.status;
                    
                    if ( isdefined( bot.mind_personality ) )
                    {
                        printstring += "<dev string:x360>" + bot function_d72fc34d742ef919();
                    }
                    
                    printstring += "<dev string:x360>" + bot function_21fe18b1e1e83a2a();
                    print3d( printlocation, printstring, var_de5a5558ba4d830a, 1, scale, 1 );
                    printlocation += ( 0, 0, linespacing );
                    
                    if ( var_89bee820769f600d )
                    {
                        printtoscreen2d( screenx, screeny, printstring, var_c89cc0d4a5adb6d5, 1.5 );
                        screeny += var_76bf76544f2ff143;
                    }
                }
                
                if ( isdefined( bot.mind ) )
                {
                    var_c7fdf89d998c52f1 = 3;
                    var_577f45571c039a54 = bot namespace_56b9cc3deb6e3f5e::function_e3becfc53745debe( var_c7fdf89d998c52f1 );
                    
                    if ( var_577f45571c039a54.size > 0 )
                    {
                        print3d( printlocation, "<dev string:x367>" + var_577f45571c039a54, var_de5a5558ba4d830a, 1, scale, 1 );
                        
                        if ( var_89bee820769f600d )
                        {
                            printtoscreen2d( screenx, screeny, "<dev string:x367>" + var_577f45571c039a54, var_c89cc0d4a5adb6d5, 1.5 );
                        }
                    }
                    
                    printlocation += ( 0, 0, linespacing );
                    
                    if ( var_89bee820769f600d )
                    {
                        screeny += var_76bf76544f2ff143;
                    }
                    
                    actions = bot namespace_56b9cc3deb6e3f5e::function_895e12d8ae226936();
                    
                    if ( actions.size > 0 )
                    {
                        print3d( printlocation, "<dev string:x376>" + actions, var_de5a5558ba4d830a, 1, scale, 1 );
                        printlocation += ( 0, 0, linespacing );
                        
                        if ( var_89bee820769f600d )
                        {
                            printtoscreen2d( screenx, screeny, "<dev string:x376>" + actions, var_c89cc0d4a5adb6d5, 1.5 );
                            screeny += var_76bf76544f2ff143;
                        }
                    }
                    
                    lasterror = bot namespace_56b9cc3deb6e3f5e::function_7ec4108a3d7a4091();
                    
                    if ( isdefined( lasterror ) )
                    {
                        printstring = "<dev string:x383>" + lasterror;
                        print3d( printlocation, printstring, var_de5a5558ba4d830a, 1, scale, 1 );
                        printlocation += ( 0, 0, linespacing );
                        
                        if ( var_89bee820769f600d )
                        {
                            printtoscreen2d( screenx, screeny, printstring, var_c89cc0d4a5adb6d5, 1.5 );
                            screeny += var_76bf76544f2ff143;
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
    // Params 0
    // Checksum 0x0, Offset: 0x1ca8
    // Size: 0x6c, Type: dev
    function function_d72fc34d742ef919()
    {
        switch ( self.mind_personality )
        {
            case #"hash_7038dec66d8275be":
                return "<dev string:x39e>";
            case #"hash_6191aaef9f922f96":
                return "<dev string:x3ad>";
            case #"hash_2a3c28f3f1f0f8a":
                return "<dev string:x3c0>";
            default:
                assertmsg( "<dev string:x3c5>" );
                return "<dev string:x3e6>";
        }
    }

    // Namespace namespace_dc8eaf12d4db25da / namespace_41f4dfb71dd08362
    // Params 0
    // Checksum 0x0, Offset: 0x1d1c
    // Size: 0x7b, Type: dev
    function function_21fe18b1e1e83a2a()
    {
        switch ( self botgetdifficulty() )
        {
            case #"hash_29f66d99d48ef101":
                return "<dev string:x3f6>";
            case #"hash_284b2545dbaa82f7":
                return "<dev string:x406>";
            case #"hash_bd9217f8be6084ee":
                return "<dev string:x417>";
            case #"hash_b66ed8ef2f4f67f4":
                return "<dev string:x427>";
            default:
                assertmsg( "<dev string:x6d>" );
                return "<dev string:x3e6>";
        }
    }

#/
