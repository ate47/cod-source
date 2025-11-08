#using script_22b5518d4dea99e0;
#using script_3ed005fe9b78b9da;
#using scripts\common\values;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;

#namespace namespace_bc228b4ad7fb1a33;

// Namespace namespace_bc228b4ad7fb1a33 / namespace_3b5097f7552b7b28
// Params 0
// Checksum 0x0, Offset: 0x1b5
// Size: 0x59
function function_b2524786c57b7bc0()
{
    cooldowntime = getdvarfloat( @"hash_5941ed16e612ecd7", 25 );
    addpowerbutton( self, "shout", "+frag", &function_d603c7ff7a7d2841, 0, &function_9eebf900d725e7b1, &function_bcf18d8932c1e080, &function_9eebf900d725e7b1, &"MP_ZXP/SHOUT", undefined, cooldowntime, "shoutStatus", "shoutProgress" );
}

// Namespace namespace_bc228b4ad7fb1a33 / namespace_3b5097f7552b7b28
// Params 2
// Checksum 0x0, Offset: 0x216
// Size: 0x3f
function function_9eebf900d725e7b1( powerstruct, powerref )
{
    grenade = "equip_mutant_ability_6";
    scripts\mp\equipment::giveequipment( grenade, "primary" );
    scripts\mp\equipment::setequipmentslotammo( "primary", 1 );
}

// Namespace namespace_bc228b4ad7fb1a33 / namespace_3b5097f7552b7b28
// Params 2
// Checksum 0x0, Offset: 0x25d
// Size: 0x1f
function function_bcf18d8932c1e080( powerstruct, powerref )
{
    scripts\mp\equipment::takeequipment( "primary" );
}

// Namespace namespace_bc228b4ad7fb1a33 / namespace_3b5097f7552b7b28
// Params 2
// Checksum 0x0, Offset: 0x284
// Size: 0x92
function function_d603c7ff7a7d2841( powerstruct, powerref )
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
    zombie thread function_cb80241bc85a6d35( powerstruct, powerref );
    zombie thread function_2726f662b9cd30a8();
}

// Namespace namespace_bc228b4ad7fb1a33 / namespace_3b5097f7552b7b28
// Params 2
// Checksum 0x0, Offset: 0x31e
// Size: 0x108
function function_cb80241bc85a6d35( powerstruct, powerref )
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
    
    thread function_5405908fe93bb5e();
    thread function_d9aa75397a185cdf();
    var_75b3ab6087fa60fc = getdvarfloat( @"hash_b47864d5c052952", 10 );
    wait var_75b3ab6087fa60fc;
    
    if ( isdefined( powerstruct.powers[ powerref ].statusupdate ) )
    {
        function_936f0ef6e203a7fc( powerstruct.powers[ powerref ].statusupdate, 1 );
    }
    
    self notify( "stopRadarPings" );
}

// Namespace namespace_bc228b4ad7fb1a33 / namespace_3b5097f7552b7b28
// Params 0
// Checksum 0x0, Offset: 0x42e
// Size: 0x31
function function_d9aa75397a185cdf()
{
    self endon( "death_or_disconnect" );
    val::set( "dogAbilityActivate", "sprint", 0 );
    wait 3;
    val::set( "dogAbilityActivate", "sprint", 1 );
}

// Namespace namespace_bc228b4ad7fb1a33 / namespace_3b5097f7552b7b28
// Params 0
// Checksum 0x0, Offset: 0x467
// Size: 0x6b
function function_5405908fe93bb5e()
{
    self endon( "death" );
    self notify( "stopRadarPings" );
    self endon( "stopRadarPings" );
    level endon( "game_ended" );
    var_8a99420855206d2c = 3;
    var_2ff0b7294cde30f8 = 1000;
    radarradius = 1500;
    
    while ( true )
    {
        triggerportableradarpingteam( self.origin, self.team, radarradius, var_2ff0b7294cde30f8 );
        wait var_8a99420855206d2c;
    }
}

