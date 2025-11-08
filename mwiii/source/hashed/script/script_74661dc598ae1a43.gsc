#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_champion_task;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\utility\player;

#namespace namespace_ae731a50428dac3c;

// Namespace namespace_ae731a50428dac3c / namespace_ac1fbb84a83113b9
// Params 0
// Checksum 0x0, Offset: 0x220
// Size: 0x2e
function inittask()
{
    function_ac97a4f2ab8c2d53( "combat", "tryAssignTask", &function_f5539669faf51bc2 );
    function_ac97a4f2ab8c2d53( "combat", "tryBindObjective", &trybindobjective );
}

// Namespace namespace_ae731a50428dac3c / namespace_ac1fbb84a83113b9
// Params 1
// Checksum 0x0, Offset: 0x256
// Size: 0x3c
function function_f5539669faf51bc2( taskinstance )
{
    flag = function_87e60ed6830d13bc( taskinstance.info.subcategory );
    thread checkcombat( taskinstance, flag );
}

// Namespace namespace_ae731a50428dac3c / namespace_ac1fbb84a83113b9
// Params 1
// Checksum 0x0, Offset: 0x29a
// Size: 0x4a
function function_87e60ed6830d13bc( subcategory )
{
    switch ( subcategory )
    {
        case #"hash_611825599f1b56f9":
            return "kill_player_";
        case #"hash_f91b350a054b6175":
            return "down_enemy_laststand_";
        default:
            return "post_damaged";
    }
}

// Namespace namespace_ae731a50428dac3c / namespace_ac1fbb84a83113b9
// Params 2
// Checksum 0x0, Offset: 0x2ec
// Size: 0x8f
function function_9b1529847df228e( weapon, taskinstance )
{
    rootname = scripts\cp_mp\weapon::getweaponrootname( weapon );
    group = scripts\cp_mp\weapon::weapongroupmap( rootname );
    taskgroup = "weapon_" + taskinstance.info.subcategory;
    
    if ( taskinstance.info.subcategory == "any" || isdefined( group ) && group == taskgroup )
    {
        return 1;
    }
    
    return 0;
}

// Namespace namespace_ae731a50428dac3c / namespace_ac1fbb84a83113b9
// Params 3
// Checksum 0x0, Offset: 0x383
// Size: 0x7b, Type: bool
function function_2bd81bb8ee30bed8( myteam, attacker, victim )
{
    var_b58f81d02de4280c = isdefined( attacker ) && isplayer( attacker ) && attacker.team == myteam;
    var_7fbdc91ef38fa447 = isdefined( victim ) && isplayer( victim ) && victim.team != myteam || isagent( victim );
    return var_b58f81d02de4280c && var_7fbdc91ef38fa447;
}

// Namespace namespace_ae731a50428dac3c / namespace_ac1fbb84a83113b9
// Params 1
// Checksum 0x0, Offset: 0x407
// Size: 0xe9
function function_6d92f87ff87fe83f( taskinstance )
{
    level endon( "game_ended" );
    taskinstance endon( "task_end" );
    
    while ( true )
    {
        level waittill( "post_player_damaged", inflictor, attacker, victim, damage, flags, meansofdeath, objweapon, var_fcdf19e3cdd29669, point, dir, hitloc, offsettime, modelindex, part );
        
        if ( function_2bd81bb8ee30bed8( taskinstance.team, attacker, victim ) && function_9b1529847df228e( objweapon, taskinstance ) )
        {
            function_89b8bce3baa45edc( taskinstance, damage );
        }
    }
}

// Namespace namespace_ae731a50428dac3c / namespace_ac1fbb84a83113b9
// Params 1
// Checksum 0x0, Offset: 0x4f8
// Size: 0xaa
function function_c93e0a98f146b313( taskinstance )
{
    level endon( "game_ended" );
    taskinstance endon( "task_end" );
    
    while ( true )
    {
        level waittill( "post_veh_damaged", inflictor, attacker, victim, damage, objweapon );
        validcheck = isdefined( attacker ) && isplayer( attacker ) && attacker.team == taskinstance.team;
        
        if ( validcheck && function_9b1529847df228e( objweapon, taskinstance ) )
        {
            function_89b8bce3baa45edc( taskinstance, damage );
        }
    }
}

// Namespace namespace_ae731a50428dac3c / namespace_ac1fbb84a83113b9
// Params 2
// Checksum 0x0, Offset: 0x5aa
// Size: 0x13f
function checkcombat( taskinstance, flag )
{
    level endon( "game_ended" );
    taskinstance endon( "task_end" );
    taskref = taskinstance.info.ref;
    
    if ( flag == "post_damaged" )
    {
        thread function_6d92f87ff87fe83f( taskinstance );
        thread function_c93e0a98f146b313( taskinstance );
        return;
    }
    
    while ( true )
    {
        level waittill( flag + taskinstance.team, attacker, victim );
        
        if ( function_2bd81bb8ee30bed8( taskinstance.team, attacker, victim ) )
        {
            switch ( taskref )
            {
                case #"hash_eb6c78c44b750cb8":
                    if ( attacker getstance() == "crouch" )
                    {
                        break;
                    }
                    
                    continue;
                case #"hash_e5d90217334521c0":
                    if ( attacker getstance() == "prone" )
                    {
                        break;
                    }
                    
                    continue;
                case #"hash_1c95d0819be07a7b":
                    if ( !attacker scripts\mp\utility\player::isplayerads() )
                    {
                        break;
                    }
                    
                    continue;
                case #"hash_2f38c9e10e76312c":
                    if ( attacker scripts\mp\utility\player::isplayerads() )
                    {
                        break;
                    }
                    
                    continue;
                default:
                    break;
            }
            
            function_89b8bce3baa45edc( taskinstance, 1 );
        }
    }
}

