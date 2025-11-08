#using script_3ed005fe9b78b9da;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;

#namespace namespace_f093628c456dc33;

// Namespace namespace_f093628c456dc33 / namespace_a834b08ee875ee74
// Params 0
// Checksum 0x0, Offset: 0x291
// Size: 0x51
function function_453d52eb553e1047()
{
    cooldownduration = getdvarfloat( @"hash_341483558fb0f08f", 20 );
    addpowerbutton( self, "shout", "+frag", &function_7f013d8a91788fdf, 0, undefined, &playerzombiecleanup, undefined, &"MP_ZXP/SHOUT", undefined, cooldownduration, "shoutStatus", "shoutProgress" );
}

// Namespace namespace_f093628c456dc33 / namespace_a834b08ee875ee74
// Params 2
// Checksum 0x0, Offset: 0x2ea
// Size: 0x92
function function_7f013d8a91788fdf( powerstruct, powerref )
{
    zombie = self;
    
    if ( !isdefined( zombie ) )
    {
        return;
    }
    
    zombie.var_3f4318a44cfc517f = undefined;
    
    if ( !zombie function_72e633a2cadc2f8f() )
    {
        zombie function_e63114420500fb();
        zombie function_ae8ecf6e5f68f1ea( zombie.var_3f4318a44cfc517f );
        zombie thread function_f2ddb7c78178c1be( powerstruct, powerref );
        return;
    }
    
    if ( zombie scripts\mp\utility\weapon::grenadeinpullback() )
    {
        zombie canceloffhands();
    }
    
    zombie thread function_120695737abd78f4( powerstruct, powerref );
    zombie thread function_502603b3a9bddbc4( powerstruct, powerref );
    zombie thread function_2726f662b9cd30a8();
}

// Namespace namespace_f093628c456dc33 / namespace_a834b08ee875ee74
// Params 0
// Checksum 0x0, Offset: 0x384
// Size: 0x67, Type: bool
function function_72e633a2cadc2f8f()
{
    zombie = self;
    
    if ( !isdefined( zombie ) || !zombie ismutationgamemodezombie() && !function_7586e7f1e96dc16d() )
    {
        return false;
    }
    
    if ( zombie isswimunderwater() )
    {
        zombie.var_3f4318a44cfc517f = "MP_BR_INGAME/ZMB_SHOUT_ERROR_UNDERWATER";
        return false;
    }
    
    if ( zombie isonladder() )
    {
        zombie.var_3f4318a44cfc517f = "MP_BR_INGAME/ZMB_SHOUT_ERROR_LADDER";
        return false;
    }
    
    return true;
}

// Namespace namespace_f093628c456dc33 / namespace_a834b08ee875ee74
// Params 2
// Checksum 0x0, Offset: 0x3f4
// Size: 0x205
function function_502603b3a9bddbc4( powerstruct, powerref )
{
    zombie = self;
    
    if ( !isdefined( zombie ) || !isplayer( zombie ) )
    {
        return;
    }
    
    zombie endon( "death" );
    zombie endon( "disconnect" );
    zombie endon( "zombie_unset" );
    level endon( "game_ended" );
    zombie.var_a2906c0a3da2c192 = 1;
    
    if ( isdefined( powerstruct.powers[ powerref ].statusupdate ) )
    {
        function_936f0ef6e203a7fc( powerstruct.powers[ powerref ].statusupdate, 4 );
    }
    
    if ( !isbot( zombie ) )
    {
        zombie forceplaygestureviewmodel( "ges_zombie_shout" );
    }
    
    playfxontag( level._effect[ "zombie_shout" ], zombie, "j_head" );
    playfxontag( level._effect[ "zombie_shout_shockwaves" ], zombie, "tag_origin" );
    self setscriptablepartstate( "zombieRageVfx", "fx_start", 0 );
    otherteam = scripts\mp\utility\game::getotherteam( self.pers[ "team" ] )[ 0 ];
    
    foreach ( player in level.teamdata[ otherteam ][ "alivePlayers" ] )
    {
        player hudoutlineenableforclient( zombie, "outline_depth_zombievision_enemy" );
    }
    
    var_7912c8225d6a3c35 = getdvarfloat( @"hash_61b61f0247cb96ea", 5 );
    wait var_7912c8225d6a3c35;
    zombie playerzombiecleanup( powerstruct, powerref, 1 );
    zombie stopgestureviewmodel( "ges_zombie_shout" );
    zombie setscriptablepartstate( "zombieRageVfx", "fx_end", 0 );
    
    if ( isdefined( powerstruct.powers[ powerref ].statusupdate ) )
    {
        function_936f0ef6e203a7fc( powerstruct.powers[ powerref ].statusupdate, 1 );
    }
    
    zombie notify( "zombie_shout_finished" );
}

