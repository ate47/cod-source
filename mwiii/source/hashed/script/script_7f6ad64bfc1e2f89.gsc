#using script_22b5518d4dea99e0;
#using script_3ed005fe9b78b9da;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace namespace_d1863444259d49fa;

// Namespace namespace_d1863444259d49fa / namespace_1729f80971fc3afb
// Params 0
// Checksum 0x0, Offset: 0x241
// Size: 0x4d
function function_ec3d5e24082874e4()
{
    cooldowntime = getdvarfloat( @"hash_5c585d5f44aacc5d", 10 );
    addpowerbutton( self, "shout", "+frag", &function_483ba6f36672443d, 0, undefined, undefined, undefined, &"MP_ZXP/SHOUT", undefined, cooldowntime, "shoutStatus", "shoutProgress" );
}

// Namespace namespace_d1863444259d49fa / namespace_1729f80971fc3afb
// Params 2
// Checksum 0x0, Offset: 0x296
// Size: 0x92
function function_483ba6f36672443d( powerstruct, powerref )
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
    zombie thread function_afd0248aff5dc21( powerstruct, powerref );
    zombie thread function_2726f662b9cd30a8();
}

// Namespace namespace_d1863444259d49fa / namespace_1729f80971fc3afb
// Params 2
// Checksum 0x0, Offset: 0x330
// Size: 0x341
function function_afd0248aff5dc21( powerstruct, powerref )
{
    zombie = self;
    zombie playsound( "jup_mp_mode_mutation_acid_blast" );
    
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
        zombie playgestureviewmodel( "jup_ges_vm_offhand_1h_sludger_acid_blast", undefined, 1 );
    }
    
    wait 0.4;
    forward = vectornormalize( anglestoforward( zombie getplayerangles() ) );
    right = vectornormalize( anglestoright( zombie getplayerangles() ) );
    fireorigin = zombie geteye() + forward * 22 + ( 0, 0, -5 );
    fireend = fireorigin + forward * 1000;
    otherteam = scripts\mp\utility\game::getotherteam( self.pers[ "team" ] )[ 0 ];
    
    foreach ( player in level.teamdata[ otherteam ][ "alivePlayers" ] )
    {
        if ( player isentitywithincone( fireorigin, forward, 10, 100 ) )
        {
            player dodamage( 300, player.origin, self, self, "MOD_FIRE" );
        }
    }
    
    velocity = 1500;
    var_4f8bb17d0fad6744 = vectornormalize( anglestoforward( zombie getplayerangles() + ( 0, 7, 0 ) ) );
    var_4f8bb27d0fad6977 = vectornormalize( anglestoforward( zombie getplayerangles() + ( 0, -7, 0 ) ) );
    orb1 = magicgrenademanual( "jup_mutant_sludge_ball", fireorigin, velocity * forward );
    orb2 = magicgrenademanual( "jup_mutant_sludge_ball", fireorigin - 8 * right, velocity * var_4f8bb17d0fad6744 );
    var_6bfc733f335a43c7 = magicgrenademanual( "jup_mutant_sludge_ball", fireorigin + 8 * right, velocity * var_4f8bb27d0fad6977 );
    array_thread( [ orb1, orb2, var_6bfc733f335a43c7 ], &function_e1c46f218ae01158, zombie );
    zombie thread function_2d4d1e5adf4110f5( orb1, orb2, var_6bfc733f335a43c7 );
    var_5b23b1652cad3c0a = getdvarfloat( @"hash_ad5c1a6a44d0a85c", 10 );
    cooldowntime = getdvarfloat( @"hash_5c585d5f44aacc5d", 10 );
    wait var_5b23b1652cad3c0a;
    
    if ( isdefined( powerstruct.powers[ powerref ].statusupdate ) && cooldowntime > var_5b23b1652cad3c0a )
    {
        function_936f0ef6e203a7fc( powerstruct.powers[ powerref ].statusupdate, 1 );
    }
}

