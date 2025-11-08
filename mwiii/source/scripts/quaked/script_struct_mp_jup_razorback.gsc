#using scripts\common\utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_airdrop;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;

#namespace namespace_7d937d28dc1863ea;

// Namespace namespace_7d937d28dc1863ea / scripts\quaked\script_struct_mp_jup_razorback
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x21e
// Size: 0x1e
function autoexec main()
{
    level.shouldinitvehicles = 1;
    function_c0b3ddc9a6bdcc46( "veh_jup_razorback", &function_7b85ecc9d8f7999f );
}

// Namespace namespace_7d937d28dc1863ea / scripts\quaked\script_struct_mp_jup_razorback
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x244
// Size: 0xa0
function private function_7b85ecc9d8f7999f()
{
    if ( !function_9697379150687859( "veh_jup_razorback" ) )
    {
        return;
    }
    
    level._effect[ "razorback_land" ] = loadfx( "vfx/iw8_mp/killstreak/vfx_tank_dropoff_dust.vfx" );
    callbacks = [];
    callbacks[ "spawn" ] = &function_62702a579222bd60;
    callbacks[ "initSpawnData" ] = &function_1859f961771f5092;
    callbacks[ "enterEnd" ] = &function_e46a03fe7ae6e0e6;
    callbacks[ "exitEnd" ] = &function_8dfba5d7f86409a6;
    callbacks[ "reenter" ] = &function_6a0b988cd7cc2702;
    callbacks[ "spawnPostAirdrop" ] = &function_36266b198eee7af1;
    callbacks[ "copySpawnData" ] = &function_220f1eb18c81f91f;
    function_8497e7e46b5e397( "veh_jup_razorback", callbacks );
}

// Namespace namespace_7d937d28dc1863ea / scripts\quaked\script_struct_mp_jup_razorback
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2ec
// Size: 0x9a
function private function_1859f961771f5092( spawndata )
{
    if ( !isdefined( spawndata ) )
    {
        spawndata = spawnstruct();
    }
    
    if ( !isdefined( spawndata.spawnmethod ) )
    {
        spawndata.spawnmethod = "place_at_position_unsafe";
    }
    
    if ( isdefined( spawndata.skinoverride ) )
    {
        switch ( spawndata.skinoverride )
        {
            case #"hash_22ce3b03c1e51a9c":
                spawndata.skinoverride = "tan";
                break;
            case #"hash_a1e9b77432f55b0e":
                spawndata.skinoverride = "green";
                break;
        }
    }
    
    return spawndata;
}

// Namespace namespace_7d937d28dc1863ea / scripts\quaked\script_struct_mp_jup_razorback
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x38f
// Size: 0x4c
function private function_62702a579222bd60( spawndata, faildata )
{
    function_1859f961771f5092( spawndata );
    
    if ( !isdefined( spawndata.showheadicon ) )
    {
        spawndata.showheadicon = 0;
    }
    
    vehicle = razorback_spawn( spawndata, faildata );
    return vehicle;
}

// Namespace namespace_7d937d28dc1863ea / scripts\quaked\script_struct_mp_jup_razorback
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3e4
// Size: 0x6f
function private function_220f1eb18c81f91f( from, to )
{
    to.spawnmethod = from.spawnmethod;
    to.faceawayfromowner = from.faceawayfromowner;
    to.cantimeout = from.cantimeout;
    to.showheadicon = from.showheadicon;
}

// Namespace namespace_7d937d28dc1863ea / scripts\quaked\script_struct_mp_jup_razorback
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x45b
// Size: 0x19d
function private razorback_spawn( spawndata, faildata, streakinfo )
{
    spawnposition = undefined;
    spawnangles = undefined;
    var_a50521aed4831f1c = undefined;
    var_3ee18b54b626dba8 = undefined;
    spawndata = function_1859f961771f5092( spawndata );
    assertex( isdefined( spawndata ) && ( isdefined( spawndata.origin ) || spawndata.spawnmethod == "<dev string:x1c>" ), "<dev string:x33>" );
    isairdrop = issubstr( spawndata.spawnmethod, "airdrop_" );
    spawnposition = spawndata.origin;
    spawnangles = spawndata.angles;
    
    if ( isdefined( spawndata.owner ) && istrue( spawndata.faceawayfromowner ) )
    {
        between = spawnposition - spawndata.owner.origin;
        
        if ( length2dsquared( between ) > 0 )
        {
            spawnangles = vectortoangles( spawnposition - spawndata.owner.origin );
        }
        else
        {
            spawnangles = spawndata.owner getplayerangles( 1 );
        }
    }
    
    if ( !isdefined( spawnangles ) )
    {
        spawnangles = ( 0, randomint( 360 ), 0 );
    }
    else
    {
        spawnangles *= ( 0, 1, 0 );
    }
    
    vehicle = undefined;
    
    if ( isairdrop )
    {
        vehicle = function_594881805cec9222( spawnposition, spawnangles, var_a50521aed4831f1c, var_3ee18b54b626dba8, spawndata, faildata );
    }
    else
    {
        vehicle = function_19cfa10bff3647b0( spawnposition, spawnangles, spawndata, faildata );
    }
    
    return vehicle;
}

