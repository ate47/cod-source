#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\pmc_missions;
#using scripts\mp\poi;
#using scripts\mp\utility\game;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;

#namespace namespace_f3c34c81dcc60eda;

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x439
// Size: 0xf8
function autoexec init()
{
    wcenabled = getmatchrulesdata( "brData", "wcEnabled" );
    
    if ( !istrue( wcenabled ) )
    {
        return;
    }
    
    wcdata = getmatchrulesdata( "brData", "wcData" );
    
    if ( !isdefined( wcdata ) || wcdata == "" )
    {
        return 0;
    }
    
    wcbundlename = hashcat( %"hash_31706c654b9d3b54", wcdata );
    var_53f1209f53f48f29 = getscriptbundle( wcbundlename );
    level.var_53f1209f53f48f29 = var_53f1209f53f48f29;
    level.var_71710256253c76be = gettime();
    level.var_bfcb6f843adf3368 = gettime();
    level.var_e2b5942176a926a = getdvarint( @"hash_34c8c5cc6250285a", 7 ) * 1000;
    callback::add( #"hash_c15c682d6a5dcae0", &onplayerentergulag );
    callback::add( #"hash_438552ad6e5b08a0", &function_3b3d0d8621983ff4 );
    game[ "dialog" ][ "weaponcase_myTeam_found" ] = "flyb_grav_brwe";
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 0
// Checksum 0x0, Offset: 0x539
// Size: 0xba
function function_94b502046c767cd1()
{
    if ( isdefined( level.var_94b502046c767cd1 ) )
    {
        return level.var_94b502046c767cd1;
    }
    
    if ( scripts\mp\utility\game::getsubgametype() != "dmz" )
    {
        level.var_94b502046c767cd1 = "no_one";
        return level.var_94b502046c767cd1;
    }
    
    if ( scripts\cp_mp\utility\game_utility::function_7ee65fae13124702() || level.mapname == "mp_br_mechanics" )
    {
        trainchance = getdvarint( @"hash_5c2cb9fc4042e027", 40 );
        
        if ( trainchance > 0 && randomint( 100 ) < trainchance )
        {
            level.var_94b502046c767cd1 = "train";
            return level.var_94b502046c767cd1;
        }
    }
    
    level.var_94b502046c767cd1 = "boss";
    return level.var_94b502046c767cd1;
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 3
// Checksum 0x0, Offset: 0x5fc
// Size: 0x6c
function function_1bafb1f579534ef6( dropinfo, player, scriptablename )
{
    if ( isdefined( level.var_b220727281972841 ) )
    {
        return undefined;
    }
    
    function_f9ec88c3d71324cd( scriptablename );
    weaponcase = scripts\mp\gametypes\br_pickups::spawnpickup( level.var_1e8771caf5122101, dropinfo, 1, 1 );
    
    if ( !isdefined( weaponcase ) )
    {
        return undefined;
    }
    
    function_3e7ee85cb0d3504c( weaponcase, dropinfo.instance );
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 2
// Checksum 0x0, Offset: 0x670
// Size: 0xc2
function function_3e7ee85cb0d3504c( scriptable, instance )
{
    if ( isdefined( level.var_b220727281972841 ) )
    {
        return;
    }
    
    function_f9ec88c3d71324cd( scriptable.type );
    level.var_b220727281972841 = spawnstruct();
    level.var_b220727281972841.scriptable = scriptable;
    level.var_b220727281972841.instance = instance;
    scriptable.criticalitem = 1;
    
    if ( level.var_86b2cfc21b9abcf8 )
    {
        function_9b0ef508769a0a0f( scriptable.origin );
    }
    else
    {
        level.var_b220727281972841.objidnum = -1;
    }
    
    function_147936bfe8fd8d7e( scriptable.origin );
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1
// Checksum 0x0, Offset: 0x73a
// Size: 0xaf
function function_f9ec88c3d71324cd( scriptablename )
{
    if ( isdefined( level.var_1e8771caf5122101 ) )
    {
        return;
    }
    
    scriptablename = default_to( scriptablename, level.var_53f1209f53f48f29.scriptablename );
    level.var_1e8771caf5122101 = scriptablename;
    
    if ( scriptablename == "brloot_weaponcase_black" )
    {
        level.var_9a327d6ca5e25308 = 1;
    }
    
    lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7( scriptablename );
    scripts\engine\utility::registersharedfunc( scriptablename, "delete", &function_fbaa37f0a39a0d07 );
    scripts\engine\utility::registersharedfunc( scriptablename, "dropped", &function_f69e3d324a1172c6 );
    scripts\engine\utility::registersharedfunc( lootid, "addedToContainer", &function_22e6cb66ccb56285 );
    scripts\engine\utility::registersharedfunc( lootid, "pickedUp", &function_803a95e4e6cd2538 );
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x7f1
// Size: 0x13d, Type: bool
function private function_fbaa37f0a39a0d07()
{
    if ( isdefined( self.linkedparent ) && self.linkedparent scripts\cp_mp\vehicles\vehicle::isvehicle() && self.linkedparent scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd() == "veh9_palfa" )
    {
        return false;
    }
    
    contents = scripts\engine\trace::create_itemclip_contents();
    trace = scripts\engine\trace::ray_trace( self.origin, self.origin - ( 0, 0, 10000 ), undefined, contents );
    
    if ( !isdefined( trace[ "position" ] ) || !isdefined( trace[ "fraction" ] ) || trace[ "fraction" ] >= 0.99 || scripts\mp\outofbounds::ispointinoutofbounds( trace[ "position" ] ) )
    {
        onnavmesh = getclosestpointonnavmesh( self.origin );
        trace = scripts\engine\trace::ray_trace( onnavmesh, onnavmesh - ( 0, 0, 1000 ), undefined, contents );
    }
    
    if ( !isdefined( trace[ "position" ] ) || !isdefined( trace[ "normal" ] ) || !isdefined( trace[ "fraction" ] ) || trace[ "fraction" ] >= 0.99 )
    {
        return false;
    }
    
    utility::scriptable_clearparententity();
    self.origin = trace[ "position" ];
    return true;
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 2
// Checksum 0x0, Offset: 0x937
// Size: 0x6e
function spawnweaponcase( player, dropstruct )
{
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( dropstruct, player.origin, player.angles, player );
    weaponcase = scripts\mp\gametypes\br_pickups::spawnpickup( level.var_1e8771caf5122101, dropinfo, 1 );
    function_f69e3d324a1172c6( weaponcase, player, dropinfo.origin );
    return weaponcase;
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x9ae
// Size: 0x1ec
function private function_f69e3d324a1172c6( scriptable, owner, finalorigin )
{
    assert( isdefined( owner ) );
    
    if ( !isdefined( level.var_b220727281972841 ) )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    level.var_b220727281972841.currentowner = undefined;
    level.var_b220727281972841.scriptable = scriptable;
    scriptable.criticalitem = 1;
    
    if ( level.var_86b2cfc21b9abcf8 && level.var_b220727281972841.objidnum != -1 )
    {
        level notify( "interuptWeaponCaseShow" );
        objective_setplayintro( level.var_b220727281972841.objidnum, 0 );
        objective_disableping( level.var_b220727281972841.objidnum, istrue( level.var_53f1209f53f48f29.var_6342a4ff1d4cd212 ) );
        scripts\mp\objidpoolmanager::function_df6a3e032fa07d22( level.var_b220727281972841.objidnum );
    }
    
    if ( level.var_509664f56a31278f )
    {
        splash = level.var_53f1209f53f48f29.var_370a2e386a4e87c5;
        
        if ( isdefined( splash ) && splash != "" )
        {
            teammates = array_remove( level.teamdata[ owner.team ][ "players" ], owner );
            showdmzsplash( splash, teammates, undefined, undefined, owner );
        }
        
        splash = level.var_53f1209f53f48f29.var_eb67bce2db34d570;
        
        if ( isdefined( splash ) && splash != "" )
        {
            if ( level.var_bfcb6f843adf3368 + level.var_e2b5942176a926a < gettime() )
            {
                level.var_bfcb6f843adf3368 = gettime();
                showdmzsplash( splash, [ owner ] );
            }
        }
    }
    
    function_d88e40b4707fdabd( owner, owner.health <= 0 );
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xba2
// Size: 0xf1
function private function_22e6cb66ccb56285( container, owner )
{
    if ( !isdefined( level.var_b220727281972841 ) )
    {
        assertmsg( "<dev string:x5b>" );
        return;
    }
    
    level.var_b220727281972841.currentowner = undefined;
    level.var_b220727281972841.scriptable = container;
    
    if ( level.var_b220727281972841.objidnum != -1 )
    {
        level notify( "interuptWeaponCaseShow" );
        objective_setplayintro( level.var_b220727281972841.objidnum, 0 );
        objective_disableping( level.var_b220727281972841.objidnum, istrue( level.var_53f1209f53f48f29.var_10ba92c5298ab10b ) || istrue( level.var_53f1209f53f48f29.var_6342a4ff1d4cd212 ) );
        scripts\mp\objidpoolmanager::function_df6a3e032fa07d22( level.var_b220727281972841.objidnum );
    }
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xc9b
// Size: 0x546
function private function_803a95e4e6cd2538( scriptable, player )
{
    if ( !isdefined( level.var_b220727281972841 ) )
    {
        function_f9ec88c3d71324cd( "brloot_weaponcase_black" );
        level.var_b220727281972841 = spawnstruct();
        level.var_b220727281972841.currentowner = player;
        
        if ( level.var_86b2cfc21b9abcf8 )
        {
            function_9b0ef508769a0a0f( player.origin );
        }
    }
    
    objid = level.var_b220727281972841.objidnum;
    var_2db2f4dfa0a0d05f = 0;
    
    if ( !isdefined( level.var_b220727281972841.lastteam ) || isdefined( player.team ) && player.team != level.var_b220727281972841.lastteam )
    {
        if ( objid != -1 )
        {
            objective_setownerteam( objid, player.team );
            objective_setprogressteam( objid, player.team );
            objective_setpulsate( objid, 1 );
        }
        
        if ( level.var_509664f56a31278f )
        {
            var_2db2f4dfa0a0d05f = 1;
            defaultsplash = level.var_53f1209f53f48f29.pickedupsplash;
            
            if ( isdefined( level.var_9d7687867d52ac75 ) )
            {
                defaultsplash = [[ level.var_9d7687867d52ac75 ]]();
            }
            
            splash = ter_op( istrue( level.var_b220727281972841.pickedupbefore ), level.var_53f1209f53f48f29.transfersplash, defaultsplash );
            level.var_b220727281972841.pickedupbefore = 1;
            
            if ( isdefined( splash ) && splash != "" )
            {
                players = level.players;
                
                if ( isdefined( level.var_53f1209f53f48f29.var_77e9cba9da41c3a1 ) && level.var_53f1209f53f48f29.var_77e9cba9da41c3a1 != "" )
                {
                    players = array_remove( level.players, player );
                }
                
                showdmzsplash( splash, players, scripts\mp\poi::poi_findPOIOriginIsIn( player.origin, undefined, undefined, 1 ) );
            }
            
            level thread function_31a079a1fe9caa2( player );
        }
        
        if ( scripts\cp_mp\utility\game_utility::function_5e0e3a24dbb1fae1() && scripts\mp\pmc_missions::function_bebcefbd95a287ec( player ) )
        {
            scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "faction_e_fearless_on_weaponcase_pickup", player.team );
        }
        else
        {
            scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "weapon_case_pickup_self", player.team );
        }
        
        if ( level.mapname != "mp_bio_lab" )
        {
            scripts\cp_mp\overlord::playevent( "weapon_case_pickup_enemy", array_difference( level.players, getteamdata( player.team, "players" ) ) );
        }
        
        if ( !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
        {
            exfils = getteamdata( player.team, "exfils" );
            
            if ( exfils.size > 0 )
            {
                var_ef5c2361236a6ba9 = sortbydistance( exfils, player.origin )[ 0 ].ent;
                
                if ( isdefined( var_ef5c2361236a6ba9 ) )
                {
                    player scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout( 18, var_ef5c2361236a6ba9.origin, <error objectid>.index, var_ef5c2361236a6ba9 getlinkedscriptableinstance() );
                }
            }
        }
    }
    
    if ( objid != -1 )
    {
        if ( istrue( level.var_53f1209f53f48f29.var_10ba92c5298ab10b ) || istrue( level.var_53f1209f53f48f29.var_6342a4ff1d4cd212 ) )
        {
            objective_disableping( objid, istrue( level.var_53f1209f53f48f29.var_10ba92c5298ab10b ) || istrue( level.var_53f1209f53f48f29.var_6342a4ff1d4cd212 ) );
            scripts\cp_mp\calloutmarkerping::function_cd96f73dbca496b8( objid );
        }
    }
    
    if ( level.var_509664f56a31278f )
    {
        splash = level.var_53f1209f53f48f29.var_a57c046cc112e52e;
        
        if ( isdefined( splash ) && splash != "" )
        {
            teammates = array_remove( getteamdata( player.team, "players" ), player );
            showdmzsplash( splash, teammates, undefined, undefined, player );
        }
        
        splash = level.var_53f1209f53f48f29.var_77e9cba9da41c3a1;
        
        if ( isdefined( splash ) && splash != "" )
        {
            if ( level.var_71710256253c76be + level.var_e2b5942176a926a < gettime() )
            {
                level.var_71710256253c76be = gettime();
                showdmzsplash( splash, [ player ] );
            }
        }
    }
    
    if ( objid != -1 && !var_2db2f4dfa0a0d05f )
    {
        scripts\mp\objidpoolmanager::function_df6a3e032fa07d22( objid );
    }
    
    if ( !isdefined( level.var_b220727281972841.lastteam ) || level.var_b220727281972841.lastteam != player.team )
    {
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "weaponcase_myTeam_found", player.team, 1, 2, undefined );
    }
    
    level.var_b220727281972841.currentowner = player;
    level.var_b220727281972841.lastteam = player.team;
    level.var_b220727281972841.scriptable = undefined;
    function_ab9f38ae158a284c( player );
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1
// Checksum 0x0, Offset: 0x11e9
// Size: 0x38, Type: bool
function isweaponcase( lootid )
{
    if ( !isdefined( level.var_1e8771caf5122101 ) )
    {
        return false;
    }
    
    wclootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7( level.var_1e8771caf5122101 );
    return lootid == wclootid;
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 0
// Checksum 0x0, Offset: 0x122a
// Size: 0x39
function function_c320904c58171311()
{
    if ( hasweaponcase( self ) && isalive( self ) && !istrue( self.extracted ) && !istrue( self.var_ded04cdd264a7e00 ) )
    {
        dropweaponcase();
    }
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 0
// Checksum 0x0, Offset: 0x126b
// Size: 0x64
function dropweaponcase()
{
    if ( istrue( self.extracted ) )
    {
        return;
    }
    
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo( self.origin, self.angles );
    weaponcase = scripts\mp\gametypes\br_pickups::spawnpickup( level.var_1e8771caf5122101, dropinfo, 1 );
    function_f69e3d324a1172c6( weaponcase, self, dropinfo.origin );
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x12d7
// Size: 0x8f
function private function_31a079a1fe9caa2( var_480f8576be141bb4 )
{
    objid = level.var_b220727281972841.objidnum;
    
    if ( level.var_86b2cfc21b9abcf8 && objid != -1 )
    {
        objective_setplayintro( level.var_b220727281972841.objidnum, 0 );
        level notify( "interuptWeaponCaseShow" );
        level endon( "interuptWeaponCaseShow" );
        scripts\mp\objidpoolmanager::function_f5862ad1ad967602( objid );
        wait 3.8;
        objective_setplayintro( objid, 1 );
        scripts\mp\objidpoolmanager::function_df6a3e032fa07d22( objid );
        waitframe();
        objective_setplayintro( objid, 0 );
    }
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1
// Checksum 0x0, Offset: 0x136e
// Size: 0x7f
function function_5704ab2a9381630f( player )
{
    if ( hasweaponcase( player ) )
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( level.var_b220727281972841.objidnum );
        scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "weapon_case_extract_self", player.team );
        scripts\cp_mp\overlord::playevent( "weapon_case_extract_enemy", array_difference( level.players, getteamdata( player.team, "players" ) ) );
        level notify( "weaponCase_extracted" );
    }
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1
// Checksum 0x0, Offset: 0x13f5
// Size: 0x2f, Type: bool
function didextractwithweaponcase( player )
{
    return isdefined( level.var_8fc589b1edff1fb2 ) && istrue( level.var_8fc589b1edff1fb2[ player.guid ] );
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1
// Checksum 0x0, Offset: 0x142d
// Size: 0x188
function function_25a4b6a2083e2ab( players )
{
    if ( !isdefined( level.var_b220727281972841 ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_8fc589b1edff1fb2 ) )
    {
        level.var_8fc589b1edff1fb2 = [];
    }
    
    owner = level.var_b220727281972841.currentowner;
    
    if ( isdefined( owner ) && array_contains( players, owner ) )
    {
        foreach ( teammember in players )
        {
            if ( !isdefined( teammember ) )
            {
                continue;
            }
            
            if ( !is_equal( teammember.team, owner.team ) )
            {
                continue;
            }
            
            level.var_8fc589b1edff1fb2[ teammember.guid ] = 1;
        }
        
        var_d64bef4dd271a622 = array_remove_array( level.players, players );
        
        if ( isdefined( level.var_b220727281972841.instance ) && isdefined( level.var_b220727281972841.instance.bosstype ) )
        {
            showdmzsplash( "dmz_lootbox_extracted_" + level.var_b220727281972841.instance.bosstype, var_d64bef4dd271a622, owner.closestpoi );
            return;
        }
        
        showdmzsplash( "dmz_lootbox_extracted_generic", var_d64bef4dd271a622, owner.closestpoi );
    }
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1
// Checksum 0x0, Offset: 0x15bd
// Size: 0xb2
function function_baf5e17d7033a223( player )
{
    if ( !isdefined( level.var_8fc589b1edff1fb2 ) )
    {
        level.var_8fc589b1edff1fb2 = [];
    }
    
    var_5b6d15e33cb2eb51 = level.var_8fc589b1edff1fb2[ player.guid ];
    var_f260f6aff9ac7f06 = ter_op( isdefined( function_84d052fbd32e9c5b( player ) ), 1, 0 );
    
    if ( !isdefined( var_5b6d15e33cb2eb51 ) )
    {
        return 0;
    }
    
    assert( var_5b6d15e33cb2eb51 >= var_f260f6aff9ac7f06, "<dev string:xb0>" );
    
    if ( isdefined( level.var_8fc589b1edff1fb2[ player.guid ] ) )
    {
        return ( ( var_5b6d15e33cb2eb51 - var_f260f6aff9ac7f06 ) * level.br_pickups.br_value[ level.var_1e8771caf5122101 ] );
    }
    
    return 0;
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1
// Checksum 0x0, Offset: 0x1678
// Size: 0x12b
function function_8f6753648e94e7ec( player )
{
    if ( !isdefined( level.var_8fc589b1edff1fb2 ) )
    {
        level.var_8fc589b1edff1fb2 = [];
    }
    
    var_5b6d15e33cb2eb51 = level.var_8fc589b1edff1fb2[ player.guid ];
    
    if ( !isdefined( var_5b6d15e33cb2eb51 ) || var_5b6d15e33cb2eb51 == 0 )
    {
        return [];
    }
    
    if ( !isdefined( level.br_pickups ) || !isdefined( level.br_pickups.br_weapontoscriptable ) )
    {
        assertmsg( "<dev string:xfb>" );
        return [];
    }
    
    if ( !isdefined( level.var_4cb4bde4ae44acba ) )
    {
        level.var_4cb4bde4ae44acba = array_randomize( array_convert_keys_to_ints( level.br_pickups.br_weapontoscriptable ) );
    }
    
    if ( !isdefined( level.randomweaponindex ) )
    {
        level.randomweaponindex = 0;
    }
    
    rewards = [];
    rewards[ 0 ] = level.br_pickups.var_7b2bff2d04ee1017[ level.var_4cb4bde4ae44acba[ level.randomweaponindex ] ];
    level.randomweaponindex = ( level.randomweaponindex + 1 ) % level.var_4cb4bde4ae44acba.size;
    return rewards;
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 0
// Checksum 0x0, Offset: 0x17ac
// Size: 0xc, Type: bool
function function_fc1ce25282bcba83()
{
    return isdefined( level.var_b220727281972841 );
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1
// Checksum 0x0, Offset: 0x17c1
// Size: 0x13, Type: bool
function hasweaponcase( player )
{
    return isdefined( function_84d052fbd32e9c5b( player ) );
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1
// Checksum 0x0, Offset: 0x17dd
// Size: 0x40
function function_84d052fbd32e9c5b( player )
{
    if ( isdefined( level.var_b220727281972841 ) && is_equal( level.var_b220727281972841.currentowner, player ) )
    {
        return level.var_b220727281972841;
    }
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1825
// Size: 0x150
function private function_9b0ef508769a0a0f( origin )
{
    objid = scripts\mp\objidpoolmanager::requestobjectiveid( 99 );
    level.var_b220727281972841.objidnum = objid;
    
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setlabel( objid, level.var_53f1209f53f48f29.targetlabel );
    objective_setpings( objid, 1 );
    objective_setzoffset( objid, ( 0, 0, 80 )[ 2 ] );
    objective_icon( objid, level.var_53f1209f53f48f29.var_ad643c538be8b717 );
    objective_setobjectivetype( objid, objective_getweaponcaseobjectivetype() );
    objective_setbackground( objid, 1 );
    objective_state( objid, "current" );
    objective_position( objid, origin + ( 0, 0, 30 ) - ( 0, 0, 80 ) );
    objective_setownerteam( objid, undefined );
    objective_setprogressteam( objid, undefined );
    objective_setfadingdistance( objid, level.var_53f1209f53f48f29.var_a7c6c5d6c3d369aa, level.var_53f1209f53f48f29.var_467f4d9b8d9063b );
    objective_disableping( objid, istrue( level.var_53f1209f53f48f29.var_6342a4ff1d4cd212 ) );
    scripts\mp\objidpoolmanager::function_79a1a16de6b22b2d( objid, 16 );
    objective_setplayintro( objid, 0 );
    scripts\mp\objidpoolmanager::function_df6a3e032fa07d22( objid );
    level thread function_3de46c194ccd92d8();
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x197d
// Size: 0x5a
function private onplayerentergulag( options )
{
    if ( !isdefined( level.var_b220727281972841 ) )
    {
        return;
    }
    
    objid = level.var_b220727281972841.objidnum;
    
    if ( !isdefined( objid ) || objid == -1 )
    {
        return;
    }
    
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom( objid, options.player );
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x19df
// Size: 0x5a
function private function_3b3d0d8621983ff4( options )
{
    if ( !isdefined( level.var_b220727281972841 ) )
    {
        return;
    }
    
    objid = level.var_b220727281972841.objidnum;
    
    if ( !isdefined( objid ) || objid == -1 )
    {
        return;
    }
    
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( objid, options.player );
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1a41
// Size: 0x1a1
function private function_3de46c194ccd92d8()
{
    level endon( "game_ended" );
    level endon( "weaponCase_extracted" );
    pingtime = ter_op( istrue( level.var_9a327d6ca5e25308 ), getdvarfloat( @"hash_886c13ade3501edf", 6 ), level.var_53f1209f53f48f29.pingdelay );
    
    while ( true )
    {
        if ( isdefined( level.var_b220727281972841.currentowner ) )
        {
            if ( istrue( level.var_9a327d6ca5e25308 ) )
            {
                objective_position( level.var_b220727281972841.objidnum, level.var_b220727281972841.currentowner.origin + ( 0, 0, 30 ) - ( 0, 0, 80 ) );
            }
            else
            {
                objective_onentity( level.var_b220727281972841.objidnum, level.var_b220727281972841.currentowner );
            }
        }
        else if ( isdefined( level.var_b220727281972841.scriptable ) )
        {
            objective_position( level.var_b220727281972841.objidnum, level.var_b220727281972841.scriptable.origin + ( 0, 0, 30 ) - ( 0, 0, 80 ) );
        }
        else
        {
            scripts\mp\objidpoolmanager::returnobjectiveid( level.var_b220727281972841.objidnum );
            return;
        }
        
        objective_ping( level.var_b220727281972841.objidnum );
        wait pingtime;
    }
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1
// Checksum 0x0, Offset: 0x1bea
// Size: 0x30
function function_95d2129bcec4692( origin )
{
    anyone = level.players[ 0 ];
    anyone function_c20b29a0d9d6ccaf( "init", origin );
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1c22
// Size: 0x30
function private function_147936bfe8fd8d7e( origin )
{
    anyone = level.players[ 0 ];
    anyone function_c20b29a0d9d6ccaf( "spawned", origin );
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1c5a
// Size: 0x23
function private function_ab9f38ae158a284c( player )
{
    player function_c20b29a0d9d6ccaf( "pickup", player.origin );
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1c85
// Size: 0x2c
function private function_d88e40b4707fdabd( player, var_76941f891909e174 )
{
    player function_c20b29a0d9d6ccaf( "drop", player.origin, var_76941f891909e174 );
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x1cb9
// Size: 0x1ae
function private function_c20b29a0d9d6ccaf( type, position, var_76941f891909e174 )
{
    var_76941f891909e174 = default_to( var_76941f891909e174, 0 );
    eventparams = [];
    eventparams[ eventparams.size ] = "event_type";
    eventparams[ eventparams.size ] = type;
    assert( isstring( eventparams[ eventparams.size - 1 ] ) );
    eventparams[ eventparams.size ] = "team_name";
    eventparams[ eventparams.size ] = self.team;
    assert( isstring( eventparams[ eventparams.size - 1 ] ) );
    eventparams[ eventparams.size ] = "playlist_name";
    eventparams[ eventparams.size ] = getplaylistname();
    assert( isstring( eventparams[ eventparams.size - 1 ] ) );
    eventparams[ eventparams.size ] = "circle_index";
    eventparams[ eventparams.size ] = getcircleindex();
    assert( isnumber( eventparams[ eventparams.size - 1 ] ) );
    eventparams[ eventparams.size ] = "map_name";
    eventparams[ eventparams.size ] = level.mapname;
    assert( isstring( eventparams[ eventparams.size - 1 ] ) );
    eventparams[ eventparams.size ] = "position_x";
    eventparams[ eventparams.size ] = position[ 0 ];
    assert( isnumber( eventparams[ eventparams.size - 1 ] ) );
    eventparams[ eventparams.size ] = "position_y";
    eventparams[ eventparams.size ] = position[ 1 ];
    assert( isnumber( eventparams[ eventparams.size - 1 ] ) );
    eventparams[ eventparams.size ] = "position_z";
    eventparams[ eventparams.size ] = position[ 2 ];
    assert( isnumber( eventparams[ eventparams.size - 1 ] ) );
    eventparams[ eventparams.size ] = "owner_killed";
    eventparams[ eventparams.size ] = var_76941f891909e174;
    assert( function_c86457bdd073e07b( eventparams[ eventparams.size - 1 ] ) );
    self dlog_recordplayerevent( "dlog_event_br_weapon_case", eventparams );
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1e6f
// Size: 0x4b
function private getcircleindex()
{
    circleindex = -1;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
    {
        circleindex = level.br_circle.circleindex;
    }
    
    return circleindex;
}

// Namespace namespace_f3c34c81dcc60eda / namespace_a8b2b88699fc40fb
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1ec3
// Size: 0x20, Type: bool
function private function_c86457bdd073e07b( value )
{
    return isnumber( value ) && ( value == 1 || value == 0 );
}