// Namespace namespace_ae731a50428dac3c / namespace_ac1fbb84a83113b9
// Params 2
// Checksum 0x0, Offset: 0x6f1
// Size: 0x65, Type: bool
function function_c17dee650b7cbcb2( taskinstance, baseweapon )
{
    rootname = scripts\cp_mp\weapon::getweaponrootname( baseweapon );
    group = scripts\cp_mp\weapon::weapongroupmap( rootname );
    taskgroup = "weapon_" + taskinstance.info.subcategory;
    return isdefined( group ) && group == taskgroup;
}

// Namespace namespace_ae731a50428dac3c / namespace_ac1fbb84a83113b9
// Params 1
// Checksum 0x0, Offset: 0x75f
// Size: 0x76, Type: bool
function function_f4ee103b33981325( taskinstance )
{
    foreach ( weapon in self.equippedweapons )
    {
        baseweapon = weapon getbaseweapon();
        
        if ( function_c17dee650b7cbcb2( taskinstance, baseweapon ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_ae731a50428dac3c / namespace_ac1fbb84a83113b9
// Params 2
// Checksum 0x0, Offset: 0x7de
// Size: 0x11c, Type: bool
function function_59c1dbdc2ad03ad6( taskinstance, loot )
{
    if ( !isdefined( loot ) )
    {
        return false;
    }
    
    partname = loot function_ec5f4851431f3382();
    state = loot getscriptablepartstate( partname, 1 );
    
    if ( !isdefined( state ) || state == "hidden" )
    {
        return false;
    }
    
    scriptablename = scripts\mp\gametypes\br_pickups::lootgetscriptablename( loot );
    
    if ( !isdefined( scriptablename ) || !scripts\mp\gametypes\br_pickups::isweaponpickup( scriptablename ) )
    {
        return false;
    }
    
    if ( istrue( level.var_a9350d89a2e4d752 ) )
    {
        baseweapon = "";
        
        if ( isdefined( level.br_lootiteminfo[ loot.type ] ) && isdefined( level.br_lootiteminfo[ loot.type ].baseweapon ) )
        {
            baseweapon = level.br_lootiteminfo[ loot.type ].baseweapon;
        }
    }
    else
    {
        baseweapon = tablelookup( level.brloottablename, 1, scriptablename, 8 );
    }
    
    if ( baseweapon == "" )
    {
        return false;
    }
    
    return function_c17dee650b7cbcb2( taskinstance, baseweapon );
}

// Namespace namespace_ae731a50428dac3c / namespace_ac1fbb84a83113b9
// Params 1
// Checksum 0x0, Offset: 0x903
// Size: 0xa9
function trybindobjective( taskinstance )
{
    subcategory = taskinstance.info.subcategory;
    
    if ( subcategory == "kill" || subcategory == "down" || subcategory == "any" )
    {
        trackenemy( taskinstance );
        return;
    }
    
    if ( function_f4ee103b33981325( taskinstance ) || function_59c1dbdc2ad03ad6( taskinstance, self.pickupitem ) )
    {
        trackenemy( taskinstance );
        return;
    }
    
    items = getlootscriptablearrayinradius( undefined, undefined, self.origin, 20000 );
    function_2e55101ffd0d483c( taskinstance, items, &function_59c1dbdc2ad03ad6 );
}

// Namespace namespace_ae731a50428dac3c / namespace_ac1fbb84a83113b9
// Params 0
// Checksum 0x0, Offset: 0x9b4
// Size: 0x95
function function_b6974f3087e0fd6d()
{
    bots = [];
    
    foreach ( player in level.players )
    {
        if ( isbot( player ) && self.team != player.team )
        {
            bots = array_add( bots, player );
        }
    }
    
    return getclosest( self.origin, bots );
}

// Namespace namespace_ae731a50428dac3c / namespace_ac1fbb84a83113b9
// Params 1
// Checksum 0x0, Offset: 0xa52
// Size: 0x90
function trackenemy( taskinstance )
{
    enemy = function_b6974f3087e0fd6d();
    
    if ( isdefined( enemy ) )
    {
        circleinfo = spawnstruct();
        circleinfo scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522( "Assassination_Br", enemy.origin, 3500 );
        circleinfo scripts\cp_mp\utility\game_utility::function_cfd53c8f6878014f( self );
        objectiveinfo = spawnstruct();
        objectiveinfo.item = circleinfo;
        objectiveinfo.taskinstance = taskinstance;
        self.objectiveinfo = objectiveinfo;
        thread function_278ca71c59288fc7();
    }
}

// Namespace namespace_ae731a50428dac3c / namespace_ac1fbb84a83113b9
// Params 0
// Checksum 0x0, Offset: 0xaea
// Size: 0x6a
function function_278ca71c59288fc7()
{
    self endon( "disconnect" );
    self.objectiveinfo endon( "objective_removed" );
    
    while ( isdefined( self.objectiveinfo ) )
    {
        enemy = function_b6974f3087e0fd6d();
        
        if ( isdefined( enemy ) )
        {
            self.objectiveinfo.item scripts\cp_mp\utility\game_utility::function_6e148c8da2e4db13( enemy.origin );
        }
        
        wait 5;
    }
}