// Namespace namespace_f093628c456dc33 / namespace_a834b08ee875ee74
// Params 3
// Checksum 0x0, Offset: 0x601
// Size: 0x98
function playerzombiecleanup( powerstruct, powerref, docooldown )
{
    otherteam = scripts\mp\utility\game::getotherteam( self.pers[ "team" ] )[ 0 ];
    
    foreach ( player in level.teamdata[ otherteam ][ "players" ] )
    {
        player hudoutlinedisableforclient( self );
    }
}

// Namespace namespace_f093628c456dc33 / namespace_a834b08ee875ee74
// Params 0
// Checksum 0x0, Offset: 0x6a1
// Size: 0xac
function function_74b142ac51e57492()
{
    zombie = self;
    zombie endon( "death" );
    zombie endon( "disconnect" );
    zombie endon( "zombie_unset" );
    zombie endon( "zombie_shout_finished" );
    level endon( "game_ended" );
    
    if ( !isdefined( zombie ) || !zombie ismutationgamemodezombie() )
    {
        return;
    }
    
    zombie function_9354c4c50c43abc0( level.var_ec4da42b3bbf344c.var_2d23e5b9abed638c );
    
    while ( true )
    {
        zombie.movespeedscaler = zombie function_9af8aa334971aeb0();
        
        if ( isdefined( zombie.movespeedscaler ) && zombie.movespeedscaler > 0 )
        {
            zombie setmovespeedscale( zombie.movespeedscaler );
        }
        
        waitframe();
    }
}

// Namespace namespace_f093628c456dc33 / namespace_a834b08ee875ee74
// Params 0
// Checksum 0x0, Offset: 0x755
// Size: 0x5d
function function_9af8aa334971aeb0()
{
    zombie = self;
    
    if ( !isdefined( zombie ) || !zombie ismutationgamemodezombie() )
    {
        return undefined;
    }
    
    if ( zombie isswimming() )
    {
        return undefined;
    }
    
    if ( zombie issprintsliding() )
    {
        return level.var_ec4da42b3bbf344c.var_6225ce8e059e5ce5;
    }
    
    return level.var_ec4da42b3bbf344c.var_695b3601560f5703;
}

// Namespace namespace_f093628c456dc33 / namespace_a834b08ee875ee74
// Params 1
// Checksum 0x0, Offset: 0x7bb
// Size: 0x1b
function function_c6519d37adedcb4f( time )
{
    if ( isdefined( time ) )
    {
        wait time;
    }
    
    self enableplayerbreathsystem( 1 );
}

// Namespace namespace_f093628c456dc33 / namespace_a834b08ee875ee74
// Params 2
// Checksum 0x0, Offset: 0x7de
// Size: 0x73
function function_120695737abd78f4( powerstruct, powerref )
{
    if ( level.var_ec4da42b3bbf344c.hudserver )
    {
        self.powershud[ powerref ].barelem updatebar( 1, 0 );
    }
    else
    {
        self.powershud[ powerref ].frac = 1;
    }
    
    thread playerpowerstartcooldown( powerstruct, powerref );
}

// Namespace namespace_f093628c456dc33 / namespace_a834b08ee875ee74
// Params 2
// Checksum 0x0, Offset: 0x859
// Size: 0x1b
function function_cd06c81e9adcbee9( powerstruct, powerref )
{
    self notify( "playerZombieGasOrShout" );
}

// Namespace namespace_f093628c456dc33 / namespace_a834b08ee875ee74
// Params 0
// Checksum 0x0, Offset: 0x87c
// Size: 0x10a
function function_2726f662b9cd30a8()
{
    zombie = self;
    zombie endon( "zombie_shout_finished" );
    waittill_any_ents( zombie, "death", zombie, "disconnect", level, "game_ended", zombie, "zombie_unset" );
    
    if ( !isdefined( zombie ) )
    {
        return;
    }
    
    if ( istrue( zombie.var_a2906c0a3da2c192 ) )
    {
        stopfxontag( level._effect[ "zombie_shout" ], zombie, "j_head" );
        stopfxontag( level._effect[ "zombie_shout_shockwaves" ], zombie, "tag_origin" );
        
        if ( zombie isgestureplaying( "ges_zombie_shout" ) )
        {
            zombie stopgestureviewmodel( "ges_zombie_shout" );
        }
    }
    
    if ( istrue( zombie.buffed ) )
    {
        zombie setscriptablepartstate( "zombieBuffVfx", "off", 0 );
        zombie setscriptablepartstate( "zombieRageVfx", "off", 0 );
        zombie.movespeedscaler = 1;
        zombie setmovespeedscale( zombie.movespeedscaler );
    }
    
    zombie.var_a2906c0a3da2c192 = 0;
    zombie.buffed = 0;
}