// Namespace namespace_d1863444259d49fa / namespace_1729f80971fc3afb
// Params 1
// Checksum 0x0, Offset: 0x679
// Size: 0xed
function function_e1c46f218ae01158( player )
{
    player endon( "death" );
    self endon( "detonated" );
    team = player.pers[ "team" ];
    self waittill( "explode", position );
    
    if ( !isdefined( player.var_582f318728c4fc49 ) )
    {
        player.var_582f318728c4fc49 = [];
    }
    
    cylinder_height = 40;
    cylinder_radius = 64;
    trigger = spawn( "trigger_radius", position, 0, cylinder_radius, cylinder_height );
    trigger.team = team;
    trigger thread function_52d9e43ed1d8d018( cylinder_radius, cylinder_height );
    trigger delaycall( 10, &delete );
    trigger.owner = player;
    trigger thread function_d92dad56e767e388( player );
    player.var_582f318728c4fc49[ player.var_582f318728c4fc49.size ] = trigger;
}

// Namespace namespace_d1863444259d49fa / namespace_1729f80971fc3afb
// Params 1
// Checksum 0x0, Offset: 0x76e
// Size: 0x24
function function_d92dad56e767e388( player )
{
    self endon( "entitydeleted" );
    player waittill( "disconnect" );
    self.owner = undefined;
}

// Namespace namespace_d1863444259d49fa / namespace_1729f80971fc3afb
// Params 2
// Checksum 0x0, Offset: 0x79a
// Size: 0x69
function function_52d9e43ed1d8d018( cylinder_radius, cylinder_height )
{
    while ( true )
    {
        thread function_aaee6f5a220b108d( cylinder_radius, cylinder_height );
        self waittill( "trigger", player );
        
        if ( is_equal( player.pers[ "team" ], self.team ) )
        {
            continue;
        }
        
        player thread function_d94ddba84e19ba7b( self );
    }
}

// Namespace namespace_d1863444259d49fa / namespace_1729f80971fc3afb
// Params 2
// Checksum 0x0, Offset: 0x80b
// Size: 0x4d
function function_aaee6f5a220b108d( radius, height )
{
    self endon( "entitydeleted" );
    
    while ( true )
    {
        thread scripts\cp_mp\utility\debug_utility::drawcylinder( self.origin, radius, height, 0.5, ( 0, 0, 255 ) );
        wait 0.5;
    }
}

// Namespace namespace_d1863444259d49fa / namespace_1729f80971fc3afb
// Params 1
// Checksum 0x0, Offset: 0x860
// Size: 0xa8
function function_d94ddba84e19ba7b( trigger )
{
    self endon( "disconnect" );
    
    if ( istrue( self.var_9e981d3506a0fcb7 ) )
    {
        return;
    }
    
    self.var_9e981d3506a0fcb7 = 1;
    thread scripts\cp_mp\utility\shellshock_utility::_shellshock( "gas_grenade_heavy_mp", "gas", 3, 0 );
    self setmovespeedscale( 0.3 );
    var_13c46e7d87741b0 = makeweapon( "jup_mutant_sludge_ball" );
    self dodamage( 50, trigger.origin, trigger.owner, trigger.owner, "MOD_FIRE", var_13c46e7d87741b0 );
    wait 1;
    self setmovespeedscale( 1 );
    self.var_9e981d3506a0fcb7 = 0;
}

// Namespace namespace_d1863444259d49fa / namespace_1729f80971fc3afb
// Params 3
// Checksum 0x0, Offset: 0x910
// Size: 0x155
function function_2d4d1e5adf4110f5( orb1, orb2, var_6bfc733f335a43c7 )
{
    self endon( "disconnect" );
    team = scripts\mp\utility\game::getotherteam( self.pers[ "team" ] )[ 0 ];
    
    while ( isdefined( orb1 ) || isdefined( orb2 ) || isdefined( var_6bfc733f335a43c7 ) )
    {
        alive_enemies = scripts\mp\utility\teams::getteamdata( team, "alivePlayers" );
        
        foreach ( enemy in alive_enemies )
        {
            origin = enemy geteye();
            
            if ( isdefined( orb1 ) && distance( orb1.origin, origin ) < 30 )
            {
                orb1 notify( "detonated" );
                orb1 detonate( self );
            }
            
            if ( isdefined( orb2 ) && distance( orb2.origin, origin ) < 30 )
            {
                orb2 notify( "detonated" );
                orb2 detonate( self );
            }
            
            if ( isdefined( var_6bfc733f335a43c7 ) && distance( var_6bfc733f335a43c7.origin, origin ) < 30 )
            {
                var_6bfc733f335a43c7 notify( "detonated" );
                var_6bfc733f335a43c7 detonate( self );
            }
        }
        
        waitframe();
    }
}

