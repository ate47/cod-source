#using scripts\common\utility;
#using scripts\common\vehicle_build;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace veh9_mil_lnd_tank_cougar;

// Namespace veh9_mil_lnd_tank_cougar / namespace_5498b662a2e15bd0
// Params 3
// Checksum 0x0, Offset: 0x180
// Size: 0x10a
function main( model, type, classname )
{
    precachemodel( "veh9_mil_lnd_tank_cougar_turret" );
    precachemodel( "veh9_mil_lnd_tank_cougar_turret_gun" );
    build_template( "coscar", model, type, classname );
    build_localinit( &init_local );
    build_team( "allies" );
    build_radiusdamage( ( 0, 0, 0 ), 500, 120, 20 );
    build_deathquake( 1, 1.6, 500 );
    build_mainturret( "iw9_tur_cougar_sp", "tag_turret", "veh9_mil_lnd_tank_cougar_turret", "manual", 0, 0 );
    build_turret( "iw9_mg_cougar_sp", "tag_turret", "veh9_mil_lnd_tank_cougar_turret_gun", "manual", 0, 0, ( 0, 0, 0 ), undefined, 1 );
    build_bulletshield( 1 );
    build_grenadeshield( 1 );
    function_ceeb72985b41bfb1( 1 );
    function_d82e00bef8433948( [ "c4_sp", "improvised_mine" ] );
    function_5a73d7723fce9849();
}

// Namespace veh9_mil_lnd_tank_cougar / namespace_5498b662a2e15bd0
// Params 0
// Checksum 0x0, Offset: 0x292
// Size: 0x2
function init_local()
{
    
}

// Namespace veh9_mil_lnd_tank_cougar / namespace_5498b662a2e15bd0
// Params 0
// Checksum 0x0, Offset: 0x29c
// Size: 0x1c4
function setup_turrets()
{
    turret = spawnturret( "misc_turret", self gettagorigin( "tag_turret" ), "iw9_tur_cougar_sp", 0 );
    turret linkto( self, "tag_turret", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    turret setmodel( "veh9_mil_lnd_tank_cougar_turret" );
    turret setmode( "sentry_offline" );
    turret setsentryowner( undefined );
    turret makeunusable();
    turret setdefaultdroppitch( 0 );
    turret setturretmodechangewait( 1 );
    turret.angles = self.angles;
    turret.vehicle = self;
    turret.maxhealth = 999999;
    turret.health = turret.maxhealth;
    turret setcandamage( 0 );
    self.turret = turret;
    gunner = spawnturret( "misc_turret", self gettagorigin( "tag_turret" ), "iw9_mg_cougar_sp", 0 );
    gunner linkto( self, "tag_turret", ( 0, 0, 16 ), ( 0, 0, 0 ) );
    gunner setmodel( "veh9_mil_lnd_tank_cougar_turret_gun" );
    gunner setmode( "sentry_offline" );
    gunner setsentryowner( undefined );
    gunner makeunusable();
    gunner setdefaultdroppitch( 0 );
    gunner setturretmodechangewait( 1 );
    gunner.angles = self.angles;
    gunner.vehicle = self;
    gunner.maxhealth = 999999;
    gunner.health = gunner.maxhealth;
    gunner setcandamage( 0 );
    self.gunner = gunner;
}

// Namespace veh9_mil_lnd_tank_cougar / namespace_5498b662a2e15bd0
// Params 0
// Checksum 0x0, Offset: 0x468
// Size: 0xce
function unload_groups()
{
    unload_groups = [];
    group = "passengers";
    unload_groups[ group ] = [];
    unload_groups[ group ][ unload_groups[ group ].size ] = 1;
    unload_groups[ group ][ unload_groups[ group ].size ] = 2;
    unload_groups[ group ][ unload_groups[ group ].size ] = 3;
    group = "all_but_gunner";
    unload_groups[ group ] = [];
    unload_groups[ group ][ unload_groups[ group ].size ] = 0;
    unload_groups[ group ][ unload_groups[ group ].size ] = 1;
    unload_groups[ group ][ unload_groups[ group ].size ] = 2;
    group = "rear_driver_side";
    unload_groups[ group ] = [];
    unload_groups[ group ][ unload_groups[ group ].size ] = 2;
    group = "all";
    unload_groups[ group ] = [];
    unload_groups[ group ][ unload_groups[ group ].size ] = 0;
    unload_groups[ group ][ unload_groups[ group ].size ] = 1;
    unload_groups[ group ][ unload_groups[ group ].size ] = 2;
    unload_groups[ group ][ unload_groups[ group ].size ] = 3;
    unload_groups[ "default" ] = unload_groups[ "all" ];
    return unload_groups;
}

