#using scripts\anim\battlechatter;
#using scripts\cp_mp\stealth\utility;
#using scripts\engine\utility;
#using scripts\smartobjects\utility;
#using scripts\stealth\corpse;
#using scripts\stealth\manager;
#using scripts\stealth\threat_sight;
#using scripts\stealth\utility;

#namespace manager;

// Namespace manager / scripts\cp_mp\stealth\manager
// Params 0
// Checksum 0x0, Offset: 0x209
// Size: 0xde
function main()
{
    scripts\smartobjects\utility::init_smartobjects();
    scripts\stealth\manager::main();
    assertex( isdefined( level.stealth ), "level.stealth should have been defined in scriptsstealthmanager::main()" );
    level.stealth.fnaddeventplaybcs = &scripts\anim\battlechatter::addeventplaybcs;
    level.fngetcorpsearrayfunc = &get_corpse_array;
    level.stealth.fngetplayerdrone = &get_player_drone;
    level.var_4fa3c4eb77c24130 = &function_4fa3c4eb77c24130;
    level.var_c5e87dfa7679b0a5 = &function_d3110770982eea0e;
    level thread function_7e4ce548f5795c03();
    set_detect_ranges();
    set_corpse_detect_ranges();
    level thread scripts\stealth\threat_sight::threat_sight_set_enabled( 1 );
    level thread manager_thread();
    level thread update_stealth_spotted_thread();
    
    if ( scripts\engine\utility::issharedfuncdefined( "stealth", "init" ) )
    {
        [[ scripts\engine\utility::getsharedfunc( "stealth", "init" ) ]]();
    }
}

// Namespace manager / scripts\cp_mp\stealth\manager
// Params 0
// Checksum 0x0, Offset: 0x2ef
// Size: 0x29
function function_4fa3c4eb77c24130()
{
    if ( scripts\engine\utility::issharedfuncdefined( "stealth_enemy", "init" ) )
    {
        self [[ scripts\engine\utility::getsharedfunc( "stealth_enemy", "init" ) ]]();
    }
}

// Namespace manager / scripts\cp_mp\stealth\manager
// Params 1
// Checksum 0x0, Offset: 0x320
// Size: 0x33
function function_d3110770982eea0e( bspotted )
{
    if ( scripts\engine\utility::issharedfuncdefined( "stealth", "spotted_event_handler" ) )
    {
        self [[ scripts\engine\utility::getsharedfunc( "stealth", "spotted_event_handler" ) ]]( bspotted );
    }
}

// Namespace manager / scripts\cp_mp\stealth\manager
// Params 10
// Checksum 0x0, Offset: 0x35b
// Size: 0x53
function empty( param_1, param_2, param_3, param_4, param_5, param_6, param_7, param_8, param_9, param_10 )
{
    
}

// Namespace manager / scripts\cp_mp\stealth\manager
// Params 0
// Checksum 0x0, Offset: 0x3b6
// Size: 0x2
function set_detect_ranges()
{
    
}

// Namespace manager / scripts\cp_mp\stealth\manager
// Params 0
// Checksum 0x0, Offset: 0x3c0
// Size: 0x33
function set_corpse_detect_ranges()
{
    array[ "sight_dist" ] = 512;
    array[ "detect_dist" ] = 256;
    array[ "found_dist" ] = 128;
    scripts\stealth\corpse::set_corpse_ranges( array );
}

