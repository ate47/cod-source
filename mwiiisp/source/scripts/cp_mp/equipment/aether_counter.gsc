#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;

#namespace aether_counter;

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 0
// Checksum 0x0, Offset: 0x221
// Size: 0xb0
function function_af629bfd2cc31d67()
{
    if ( isdefined( level.var_9c6bcabc08e74a5e ) )
    {
        return;
    }
    
    level.var_9c6bcabc08e74a5e = 1;
    level.var_b38bd8b30b329ecd = spawnstruct();
    level.var_b38bd8b30b329ecd.partition = create_partition( [], 4000 );
    level.var_b38bd8b30b329ecd.radiationmaxdist = getdvarint( @"hash_ac8dcf3f0fa3df5b", 1000 );
    registersharedfunc( "equip_aethercounter", "used", &function_88108e9a7fefa45c );
    registersharedfunc( "equip_aethercounter", "onGive", &function_2ee478f031f97735 );
    registersharedfunc( "equip_aethercounter", "onTake", &function_3bf23e1e0eccb4a7 );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 2
// Checksum 0x0, Offset: 0x2d9
// Size: 0x52
function function_2ee478f031f97735( equipmentref, equipmentslot )
{
    if ( equipmentref != "equip_aethercounter" )
    {
        return;
    }
    
    function_af629bfd2cc31d67();
    self notifyonplayercommand( "pullout_gc", "+smoke" );
    self notify( "aethercounter_take" );
    thread aethercounter_watchfordevicepullout();
    function_b725c6b75eac64a( -1 );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 2
// Checksum 0x0, Offset: 0x333
// Size: 0x43
function function_3bf23e1e0eccb4a7( equipmentref, equipmentslot )
{
    if ( equipmentref != "equip_aethercounter" )
    {
        return;
    }
    
    self notifyonplayercommandremove( "pullout_gc", "+smoke" );
    self notify( "aethercounter_take" );
    function_b725c6b75eac64a( -1 );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 1
// Checksum 0x0, Offset: 0x37e
// Size: 0x27
function function_88108e9a7fefa45c( grenade )
{
    waitframe();
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
    
    self notify( "aethercounter_putaway" );
    function_b914dca03eb66c0d();
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 0
// Checksum 0x0, Offset: 0x3ad
// Size: 0x189
function aethercounter_watchfordevicepullout()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "aethercounter_watchForDevicePullout" );
    self endon( "aethercounter_watchForDevicePullout" );
    raceresult = spawnstruct();
    childthread function_f7c4dd82fc32c7b9( raceresult );
    childthread function_9df43daca6fc5bc2( raceresult );
    
    while ( true )
    {
        death = istrue( raceresult.death );
        take = istrue( raceresult.take );
        pulledout = istrue( raceresult.pulledout );
        
        if ( death || take )
        {
            self notify( "aethercounter_watchRaceEnd" );
            return;
        }
        
        if ( istrue( self.inlaststand ) )
        {
            waitframe();
            continue;
        }
        
        if ( !isdefined( self.var_b38bd8b30b329ecd ) )
        {
            self.var_b38bd8b30b329ecd = spawnstruct();
        }
        
        outofrange = 1;
        self.var_b38bd8b30b329ecd.var_e91c9347e638750d = function_c621b72b61c253ef();
        
        if ( isdefined( self.var_b38bd8b30b329ecd.var_e91c9347e638750d ) )
        {
            var_1e331291fa3bd60 = function_2588ffec6fe5bd6d( self.var_b38bd8b30b329ecd.var_e91c9347e638750d );
            
            if ( function_2d56da6c95356759( self, var_1e331291fa3bd60, self.var_b38bd8b30b329ecd.var_e91c9347e638750d.detectionrange ) )
            {
                outofrange = 0;
                function_8031a35aa804e254( var_1e331291fa3bd60 );
            }
            else
            {
                outofrange = function_92d0e5b2f76e0fe5();
            }
        }
        else
        {
            outofrange = function_92d0e5b2f76e0fe5();
        }
        
        if ( istrue( outofrange ) )
        {
            function_b725c6b75eac64a( -1 );
        }
        
        waitframe();
    }
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 0
// Checksum 0x0, Offset: 0x53e
// Size: 0x90, Type: bool
function function_92d0e5b2f76e0fe5()
{
    if ( issharedfuncdefined( "radiation", "radiation_isInit" ) && issharedfuncdefined( "radiation", "radiation_signedDistanceFromRadiationCircle" ) )
    {
        if ( [[ scripts\engine\utility::getsharedfunc( "radiation", "radiation_isInit" ) ]]() )
        {
            var_7541c0ea78d6cdaf = [[ scripts\engine\utility::getsharedfunc( "radiation", "radiation_signedDistanceFromRadiationCircle" ) ]]( self.origin );
            
            if ( var_7541c0ea78d6cdaf < level.var_b38bd8b30b329ecd.radiationmaxdist )
            {
                function_8031a35aa804e254( 99999999999 );
                return false;
            }
        }
    }
    
    return true;
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 1
// Checksum 0x0, Offset: 0x5d7
// Size: 0x148
function function_8031a35aa804e254( dist )
{
    if ( getweaponbasename( self getheldoffhand() ) == "aether_counter_mp" )
    {
        self.var_b38bd8b30b329ecd.pulledout = 1;
        self.var_b38bd8b30b329ecd.var_f458338f4188859e = _aethercounter_calculateaethercounterpulserate( dist, self.var_b38bd8b30b329ecd.var_e91c9347e638750d );
        
        if ( !isdefined( self.var_b38bd8b30b329ecd.timesincetick ) )
        {
            self.var_b38bd8b30b329ecd.timesincetick = 0;
        }
        
        function_b725c6b75eac64a( clamp( 1.4 - self.var_b38bd8b30b329ecd.var_f458338f4188859e, 0, 1.4 ) );
        
        if ( self.var_b38bd8b30b329ecd.timesincetick >= self.var_b38bd8b30b329ecd.var_f458338f4188859e )
        {
            function_8f4759d455d12f06();
            self.var_b38bd8b30b329ecd.timesincetick = 0;
        }
        
        self.var_b38bd8b30b329ecd.timesincetick += level.framedurationseconds;
        return;
    }
    
    function_b725c6b75eac64a( -0.25 );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 0
// Checksum 0x0, Offset: 0x727
// Size: 0x1a, Type: bool
function function_5a5133a5c98f4851()
{
    if ( getweaponbasename( self getheldoffhand() ) == "aether_counter_mp" )
    {
        return true;
    }
    
    return false;
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 1
// Checksum 0x0, Offset: 0x74a
// Size: 0x30
function function_f7c4dd82fc32c7b9( raceresult )
{
    self endon( "aethercounter_watchRaceEnd" );
    self waittill( "death" );
    raceresult.death = 1;
    self notify( "aethercounter_watchRaceStart" );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 1
// Checksum 0x0, Offset: 0x782
// Size: 0x30
function function_9df43daca6fc5bc2( raceresult )
{
    self endon( "aethercounter_watchRaceEnd" );
    self waittill( "aethercounter_take" );
    raceresult.take = 1;
    self notify( "aethercounter_watchRaceStart" );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 1
// Checksum 0x0, Offset: 0x7ba
// Size: 0x5a
function function_5aab43e8311b7e7f( raceresult )
{
    self endon( "aethercounter_watchRaceEnd" );
    self waittill( "pullout_gc", weapon );
    
    while ( true )
    {
        if ( getweaponbasename( self getheldoffhand() ) == "aether_counter_mp" )
        {
            break;
        }
    }
    
    raceresult.pulledout = 1;
    self notify( "aethercounter_watchRaceStart" );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 1
// Checksum 0x0, Offset: 0x81c
// Size: 0x47
function function_824860a3ff9ea883( raceresult )
{
    self endon( "aethercounter_watchRaceEnd" );
    
    while ( true )
    {
        if ( getweaponbasename( self getheldoffhand() ) == "aether_counter_mp" )
        {
            break;
        }
    }
    
    raceresult.putaway = 1;
    self notify( "aethercounter_watchRaceEnd" );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 0
// Checksum 0x0, Offset: 0x86b
// Size: 0x42
function function_b914dca03eb66c0d()
{
    self notify( "aethercounter_putaway" );
    
    if ( isdefined( self.var_b38bd8b30b329ecd ) )
    {
        self.var_b38bd8b30b329ecd.pulledout = undefined;
        self.var_b38bd8b30b329ecd = undefined;
        function_e9db195fe373a520();
        function_7812e187185aef80();
    }
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 0
// Checksum 0x0, Offset: 0x8b5
// Size: 0x24, Type: bool
function function_1cfcd2b63bc91c2d()
{
    return isdefined( self.var_b38bd8b30b329ecd ) && istrue( self.var_b38bd8b30b329ecd.pulledout );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 0
// Checksum 0x0, Offset: 0x8e2
// Size: 0xf
function function_7812e187185aef80()
{
    self setclientomnvar( "ui_geigercounter_meter", 0 );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 1
// Checksum 0x0, Offset: 0x8f9
// Size: 0x18
function function_90f4a7cf8aae35c5( data )
{
    self setclientomnvar( "ui_geigercounter_meter", data );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 0
// Checksum 0x0, Offset: 0x919
// Size: 0xe
function function_8f4759d455d12f06()
{
    self playlocalsound( "iw9_geiger_counter_tick" );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 0
// Checksum 0x0, Offset: 0x92f
// Size: 0xe
function function_e9db195fe373a520()
{
    self stoplocalsound( "iw9_geiger_counter_tick" );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 1
// Checksum 0x0, Offset: 0x945
// Size: 0x35
function function_b725c6b75eac64a( overridevalue )
{
    if ( isdefined( overridevalue ) )
    {
        function_90f4a7cf8aae35c5( overridevalue );
        return;
    }
    
    function_90f4a7cf8aae35c5( self.var_b38bd8b30b329ecd.var_f458338f4188859e );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 1
// Checksum 0x0, Offset: 0x982
// Size: 0x26
function function_81e4d8ae8de025ab( object )
{
    level.var_b38bd8b30b329ecd.partition function_24bbefb4beda630d( object );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 1
// Checksum 0x0, Offset: 0x9b0
// Size: 0x26
function function_2e0a6a72e3e7388d( object )
{
    level.var_b38bd8b30b329ecd.partition function_9cd3f5f067afea37( object );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 0
// Checksum 0x0, Offset: 0x9de
// Size: 0x24
function function_c621b72b61c253ef()
{
    return level.var_b38bd8b30b329ecd.partition function_60dbe20f8385f1b0( self.origin );
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 1
// Checksum 0x0, Offset: 0xa0b
// Size: 0x3c
function function_2588ffec6fe5bd6d( var_476ba0cad41d3b92 )
{
    radiationpos = var_476ba0cad41d3b92.origin;
    var_1e331291fa3bd60 = distancesquared( radiationpos, self.origin );
    return var_1e331291fa3bd60;
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 3
// Checksum 0x0, Offset: 0xa50
// Size: 0x35, Type: bool
function function_2d56da6c95356759( player, var_1e331291fa3bd60, var_98a5e37618751295 )
{
    detectionradius = default_to( var_98a5e37618751295, 4000 );
    return var_1e331291fa3bd60 < detectionradius * detectionradius;
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 2
// Checksum 0x0, Offset: 0xa8e
// Size: 0x2b3
function _aethercounter_calculateaethercounterpulserate( var_1e331291fa3bd60, object )
{
    self notify( "_aethercounter_calculateaetherCounterPulseRate" );
    self endon( "_aethercounter_calculateaetherCounterPulseRate" );
    self endon( "disconnect" );
    var_9068cb3a62d2ccd4 = 0.1;
    minwait = lookupsoundlength( "iw9_aether_counter_tick" ) / 1000;
    maxwait = 1.4;
    mindist = 0;
    maxdist = default_to( object.detectionrange, 4000 );
    dist = sqrt( var_1e331291fa3bd60 );
    waittime = minwait;
    waittime_lookat = minwait;
    waittime_dist = minwait;
    total_factor = 0;
    dist_factor = clamp( -1 * ( dist - mindist ) / ( maxdist - mindist ) + 1, 0, 1 );
    radiation_factor = 0;
    
    if ( issharedfuncdefined( "radiation", "radiation_isInit" ) && issharedfuncdefined( "radiation", "radiation_signedDistanceFromRadiationCircle" ) )
    {
        if ( [[ scripts\engine\utility::getsharedfunc( "radiation", "radiation_isInit" ) ]]() )
        {
            var_7541c0ea78d6cdaf = [[ scripts\engine\utility::getsharedfunc( "radiation", "radiation_signedDistanceFromRadiationCircle" ) ]]( self.origin );
            in_radiation = var_7541c0ea78d6cdaf <= 0;
            
            if ( in_radiation )
            {
                radiation_factor = 1;
            }
            else
            {
                radiation_factor = clamp( -1 * var_7541c0ea78d6cdaf / level.var_b38bd8b30b329ecd.radiationmaxdist + 1, 0, 1 );
            }
        }
    }
    
    angle_factor = 0;
    
    if ( isdefined( object ) )
    {
        player_forward = anglestoforward( self getplayerangles() );
        var_4712089f9a28931d = vectornormalize( object.origin - self.origin );
        dot_vec = vectordot( player_forward, var_4712089f9a28931d );
        angle_factor = clamp( 20 * dist_factor, 0, 1 ) * ( dot_vec + 1 ) / 2;
    }
    
    total_factor = clamp( dist_factor * 0.8 + angle_factor * 0.2 + radiation_factor * 1, 0, 1 );
    
    if ( isdefined( object ) && isdefined( object.var_71a737239e0ee274 ) )
    {
        total_factor *= object.var_71a737239e0ee274;
    }
    
    waittime = ( -1 * total_factor + 1 ) * maxwait;
    return waittime;
}

// Namespace aether_counter / scripts\cp_mp\equipment\aether_counter
// Params 0
// Checksum 0x0, Offset: 0xd4a
// Size: 0x3a
function function_f2aa833e16733c5e()
{
    if ( function_1cfcd2b63bc91c2d() )
    {
        return ( clamp( 1.4 - self.var_b38bd8b30b329ecd.var_f458338f4188859e, 0, 1.4 ) / 1.4 * 10 );
    }
    
    return 0;
}

