#using script_24fbedba9a7a1ef4;
#using scripts\common\utility;
#using scripts\cp\cp_outline_utility;
#using scripts\cp\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\equipment\scripted_trophy;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;

#namespace namespace_83d0a99a6cf98286;

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 0
// Checksum 0x0, Offset: 0x29b
// Size: 0x151
function pyro_register()
{
    bossdetails = spawnstruct();
    bossdetails.armor = getdvarfloat( @"hash_60a6f859cc67b71b", 5000 );
    bossdetails.maxdamage = getdvarint( @"hash_c35de7777481df06", 100 );
    bossdetails.spawnstructs = [];
    bossdetails.name = "pyro";
    bossdetails.var_649245b52dbf88a9 = getdvarint( @"hash_f454d60a0ac05167", 2 );
    bossdetails.initfunc = &pyro_init;
    bossdetails.var_e68429b39c75b6ee = &function_4108074415abc816;
    level.br_lootiteminfo[ "brloot_weapon_sh_vecho_lege" ] = spawnstruct();
    level.br_lootiteminfo[ "brloot_weapon_sh_vecho_lege" ].baseweapon = "iw9_sh_vecho";
    level.br_lootiteminfo[ "brloot_weapon_sh_vecho_lege" ].fullweaponname = "iw9_sh_vecho_mp+ammo_12g_db_vecho+bar_sh_hvyshort_p04+bolt_p04+drum_sh_p04+ironsdefault_vecho+lasercyl_hip03+pgrip_p04_vecho+rec_vecho+stock_sh_tactical_p04_vecho";
    level.br_lootiteminfo[ "brloot_weapon_sh_vecho_lege" ].fullweaponobj = makeweaponfromstring( level.br_lootiteminfo[ "brloot_weapon_sh_vecho_lege" ].fullweaponname );
    registerboss( bossdetails );
    
    /#
        level thread function_e1252da83d53b11d();
    #/
    
    level.pyro_registered = 1;
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 1
// Checksum 0x0, Offset: 0x3f4
// Size: 0x5a
function registerboss( detailsstruct )
{
    if ( !isdefined( level.bosses ) )
    {
        level.bosses = [];
    }
    
    level.bosses[ detailsstruct.name ] = detailsstruct;
    level.bosses[ detailsstruct.name ].instances = [];
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 1
// Checksum 0x0, Offset: 0x456
// Size: 0x71
function function_2e6e2b664dfe3186( name )
{
    instance = spawnstruct();
    instance.var_7d8ad21e5dfd7c94 = [];
    instance.var_673ececee90d036e = [];
    instance.name = name;
    level.bosses[ name ].instances[ level.bosses[ name ].instances.size ] = instance;
    return instance;
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 1
// Checksum 0x0, Offset: 0x4d0
// Size: 0xe2
function pyro_init( bossdetails )
{
    level.var_c8c9fe6038e69b34 = getdvarint( @"hash_6968ab4b0d874c4d", 30 ) * 1000;
    level.var_ad758bda532f9152 = int( level.var_c8c9fe6038e69b34 * 0.4 );
    bossdetails.spawnstructs = [];
    
    if ( !isdefined( level.struct_class_names[ "script_noteworthy" ][ "boss_pyro" ] ) )
    {
        return;
    }
    
    foreach ( node in level.struct_class_names[ "script_noteworthy" ][ "boss_pyro" ] )
    {
        bossdetails.spawnstructs[ bossdetails.spawnstructs.size ] = node;
    }
    
    scripts\cp_mp\equipment\scripted_trophy::trophy_init();
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 0
// Checksum 0x0, Offset: 0x5ba
// Size: 0x10
function function_b9af1a95f5d7a50b()
{
    pyro_register();
    scripts\cp_mp\equipment\scripted_trophy::trophy_init();
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 0
// Checksum 0x0, Offset: 0x5d2
// Size: 0x10f
function function_4108074415abc816()
{
    if ( !istrue( level.pyro_registered ) )
    {
        function_b9af1a95f5d7a50b();
    }
    
    aitype = "enemy_cp_boss_pyro";
    boss = self;
    
    if ( !isdefined( boss ) )
    {
        return;
    }
    
    boss.var_b582b10663b5b2a9 = 0;
    function_fb62bcef7fab15fb( boss );
    weaponname = getcompleteweaponname( boss.weapon );
    
    if ( !isdefined( boss.weaponinfo[ weaponname ] ) )
    {
        boss scripts\common\utility::initweapon( boss.weapon );
    }
    
    boss.a.weaponpos[ "right" ] = boss.weapon;
    boss.callbackdamaged = &pyro_damaged;
    loc = spawnstruct();
    loc.origin = boss.origin;
    loc.angles = ( 0, 0, 0 );
    boss thread function_5ee2f96997d9f8f5( loc );
    return boss;
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 1
// Checksum 0x0, Offset: 0x6ea
// Size: 0x3f
function function_125dad10f1261289( loc )
{
    boss = self;
    self endon( "death" );
    boss waittill( boss.spawner.script_noteworthy );
    boss function_5ee2f96997d9f8f5( loc );
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 1
// Checksum 0x0, Offset: 0x731
// Size: 0x37
function function_1cce3618f05eb5c8( loc )
{
    boss = self;
    scripts\cp_mp\equipment\scripted_trophy::trophy_create( loc, 1, 10, 200, "axis" );
    boss.var_d16a13b262da0bf6 = loc;
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 1
// Checksum 0x0, Offset: 0x770
// Size: 0x76
function function_5ee2f96997d9f8f5( loc )
{
    boss = self;
    
    if ( isdefined( boss.spawner ) )
    {
        if ( isdefined( boss.spawner.script_noteworthy ) && issubstr( boss.spawner.script_noteworthy, "delay_trophy" ) )
        {
            boss thread function_125dad10f1261289( loc );
            return;
        }
    }
    
    boss function_1cce3618f05eb5c8( loc );
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 1
// Checksum 0x0, Offset: 0x7ee
// Size: 0x177
function function_fb62bcef7fab15fb( agent )
{
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    grenade_type = "molotov_mp";
    grenadeammo = getdvarint( @"hash_537fa443ce212a8a", 12 );
    weapon = level.br_lootiteminfo[ "brloot_weapon_sh_vecho_lege" ].fullweaponobj;
    armor = 666;
    helmet = 10;
    agent.var_668b72f41e87c75a = 1;
    agent.var_d38fb77455b25729 = 4000;
    agent.var_ba2f6374446e1525 = 0;
    agent.var_e6af4ba7cf5cc852 = 0;
    agent.var_62482b4f67666074 = 10000;
    agent.var_a7aae99da4c9e990 = 60000;
    agent.var_2808079b46ae6650 = 3000;
    agent.var_7528bdd4f8ea8811 = 0;
    agent.var_a83b580f45a7120 = 20000;
    weaponcase = undefined;
    agent.baseaccuracy = getdvarfloat( @"hash_298d4ea8b0934e31", 1.2 );
    agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff( "body_sp_opforce_al_qatala_boss_pyro", "head_sp_opforce_al_qatala_boss_pyro", weapon, grenade_type, grenadeammo, armor, helmet, 1 );
    agent function_720c3b7abf4baac8( "pyro", 0, weaponcase );
    agent thread scripts\cp_mp\agents\agent_utils::function_36613ffb5ebe56( agent );
    agent setgeartype( "scubagr" );
    agent setclothtype( "vestheavy" );
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 3
// Checksum 0x0, Offset: 0x96d
// Size: 0x5c
function function_720c3b7abf4baac8( name, var_b700d8d067b3eedb, var_787d4be10ba144d6 )
{
    self.var_b582b10663b5b2a9 = 0;
    self.var_685390c6753c2cc7 = istrue( var_b700d8d067b3eedb );
    self.battlechatterallowed = 0;
    self.bossname = name;
    self.var_f2a62f02827daaa5 = 1;
    thread function_2676819f01ae14ed( name, var_787d4be10ba144d6 );
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 3
// Checksum 0x0, Offset: 0x9d1
// Size: 0x141
function function_2676819f01ae14ed( name, var_787d4be10ba144d6, var_c026f33ac9e83deb )
{
    self endon( "boss_despawn" );
    instance = self.bossinstance;
    self waittill( "death", killer );
    
    if ( isdefined( killer ) && isdefined( killer.vehicletype ) )
    {
        if ( isdefined( killer.owner ) )
        {
            killer = killer.owner;
        }
    }
    
    if ( isdefined( instance ) )
    {
        instance notify( "boss_death" );
        instance.killed = 1;
        instance.killer = killer;
    }
    
    if ( isdefined( killer ) && isdefined( killer.team ) )
    {
        players = scripts\cp\cp_outline_utility::getteamdata( killer.team, "players" );
        
        foreach ( player in players )
        {
            if ( !isdefined( player.var_8c8050d7d861d06c ) )
            {
                player.var_8c8050d7d861d06c = 0;
            }
            
            player.var_8c8050d7d861d06c++;
        }
    }
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 0
// Checksum 0x0, Offset: 0xb1a
// Size: 0x2
function function_f040efe2f90b41fb()
{
    
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 13
// Checksum 0x0, Offset: 0xb24
// Size: 0x1b1
function pyro_damaged( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon )
{
    if ( !istrue( self.var_e6af4ba7cf5cc852 ) && isdefined( shitloc ) && shitloc == "shield" )
    {
        time = gettime();
        
        if ( !isdefined( self.var_e494707422b1cfe6 ) )
        {
            self.var_e494707422b1cfe6 = time;
        }
        
        if ( isdefined( self.var_f35de24a74b2dd14 ) && time - self.var_f35de24a74b2dd14 > self.var_a7aae99da4c9e990 )
        {
            self.var_e494707422b1cfe6 = time;
            self.var_ba2f6374446e1525 = 0;
        }
        
        self.var_f35de24a74b2dd14 = time;
        self.var_ba2f6374446e1525 += idamage;
        
        if ( self.var_ba2f6374446e1525 > self.var_d38fb77455b25729 && time - self.var_e494707422b1cfe6 > self.var_62482b4f67666074 )
        {
            self.bhasthermitestucktoshield = 1;
            self.thermitestuckpains = 4;
            thread function_e44c53e48f00cce( eattacker );
        }
    }
    else if ( self.var_7528bdd4f8ea8811 - gettime() > self.var_a83b580f45a7120 )
    {
        thread function_e44c53e48f00cce( eattacker );
    }
    
    self.lastattackedtime = gettime();
    namespace_daa149ca485fd50a::function_dffac413ed66bcd0( einflictor, eattacker, int( idamage ), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon );
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 1
// Checksum 0x0, Offset: 0xcdd
// Size: 0xe4
function function_e44c53e48f00cce( attacker )
{
    self.var_7528bdd4f8ea8811 = gettime();
    wait 1;
    scripts\cp_mp\agents\agent_utils::function_ae99616202575e39( attacker.origin, "molotov_mp", 128 );
    self waittill( "ai_forceThrowGrenade_finish" );
    
    for ( i = 0; i < 2 ; i++ )
    {
        var_5b4505d2dcc12bd8 = function_6174330574a2a273() * 0.5;
        var_217cffeb082de02a = anglestoforward( self.angles ) + ( var_5b4505d2dcc12bd8[ 0 ], var_5b4505d2dcc12bd8[ 1 ], 0 );
        throwstart = self.origin + var_217cffeb082de02a * 50;
        nade = self launchgrenade( "molotov_mp", throwstart, var_217cffeb082de02a + ( 0, 0, 1 ) );
        nade.team = self.team;
    }
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 0
// Checksum 0x0, Offset: 0xdc9
// Size: 0x92
function function_96323c515c3294bf()
{
    self endon( "death" );
    
    while ( true )
    {
        if ( isdefined( self.lastattackedtime ) )
        {
            if ( gettime() - self.lastattackedtime > self.var_2808079b46ae6650 && gettime() - self.var_7528bdd4f8ea8811 > self.var_a83b580f45a7120 )
            {
                self.var_7528bdd4f8ea8811 = gettime();
                players = scripts\cp\utility::getplayersinradius( self.origin, 1000 );
                self.lastattackedtime = undefined;
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 1
// Checksum 0x0, Offset: 0xe63
// Size: 0x41
function pyro_track( icon )
{
    self endon( "death" );
    
    while ( true )
    {
        waitframe();
        icon function_6e148c8da2e4db13( self.origin );
        icon.origin = self.origin;
    }
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 0
// Checksum 0x0, Offset: 0xeac
// Size: 0x71
function function_e63eef21b7acd619()
{
    pyroboss = self;
    
    if ( !isdefined( pyroboss.fortress ) )
    {
        return;
    }
    
    pyroboss endon( "death" );
    level endon( "game_ended" );
    level.var_6acf5c6209798cbf.var_9559116321e7fd23 = 0;
    pyroboss.fortress waittill( "barrelExploded" );
    level.var_6acf5c6209798cbf.barrelexploded = 1;
    level notify( "pyro_interruptLine" );
}

// Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
// Params 1
// Checksum 0x0, Offset: 0xf25
// Size: 0x29
function function_e7d3411db935e99b( pos )
{
    self endon( "death" );
    wait 2;
    self.vehicle_position = pos;
    self.script_startingposition = pos;
}

/#

    // Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
    // Params 0
    // Checksum 0x0, Offset: 0xf56
    // Size: 0x99, Type: dev
    function function_e1252da83d53b11d()
    {
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_f80ba80fbbcabe69", 0 ) == 1 )
            {
                pos = spawnstruct();
                pos.origin = level.players[ 0 ].origin;
                pos.angles = level.players[ 0 ].angles;
                pos.team = "<dev string:x1c>";
                wait 5;
                setdvar( @"hash_f80ba80fbbcabe69", 0 );
            }
        }
    }

    // Namespace namespace_83d0a99a6cf98286 / namespace_93c3eb17bb66abd3
    // Params 0
    // Checksum 0x0, Offset: 0xff7
    // Size: 0x4e, Type: dev
    function function_18d36b05200764aa()
    {
        boss = self;
        boss endon( "<dev string:x21>" );
        
        while ( true )
        {
            boss thread scripts\cp\utility::drawsphere( boss.origin, 64, 0.05, ( 1, 0, 0 ) );
            wait 0.05;
        }
    }

#/
