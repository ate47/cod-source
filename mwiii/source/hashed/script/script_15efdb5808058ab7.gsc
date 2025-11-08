#using script_16ea1b94f0f381b3;
#using script_193e3e231841082f;
#using script_3054293078dbc58c;
#using script_77be8cd2b6610d5;
#using script_7edf952f8921aa6b;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\mp_agent_damage;

#namespace zombie_deathworm;

// Namespace zombie_deathworm / namespace_f7625713f64f26e7
// Params 0
// Checksum 0x0, Offset: 0x27b
// Size: 0x14e
function function_f93080dca9cb5ee1()
{
    self.var_54203a3172b47cde = 0;
    self.var_d921d7d91354061f = [];
    var_de7821bc51ab43a0 = [[ self.var_8f1d8328f7a9091b ]]();
    
    for ( ball_i = 0; ball_i < 6 ; ball_i++ )
    {
        self.var_d921d7d91354061f[ ball_i ] = spawn( "script_model", self.origin );
        self.var_d921d7d91354061f[ ball_i ] setmodel( self.zombieaisettings.var_e58a65b7a8f5973c.var_cbd70cd7d3efd854 );
        self.var_d921d7d91354061f[ ball_i ].var_52dcdba485e7ceeb = "tag_origin";
        self.var_d921d7d91354061f[ ball_i ].worm = self;
        self.var_d921d7d91354061f[ ball_i ] callback::add( "homing_ball_hit_character", &function_a1bdc742ad6e0574 );
        namespace_4e684dc307dd4bdd::function_a8c2757799695a5a( self.var_d921d7d91354061f[ ball_i ] );
        
        if ( var_de7821bc51ab43a0 < 7 )
        {
            namespace_4e684dc307dd4bdd::function_79bb217b25d90ffd( self.var_d921d7d91354061f[ ball_i ], 80, 12, 150 );
            continue;
        }
        
        namespace_4e684dc307dd4bdd::function_79bb217b25d90ffd( self.var_d921d7d91354061f[ ball_i ], 100, 24, 200 );
    }
    
    thread function_54d084d40575a948();
    thread function_ec0b124d362b4bc9();
    thread function_5478033773b689f5();
    
    /#
        function_2ece3ee2d2c0e61e();
    #/
}

// Namespace zombie_deathworm / namespace_f7625713f64f26e7
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3d1
// Size: 0x20
function private function_5478033773b689f5()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "spittle_start" );
        function_9fed92155e753421();
    }
}

// Namespace zombie_deathworm / namespace_f7625713f64f26e7
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3f9
// Size: 0x79
function private function_9fed92155e753421()
{
    thread thread_on_notify( "spawn_spittle_ball", &function_21ba3594ae34508e, undefined, undefined, self, self, "spittle_end" );
    thread thread_on_notify( "release_ents_in_mouth", &function_b3c852f9bf8c47c3, undefined, undefined, self, self, "spittle_end" );
    thread thread_on_notify( "open_mouth_spittle", &function_5d00deda54ae49e1, undefined, undefined, self );
    ai::function_3e5ce428974325fb( "spittle_cooldown", getdvarint( @"hash_a40da1f711d412d", 25000 ) );
    
    /#
        function_aa106600fcdbb98a( "<dev string:x1c>" );
    #/
}

// Namespace zombie_deathworm / namespace_f7625713f64f26e7
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x47a
// Size: 0x108
function private function_21ba3594ae34508e()
{
    function_814d919be8390cd3();
    head_pos = self gettagorigin( "tag_fx_mouth" );
    air_drag = getdvarfloat( @"hash_d03ff094337507bb", 250 );
    shoot_fov = getdvarfloat( @"hash_49eef1dc7ee5f947", 50 );
    targets = function_f3cc7c88e4a22d9c();
    var_d9164eae841531c8 = targets.size;
    
    if ( self.var_f8adf1aaec88d636 > 1 )
    {
        var_d9164eae841531c8 = max( 4, var_d9164eae841531c8 );
    }
    
    var_d9164eae841531c8 = clamp( var_d9164eae841531c8, 2, 6 );
    
    if ( istrue( self.var_cfa89ff2e0efade1 ) )
    {
        var_d9164eae841531c8 = 0;
    }
    
    for ( ball_i = 0; ball_i < var_d9164eae841531c8 ; ball_i++ )
    {
        current_velocity = function_a4438c777cf89315( shoot_fov, ball_i, var_d9164eae841531c8 );
        target = targets.size <= 0 ? undefined : targets[ ball_i % targets.size ];
        function_6d6444e1320ead48( self.var_d921d7d91354061f[ ball_i ], current_velocity, air_drag, head_pos, target );
        wait 0.1;
    }
}

// Namespace zombie_deathworm / namespace_f7625713f64f26e7
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x58a
// Size: 0x9
function private function_b3c852f9bf8c47c3()
{
    function_814d919be8390cd3();
}