// Namespace namespace_7d937d28dc1863ea / scripts\quaked\script_struct_mp_jup_razorback
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x601
// Size: 0x9e
function private function_19cfa10bff3647b0( spawnposition, spawnangles, spawndata, faildata )
{
    oldorigin = spawndata.origin;
    oldangles = spawndata.angles;
    spawndata.origin = spawnposition;
    spawndata.angles = spawnangles;
    vehicle = function_36266b198eee7af1( spawndata, faildata );
    spawndata.origin = oldorigin;
    spawndata.angles = oldangles;
    
    if ( !isdefined( vehicle ) )
    {
        return undefined;
    }
    
    return vehicle;
}

// Namespace namespace_7d937d28dc1863ea / scripts\quaked\script_struct_mp_jup_razorback
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x6a8
// Size: 0x69
function private function_36266b198eee7af1( spawndata, faildata )
{
    vehicle = function_bba34cf920370ff4( "veh_jup_razorback", spawndata, faildata );
    turret_weapon = function_154eeb077c3211e2();
    turret = function_7d1a850ac1a81925( vehicle, turret_weapon, spawndata, "tag_turret_attach", "veh_jup_mil_tank_razorback_turret_vehphys" );
    vehicle_registerturret( vehicle, turret, makeweapon( turret_weapon ) );
    return vehicle;
}

// Namespace namespace_7d937d28dc1863ea / scripts\quaked\script_struct_mp_jup_razorback
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x71a
// Size: 0x94
function private function_e46a03fe7ae6e0e6( vehicle, seatid, oldseatid, player, data )
{
    if ( istrue( data.success ) )
    {
        thread function_446e8de4f20c387b( vehicle, seatid, oldseatid, player, data );
        return;
    }
    
    if ( !istrue( data.playerdisconnect ) && !istrue( data.playerdeath ) )
    {
        if ( seatid == "gunner" )
        {
            turret_weapon = function_154eeb077c3211e2();
            thread vehicle_occupancy_taketurret( player, vehicle, turret_weapon, data, 1 );
        }
    }
}

// Namespace namespace_7d937d28dc1863ea / scripts\quaked\script_struct_mp_jup_razorback
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x7b6
// Size: 0x70
function private function_446e8de4f20c387b( vehicle, seatid, oldseatid, player, data )
{
    if ( seatid == "gunner" )
    {
        turret_weapon = function_154eeb077c3211e2();
        player function_d764f933c0054e16( vehicle, turret_weapon, 0, 0 );
        player visionsetkillstreakforplayer( "aviCougarGunner", 0 );
    }
    
    function_5004590331017d88( vehicle, seatid, oldseatid, player, data );
}

// Namespace namespace_7d937d28dc1863ea / scripts\quaked\script_struct_mp_jup_razorback
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x82e
// Size: 0x46
function private function_8dfba5d7f86409a6( vehicle, seatid, newseatid, player, data )
{
    if ( istrue( data.success ) )
    {
        function_1ccee9eb8e41323b( vehicle, seatid, newseatid, player, data );
    }
}

// Namespace namespace_7d937d28dc1863ea / scripts\quaked\script_struct_mp_jup_razorback
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x87c
// Size: 0x79
function private function_1ccee9eb8e41323b( vehicle, seatid, newseatid, player, data )
{
    if ( seatid == "gunner" )
    {
        if ( !istrue( data.playerdisconnect ) )
        {
            turret_weapon = function_154eeb077c3211e2();
            player function_99ec1e87f279f082( data, vehicle, turret_weapon );
            player visionsetkillstreakforplayer( "" );
        }
    }
    
    function_cb4191526e56163c( vehicle, seatid, newseatid, player, data );
}

// Namespace namespace_7d937d28dc1863ea / scripts\quaked\script_struct_mp_jup_razorback
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x8fd
// Size: 0x5b
function private function_6a0b988cd7cc2702( vehicle, reenterseatid, var_3f68c37bafd38606, player, data )
{
    if ( isdefined( var_3f68c37bafd38606 ) && var_3f68c37bafd38606 == "gunner" )
    {
        turret_weapon = function_154eeb077c3211e2();
        thread vehicle_occupancy_taketurret( player, vehicle, turret_weapon, data, 1 );
    }
}

// Namespace namespace_7d937d28dc1863ea / scripts\quaked\script_struct_mp_jup_razorback
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0x960
// Size: 0x68
function private function_594881805cec9222( position, angles, groundposition, groundnormal, spawndata, faildata )
{
    spawndata.origin = position;
    spawndata.angles = angles;
    vehicle = scripts\cp_mp\vehicles\vehicle_airdrop::vehicle_airdrop( "veh_jup_razorback", spawndata, faildata );
    return vehicle;
}

// Namespace namespace_7d937d28dc1863ea / scripts\quaked\script_struct_mp_jup_razorback
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x9d1
// Size: 0x38
function private function_154eeb077c3211e2()
{
    turretweapon = function_2e58e7b01554419a( "veh_jup_razorback", "gunner" );
    
    if ( isdefined( turretweapon ) )
    {
        return turretweapon.basename;
    }
    
    return "";
}

