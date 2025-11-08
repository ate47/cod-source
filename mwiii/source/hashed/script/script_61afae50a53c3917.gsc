#using script_39d11000e476a42a;
#using script_482376d10f69832c;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#using scripts\mp\objective_marker_bundle_helper;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\teams;

#namespace namespace_c493b0becc9ac9e3;

// Namespace namespace_c493b0becc9ac9e3 / namespace_c8baf39126f1ef99
// Params 4
// Checksum 0x0, Offset: 0x12e
// Size: 0x143
function function_65e52fad2bce952c( var_b8b25f4d3c3dab1d, var_18f698ac43092a07, var_e779ac7e9e65683d, var_730999d9ac61610e )
{
    assert( isdefined( var_18f698ac43092a07 ) && isdefined( var_b8b25f4d3c3dab1d ) && isdefined( var_e779ac7e9e65683d ), "<dev string:x1c>" );
    assert( isplayer( var_b8b25f4d3c3dab1d ), "<dev string:x6d>" );
    reward_groups = [];
    a_players = var_b8b25f4d3c3dab1d scripts\cp_mp\utility\squad_utility::getsquadmembers();
    
    foreach ( player in a_players )
    {
        reward_groups[ reward_groups.size ] = [ player ];
        
        if ( istrue( var_730999d9ac61610e ) )
        {
            if ( !isdefined( player.var_f0de17708687532e ) )
            {
                player.var_f0de17708687532e = [];
            }
            
            player.var_f0de17708687532e = function_6d6af8144a5131f1( player.var_f0de17708687532e, var_18f698ac43092a07 );
        }
    }
    
    reward_placement = namespace_71ca15b739deab72::function_3ae7f99339b96499( var_e779ac7e9e65683d );
    lootfunctionargs = spawnstruct();
    lootfunctionargs.var_18f698ac43092a07 = var_18f698ac43092a07;
    level namespace_e8853d3344e33cf6::function_863be9e39e19fe2f( reward_groups, reward_placement, &function_de032cb8f1df5adc, lootfunctionargs );
}

// Namespace namespace_c493b0becc9ac9e3 / namespace_c8baf39126f1ef99
// Params 2
// Checksum 0x0, Offset: 0x279
// Size: 0x36
function function_d737da36e4f0f6c2( player, var_18f698ac43092a07 )
{
    if ( isdefined( player.var_f0de17708687532e ) )
    {
        return array_contains( player.var_f0de17708687532e, var_18f698ac43092a07 );
    }
    
    return 0;
}

// Namespace namespace_c493b0becc9ac9e3 / namespace_c8baf39126f1ef99
// Params 1
// Checksum 0x0, Offset: 0x2b8
// Size: 0x4d
function function_de032cb8f1df5adc( lootfunctionargs )
{
    cache = spawnstruct();
    items = function_bc2f4857c90f5344( lootfunctionargs.var_18f698ac43092a07, 1 );
    common_cache::function_fd95ef820bb2b980( items, cache );
    return cache.contents;
}

