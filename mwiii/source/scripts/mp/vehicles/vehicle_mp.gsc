#using scripts\common\utility;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\engine\utility;
#using scripts\mp\equipment\trophy_system;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\outofbounds;
#using scripts\mp\vehicles\damage;
#using scripts\mp\vehicles\light_tank_mp;
#using scripts\mp\vehicles\vehicle_compass_mp;
#using scripts\mp\vehicles\vehicle_damage_mp;
#using scripts\mp\vehicles\vehicle_interact_mp;
#using scripts\mp\vehicles\vehicle_mines_mp;
#using scripts\mp\vehicles\vehicle_occupancy_mp;
#using scripts\mp\vehicles\vehicle_oob_mp;
#using scripts\mp\vehicles\vehicle_spawn_mp;

#namespace vehicle_mp;

// Namespace vehicle_mp / scripts\mp\vehicles\vehicle_mp
// Params 0
// Checksum 0x0, Offset: 0x2ce
// Size: 0x190
function vehicle_mp_init()
{
    scripts\engine\utility::registersharedfunc( "vehicle", "create", &vehicle_mp_create );
    scripts\engine\utility::registersharedfunc( "vehicle", "createLate", &vehicle_mp_createlate );
    scripts\engine\utility::registersharedfunc( "vehicle", "deleteNextFrame", &vehicle_mp_deletenextframe );
    scripts\engine\utility::registersharedfunc( "vehicle", "deleteNextFrameLate", &vehicle_mp_deletenextframelate );
    scripts\engine\utility::registersharedfunc( "vehicle", "createHint", &scripts\mp\gameobjects::createhintobject );
    scripts\engine\utility::registersharedfunc( "vehicle_interact", "init", &scripts\mp\vehicles\vehicle_interact_mp::vehicle_interact_mp_init );
    scripts\engine\utility::registersharedfunc( "vehicle_occupancy", "init", &scripts\mp\vehicles\vehicle_occupancy_mp::vehicle_occupancy_mp_init );
    scripts\engine\utility::registersharedfunc( "vehicle_mines", "init", &scripts\mp\vehicles\vehicle_mines_mp::vehicle_mines_mp_init );
    scripts\engine\utility::registersharedfunc( "vehicle_spawn", "init", &scripts\mp\vehicles\vehicle_spawn_mp::vehicle_spawn_mp_init );
    scripts\engine\utility::registersharedfunc( "vehicle_compass", "init", &scripts\mp\vehicles\vehicle_compass_mp::vehicle_compass_mp_init );
    scripts\engine\utility::registersharedfunc( "vehicle_damage", "init", &scripts\mp\vehicles\vehicle_damage_mp::vehicle_damage_mp_init );
    scripts\engine\utility::registersharedfunc( "vehicle_upgrade", "init", &scripts\mp\gametypes\br_armory_kiosk::_runpurchasemenu );
    scripts\engine\utility::registersharedfunc( "vehicle_trophy", "init", &scripts\mp\equipment\trophy_system::trophy_watchprotection );
    scripts\engine\utility::registersharedfunc( "vehicle_trophyDestroyTarget", "init", &scripts\mp\equipment\trophy_system::function_477783276ea16601 );
    scripts\engine\utility::registersharedfunc( "vehicle_trophyCreateExplosion", "init", &scripts\mp\equipment\trophy_system::trophy_createexplosion );
    scripts\engine\utility::registersharedfunc( "vehicle_trophyExplode", "init", &scripts\mp\equipment\trophy_system::trophy_explode );
    scripts\engine\utility::registersharedfunc( "light_tank", "init", &scripts\mp\vehicles\light_tank_mp::light_tank_mp_init );
    scripts\mp\vehicles\damage::init();
    scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_init();
    
    /#
        function_e36283a0d7dc082c();
    #/
}

// Namespace vehicle_mp / scripts\mp\vehicles\vehicle_mp
// Params 2
// Checksum 0x0, Offset: 0x466
// Size: 0x5e
function vehicle_mp_create( vehicle, spawndata )
{
    vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth( vehicle );
    vehicle.health = vehicle.maxhealth;
    scripts\mp\outofbounds::registerentforoob( vehicle, "vehicle" );
    vehicle enableplayermarks( "killstreak" );
    scripts\mp\vehicles\vehicle_occupancy_mp::vehicle_occupancy_mp_updatemarkfilter( vehicle );
}

// Namespace vehicle_mp / scripts\mp\vehicles\vehicle_mp
// Params 2
// Checksum 0x0, Offset: 0x4cc
// Size: 0x13
function vehicle_mp_createlate( vehicle, spawndata )
{
    
}

// Namespace vehicle_mp / scripts\mp\vehicles\vehicle_mp
// Params 1
// Checksum 0x0, Offset: 0x4e7
// Size: 0x15
function vehicle_mp_deletenextframe( vehicle )
{
    scripts\mp\outofbounds::clearoob( vehicle, 1 );
}

// Namespace vehicle_mp / scripts\mp\vehicles\vehicle_mp
// Params 1
// Checksum 0x0, Offset: 0x504
// Size: 0xb
function vehicle_mp_deletenextframelate( vehicle )
{
    
}

// Namespace vehicle_mp / scripts\mp\vehicles\vehicle_mp
// Params 1
// Checksum 0x0, Offset: 0x517
// Size: 0x77
function function_dd9423aa2b333df5( vehicle )
{
    if ( !isdefined( vehicle ) || !isdefined( vehicle.vehiclename ) )
    {
        return 0;
    }
    
    switch ( vehicle.vehiclename )
    {
        case #"hash_228830c793bd36cb":
        case #"hash_cbbafedb48ea9aea":
        case #"hash_d589a6a019e9defe":
        case #"hash_f690b9139a2baa7e":
            return 1;
        default:
            return 0;
    }
}

/#

    // Namespace vehicle_mp / scripts\mp\vehicles\vehicle_mp
    // Params 0
    // Checksum 0x0, Offset: 0x596
    // Size: 0xd, Type: dev
    function function_e36283a0d7dc082c()
    {
        thread function_8154c406e557eba0();
    }

    // Namespace vehicle_mp / scripts\mp\vehicles\vehicle_mp
    // Params 0
    // Checksum 0x0, Offset: 0x5ab
    // Size: 0x32, Type: dev
    function function_8154c406e557eba0()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_f29bd33b293b2675", 0 ) != 0 )
            {
                function_a6a8c67dda2a3121();
            }
            
            wait level.framedurationseconds;
        }
    }

    // Namespace vehicle_mp / scripts\mp\vehicles\vehicle_mp
    // Params 0
    // Checksum 0x0, Offset: 0x5e5
    // Size: 0x104, Type: dev
    function function_a6a8c67dda2a3121()
    {
        vehicles = getentarray( "<dev string:x1c>", "<dev string:x2e>" );
        
        foreach ( vehicle in vehicles )
        {
            point = vehicle.origin;
            point += anglestoforward( vehicle.angles ) * getdvarint( @"hash_a765ffa626d484ef", 0 );
            point += anglestoright( vehicle.angles ) * getdvarint( @"hash_46a8210687b62330", 0 );
            point += anglestoup( vehicle.angles ) * getdvarint( @"hash_29007f0daffa3caf", 0 );
            thread scripts\cp_mp\utility\debug_utility::drawsphere( point, 2, level.framedurationseconds, ( 1, 1, 1 ) );
        }
    }

#/