// Namespace manager / scripts\cp_mp\stealth\manager
// Params 0
// Checksum 0x0, Offset: 0x3fb
// Size: 0x351
function function_7e4ce548f5795c03()
{
    while ( !isdefined( level.stealth ) )
    {
        waitframe();
    }
    
    hiddenranges[ "prone" ] = 1000;
    hiddenranges[ "crouch" ] = 2000;
    hiddenranges[ "stand" ] = getdvarint( @"hash_113e6612d6e3bb87", 2750 );
    var_b6b642cbeff52b88[ "prone" ] = 150;
    var_b6b642cbeff52b88[ "crouch" ] = 350;
    var_b6b642cbeff52b88[ "stand" ] = 600;
    hiddenranges[ "shadow_prone" ] = 0.05;
    hiddenranges[ "shadow_crouch" ] = 0.05;
    hiddenranges[ "shadow_stand" ] = 0.3;
    spottedranges[ "prone" ] = 1500;
    spottedranges[ "crouch" ] = 2500;
    spottedranges[ "stand" ] = getdvarint( @"hash_4689de43493d4968", 3250 );
    var_d0f35fc0a5c3df79[ "prone" ] = 250;
    var_d0f35fc0a5c3df79[ "crouch" ] = 1000;
    var_d0f35fc0a5c3df79[ "stand" ] = 1800;
    spottedranges[ "shadow_prone" ] = 0.01;
    spottedranges[ "shadow_crouch" ] = 0.02;
    spottedranges[ "shadow_stand" ] = 0.38;
    var_8f3f480583606401[ "prone" ] = 1.1;
    var_8f3f480583606401[ "crouch" ] = 1.15;
    var_8f3f480583606401[ "stand" ] = 1.2;
    var_fac370d058479827[ "prone" ] = 0;
    var_fac370d058479827[ "crouch" ] = 0;
    var_fac370d058479827[ "stand" ] = 0;
    var_fb574b7959625bf0[ "prone" ] = 0;
    var_fb574b7959625bf0[ "crouch" ] = 0;
    var_fb574b7959625bf0[ "stand" ] = 0;
    scripts\stealth\utility::set_detect_ranges( hiddenranges, spottedranges, var_8f3f480583606401 );
    scripts\stealth\utility::set_min_detect_range_darkness( var_b6b642cbeff52b88, var_d0f35fc0a5c3df79 );
    scripts\stealth\utility::function_f3883fe06a11269( var_fac370d058479827, var_fb574b7959625bf0 );
    
    if ( !isdefined( level.gamemodebundle ) || istrue( level.gamemodebundle.var_f8c2703e1020ada0 ) )
    {
        event_distances[ "spotted" ][ "explosion" ] = getdvarint( @"hash_a164303e1057f68b", 3000 );
        event_distances[ "hidden" ][ "explosion" ] = getdvarint( @"hash_4ff0d45555734622", 2500 );
        event_distances[ "spotted" ][ "gunshot" ] = getdvarint( @"hash_816440654797aa4e", 2500 );
        event_distances[ "hidden" ][ "gunshot" ] = getdvarint( @"hash_af518075d89400d", 2500 );
        event_distances[ "spotted" ][ "gunshot_teammate" ] = getdvarint( @"hash_57ad54b68036f52a", 2500 );
        event_distances[ "hidden" ][ "gunshot_teammate" ] = getdvarint( @"hash_ec133bcfe15d64f9", 2500 );
        event_distances[ "spotted" ][ "footstep" ] = 128;
        event_distances[ "hidden" ][ "footstep" ] = getdvarint( @"hash_5110fbb11d551c74", 64 );
        event_distances[ "spotted" ][ "footstep_walk" ] = 512;
        event_distances[ "hidden" ][ "footstep_walk" ] = getdvarint( @"hash_9300acad842264a5", 256 );
        event_distances[ "spotted" ][ "footstep_sprint" ] = 768;
        event_distances[ "hidden" ][ "footstep_sprint" ] = getdvarint( @"hash_42b014df24f71fa", 512 );
        scripts\stealth\manager::set_custom_distances( event_distances );
    }
    
    if ( isdefined( level.var_2921e9fc2c12207c ) )
    {
        [[ level.var_2921e9fc2c12207c ]]();
    }
}

// Namespace manager / scripts\cp_mp\stealth\manager
// Params 0
// Checksum 0x0, Offset: 0x754
// Size: 0x72
function manager_thread()
{
    while ( true )
    {
        flag_wait( "stealth_enabled" );
        threat_sight_set_dvar( 1 );
        flag_wait( "stealth_spotted" );
        
        if ( !flag( "stealth_enabled" ) )
        {
            continue;
        }
        
        scripts\stealth\manager::event_change( "spotted" );
        flag_waitopen( "stealth_spotted" );
        
        if ( !flag( "stealth_enabled" ) )
        {
            continue;
        }
        
        scripts\stealth\manager::event_change( "hidden" );
        waittillframeend();
    }
}

// Namespace manager / scripts\cp_mp\stealth\manager
// Params 1
// Checksum 0x0, Offset: 0x7ce
// Size: 0x29
function threat_sight_set_dvar( enabled )
{
    if ( enabled && !getstealththreatsightenabled() )
    {
        return;
    }
    
    setdvar( @"ai_threatsight", enabled );
}

