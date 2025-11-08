#using scripts\common\utility;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\gasmask;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_champion_task;
#using scripts\mp\gametypes\br_public;

#namespace namespace_947f137e8c5c3d4;

// Namespace namespace_947f137e8c5c3d4 / namespace_f8aa7c160140e21
// Params 0
// Checksum 0x0, Offset: 0x16f
// Size: 0x2e
function inittask()
{
    function_ac97a4f2ab8c2d53( "misc", "tryAssignTask", &function_1a86afc387820604 );
    function_ac97a4f2ab8c2d53( "misc", "checkTaskValid", &checktaskvalid );
}

// Namespace namespace_947f137e8c5c3d4 / namespace_f8aa7c160140e21
// Params 2
// Checksum 0x0, Offset: 0x1a5
// Size: 0x192, Type: bool
function checktaskvalid( selectedtask, team )
{
    if ( selectedtask.subcategory == "equiped_full_armor" )
    {
        foreach ( player in level.teamdata[ team ][ "players" ] )
        {
            if ( isdefined( player ) && player scripts\cp_mp\armor::function_ac266fc218266d08() < player.maxarmorhealth )
            {
                return true;
            }
        }
        
        return false;
    }
    else if ( selectedtask.subcategory == "picked_up_item_brloot_self_revive" )
    {
        foreach ( player in level.teamdata[ team ][ "players" ] )
        {
            if ( isdefined( player ) && !player scripts\mp\gametypes\br_public::hasselfrevivetoken() )
            {
                return true;
            }
        }
        
        return false;
    }
    else if ( selectedtask.subcategory == "picked_up_item_brloot_equip_gasmask" )
    {
        foreach ( player in level.teamdata[ team ][ "players" ] )
        {
            if ( isdefined( player ) && !scripts\cp_mp\gasmask::hasgasmask( player ) )
            {
                return true;
            }
        }
        
        return false;
    }
    
    return false;
}

// Namespace namespace_947f137e8c5c3d4 / namespace_f8aa7c160140e21
// Params 1
// Checksum 0x0, Offset: 0x340
// Size: 0xbc
function function_1a86afc387820604( taskinstance )
{
    flag = taskinstance.info.subcategory + "_" + taskinstance.team;
    
    if ( taskinstance.info.subcategory == "equiped_full_armor" )
    {
        thread function_ca3b60f5f124d2ad( flag, taskinstance );
        return;
    }
    
    if ( taskinstance.info.subcategory == "picked_up_item_brloot_self_revive" )
    {
        thread function_473b169b28634ac0( flag, taskinstance );
        return;
    }
    
    if ( taskinstance.info.subcategory == "picked_up_item_brloot_equip_gasmask" )
    {
        thread function_a1e5492242dcf7e5( flag, taskinstance );
    }
}

// Namespace namespace_947f137e8c5c3d4 / namespace_f8aa7c160140e21
// Params 2
// Checksum 0x0, Offset: 0x404
// Size: 0xd4
function function_ca3b60f5f124d2ad( flag, taskinstance )
{
    level endon( "game_ended" );
    taskinstance endon( "task_end" );
    
    while ( true )
    {
        level waittill( flag, player );
        var_876d422c8206879c = 1;
        
        foreach ( player in level.teamdata[ taskinstance.team ][ "players" ] )
        {
            if ( !isdefined( player ) || player scripts\cp_mp\armor::function_ac266fc218266d08() < player.maxarmorhealth )
            {
                var_876d422c8206879c = 0;
                break;
            }
        }
        
        if ( var_876d422c8206879c == 1 && isdefined( player ) )
        {
            player function_89b8bce3baa45edc( taskinstance, 1 );
        }
    }
}

// Namespace namespace_947f137e8c5c3d4 / namespace_f8aa7c160140e21
// Params 2
// Checksum 0x0, Offset: 0x4e0
// Size: 0xc8
function function_473b169b28634ac0( flag, taskinstance )
{
    level endon( "game_ended" );
    taskinstance endon( "task_end" );
    
    while ( true )
    {
        level waittill( flag, player );
        var_45b9b8130cdea6a5 = 1;
        
        foreach ( player in level.teamdata[ taskinstance.team ][ "players" ] )
        {
            if ( !isdefined( player ) || !player scripts\mp\gametypes\br_public::hasselfrevivetoken() )
            {
                var_45b9b8130cdea6a5 = 0;
                break;
            }
        }
        
        if ( var_45b9b8130cdea6a5 == 1 && isdefined( player ) )
        {
            player function_89b8bce3baa45edc( taskinstance, 1 );
        }
    }
}

// Namespace namespace_947f137e8c5c3d4 / namespace_f8aa7c160140e21
// Params 2
// Checksum 0x0, Offset: 0x5b0
// Size: 0xc8
function function_a1e5492242dcf7e5( flag, taskinstance )
{
    level endon( "game_ended" );
    taskinstance endon( "task_end" );
    
    while ( true )
    {
        level waittill( flag, player );
        var_f1700ca637a7710f = 1;
        
        foreach ( player in level.teamdata[ taskinstance.team ][ "players" ] )
        {
            if ( !isdefined( player ) || !scripts\cp_mp\gasmask::hasgasmask( player ) )
            {
                var_f1700ca637a7710f = 0;
                break;
            }
        }
        
        if ( var_f1700ca637a7710f == 1 && isdefined( player ) )
        {
            player function_89b8bce3baa45edc( taskinstance, 1 );
        }
    }
}

