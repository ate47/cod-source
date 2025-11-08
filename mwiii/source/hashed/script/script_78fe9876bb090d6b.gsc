#using script_4948cdf739393d2d;
#using script_64acb6ce534155b7;
#using script_b7a9ce0a2282b79;
#using scripts\common\utility;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\utility;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\dmz_audio;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\hud_message;
#using scripts\mp\locksandkeys;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace namespace_49d5ece81956adc8;

// Namespace namespace_49d5ece81956adc8 / namespace_a713760a939752c1
// Params 1
// Checksum 0x0, Offset: 0x46a
// Size: 0x4aa
function function_80d68c9701e1aea5( data )
{
    level.var_cf05afb32024800a = spawnstruct();
    level.var_cf05afb32024800a.circleradius = getdvarint( @"hash_83519ef779747386", 800 );
    level.var_cf05afb32024800a.numcaches = getdvarint( @"hash_6d9ec532c0b1e0ed", 3 );
    level.var_cf05afb32024800a.mindist = getdvarint( @"hash_3b18aa46658249fe", 1000 );
    level.var_cf05afb32024800a.mindistsq = level.var_cf05afb32024800a.mindist * level.var_cf05afb32024800a.mindist;
    level.var_cf05afb32024800a.maxdist = getdvarint( @"hash_b95a7ef81c8fde90", 6000 );
    level.var_cf05afb32024800a.maxdistsq = level.var_cf05afb32024800a.maxdist * level.var_cf05afb32024800a.maxdist;
    level.var_d0a1b79d28edcbb7 = [];
    allnodes = getentitylessscriptablearray( "scriptable_dmz_crate_wood", "classname" );
    potentialnodes = [];
    
    foreach ( node in allnodes )
    {
        if ( !function_ff08d2b3254ea0d( node ) )
        {
            potentialnodes[ potentialnodes.size ] = node;
        }
    }
    
    potentialnodes = array_randomize( potentialnodes );
    
    foreach ( node in potentialnodes )
    {
        if ( istrue( node.taken ) )
        {
            continue;
        }
        
        node.taken = 1;
        node.nodes = [];
        
        for ( i = 0; i < level.var_cf05afb32024800a.numcaches - 1 ; i++ )
        {
            foreach ( othernode in potentialnodes )
            {
                if ( istrue( othernode.taken ) )
                {
                    continue;
                }
                
                var_60dafd3981c61e97 = array_add( node.nodes, node );
                withindistance = 1;
                
                foreach ( selectednode in var_60dafd3981c61e97 )
                {
                    distsq = distance2dsquared( selectednode.origin, othernode.origin );
                    
                    if ( distsq < level.var_cf05afb32024800a.mindistsq || distsq > level.var_cf05afb32024800a.maxdistsq )
                    {
                        withindistance = 0;
                        break;
                    }
                }
                
                if ( withindistance )
                {
                    node.nodes[ node.nodes.size ] = othernode;
                    othernode.taken = 1;
                    break;
                }
            }
        }
        
        if ( node.nodes.size == level.var_cf05afb32024800a.numcaches - 1 )
        {
            level.var_d0a1b79d28edcbb7[ level.var_d0a1b79d28edcbb7.size ] = node;
            node.var_c93ea8f612f4aaba = 1;
            
            foreach ( othernode in node.nodes )
            {
                othernode.var_c93ea8f612f4aaba = 1;
            }
            
            continue;
        }
        
        node.taken = 0;
        
        foreach ( othernode in node.nodes )
        {
            othernode.taken = 0;
        }
    }
    
    function_b713f2d39b34540f( data, &function_1b08eecb1ef258c3, level.var_d0a1b79d28edcbb7 );
}

// Namespace namespace_49d5ece81956adc8 / namespace_a713760a939752c1
// Params 1
// Checksum 0x0, Offset: 0x91c
// Size: 0x41, Type: bool
function function_ff08d2b3254ea0d( node )
{
    return namespace_9823ee6035594d67::function_f59f68adc71d49b3( node.origin ) || scripts\mp\locksandkeys::function_64332f29e2409e55( node.origin ) || istrue( node.islockedcache );
}

// Namespace namespace_49d5ece81956adc8 / namespace_a713760a939752c1
// Params 2
// Checksum 0x0, Offset: 0x966
// Size: 0xec
function function_1b08eecb1ef258c3( activity, node )
{
    task = task_create( activity );
    task.funcs[ "onInit" ] = &function_96771c28a0ff4628;
    task.funcs[ "onTeamAssigned" ] = &function_aa932ab67844f7ab;
    task.funcs[ "onPlayerJoined" ] = &function_776101fe1e75a23a;
    task.funcs[ "onPlayerRemoved" ] = &function_f2e92a7c1fd7db79;
    task.funcs[ "onTeamStart" ] = &function_4f6565bdadaf8fc1;
    task.funcs[ "onCancel" ] = &function_ba813599d8aa3e30;
    task.node = node;
    task.ref = "dmz_scav";
    task.refindex = namespace_1eb3c4e0e28fac71::getquesttableindex( task.ref );
    return task;
}

