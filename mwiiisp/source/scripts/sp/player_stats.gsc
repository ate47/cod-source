#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;

#namespace player_stats;

// Namespace player_stats / scripts\sp\player_stats
// Params 0
// Checksum 0x0, Offset: 0x25e
// Size: 0xb4
function init_stats()
{
    self.stats[ "kills" ] = 0;
    self.stats[ "kills_melee" ] = 0;
    self.stats[ "kills_explosives" ] = 0;
    self.stats[ "kills_juggernaut" ] = 0;
    self.stats[ "kills_vehicle" ] = 0;
    self.stats[ "kills_sentry" ] = 0;
    self.stats[ "headshots" ] = 0;
    self.stats[ "shots_fired" ] = 0;
    self.stats[ "shots_hit" ] = 0;
    self.stats[ "weapon" ] = [];
    thread shots_fired_recorder();
}

// Namespace player_stats / scripts\sp\player_stats
// Params 0
// Checksum 0x0, Offset: 0x31a
// Size: 0x63, Type: bool
function was_headshot()
{
    if ( isdefined( self.died_of_headshot ) && self.died_of_headshot )
    {
        return true;
    }
    
    if ( !isdefined( self.damagelocation ) )
    {
        return false;
    }
    
    return self.damagelocation == "helmet" || self.damagelocation == "head" || self.damagelocation == "neck";
}

// Namespace player_stats / scripts\sp\player_stats
// Params 4
// Checksum 0x0, Offset: 0x386
// Size: 0x28f
function register_kill( killedent, cause, weaponname, killtype )
{
    assertex( isdefined( cause ), "Tried to register a player stat for a kill that didn't have a method of death" );
    player = self;
    
    if ( isdefined( self.owner ) )
    {
        player = self.owner;
    }
    
    if ( !isplayer( player ) )
    {
        if ( isdefined( level.pmc_match ) && level.pmc_match )
        {
            player = level.players[ randomint( level.players.size ) ];
        }
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( isdefined( level.skip_pilot_kill_count ) && isdefined( killedent.drivingvehicle ) && killedent.drivingvehicle )
    {
        return;
    }
    
    player.stats[ "kills" ]++;
    
    if ( isdefined( killedent ) )
    {
        if ( killedent was_headshot() )
        {
            player.stats[ "headshots" ]++;
        }
        
        if ( isdefined( killedent.juggernaut ) )
        {
            player.stats[ "kills_juggernaut" ]++;
        }
        
        if ( isdefined( killedent.issentrygun ) )
        {
            player.stats[ "kills_sentry" ]++;
        }
        
        if ( killedent.code_classname == "script_vehicle" )
        {
            player.stats[ "kills_vehicle" ]++;
            
            if ( isdefined( killedent.riders ) )
            {
                foreach ( rider in killedent.riders )
                {
                    if ( isdefined( rider ) )
                    {
                        player register_kill( rider, cause, weaponname, killtype );
                    }
                }
            }
        }
    }
    
    if ( cause_is_explosive( cause ) )
    {
        player.stats[ "kills_explosives" ]++;
    }
    
    if ( isdefined( weaponname ) )
    {
        weapon = makeweaponfromstring( weaponname );
    }
    else
    {
        weapon = player getcurrentweapon();
    }
    
    if ( issubstr( tolower( cause ), "melee" ) )
    {
        player.stats[ "kills_melee" ]++;
        
        if ( weaponinventorytype( weapon ) == "primary" )
        {
            return;
        }
    }
    
    assert( isdefined( weapon ) );
    
    if ( player is_new_weapon( weapon ) )
    {
        player register_new_weapon( weapon );
    }
    
    player.stats[ "weapon" ][ getcompleteweaponname( weapon ) ].kills++;
}

// Namespace player_stats / scripts\sp\player_stats
// Params 0
// Checksum 0x0, Offset: 0x61d
// Size: 0xa2
function register_shot_hit()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    assert( isdefined( self.stats ) );
    
    if ( isdefined( self.registeringshothit ) )
    {
        return;
    }
    
    self.registeringshothit = 1;
    self.stats[ "shots_hit" ]++;
    weapon = self getcurrentweapon();
    assert( isdefined( weapon ) );
    
    if ( is_new_weapon( weapon ) )
    {
        register_new_weapon( weapon );
    }
    
    self.stats[ "weapon" ][ getcompleteweaponname( weapon ) ].shots_hit++;
    waittillframeend();
    self.registeringshothit = undefined;
}

// Namespace player_stats / scripts\sp\player_stats
// Params 0
// Checksum 0x0, Offset: 0x6c7
// Size: 0x7c
function shots_fired_recorder()
{
    self endon( "death" );
    
    for ( ;; )
    {
        self waittill( "weapon_fired" );
        weapon = self getcurrentweapon();
        
        if ( !isdefined( weapon ) || !isprimaryweapon( weapon ) )
        {
            continue;
        }
        
        self.stats[ "shots_fired" ]++;
        
        if ( is_new_weapon( weapon ) )
        {
            register_new_weapon( weapon );
        }
        
        self.stats[ "weapon" ][ getcompleteweaponname( weapon ) ].shots_fired++;
    }
}