// Namespace zombie_deathworm / namespace_f7625713f64f26e7
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x59b
// Size: 0x116
function private function_6d6444e1320ead48( ball, velocity, air_drag, head_pos, target_ent )
{
    ball utility::function_3ab9164ef76940fd( "spittle", "spittle_on" );
    ball dontinterpolate();
    ball.origin = head_pos + anglestoforward( self.angles ) * 150;
    ball namespace_4e684dc307dd4bdd::launch_ball( velocity, getdvarfloat( @"hash_829137421b9a9889", 3 ), air_drag );
    
    if ( isdefined( target_ent ) )
    {
        namespace_4e684dc307dd4bdd::function_8a1752d6a06e7cd7( ball, target_ent );
    }
    
    ball setcandamage( 1 );
    ball solid();
    ball.scripthealth = getdvarint( @"hash_2851a67e797b5352", 50 );
    ball.maxhealth = 10000;
    ball.health = ball.maxhealth;
    ball.team = self.team;
    ball thread function_31a1df98de27eb46();
    ball.var_c1ae8e663059a05c = gettime();
    self.var_54203a3172b47cde++;
}

// Namespace zombie_deathworm / namespace_f7625713f64f26e7
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x6b9
// Size: 0xcc
function private function_a4438c777cf89315( shoot_fov, ball_i, num_to_spawn, var_3f7f044e180a4e3a )
{
    var_d04bd7f014726149 = getdvarfloat( @"hash_819a621ebc0c490a", 500 );
    var_c8fef90150a3a014 = getdvarfloat( @"hash_e9a5f6f18ff08271", 100 );
    var_6f31749eb79d2f39 = ball_i * shoot_fov / num_to_spawn - shoot_fov * 0.5;
    forward_vec = anglestoforward( self.angles + ( 0, var_6f31749eb79d2f39, 0 ) );
    velocity = forward_vec * var_d04bd7f014726149 + ( 0, 0, -1 ) * var_c8fef90150a3a014;
    
    if ( istrue( var_3f7f044e180a4e3a ) )
    {
        velocity = vectornormalize( velocity ) * length( self.ball_velocity );
    }
    
    return velocity;
}

// Namespace zombie_deathworm / namespace_f7625713f64f26e7
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x78e
// Size: 0x16d
function private function_a1bdc742ad6e0574( params )
{
    hit_ent = params.hitcharacter;
    
    if ( !isdefined( hit_ent ) )
    {
        return;
    }
    
    if ( self.origin[ 2 ] < hit_ent.origin[ 2 ] )
    {
        self.origin = ( self.origin[ 0 ], self.origin[ 1 ], hit_ent.origin[ 2 ] );
        return;
    }
    
    if ( ent_flag( "hit_character" ) )
    {
        return;
    }
    
    var_dd72a06a38d7143a = 30;
    
    if ( istrue( self.worm.var_fa1a1806d30a40e1 ) && self.worm.var_f8adf1aaec88d636 >= 7 )
    {
        var_dd72a06a38d7143a = 60;
        
        if ( self.worm.var_f8adf1aaec88d636 >= 13 )
        {
            var_dd72a06a38d7143a = max( var_dd72a06a38d7143a, hit_ent.health * 0.5 );
        }
    }
    
    hit_ent dodamage( var_dd72a06a38d7143a, self.origin, self, self, "MOD_IMPACT" );
    ent_flag_set( "hit_character" );
    thread ent_flag_clear_delayed( "hit_character", 2 );
    
    if ( isplayer( hit_ent ) )
    {
        currentstate = hit_ent getscriptablepartstate( "deathwormVFX", 1 );
        
        if ( isdefined( currentstate ) && currentstate != "swallowed" )
        {
            hit_ent function_3ab9164ef76940fd( "deathwormVFX", "hit_by_spittle" );
        }
    }
}