// Namespace namespace_c493b0becc9ac9e3 / namespace_c8baf39126f1ef99
// Params 4
// Checksum 0x0, Offset: 0x30e
// Size: 0xe7
function function_9426e2a8c6789b97( player, var_f877158dac9d9e99, itembundlename, isdebug )
{
    itembundle = getscriptbundle( "itemspawnentry:" + itembundlename );
    payload = [ #"teamselect", player getentitynumber() ];
    a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
    item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4( itembundle, var_f877158dac9d9e99, undefined, 0, 1, payload );
    
    if ( isdefined( item ) && !istrue( isdebug ) )
    {
        params = spawnstruct();
        params.item = item;
        params.itembundlename = itembundlename;
        params.payload = payload;
        
        if ( isdefined( level.var_8b939fbe0ef2d56b ) )
        {
            player [[ level.var_8b939fbe0ef2d56b ]]( params );
        }
    }
}

// Namespace namespace_c493b0becc9ac9e3 / namespace_c8baf39126f1ef99
// Params 1
// Checksum 0x0, Offset: 0x3fd
// Size: 0x56
function function_579b200202dd2b1b( enteringentity )
{
    playerstocheck = undefined;
    
    if ( isdefined( enteringentity ) )
    {
        playerstocheck = [];
        
        if ( isplayer( enteringentity ) )
        {
            playerstocheck[ playerstocheck.size ] = enteringentity;
        }
        else if ( enteringentity scripts\cp_mp\vehicles\vehicle::isvehicle() )
        {
            occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( enteringentity );
            
            if ( isdefined( occupants ) )
            {
                playerstocheck = occupants;
            }
        }
    }
    
    return playerstocheck;
}

// Namespace namespace_c493b0becc9ac9e3 / namespace_c8baf39126f1ef99
// Params 1
// Checksum 0x0, Offset: 0x45c
// Size: 0x47
function function_fbd6a74053f1cb9a( objectivemarkerbundlename )
{
    var_ffcea9c7e03fdcba = -1;
    
    if ( isdefined( objectivemarkerbundlename ) )
    {
        markerid = scripts\mp\objective_marker_bundle_helper::CreateObjectiveMarkerFromBundleXHash( objectivemarkerbundlename );
        
        if ( isdefined( markerid ) && markerid != -1 )
        {
            var_ffcea9c7e03fdcba = markerid;
            objective_removeallfrommask( markerid );
        }
    }
    
    return var_ffcea9c7e03fdcba;
}

// Namespace namespace_c493b0becc9ac9e3 / namespace_c8baf39126f1ef99
// Params 2
// Checksum 0x0, Offset: 0x4ac
// Size: 0x8a
function function_1fcbe5915340280a( players, markerid )
{
    if ( isdefined( players ) && isdefined( markerid ) && isarray( players ) && players.size > 0 && markerid != -1 )
    {
        foreach ( player in players )
        {
            objective_addclienttomask( markerid, player );
            objective_showtoplayersinmask( markerid );
        }
    }
}

// Namespace namespace_c493b0becc9ac9e3 / namespace_c8baf39126f1ef99
// Params 2
// Checksum 0x0, Offset: 0x53e
// Size: 0x83
function function_f535888a3f1341a4( players, markerid )
{
    if ( isdefined( players ) && isdefined( markerid ) && isarray( players ) && players.size > 0 && markerid != -1 )
    {
        foreach ( player in players )
        {
            objective_removeclientfrommask( markerid, player );
        }
    }
}

// Namespace namespace_c493b0becc9ac9e3 / namespace_c8baf39126f1ef99
// Params 1
// Checksum 0x0, Offset: 0x5c9
// Size: 0x1f
function function_fa14863bc660a9b5( markerid )
{
    if ( isdefined( markerid ) && markerid != -1 )
    {
        objective_removeallfrommask( markerid );
    }
}

// Namespace namespace_c493b0becc9ac9e3 / namespace_c8baf39126f1ef99
// Params 4
// Checksum 0x0, Offset: 0x5f0
// Size: 0xdc
function function_a90a4361890d7c1d( var_a46efd0f95adb3ac, players, markerid, iconzoffset )
{
    if ( isdefined( players ) && isdefined( var_a46efd0f95adb3ac ) && isdefined( self ) && isdefined( markerid ) && isent( var_a46efd0f95adb3ac ) && isarray( players ) && players.size > 0 && markerid != -1 )
    {
        level endon( "game_ended" );
        var_a46efd0f95adb3ac endon( "death" );
        self endon( "attunement_ended" );
        scripts\mp\objidpoolmanager::update_objective_setzoffset( markerid, iconzoffset );
        function_1fcbe5915340280a( players, markerid );
        
        foreach ( player in players )
        {
            while ( true )
            {
                scripts\mp\objidpoolmanager::update_objective_onentity( markerid, var_a46efd0f95adb3ac );
                waitframe();
            }
        }
    }
}