// Namespace player_stats / scripts\sp\player_stats
// Params 1
// Checksum 0x0, Offset: 0x74b
// Size: 0x29, Type: bool
function is_new_weapon( weapon )
{
    if ( isdefined( self.stats[ "weapon" ][ getcompleteweaponname( weapon ) ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace player_stats / scripts\sp\player_stats
// Params 1
// Checksum 0x0, Offset: 0x77d
// Size: 0x76, Type: bool
function cause_is_explosive( cause )
{
    cause = tolower( cause );
    
    switch ( cause )
    {
        case #"hash_1991ba0f6a8cd0a2":
        case #"hash_25d762139cbf755b":
        case #"hash_3734ba2dac7b82b0":
        case #"hash_95f4dd5cd9bac6c6":
        case #"hash_e519b5a3caf0a103":
        case #"hash_fec6e5947c5a138b":
            return true;
        default:
            return false;
    }
    
    return false;
}

// Namespace player_stats / scripts\sp\player_stats
// Params 1
// Checksum 0x0, Offset: 0x7fc
// Size: 0xa7
function register_new_weapon( weapon )
{
    weaponname = getcompleteweaponname( weapon );
    self.stats[ "weapon" ][ weaponname ] = spawnstruct();
    self.stats[ "weapon" ][ weaponname ].name = weaponname;
    self.stats[ "weapon" ][ weaponname ].shots_fired = 0;
    self.stats[ "weapon" ][ weaponname ].shots_hit = 0;
    self.stats[ "weapon" ][ weaponname ].kills = 0;
}

// Namespace player_stats / scripts\sp\player_stats
// Params 0
// Checksum 0x0, Offset: 0x8ab
// Size: 0x36b
function set_stat_dvars()
{
    playernum = 1;
    
    foreach ( player in level.players )
    {
        setdvar( hashcat( @"stats_", playernum, "_kills_melee", player.stats[ "kills_melee" ] ) );
        setdvar( hashcat( @"stats_", playernum, "_kills_juggernaut", player.stats[ "kills_juggernaut" ] ) );
        setdvar( hashcat( @"stats_", playernum, "_kills_explosives", player.stats[ "kills_explosives" ] ) );
        setdvar( hashcat( @"stats_", playernum, "_kills_vehicle", player.stats[ "kills_vehicle" ] ) );
        setdvar( hashcat( @"stats_", playernum, "_kills_sentry", player.stats[ "kills_sentry" ] ) );
        weapons = player get_best_weapons( 5 );
        
        foreach ( weapon in weapons )
        {
            weapon.accuracy = 0;
            
            if ( weapon.shots_fired > 0 )
            {
                weapon.accuracy = int( weapon.shots_hit / weapon.shots_fired * 100 );
            }
        }
        
        for ( i = 1; i < 6 ; i++ )
        {
            setdvar( hashcat( @"stats_", playernum, "_weapon", i, "_name" ), " " );
            setdvar( hashcat( @"stats_", playernum, "_weapon", i, "_kills" ), " " );
            setdvar( hashcat( @"stats_", playernum, "_weapon", i, "_shots" ), " " );
            setdvar( hashcat( @"stats_", playernum, "_weapon", i, "_accuracy" ), " " );
        }
        
        for ( i = 0; i < weapons.size ; i++ )
        {
            if ( !isdefined( weapons[ i ] ) )
            {
                break;
            }
            
            setdvar( hashcat( @"stats_", playernum, "_weapon", i + 1, "_name" ), weapons[ i ].name );
            setdvar( hashcat( @"stats_", playernum, "_weapon", i + 1, "_kills" ), weapons[ i ].kills );
            setdvar( hashcat( @"stats_", playernum, "_weapon", i + 1, "_shots" ), weapons[ i ].shots_fired );
            setdvar( hashcat( @"stats_", playernum, "_weapon", i + 1, "_accuracy" ), weapons[ i ].accuracy + "%" );
        }
        
        playernum++;
    }
}

// Namespace player_stats / scripts\sp\player_stats
// Params 1
// Checksum 0x0, Offset: 0xc1e
// Size: 0x3b
function get_best_weapons( var_1391e661d0c70d36 )
{
    weaponstats = [];
    
    for ( i = 0; i < var_1391e661d0c70d36 ; i++ )
    {
        weaponstats[ i ] = get_weapon_with_most_kills( weaponstats );
    }
    
    return weaponstats;
}

// Namespace player_stats / scripts\sp\player_stats
// Params 1
// Checksum 0x0, Offset: 0xc62
// Size: 0x112
function get_weapon_with_most_kills( excluders )
{
    if ( !isdefined( excluders ) )
    {
        excluders = [];
    }
    
    highest = undefined;
    
    foreach ( weapon in self.stats[ "weapon" ] )
    {
        isexcluder = 0;
        
        foreach ( excluder in excluders )
        {
            if ( weapon.name == excluder.name )
            {
                isexcluder = 1;
                break;
            }
        }
        
        if ( isexcluder )
        {
            continue;
        }
        
        if ( !isdefined( highest ) )
        {
            highest = weapon;
            continue;
        }
        
        if ( weapon.kills > highest.kills )
        {
            highest = weapon;
        }
    }
    
    return highest;
}

