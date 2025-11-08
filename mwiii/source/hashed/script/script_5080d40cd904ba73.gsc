#using script_16ea1b94f0f381b3;
#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_2f11ea014b8bb8eb;
#using script_3ab210ea917601e7;
#using script_41387eecc35b88bf;
#using script_485622d93fa7e4cf;
#using script_4e6e58ab5d96c2b0;
#using script_4ef01fe6151dde4d;
#using script_4fa7e9e11630166c;
#using script_4fdefae8b7bcdf73;
#using script_638d701d263ee1ed;
#using script_64351208cb856df9;
#using script_6f65366f542f6627;
#using script_749ff6f56673a813;
#using script_7956d56c4922bd1;
#using script_79deab1955343d5d;
#using script_7c875a4a27280806;
#using script_7edf952f8921aa6b;
#using script_9880b9dc28bc25e;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\scriptable;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#using scripts\mp\equipment\molotov;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\gametypes\ob;
#using scripts\mp\playerlogic;
#using scripts\mp\scoreboard;
#using scripts\mp\utility\teams;

#namespace namespace_f9a64c6fd3a886a1;

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 0
// Checksum 0x0, Offset: 0x771
// Size: 0x1f
function function_af4cc6b8e4e57940()
{
    callback::add( "player_spawned", &on_player_spawned );
    scripts\engine\scriptable::scriptable_adddamagedcallback( &function_61c4487eafc2bc4c );
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 0
// Checksum 0x0, Offset: 0x798
// Size: 0x23f
function function_74139ae6c2c53345()
{
    s_pos = getstruct( "infil_chopper", "targetname" );
    s_goal = getstruct( s_pos.target, "targetname" );
    spawndata = spawnstruct();
    spawndata.origin = s_pos.origin;
    spawndata.angles = s_pos.angles;
    spawndata.preventrespawn = 1;
    spawndata.spawntype = "GAME_MODE";
    spawndata.var_699ac4a9c9e9f0ec = 1;
    spawndata.var_24993ee24f7c7c0 = 1;
    self.infil_chopper = undefined;
    
    while ( true )
    {
        self.infil_chopper = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "veh9_palfa", spawndata );
        
        if ( isdefined( self.infil_chopper ) )
        {
            break;
        }
        
        waitframe();
    }
    
    self.infil_chopper.e_linkto = getent( "linkto_clip_infil_chopper", "targetname" );
    self.infil_chopper.mdl_clip = getent( "clip_infil_chopper", "targetname" );
    self.infil_chopper.mdl_clip linkto( self.infil_chopper.e_linkto );
    self.infil_chopper.e_linkto rotateto( self.infil_chopper.angles, 0.05 );
    self.infil_chopper.e_linkto moveto( self.infil_chopper.origin, 0.05 );
    self.infil_chopper.e_linkto waittill( "movedone" );
    self.infil_chopper.e_linkto linkto( self.infil_chopper );
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable( self.infil_chopper );
    self.infil_chopper scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setcandamage( 0 );
    level flag_set( "quest_infil_active" );
    self.infil_chopper thread function_86b4ca8e83c456e6( self, s_goal );
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 2
// Checksum 0x0, Offset: 0x9df
// Size: 0x260
function function_86b4ca8e83c456e6( s_quest, s_goal )
{
    self endon( "death" );
    self.team = level.players[ 0 ].team;
    namespace_9f6a961447bab709::function_a609274d97743733();
    self vehicle_setspeed( 45, 20, 8 );
    self setvehgoalpos( self.origin, 1 );
    self waittill( "goal" );
    s_quest thread function_e22ffb38d3d9e977();
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    if ( !level flag( "ob_infil_completed" ) )
    {
        level flag_wait( "ob_infil_completed" );
    }
    
    s_quest flag_wait( "players_onboard" );
    s_quest thread players_infil();
    
    while ( true )
    {
        if ( isdefined( s_goal.script_noteworthy ) )
        {
            if ( s_goal.script_noteworthy == "drop_off" )
            {
                s_quest flag_set( "dropped_off" );
                self setvehgoalpos( s_goal.origin, 1 );
                self setgoalyaw( flat_angle( s_goal.angles )[ 1 ] );
            }
        }
        else
        {
            self setvehgoalpos( s_goal.origin, 0 );
        }
        
        self waittill( "goal" );
        
        if ( isdefined( s_goal.script_noteworthy ) )
        {
            if ( s_goal.script_noteworthy == "drop_off" )
            {
                namespace_262d6474998a2356::function_641bc1548cff8210( "QUEST_INFILTRATE", level.players );
                self.mdl_clip delete();
                self.e_linkto delete();
                thread function_83ff2df370bc359b( s_quest );
                s_quest flag_set( "drop_off" );
                s_quest flag_wait( "players_disembarked" );
            }
        }
        
        if ( isdefined( s_goal.target ) )
        {
            s_goal = getstruct( s_goal.target, "targetname" );
            continue;
        }
        
        break;
    }
    
    if ( isarray( self.pilots ) )
    {
        foreach ( pilot in self.pilots )
        {
            pilot delete();
        }
    }
    
    level flag_clear( "quest_infil_active" );
    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setcandamage( 1 );
    scripts\cp_mp\vehicles\vehicle_damage::function_d0df49de517ded03();
    scripts\cp_mp\vehicles\vehicle::vehicle_explode();
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 1
// Checksum 0x0, Offset: 0xc47
// Size: 0x10f
function function_83ff2df370bc359b( s_quest )
{
    self endon( "death" );
    s_quest endon( "infil_done" );
    
    if ( is_equal( s_quest.act_name, "s0_act2" ) )
    {
        thread scripts\cp_mp\overlord::playevent( "quest_s0_a2t6_deploy", level.players );
        s_quest.var_3a7e8de43eccff16 = gettime();
    }
    
    thread infil_timeout( s_quest );
    
    while ( true )
    {
        self.var_9c80d69eb7a7d6cd = 0;
        
        foreach ( player in level.players )
        {
            if ( function_c80b9a252474413b( player ) )
            {
                self.var_9c80d69eb7a7d6cd = 1;
            }
        }
        
        if ( !self.var_9c80d69eb7a7d6cd )
        {
            break;
        }
        
        wait 0.1;
    }
    
    wait 2;
    s_quest flag_set( "players_disembarked" );
    s_quest flag_set( "infil_done" );
    s_quest notify( "infil_done" );
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 1
// Checksum 0x0, Offset: 0xd5e
// Size: 0x94
function infil_timeout( s_quest )
{
    self endon( "death" );
    s_quest endon( "infil_done" );
    
    foreach ( player in level.players )
    {
        player thread function_4cc1ee860edc24ea( s_quest );
    }
    
    wait 20;
    s_quest flag_set( "players_disembarked" );
    s_quest flag_set( "infil_done" );
    s_quest notify( "infil_done" );
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 1
// Checksum 0x0, Offset: 0xdfa
// Size: 0x9b
function function_4cc1ee860edc24ea( s_quest )
{
    self endon( "death" );
    var_ca615faf4270509a = 20;
    start_time = gettime();
    
    while ( true )
    {
        wait 1;
        elapsed_time = ( gettime() - start_time ) / 1000;
        n_time_remaining = int( max( var_ca615faf4270509a - elapsed_time, 0 ) );
        
        if ( s_quest flag( "players_disembarked" ) )
        {
            n_time_remaining = 0;
        }
        
        if ( n_time_remaining <= 0 )
        {
            self setclientomnvar( "ui_match_start_countdown", -1 );
            return;
        }
        
        self setclientomnvar( "ui_match_start_countdown", n_time_remaining );
    }
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 1
// Checksum 0x0, Offset: 0xe9d
// Size: 0x52
function function_c80b9a252474413b( player )
{
    if ( !isdefined( self ) || !isalive( self ) || !isdefined( self.origin ) || !isdefined( player ) || !isdefined( player.origin ) )
    {
        return 0;
    }
    
    return function_f69d383479425bfa( player.origin );
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 1
// Checksum 0x0, Offset: 0xef8
// Size: 0xee, Type: bool
function function_f69d383479425bfa( origin )
{
    forward = anglestoforward( self.angles );
    up = anglestoup( self.angles );
    toorigin = origin - self.origin;
    transform = coordtransformtranspose( origin, self.origin, self.angles );
    forwarddist = transform[ 0 ];
    sidedist = transform[ 1 ];
    verticaldist = transform[ 2 ];
    withinforward = forwarddist > -350 && forwarddist < 350;
    withinside = sidedist > -60 && sidedist < 60;
    withinvertical = verticaldist > -235 && verticaldist < -115;
    return withinforward && withinside && withinvertical;
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 2
// Checksum 0x0, Offset: 0xfef
// Size: 0x1b2
function function_44dc89f43f1c1e1c( n_index, vh_chopper )
{
    switch ( n_index )
    {
        case 0:
            v_pos = vh_chopper gettagorigin( "tag_door_rear" );
            v_pos = vectornormalize( anglestoright( vh_chopper.angles ) ) * 25 + v_pos;
            break;
        case 1:
            v_pos = vh_chopper gettagorigin( "tag_door_rear" );
            v_pos = vectornormalize( anglestoright( vh_chopper.angles ) ) * -25 + v_pos;
            break;
        case 2:
            v_pos = vh_chopper gettagorigin( "tag_door_rear" );
            v_pos = vectornormalize( anglestoforward( vh_chopper.angles ) ) * 100 + v_pos;
            break;
        case 3:
            v_pos = vh_chopper gettagorigin( "tag_door_rear" );
            v_pos = vectornormalize( anglestoforward( vh_chopper.angles ) ) * 200 + v_pos;
            break;
        case 4:
            v_pos = vh_chopper gettagorigin( "tag_door_rear" );
            v_pos = vectornormalize( anglestoforward( vh_chopper.angles ) ) * 300 + v_pos;
            break;
        case 5:
            v_pos = vh_chopper gettagorigin( "tag_door_rear" );
            v_pos = vectornormalize( anglestoforward( vh_chopper.angles ) ) * 400 + v_pos;
            break;
        default:
            v_pos = vh_chopper gettagorigin( "tag_door_rear" );
            v_pos = vectornormalize( anglestoforward( vh_chopper.angles ) ) * 350 + v_pos;
            break;
    }
    
    return v_pos;
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 0
// Checksum 0x0, Offset: 0x11aa
// Size: 0xad
function function_e22ffb38d3d9e977()
{
    var_963794e1e7c36495 = 9000;
    start_time = gettime();
    
    while ( true )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( !istrue( level.players[ i ].var_17f0c6e0a73cf45 ) )
            {
                teleport_player( level.players[ i ], i );
                level.players[ i ].var_17f0c6e0a73cf45 = 1;
            }
        }
        
        if ( gettime() > start_time + var_963794e1e7c36495 )
        {
            break;
        }
        
        wait 0.5;
    }
    
    flag_set( "players_onboard" );
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 3
// Checksum 0x0, Offset: 0x125f
// Size: 0x13c
function teleport_player( player, index, var_cd6f4a9d7cd49916 )
{
    var_9c04c1e560e2931e = 0;
    index = default_to( index, 0 );
    
    if ( istrue( var_cd6f4a9d7cd49916 ) || !isdefined( self.infil_chopper ) )
    {
        a_spawn_pos = getstructarray( "quest_act2_player_spawn", "targetname" );
        
        if ( isdefined( a_spawn_pos[ 0 ] ) )
        {
            v_pos = a_spawn_pos[ 0 ].origin;
            player setorigin( v_pos );
            var_9c04c1e560e2931e = 1;
        }
    }
    else if ( isdefined( self.infil_chopper ) )
    {
        v_pos = function_44dc89f43f1c1e1c( index, self.infil_chopper );
    }
    
    if ( isdefined( v_pos ) && !istrue( var_9c04c1e560e2931e ) )
    {
        level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer( player, 1, 0.1 );
        player freezecontrols( 1 );
        player.var_cac91eb6521df629 = self.infil_chopper;
        player.ignoreme = 1;
        player setorigin( v_pos );
        
        if ( isdefined( self.infil_chopper ) )
        {
            player setplayerangles( self.infil_chopper.angles * -1 );
            player playerlinkto( self.infil_chopper );
            player playerlinkedoffsetenable();
        }
    }
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 0
// Checksum 0x0, Offset: 0x13a3
// Size: 0x10c
function players_infil()
{
    self.a_s_player_spawns = getstructarray( "quest_act2_player_spawn", "targetname" );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( isalive( level.players[ i ] ) )
        {
            level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer( level.players[ i ], 0, 2 );
            level.players[ i ] freezecontrols( 0 );
            level.players[ i ] unlink();
        }
    }
    
    if ( is_equal( self.act_name, "s0_act2" ) )
    {
        thread scripts\cp_mp\overlord::playconversation( "quest_s0_a2t6_infil", level.players, 2.5, 1 );
    }
    
    flag_wait( "drop_off" );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( isalive( level.players[ i ] ) )
        {
            level.players[ i ].ignoreme = 0;
        }
    }
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 1
// Checksum 0x0, Offset: 0x14b7
// Size: 0x54
function on_player_spawned( params )
{
    if ( level flag( "quest_infil_active" ) && level flag( "players_onboard" ) && isdefined( level.var_df433561007fc313 ) )
    {
        level.var_df433561007fc313 teleport_player( self, undefined, 1 );
        thread function_5f29a4befb3e5c95();
    }
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 0
// Checksum 0x0, Offset: 0x1513
// Size: 0x2a
function function_5f29a4befb3e5c95()
{
    wait 3;
    
    if ( isalive( self ) )
    {
        level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer( self, 0, 2 );
        self freezecontrols( 0 );
        self unlink();
    }
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 0
// Checksum 0x0, Offset: 0x1545
// Size: 0x119
function function_7a5ab9d5c8dbfe6a()
{
    level endon( "game_ended_aether_storm" );
    level endon( "game_ended_story_mission" );
    level endon( "game_ended" );
    
    if ( istrue( getdvarint( @"hash_e5fe708a349f861f", 0 ) ) )
    {
        return;
    }
    
    while ( true )
    {
        var_4a78d94487188ca6 = 0;
        
        foreach ( player in level.players )
        {
            if ( namespace_b3fcba693d3adc37::function_f3645fa4bfb45a97( player ) )
            {
                var_4a78d94487188ca6 = 1;
            }
        }
        
        wait 1.5;
        
        if ( !var_4a78d94487188ca6 )
        {
            end_game = 1;
            
            foreach ( player in level.players )
            {
                if ( namespace_b3fcba693d3adc37::function_f3645fa4bfb45a97( player ) )
                {
                    end_game = 0;
                }
            }
            
            if ( istrue( end_game ) )
            {
                level thread scripts\mp\gametypes\ob::onsquadeliminated( level.players, 0 );
                break;
            }
        }
    }
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 0
// Checksum 0x0, Offset: 0x1666
// Size: 0x1a2
function function_fe7df93324621658()
{
    val::set( "exfil", "breath_system", 0 );
    val::set( "exfil", "cg_drawcrosshair", 0 );
    val::set( "exfil", "crouch", 0 );
    val::set( "exfil", "damage", 0 );
    val::set( "exfil", "gesture", 0 );
    val::set( "exfil", "allow_jump", 0 );
    val::set( "exfil", "killstreaks", 0 );
    val::set( "exfil", "melee", 0 );
    val::set( "exfil", "allow_movement", 0 );
    val::set( "exfil", "offhand_weapons", 0 );
    val::set( "exfil", "prone", 0 );
    val::set( "exfil", "sprint", 0 );
    val::set( "exfil", "supers", 0 );
    val::set( "exfil", "usability", 0 );
    val::set( "exfil", "weapon", 0 );
    val::set( "exfil", "fire", 0 );
    val::set( "exfil", "weapon_switch", 0 );
    val::set( "exfil", "freezecontrols", 1 );
    val::set( "exfil", "ignoreme", 1 );
    val::set( "exfil", "show_crosshair", 0 );
    val::set( "exfil", "show_dpad_hud", 0 );
    val::set( "exfil", "show_hud", 0 );
    val::set( "exfil", "show_weapon_hud", 0 );
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 0
// Checksum 0x0, Offset: 0x1810
// Size: 0x96
function ai_cleanup()
{
    var_94d08343de33ee25 = getaiarray();
    
    for ( i = 0; i < var_94d08343de33ee25.size ; i++ )
    {
        if ( isalive( var_94d08343de33ee25[ i ] ) && isdefined( var_94d08343de33ee25[ i ].agent_type ) && var_94d08343de33ee25[ i ].agent_type != "actor_jup_spawner_zombie_deathworm_quest" && !isdefined( var_94d08343de33ee25[ i ].var_69b049cf4b18c73b ) )
        {
            if ( isdefined( var_94d08343de33ee25[ i ].magic_bullet_shield ) )
            {
                var_94d08343de33ee25[ i ] scripts\common\ai::stop_magic_bullet_shield();
            }
            
            var_94d08343de33ee25[ i ] kill();
            waitframe();
        }
    }
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x18ae
// Size: 0x50
function private activate_barrel( barrel )
{
    barrel setscriptablepartstate( "state", "healthy" );
    barrel.navobstacleid = createnavobstaclebybounds( barrel.origin, ( 16, 16, 45 ), barrel.angles );
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 11
// Checksum 0x0, Offset: 0x1906
// Size: 0x9e
function function_61c4487eafc2bc4c( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname )
{
    if ( !is_equal( instance.type, "barrel_toggleable_red" ) || istrue( instance.destroyed ) )
    {
        return;
    }
    
    thread red_barrel_explosion_monitor( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname );
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 11, eflags: 0x4
// Checksum 0x0, Offset: 0x19ac
// Size: 0x1ca
function private red_barrel_explosion_monitor( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname )
{
    level endon( "game_ended" );
    instance notify( "red_barrel_explosion_monitor" );
    instance endon( "red_barrel_explosion_monitor" );
    assertex( instance getscriptablehaspart( "<dev string:x1c>" ), "<dev string:x25>" + instance.origin );
    damagerange = getdvarint( @"hash_d5bf7c2cfa2963af", 300 );
    outerdamage = getdvarint( @"hash_7e4c624175a9b761", 100 );
    innerdamage = getdvarint( @"hash_8d319c1d79922952", 400 );
    finalwaittime = gettime() + 5000;
    
    while ( gettime() < finalwaittime )
    {
        if ( instance getscriptablepartstate( "state" ) == "explode" )
        {
            if ( isdefined( eattacker ) && isplayer( eattacker ) )
            {
                a_ai_enemies = getaiarrayinradius( instance.origin, 300 );
                
                foreach ( ai_enemy in a_ai_enemies )
                {
                    if ( isalive( ai_enemy ) )
                    {
                        ai_enemy thread function_c060ff430f92726d( instance );
                    }
                }
            }
            
            radiusdamage( instance.origin, damagerange, innerdamage, outerdamage, eattacker, "MOD_EXPLOSIVE", objweapon );
            break;
        }
        
        waitframe();
    }
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 1
// Checksum 0x0, Offset: 0x1b7e
// Size: 0xe0
function function_c060ff430f92726d( barrel )
{
    self endon( "death" );
    scripts\engine\throttle::function_f632348cbb773537( level.var_cced1297c1210e46, self );
    
    if ( distance2dsquared( self.origin, barrel.origin ) < 225 )
    {
        n_damage = self.maxhealth;
    }
    else if ( distance2dsquared( self.origin, barrel.origin ) > 270 )
    {
        n_damage = int( self.maxhealth * 0.5 );
    }
    else
    {
        n_damage = int( self.maxhealth * 0.8 );
    }
    
    thread scripts\mp\equipment\molotov::molotov_burn_for_time( 6, self, self, barrel );
    self dodamage( int( n_damage * 0.5 ), barrel.origin, barrel, barrel, "MOD_EXPLOSIVE" );
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1c66
// Size: 0x41
function private function_e1b5f91e2e989934( team, var_413767c93d7dff98 )
{
    if ( !isdefined( var_413767c93d7dff98 ) )
    {
        var_413767c93d7dff98 = 1;
    }
    
    if ( !isdefined( level.var_4b90dae6c1d817ee ) )
    {
        level.var_4b90dae6c1d817ee = [];
    }
    
    level.var_4b90dae6c1d817ee[ team ] = var_413767c93d7dff98;
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 3
// Checksum 0x0, Offset: 0x1caf
// Size: 0x604
function function_bf01aba31e9023d1( var_ec133e81bf98bedc, a_players, var_a6b3fae0395f75c3 )
{
    if ( !isdefined( var_ec133e81bf98bedc ) )
    {
        var_ec133e81bf98bedc = 0;
    }
    
    if ( !isdefined( var_a6b3fae0395f75c3 ) )
    {
        var_a6b3fae0395f75c3 = "mission";
    }
    
    var_278601650c73378a = !isdefined( a_players );
    a_players = default_to( a_players, level.players );
    
    foreach ( player in a_players )
    {
        player.var_f52eb40ba99ffa4c = 1;
        player.var_89b6795dafb21681 = 1;
        
        if ( istrue( var_278601650c73378a ) )
        {
            function_e1b5f91e2e989934( player.team );
        }
        
        player thread namespace_b3f32c8cb80b8124::function_5751d00ce46557da( 1 );
        
        if ( !istrue( var_ec133e81bf98bedc ) )
        {
            level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer( player, 1, 0.25 );
            wait 0.25;
        }
        
        player.exfilpos = player.origin;
        player val::set( "exfil", "crouch", 0 );
        player val::set( "exfil", "gesture", 0 );
        player val::set( "exfil", "allow_jump", 0 );
        player val::set( "exfil", "killstreaks", 0 );
        player val::set( "exfil", "melee", 0 );
        player val::set( "exfil", "offhand_weapons", 0 );
        player val::set( "exfil", "prone", 0 );
        player val::set( "exfil", "sprint", 0 );
        player val::set( "exfil", "supers", 0 );
        player val::set( "exfil", "usability", 0 );
        player val::set( "exfil", "weapon", 0 );
        player val::set( "exfil", "allow_movement", 0 );
        player val::set( "exfil", "fire", 0 );
        player val::set( "exfil", "weapon_switch", 0 );
        player val::set( "exfil", "damage", 0 );
        player val::set( "exfil", "ignoreme", 1 );
        player freezecontrols( 1 );
        player playerhide();
        
        if ( getdvarint( @"hash_77f6de1d536c1ca1", 1 ) )
        {
            player ob_exfil::function_86924395ad6e3c5e();
        }
        
        ob_exfil::function_46f56bf948599140( player, var_a6b3fae0395f75c3 );
        var_11ae79f313bae6a8 = 0;
        var_1a32758b940764f4 = 1;
        str_difficulty = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10( player.origin );
        
        switch ( str_difficulty )
        {
            case #"hash_7bb2cd766703d463":
            default:
                var_11ae79f313bae6a8 = 0;
                break;
            case #"hash_af83e47edfa8900a":
                var_11ae79f313bae6a8 = 1000;
                break;
            case #"hash_5343b465e56ec9a4":
            case #"hash_651f76c0ad6741ec":
                var_11ae79f313bae6a8 = 2000;
                break;
        }
        
        player ob_exfil::function_30f809c426b6a126();
        ob_exfil::function_edff661c569fa3bc( player );
        
        if ( function_a6172e49f7313fd8() )
        {
            player function_6aa0d0467dfd4624( 1 );
            player function_80c587026fbc6e0d();
        }
        else
        {
            player function_f34b9a983ed02221();
            player scripts\cp_mp\loot\common_inventory::function_389d4cd85d174957();
        }
        
        if ( isdefined( level.var_4b90dae6c1d817ee ) && istrue( level.var_4b90dae6c1d817ee[ player.team ] ) )
        {
            player setclientomnvar( "ui_dmz_extract_successful", 2 );
        }
        else
        {
            fullyextracted = 1;
            
            foreach ( teammate in getteamdata( player.team, "players" ) )
            {
                if ( !istrue( teammate.var_f52eb40ba99ffa4c ) )
                {
                    fullyextracted = 0;
                    break;
                }
            }
            
            if ( fullyextracted )
            {
                function_e1b5f91e2e989934( player.team );
                player setclientomnvar( "ui_dmz_extract_successful", 2 );
            }
            else
            {
                player setclientomnvar( "ui_dmz_extract_successful", 1 );
            }
        }
        
        player ob::function_865b1a5a62c49d7( 1, 0, 1 );
        player callback::callback( "exfil_success" );
        scripts\mp\gamelogic::processlobbydataforclient( player );
        scripts\mp\scoreboard::processcommonplayerdataforplayer( player );
        processlobbydata();
        player namespace_7177e11e3871c8f4::function_1b6b6e760a1bdd78();
        level.skipplaybodycountsound = 1;
        spawnpoints = getentarray( "mp_global_intermission", "classname" );
        spawnpoint = array_random( spawnpoints );
        player scripts\mp\playerlogic::removefromalivecount( 1 );
        scripts\mp\utility\teams::validatealivecount( "extract", player.team, player );
        
        if ( isdefined( level.var_4b90dae6c1d817ee ) && istrue( level.var_4b90dae6c1d817ee[ player.team ] ) )
        {
            if ( isdefined( self.exfilpos ) )
            {
                player scripts\mp\playerlogic::spawnintermission( spawnpoint, undefined, 0 );
            }
            else
            {
                player scripts\mp\gametypes\br_spectate::spawnintermissionatplayer( player );
            }
        }
        else
        {
            player thread scripts\mp\playerlogic::spawnspectator( spawnpoint.origin, spawnpoint.angles, var_1a32758b940764f4 );
        }
        
        var_b2e199b24ee09a53 = getteamdata( player.team, "alivePlayers" );
        
        if ( !isdefined( var_b2e199b24ee09a53 ) || var_b2e199b24ee09a53.size == 0 )
        {
        }
        
        level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer( player, 0, 1 );
        player setclientomnvar( "ui_br_squad_eliminated_active", 1 );
        player setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "victory" ] );
        player setclientomnvar( "ui_round_end_reason", game[ "end_reason" ][ "objective_completed" ] );
        
        if ( isdefined( player.matchbonus ) )
        {
            player setclientomnvar( "ui_round_end_match_bonus", player.matchbonus );
        }
        
        player setclientdvar( @"hash_cbb22e2fb1a57873", 1 );
    }
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 0
// Checksum 0x0, Offset: 0x22bb
// Size: 0x7a
function function_3b564213c8be506d()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player thread function_933a8cdaac11b439();
        }
    }
    
    wait 25;
    level thread gamelogic::endgame( "none", game[ "end_reason" ][ "objective_failed" ] );
}

// Namespace namespace_f9a64c6fd3a886a1 / namespace_134d54e39331ee45
// Params 0
// Checksum 0x0, Offset: 0x233d
// Size: 0x9c
function function_933a8cdaac11b439()
{
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer( self, 1, 1 );
    wait 2;
    namespace_7177e11e3871c8f4::function_1b6b6e760a1bdd78();
    spawnpoints = getentarray( "mp_global_intermission", "classname" );
    spawnpoint = array_random( spawnpoints );
    scripts\mp\gametypes\br_spectate::spawnintermissionatplayer( self );
    thread scripts\mp\playerlogic::spawnspectator( spawnpoint.origin, spawnpoint.angles, 1 );
    wait 1;
    thread scripts\mp\gametypes\ob::function_922c3629c545df86();
    
    if ( isalive( self ) && self.sessionstate == "playing" )
    {
        self kill();
    }
}