// Namespace zombie_deathworm / namespace_f7625713f64f26e7
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x903
// Size: 0x179
function private function_31a1df98de27eb46()
{
    self endon( "death" );
    
    while ( true )
    {
        waitframe();
        self waittill( "damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        dmgstruct = function_34e78cbd2dfff6df( inflictor, attacker, damage, idflags, meansofdeath, undefined, point, direction_vec, undefined, undefined, undefined, undefined, objweapon );
        damage = function_89cc24cfc33e2693( dmgstruct );
        self.scripthealth -= damage;
        killing_blow = 0;
        
        if ( self.scripthealth <= 0 )
        {
            function_e649134398caaa95();
            killing_blow = 1;
        }
        
        if ( isplayer( attacker ) )
        {
            attacker updatehitmarker_sharedfunc( "standard", killing_blow );
            
            if ( scripts\mp\mp_agent_damage::function_87c3b43d00319847() )
            {
                displaydamagenumber_sharedfunc( attacker, self, "none", meansofdeath, objweapon, int( damage ), self.origin, 0, undefined, 0, 0 );
            }
        }
        
        /#
            function_aa106600fcdbb98a( "<dev string:x2d>" + self.health, self.origin );
        #/
    }
}

// Namespace zombie_deathworm / namespace_f7625713f64f26e7
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xa84
// Size: 0x6d
function private function_e649134398caaa95()
{
    utility::function_3ab9164ef76940fd( "spittle", "spittle_impact" );
    namespace_4e684dc307dd4bdd::set_invisible( self );
    self setcandamage( 0 );
    self notsolid();
    self.scripthealth = 0;
    
    if ( isdefined( self.worm ) && isdefined( self.worm.var_54203a3172b47cde ) )
    {
        self.worm.var_54203a3172b47cde--;
    }
}

// Namespace zombie_deathworm / namespace_f7625713f64f26e7
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xaf9
// Size: 0x3c
function private function_5d00deda54ae49e1()
{
    self endon( "death" );
    utility::function_3677f2be30fdd581( "mouth", "spittle" );
    waittill_2( "close_mouth_spittle", "spittle_end" );
    utility::function_3677f2be30fdd581( "mouth", "off" );
}

// Namespace zombie_deathworm / namespace_f7625713f64f26e7
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xb3d
// Size: 0x5d
function private function_54d084d40575a948()
{
    balls = self.var_d921d7d91354061f;
    self waittill( "death" );
    
    for ( ball_i = 0; ball_i < 6 ; ball_i++ )
    {
        balls[ ball_i ] function_e649134398caaa95();
    }
    
    wait 2;
    
    for ( ball_i = 0; ball_i < 6 ; ball_i++ )
    {
        balls[ ball_i ] delete();
    }
}

// Namespace zombie_deathworm / namespace_f7625713f64f26e7
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xba2
// Size: 0x91
function private function_ec0b124d362b4bc9()
{
    self endon( "death" );
    
    while ( true )
    {
        for ( ball_i = 0; ball_i < 6 ; ball_i++ )
        {
            ball = self.var_d921d7d91354061f[ ball_i ];
            
            if ( isdefined( ball.scripthealth ) && ball.scripthealth > 0 )
            {
                time_alive = gettime() - ball.var_c1ae8e663059a05c;
                
                if ( time_alive > 120000 )
                {
                    ball function_e649134398caaa95();
                }
            }
            
            waitframe();
        }
        
        wait 30;
    }
}

// Namespace zombie_deathworm / namespace_f7625713f64f26e7
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xc3b
// Size: 0x90
function private function_f3cc7c88e4a22d9c()
{
    scan_radius = 2000;
    potential_targets = self function_53a66d3a98238538( self.origin, scan_radius, 1 );
    filtered_targets = [];
    
    foreach ( target in potential_targets )
    {
        if ( !istrue( target.damageshield ) )
        {
            filtered_targets[ filtered_targets.size ] = target;
        }
    }
    
    return filtered_targets;
}

/#

    // Namespace zombie_deathworm / namespace_f7625713f64f26e7
    // Params 0
    // Checksum 0x0, Offset: 0xcd4
    // Size: 0x44, Type: dev
    function function_2ece3ee2d2c0e61e()
    {
        function_6e7290c8ee4f558b( "<dev string:x39>" );
        function_a9a864379a098ad6( "<dev string:x58>", "<dev string:x69>", &function_5f4b3863b545675a );
        function_a9a864379a098ad6( "<dev string:x7a>", "<dev string:x8b>", &function_a450b30425deff57 );
        function_fe953f000498048f();
    }

    // Namespace zombie_deathworm / namespace_f7625713f64f26e7
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xd20
    // Size: 0x46, Type: dev
    function private function_5f4b3863b545675a()
    {
        deathworm = function_6d1fbda4b8524ef2( level.players[ 0 ].origin, undefined, "<dev string:x9c>" );
        
        if ( !isdefined( deathworm ) )
        {
            return;
        }
        
        deathworm function_3e89eb3d8e3f1811( "<dev string:xb0>", 1 );
    }

    // Namespace zombie_deathworm / namespace_f7625713f64f26e7
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xd6e
    // Size: 0x17, Type: dev
    function private function_d0c59a39b0e76afe()
    {
        return getdvarint( @"hash_c4c95fbc22ee699", 0 ) > 0;
    }

    // Namespace zombie_deathworm / namespace_f7625713f64f26e7
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xd8d
    // Size: 0x1a, Type: dev
    function private function_a450b30425deff57()
    {
        function_2fb888667001fc39( "<dev string:xbe>", @"hash_c4c95fbc22ee699" );
    }

    // Namespace zombie_deathworm / namespace_f7625713f64f26e7
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0xdaf
    // Size: 0x5a, Type: dev
    function private function_aa106600fcdbb98a( text, pos )
    {
        if ( function_d0c59a39b0e76afe() )
        {
            pos = default_to( pos, self.origin + ( 0, 0, 70 ) );
            print3d( pos, "<dev string:xd9>" + text, ( 1, 0, 0 ) );
        }
    }

#/