// Namespace namespace_49d5ece81956adc8 / namespace_a713760a939752c1
// Params 0
// Checksum 0x0, Offset: 0xa5b
// Size: 0x1e0
function function_96771c28a0ff4628()
{
    self.nodes = array_add( self.node.nodes, self.node );
    
    foreach ( node in self.nodes )
    {
        node.task = self;
        node.var_534e0cf170a981b7 = &function_d8352a33e10df5a8;
    }
    
    foreach ( node in self.nodes )
    {
        if ( function_ff08d2b3254ea0d( node ) )
        {
            function_8250fd658e3aae32();
            task_ended();
            return;
        }
    }
    
    self.itemorder = array_randomize( [ "brloot_plate_carrier_2", "brloot_backpack_medium", "brloot_self_revive" ] );
    self.var_ba9295056b43d556 = array_randomize( [ "brloot_plate_carrier_2_medic", "brloot_plate_carrier_2_comms", "brloot_plate_carrier_2_stealth", "brloot_plate_carrier_3", "brloot_equip_gasmask_scuba", "brloot_equip_gasmask_durable", "brloot_backpack_large", "brloot_battlerage_self_revive", "brloot_super_self_revive_box", "brloot_super_armorbox" ] );
    self.activity.origin = self.node.origin;
    function_c847bfd52c064289( self.node.origin + ( 0, 0, 50 ) );
    self.cachesfound = 0;
}

// Namespace namespace_49d5ece81956adc8 / namespace_a713760a939752c1
// Params 1
// Checksum 0x0, Offset: 0xc43
// Size: 0x1b
function function_776101fe1e75a23a( player )
{
    function_1851e9cfb7687f68( player );
    function_fbf23ae15945ee5a( player );
}

// Namespace namespace_49d5ece81956adc8 / namespace_a713760a939752c1
// Params 1
// Checksum 0x0, Offset: 0xc66
// Size: 0x1b
function function_f2e92a7c1fd7db79( player )
{
    function_556fb3a465f0e978( player );
    function_401535e3fa9e171c( player );
}

// Namespace namespace_49d5ece81956adc8 / namespace_a713760a939752c1
// Params 1
// Checksum 0x0, Offset: 0xc89
// Size: 0x80
function function_aa932ab67844f7ab( teamname )
{
    players = getteamdata( teamname, "players" );
    function_e54df8560bf7dc64( teamname );
    thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "supply_assigned", teamname, 3 );
    self.var_8bd50c7e994c7434 = function_9c6ab63c4b6bd08b( teamname );
    function_1759acfd39bb5edf( "dmz_supply_assigned", teamname );
    function_c1fd3441ccfba6f8( teamname, "dmz_activity_start", 1.5, "dmz_activity_start_classic" );
    function_79057fbcbf8eed31();
    function_4e8f2a6350ec3613();
}

// Namespace namespace_49d5ece81956adc8 / namespace_a713760a939752c1
// Params 1
// Checksum 0x0, Offset: 0xd11
// Size: 0xb
function function_4f6565bdadaf8fc1( teamname )
{
    
}

// Namespace namespace_49d5ece81956adc8 / namespace_a713760a939752c1
// Params 1
// Checksum 0x0, Offset: 0xd24
// Size: 0x3b
function function_ba813599d8aa3e30( teamname )
{
    players = getteamdata( teamname, "players" );
    function_c1fd3441ccfba6f8( teamname, undefined, undefined );
    function_8250fd658e3aae32();
    task_ended();
}

// Namespace namespace_49d5ece81956adc8 / namespace_a713760a939752c1
// Params 0
// Checksum 0x0, Offset: 0xd67
// Size: 0x14
function function_8250fd658e3aae32()
{
    self.taskended = 1;
    function_629ed367d1393020();
}

// Namespace namespace_49d5ece81956adc8 / namespace_a713760a939752c1
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xd83
// Size: 0x4c
function private function_544de143314c88ef( teamname )
{
    self notify( "task_ended" );
    function_8250fd658e3aae32();
    thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "supply_win", teamname, 3 );
    function_c1fd3441ccfba6f8( teamname, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
    task_ended( teamname );
}

