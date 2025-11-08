#using script_4c543f01345a2c04;
#using script_638d701d263ee1ed;
#using script_77be8cd2b6610d5;
#using scripts\aitypes\zombie_entity\zombie_entity_metabones;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;

#namespace namespace_14027a3a2e30e5b7;

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 0
// Checksum 0x0, Offset: 0x20a
// Size: 0x47
function function_d1b30a5bdb59508d()
{
    setdvarifuninitialized( @"hash_376a94d300184801", 0 );
    setdvarifuninitialized( @"hash_d5172208cbbbb77e", 0 );
    zombie_entity::init_metabones();
    thread function_79ddb0c32a22eccd();
    thread function_579dee4d0f0eef08();
    self.var_795cf764ad7734f4 = &function_c549f1e04e77e820;
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 0
// Checksum 0x0, Offset: 0x259
// Size: 0x187
function function_7b56e113a19f4672()
{
    self.entitydata.var_21544f0d5a3ef4d2 = 0;
    self.entitydata.var_4dca40fc7b5a3e1f = 0;
    self.entitydata.weakpoints = [];
    
    for ( i = 0; i < 7 ; i++ )
    {
        metabone_name = "";
        
        switch ( i )
        {
            case 0:
                metabone_name = "heart";
                break;
            case 1:
                metabone_name = "l_hand";
                break;
            case 2:
                metabone_name = "r_hand";
                break;
            case 3:
                metabone_name = "l_hip";
                break;
            case 4:
                metabone_name = "r_hip";
                break;
            case 5:
                metabone_name = "l_shoulder";
                break;
            case 6:
                metabone_name = "r_shoulder";
                break;
            default:
                break;
        }
        
        if ( metabone_name == "" )
        {
            continue;
        }
        
        if ( self.entitydata.phaseindex == 0 )
        {
            if ( metabone_name == "l_hand" || metabone_name == "r_hand" )
            {
                scriptname = metabone_name + "_weakpoint";
                utility::function_3677f2be30fdd581( scriptname, "off" );
                continue;
            }
        }
        
        init_weakpoint( metabone_name );
    }
    
    thread function_e6129386d662ac36();
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 1
// Checksum 0x0, Offset: 0x3e8
// Size: 0x22e
function function_7a92abaf9289a974( params )
{
    settings = function_2a87c62a30af1ce();
    damage_taken = 0;
    
    if ( getdvarint( @"hash_376a94d300184801", 0 ) || params.eattacker == self )
    {
        damage_taken = params.idamage;
    }
    else if ( isdefined( params.metabonename ) && !metabone::function_cec565632b7fc419( params.metabonename ) )
    {
        if ( function_6db512214e7e7009( params.metabonename ) )
        {
            index = function_f83b17b2b8d7a76d( params.metabonename );
            var_a36dac6bc1508662 = toggle_weakpoint( index, "impact" );
            damage_taken = params.idamage;
            var_dd5d80e7f90dda09 = 0;
            
            if ( isdefined( self.entitydata ) )
            {
                var_dd5d80e7f90dda09 = self.entitydata.var_21544f0d5a3ef4d2;
            }
            
            if ( istrue( self.var_4919d15787f01154 ) )
            {
                zombie_damage::function_63e1cb89f73d0ad8( params );
                
                if ( isdefined( params.objweapon ) )
                {
                    if ( scripts\cp_mp\weapon::iskillstreakweapon( params.objweapon ) )
                    {
                        params.idamage *= 0.2;
                    }
                }
                
                damage_taken = params.idamage;
                function_71a411d4b5466318( params );
            }
            
            if ( var_dd5d80e7f90dda09 == 1 && self.entitydata.var_21544f0d5a3ef4d2 == 0 )
            {
                damage_bonus = self.maxhealth * settings.var_bc7aeac7d54db12e;
                damage_taken += damage_bonus;
            }
        }
    }
    
    if ( damage_taken > 0 )
    {
        health = function_6a493253ff0a74bd();
        
        if ( isplayer( params.eattacker ) )
        {
            params.eattacker playlocalsound( "evt_ai_entity_weakpoint_hit_marker" );
        }
        else if ( health - damage_taken <= 0 )
        {
            damage_taken = health - 1;
        }
    }
    
    if ( namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10( self.origin ) == "difficulty_darkaether" )
    {
        damage_taken *= getdvarfloat( @"hash_9977064abaa78b60", 0.6 );
    }
    
    return damage_taken;
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x61f
// Size: 0xcb
function private init_weakpoint( name )
{
    index = self.entitydata.weakpoints.size;
    self.entitydata.weakpoints[ index ] = spawnstruct();
    self.entitydata.weakpoints[ index ].state = "off";
    self.entitydata.weakpoints[ index ].var_d7b9041a0f377b26 = 0;
    self.entitydata.weakpoints[ index ].name = name;
    scriptable_name = name + "_weakpoint";
    utility::function_3677f2be30fdd581( name, "off" );
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x6f2
// Size: 0x146
function private function_80e7f3c380360a74()
{
    if ( !isdefined( self.entitydata.weakpoints ) )
    {
        function_7b56e113a19f4672();
    }
    
    settings = function_2a87c62a30af1ce();
    var_c301a11a2876b305 = settings.var_c301a11a2876b305;
    maxactive = settings.maxactive;
    num_active = 0;
    
    if ( var_c301a11a2876b305 >= maxactive )
    {
        num_active = var_c301a11a2876b305;
    }
    else
    {
        delta = maxactive - var_c301a11a2876b305;
        num_active = var_c301a11a2876b305 + randomint( delta );
    }
    
    num_weakpoints = self.entitydata.weakpoints.size;
    num_active = min( num_weakpoints, num_active );
    weakpoint_indices = [];
    
    for ( i = 0; i < num_weakpoints ; i++ )
    {
        weakpoint_indices[ i ] = i;
        toggle_weakpoint( i, "off" );
    }
    
    randomized_numbers = array_randomize( weakpoint_indices );
    
    for ( i = 0; i < num_active ; i++ )
    {
        toggle_weakpoint( randomized_numbers[ i ], "on", 1 );
    }
    
    self.entitydata.var_21544f0d5a3ef4d2 = num_active;
    self.entitydata.var_4dca40fc7b5a3e1f = num_active;
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x840
// Size: 0x8c
function private function_7410aa3c82ab4773()
{
    for ( i = 0; i < self.entitydata.weakpoints.size ; i++ )
    {
        toggle_weakpoint( i, "destroyed" );
        metabone::function_7380ccd6f2c49392( self.entitydata.weakpoints[ i ].name, 0 );
    }
    
    self.entitydata.var_21544f0d5a3ef4d2 = 0;
    self.entitydata.var_4dca40fc7b5a3e1f = 0;
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x8d4
// Size: 0x8c
function private function_ee11b6bc53cb7145()
{
    for ( i = 0; i < self.entitydata.weakpoints.size ; i++ )
    {
        toggle_weakpoint( i, "off" );
        metabone::function_7380ccd6f2c49392( self.entitydata.weakpoints[ i ].name, 0 );
    }
    
    self.entitydata.var_21544f0d5a3ef4d2 = 0;
    self.entitydata.var_4dca40fc7b5a3e1f = 0;
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x968
// Size: 0x25
function private function_6db512214e7e7009( name )
{
    index = function_f83b17b2b8d7a76d( name );
    return function_b88c0fec5b4cc4c8( index );
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x996
// Size: 0x9d, Type: bool
function private function_b88c0fec5b4cc4c8( index )
{
    if ( index < 0 || index >= self.entitydata.weakpoints.size )
    {
        return false;
    }
    
    if ( !isdefined( self.entitydata.weakpoints[ index ] ) || self.entitydata.weakpoints[ index ].state == "off" || self.entitydata.weakpoints[ index ].state == "destroyed" )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 1
// Checksum 0x0, Offset: 0xa3c
// Size: 0x93
function function_f83b17b2b8d7a76d( name )
{
    if ( !isdefined( self.entitydata.weakpoints ) )
    {
        return -1;
    }
    
    for ( i = 0; i < self.entitydata.weakpoints.size ; i++ )
    {
        if ( isdefined( self.entitydata.weakpoints[ i ] ) && self.entitydata.weakpoints[ i ].name == name )
        {
            return i;
        }
    }
    
    return -1;
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 3
// Checksum 0x0, Offset: 0xad8
// Size: 0x247, Type: bool
function toggle_weakpoint( index, state, set_health )
{
    if ( index < 0 || index >= self.entitydata.weakpoints.size )
    {
        return false;
    }
    
    if ( isdefined( self.entitydata.weakpoints[ index ] ) && ( self.entitydata.weakpoints[ index ].state != state || state == "off" ) )
    {
        self.entitydata.weakpoints[ index ].state = state;
        
        if ( state == "impact" )
        {
            self.entitydata.weakpoints[ index ].var_d7b9041a0f377b26 = gettime() + self.phasedata[ self.entitydata.phaseindex ].var_9cfdfb806b41190c.var_72b6da1531fbd71d;
        }
        
        scriptable_name = self.entitydata.weakpoints[ index ].name + "_weakpoint";
        utility::function_3677f2be30fdd581( scriptable_name, state );
        
        if ( state == "on" && isdefined( set_health ) && set_health == 1 )
        {
            max_health = metabone::function_58b8812944c3f7e8( self.entitydata.weakpoints[ index ].name, "active" );
            var_445602aab16329e9 = getdvarint( @"hash_d5172208cbbbb77e", 0 );
            
            if ( var_445602aab16329e9 > 0 )
            {
                max_health = var_445602aab16329e9;
            }
            
            metabone::function_5f2c6624e43cd8e( self.entitydata.weakpoints[ index ].name, max_health, "active" );
            metabone::function_7380ccd6f2c49392( self.entitydata.weakpoints[ index ].name, 1 );
        }
        else if ( state == "off" || state == "destroyed" )
        {
            metabone::function_7380ccd6f2c49392( self.entitydata.weakpoints[ index ].name, 0 );
        }
        
        return true;
    }
    
    return false;
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xd28
// Size: 0xdc
function private function_e6129386d662ac36()
{
    self endon( "death" );
    level endon( "game_ended" );
    
    while ( true )
    {
        for ( i = 0; i < self.entitydata.weakpoints.size ; i++ )
        {
            if ( self.entitydata.weakpoints[ i ].state == "impact" )
            {
                if ( gettime() > self.entitydata.weakpoints[ i ].var_d7b9041a0f377b26 )
                {
                    if ( metabone::function_cec565632b7fc419( self.entitydata.weakpoints[ i ].name ) )
                    {
                        toggle_weakpoint( i, "destroyed" );
                        continue;
                    }
                    
                    toggle_weakpoint( i, "on" );
                }
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 0
// Checksum 0x0, Offset: 0xe0c
// Size: 0x47
function function_78aa0a47f46b172c()
{
    count = 0;
    
    for ( i = 0; i < self.entitydata.weakpoints.size ; i++ )
    {
        if ( function_b88c0fec5b4cc4c8( i ) )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 0
// Checksum 0x0, Offset: 0xe5c
// Size: 0x30, Type: bool
function function_d60c223530c969ee()
{
    settings = function_2a87c62a30af1ce();
    return settings.invulnerable || settings.var_c301a11a2876b305 <= 0;
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 0
// Checksum 0x0, Offset: 0xe95
// Size: 0x37, Type: bool
function function_d892eaf3090c1d8e()
{
    if ( self.entitydata.var_4dca40fc7b5a3e1f != 0 && self.entitydata.var_21544f0d5a3ef4d2 > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xed5
// Size: 0x4f
function private function_79ddb0c32a22eccd()
{
    level endon( "game_ended" );
    self endon( "death" );
    ent_flag_wait( "entity_spawnanim_finished" );
    scripts\engine\utility::flag_wait( "scriptables_ready" );
    
    while ( true )
    {
        ent_flag_wait( "weakpoints_activate" );
        function_80e7f3c380360a74();
        ent_flag_clear( "weakpoints_activate" );
    }
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xf2c
// Size: 0x37
function private function_579dee4d0f0eef08()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( true )
    {
        ent_flag_wait( "weakpoints_deactivate" );
        function_ee11b6bc53cb7145();
        ent_flag_clear( "weakpoints_deactivate" );
    }
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xf6b
// Size: 0x29
function private function_2a87c62a30af1ce()
{
    return self.phasedata[ self.entitydata.phaseindex ].var_9cfdfb806b41190c;
}

// Namespace namespace_14027a3a2e30e5b7 / namespace_b6f78975501d56b3
// Params 2
// Checksum 0x0, Offset: 0xf9d
// Size: 0x67, Type: bool
function function_c549f1e04e77e820( var_6344ee17398456ea, params )
{
    if ( getdvarint( @"hash_376a94d300184801", 0 ) )
    {
        return true;
    }
    else if ( isdefined( params.metabonename ) && !metabone::function_cec565632b7fc419( params.metabonename ) )
    {
        if ( function_6db512214e7e7009( params.metabonename ) )
        {
            return true;
        }
    }
    
    return false;
}