// Namespace manager / scripts\cp_mp\stealth\manager
// Params 0
// Checksum 0x0, Offset: 0x7ff
// Size: 0x1d8
function update_stealth_spotted_thread()
{
    waitframe();
    wasspotted = 0;
    
    while ( true )
    {
        bspotted = scripts\stealth\manager::anyone_in_combat();
        
        if ( bspotted )
        {
            if ( !wasspotted && isdefined( level.stealth.stealth_spotted_delay ) && level.stealth.stealth_spotted_delay > 0 )
            {
                wait level.stealth.stealth_spotted_delay;
                
                if ( !scripts\stealth\manager::anyone_in_combat() )
                {
                    waitframe();
                    continue;
                }
            }
            
            if ( !flag( "stealth_spotted" ) )
            {
                flag_set( "stealth_spotted" );
                
                foreach ( player in level.players )
                {
                    if ( isdefined( player.stealth ) )
                    {
                        if ( isdefined( level.var_c5e87dfa7679b0a5 ) )
                        {
                            player [[ level.var_c5e87dfa7679b0a5 ]]( 1 );
                        }
                        
                        mygroupflagname = player scripts\stealth\utility::get_group_flagname( "stealth_spotted" );
                        flag_set( mygroupflagname );
                    }
                }
            }
        }
        else if ( flag( "stealth_spotted" ) )
        {
            flag_clear( "stealth_spotted" );
            
            foreach ( player in level.players )
            {
                if ( isdefined( player.stealth ) )
                {
                    if ( isdefined( level.var_c5e87dfa7679b0a5 ) )
                    {
                        player [[ level.var_c5e87dfa7679b0a5 ]]( 0 );
                    }
                    
                    mygroupflagname = player scripts\stealth\utility::get_group_flagname( "stealth_spotted" );
                    flag_clear( mygroupflagname );
                }
            }
        }
        
        wasspotted = bspotted;
        waitframe();
    }
}

// Namespace manager / scripts\cp_mp\stealth\manager
// Params 0
// Checksum 0x0, Offset: 0x9df
// Size: 0xaf
function get_corpse_array()
{
    if ( !isdefined( level.stealth.corpses ) )
    {
        return [];
    }
    
    foreach ( i, v in level.stealth.corpses )
    {
        if ( !isdefined( level.stealth.corpses[ i ] ) )
        {
            level.stealth.corpses[ i ] = undefined;
        }
    }
    
    return level.stealth.corpses;
}

// Namespace manager / scripts\cp_mp\stealth\manager
// Params 2
// Checksum 0x0, Offset: 0xa97
// Size: 0x1ca
function monitor_death_thread( rangeauto, rangesight )
{
    other = undefined;
    team = self.team;
    
    if ( isdefined( self.stealth.override_damage_auto_range ) )
    {
        rangeauto = self.stealth.override_damage_auto_range;
    }
    else if ( isdefined( level.stealth.override_damage_auto_range ) )
    {
        rangeauto = level.stealth.override_damage_auto_range;
    }
    
    if ( isdefined( self.stealth.override_damage_sight_range ) )
    {
        rangesight = self.stealth.override_damage_sight_range;
    }
    else if ( isdefined( level.stealth.override_damage_sight_range ) )
    {
        rangesight = level.stealth.override_damage_sight_range;
    }
    
    self waittill( "death" );
    body = self getcorpseentity();
    
    if ( isdefined( body ) )
    {
        level.stealth.corpses[ body getentitynumber() ] = body;
    }
    
    if ( !isdefined( self.lastattacker ) )
    {
        return;
    }
    
    other = self.lastattacker;
    
    if ( !isplayer( other ) && ( !isdefined( other.owner ) || !isplayer( other.owner ) ) )
    {
        return;
    }
    
    if ( isdefined( other.owner ) )
    {
        other = other.owner;
    }
    
    if ( !isdefined( other.team ) || other.team == team )
    {
        return;
    }
    
    if ( shouldbroadcastdeathstealthevent( self.damagemod ) )
    {
        stealtheventbroadcast( "ally_killed", self, other, rangeauto, rangesight );
    }
}

// Namespace manager / scripts\cp_mp\stealth\manager
// Params 1
// Checksum 0x0, Offset: 0xc69
// Size: 0x42
function get_player_drone( player )
{
    if ( isdefined( player.scout_drone ) )
    {
        return player.scout_drone;
    }
    
    if ( isdefined( player.emp_drone ) )
    {
        return player.emp_drone;
    }
    
    return undefined;
}