// Namespace namespace_49d5ece81956adc8 / namespace_a713760a939752c1
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xdd7
// Size: 0x388
function private function_d8352a33e10df5a8( instance, player )
{
    if ( !isdefined( player ) || !isdefined( player.team ) )
    {
        return;
    }
    
    if ( !isdefined( instance.task ) || !isdefined( instance.task.teams[ 0 ] ) || player.team != instance.task.teams[ 0 ] || istrue( instance.task.taskended ) )
    {
        player scripts\mp\hud_message::showerrormessage( "MP_DMZ_MISSIONS/GEIGER_SEARCH_GC_CACHE_ERR" );
        return 0;
    }
    
    if ( !isdefined( instance.taskopened ) )
    {
        task = instance.task;
        items = getscriptablelootcachecontents( instance );
        instance.containertype = 3;
        instance.contents = scripts\mp\gametypes\br_lootcache::function_ec87b214cd429e96( items, undefined );
        var_8bd50c7e994c7434 = int( ceil( instance.task.var_8bd50c7e994c7434 / level.var_cf05afb32024800a.numcaches ) );
        instance.contents = scripts\mp\gametypes\br_lootcache::function_163d360c111caa16( instance.contents, var_8bd50c7e994c7434, 500 );
        var_72bdd1d2dfbcaa5e = task.itemorder[ task.cachesfound ];
        itemid = scripts\cp_mp\utility\loot::getlootidfromref( var_72bdd1d2dfbcaa5e );
        instance.contents = scripts\mp\gametypes\br_lootcache::function_848e20cf1d6cab8f( instance.contents, 1, itemid );
        upgradecount = namespace_a38a2e1fe7519183::function_e860c1be7ff11f5b( player.team, 24 );
        
        if ( upgradecount )
        {
            chances = [ 0.5, 0.75, 0.95 ];
            chance = chances[ upgradecount - 1 ];
            
            if ( randomfloat( 1 ) < chance )
            {
                var_cb2e5f9c72c8939c = task.var_ba9295056b43d556[ task.cachesfound ];
                upgradeitemid = scripts\cp_mp\utility\loot::getlootidfromref( var_cb2e5f9c72c8939c );
                instance.contents = scripts\mp\gametypes\br_lootcache::function_848e20cf1d6cab8f( instance.contents, 1, upgradeitemid );
            }
        }
        
        instance.opened = 1;
        instance.taskopened = 1;
        task.cachesfound++;
        task function_4e8f2a6350ec3613();
        
        if ( task.cachesfound >= level.var_cf05afb32024800a.numcaches )
        {
            task function_544de143314c88ef( player.team );
            task function_1759acfd39bb5edf( "dmz_supply_secured", player.team );
            return;
        }
        
        if ( level.var_cf05afb32024800a.numcaches == 2 )
        {
            splash = "dmz_supply_1_2";
        }
        else
        {
            splash = [ "dmz_supply_2_3", "dmz_supply_1_3" ][ task.cachesfound - 1 ];
        }
        
        task function_1759acfd39bb5edf( splash, player.team );
        task function_79057fbcbf8eed31();
        task function_5314298e777e5688( "dmz_scav" );
        thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "supply_secured", player.team, 3 );
    }
}

// Namespace namespace_49d5ece81956adc8 / namespace_a713760a939752c1
// Params 0
// Checksum 0x0, Offset: 0x1167
// Size: 0x19a
function function_79057fbcbf8eed31()
{
    if ( !isdefined( self.teams[ 0 ] ) )
    {
        return;
    }
    
    players = getteamdata( self.teams[ 0 ], "players" );
    avgpos = ( 0, 0, 0 );
    numplayers = 0;
    
    foreach ( player in players )
    {
        if ( isdefined( player ) && isdefined( player.origin ) )
        {
            avgpos += player.origin;
            numplayers++;
        }
    }
    
    avgpos /= max( numplayers, 1 );
    var_64104068f7078b84 = 99999999999;
    closestnode = self.node;
    
    foreach ( node in self.nodes )
    {
        if ( istrue( node.opened ) )
        {
            continue;
        }
        
        distsq = distancesquared( node.origin, avgpos );
        
        if ( distsq < var_64104068f7078b84 )
        {
            closestnode = node;
            var_64104068f7078b84 = distsq;
        }
    }
    
    scripts\mp\gametypes\dmz_task_utils::function_cef2ed613a8338be( closestnode.origin + ( 0, 0, 50 ) );
}

// Namespace namespace_49d5ece81956adc8 / namespace_a713760a939752c1
// Params 0
// Checksum 0x0, Offset: 0x1309
// Size: 0x26
function function_4e8f2a6350ec3613()
{
    namespace_1eb3c4e0e28fac71::function_e2aa45e2c6b5dec1( level.var_cf05afb32024800a.numcaches - self.cachesfound );
}

/#

    // Namespace namespace_49d5ece81956adc8 / namespace_a713760a939752c1
    // Params 0
    // Checksum 0x0, Offset: 0x1337
    // Size: 0x2f, Type: dev
    function function_b9a9ef982e2d12a1()
    {
        while ( true )
        {
            sphere( self.origin, 50, ( 1, 1, 0 ), 0, 1 );
            waitframe();
        }
    }

#/
