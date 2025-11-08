#using scripts\cp\cp_gamescore;
#using scripts\cp\utility;

#namespace cp_core_gamescore;

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 0
// Checksum 0x0, Offset: 0x175
// Size: 0x32
function init_zombie_scoring()
{
    init_eog_score_components( [ "money_earned" ] );
    init_encounter_score_components( [ "money_earned" ] );
    set_level_score_data();
    set_level_score_callback_func();
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 0
// Checksum 0x0, Offset: 0x1af
// Size: 0xd
function set_level_score_data()
{
    level.cycle_score_scalar = 1;
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 0
// Checksum 0x0, Offset: 0x1c4
// Size: 0x10
function set_level_score_callback_func()
{
    level.endgameencounterscorefunc = &zombies_endgameencounterscorefunc;
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 1
// Checksum 0x0, Offset: 0x1dc
// Size: 0xeb
function init_eog_score_components( var_bef62e0ad2260faf )
{
    foreach ( component_name in var_bef62e0ad2260faf )
    {
        switch ( component_name )
        {
            case #"hash_1cc8a923a608c2a0":
                register_eog_score_component( "damage", 29 );
                break;
            case #"hash_a01672abfb8bcd03":
                register_eog_score_component( "money_earned", 30 );
                break;
            case #"hash_5e69ee92f1cfc638":
                register_eog_score_component( "tickets_earned", 31 );
                break;
            case #"hash_6a34f4ff0b6dcbc7":
                register_eog_score_component( "consumables_earned", 32 );
                break;
            default:
                assertmsg( "'" + component_name + "' is not a supported end-of-game score component." );
                break;
        }
    }
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 1
// Checksum 0x0, Offset: 0x2cf
// Size: 0xd9
function init_encounter_score_components( var_bef62e0ad2260faf )
{
    level.encounter_score_components = [];
    
    foreach ( component_name in var_bef62e0ad2260faf )
    {
        switch ( component_name )
        {
            case #"hash_1cc8a923a608c2a0":
                init_damage_score_component();
                break;
            case #"hash_a01672abfb8bcd03":
                init_money_earned_score_component();
                break;
            case #"hash_5e69ee92f1cfc638":
                init_tickets_earned_score_component();
                break;
            case #"hash_6a34f4ff0b6dcbc7":
                init_consumables_earned_score_component();
                break;
            default:
                assertmsg( "'" + component_name + "' is not a supported round score component." );
                break;
        }
    }
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 0
// Checksum 0x0, Offset: 0x3b0
// Size: 0x29
function init_damage_score_component()
{
    register_encounter_score_component( "damage", &init_damage_score, &reset_team_damage_performance, &reset_player_damage_performance, &calculate_damage_score, 29, "damage" );
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 0
// Checksum 0x0, Offset: 0x3e1
// Size: 0x29
function init_money_earned_score_component()
{
    register_encounter_score_component( "money_earned", &init_money_earned_score, &reset_team_money_earned_performance, &reset_player_money_earned_performance, &calculate_money_earned_score, 30, "money_earned" );
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 0
// Checksum 0x0, Offset: 0x412
// Size: 0x29
function init_tickets_earned_score_component()
{
    register_encounter_score_component( "tickets_earned", &init_tickets_earned_score, &reset_team_tickets_earned_performance, &reset_player_tickets_earned_performance, &calculate_tickets_earned_score, 31, "tickets_earned" );
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 0
// Checksum 0x0, Offset: 0x443
// Size: 0x29
function init_consumables_earned_score_component()
{
    register_encounter_score_component( "consumables_earned", &init_consumables_earned_score, &reset_team_consumables_earned_performance, &reset_player_consumables_earned_performance, &calculate_consumables_earned_score, 32, "consumables_earned" );
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 1
// Checksum 0x0, Offset: 0x474
// Size: 0xc
function init_consumables_earned_score( var_41a9c90605002d6f )
{
    return var_41a9c90605002d6f;
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 1
// Checksum 0x0, Offset: 0x489
// Size: 0xc
function reset_team_consumables_earned_performance( var_41a9c90605002d6f )
{
    return var_41a9c90605002d6f;
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 1
// Checksum 0x0, Offset: 0x49e
// Size: 0x1e
function reset_player_consumables_earned_performance( player )
{
    player.encounter_performance[ "total_consumables_earned" ] = 0;
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 2
// Checksum 0x0, Offset: 0x4c4
// Size: 0x48
function calculate_consumables_earned_score( player, var_41a9c90605002d6f )
{
    var_8a33c022619d498c = get_player_encounter_performance( player, "total_consumables_earned" );
    var_9569b1b99abf90c6 = min( 50000, var_8a33c022619d498c * 10000 );
    return int( var_9569b1b99abf90c6 );
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 1
// Checksum 0x0, Offset: 0x515
// Size: 0xc
function init_tickets_earned_score( var_41a9c90605002d6f )
{
    return var_41a9c90605002d6f;
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 1
// Checksum 0x0, Offset: 0x52a
// Size: 0xc
function reset_team_tickets_earned_performance( var_41a9c90605002d6f )
{
    return var_41a9c90605002d6f;
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 1
// Checksum 0x0, Offset: 0x53f
// Size: 0x1e
function reset_player_tickets_earned_performance( player )
{
    player.encounter_performance[ "total_tickets_earned" ] = 0;
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 2
// Checksum 0x0, Offset: 0x565
// Size: 0x49
function calculate_tickets_earned_score( player, var_41a9c90605002d6f )
{
    var_78a8533212b63dc3 = get_player_encounter_performance( player, "total_tickets_earned" );
    var_26219ab0863d9d40 = min( 999999, var_78a8533212b63dc3 * 1 );
    return int( var_26219ab0863d9d40 );
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 1
// Checksum 0x0, Offset: 0x5b7
// Size: 0xc
function init_money_earned_score( var_41a9c90605002d6f )
{
    return var_41a9c90605002d6f;
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 1
// Checksum 0x0, Offset: 0x5cc
// Size: 0xc
function reset_team_money_earned_performance( var_41a9c90605002d6f )
{
    return var_41a9c90605002d6f;
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 1
// Checksum 0x0, Offset: 0x5e1
// Size: 0x1e
function reset_player_money_earned_performance( player )
{
    player.encounter_performance[ "total_money_earned" ] = 0;
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 2
// Checksum 0x0, Offset: 0x607
// Size: 0x49
function calculate_money_earned_score( player, var_41a9c90605002d6f )
{
    var_a97b8220053ab0e0 = get_player_encounter_performance( player, "total_money_earned" );
    var_387afe16b0c786af = min( 999999, var_a97b8220053ab0e0 * 1 );
    return int( var_387afe16b0c786af );
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 1
// Checksum 0x0, Offset: 0x659
// Size: 0xc
function init_damage_score( var_41a9c90605002d6f )
{
    return var_41a9c90605002d6f;
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 1
// Checksum 0x0, Offset: 0x66e
// Size: 0xc
function reset_team_damage_performance( var_41a9c90605002d6f )
{
    return var_41a9c90605002d6f;
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 1
// Checksum 0x0, Offset: 0x683
// Size: 0x1e
function reset_player_damage_performance( player )
{
    player.encounter_performance[ "damage_done_on_agent" ] = 0;
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 2
// Checksum 0x0, Offset: 0x6a9
// Size: 0x4c
function calculate_damage_score( player, var_41a9c90605002d6f )
{
    var_af7452d5c3c28da1 = get_player_encounter_performance( player, "damage_done_on_agent" );
    var_5665f99b8d71126a = min( 999999, var_af7452d5c3c28da1 * 0.2 );
    return int( var_5665f99b8d71126a );
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 3
// Checksum 0x0, Offset: 0x6fe
// Size: 0x51
function update_agent_damage_performance( eattacker, idamage, smeansofdeath )
{
    if ( smeansofdeath == "MOD_TRIGGER_HURT" )
    {
        return;
    }
    
    attacker_as_player = get_attacker_as_player( eattacker );
    
    if ( !isdefined( attacker_as_player ) )
    {
        return;
    }
    
    attacker_as_player update_personal_encounter_performance( "damage", "damage_done_on_agent", idamage );
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 2
// Checksum 0x0, Offset: 0x757
// Size: 0x26
function update_money_earned_performance( player, amount )
{
    player update_personal_encounter_performance( "money_earned", "total_money_earned", amount );
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 2
// Checksum 0x0, Offset: 0x785
// Size: 0x26
function update_tickets_earned_performance( player, amount )
{
    player update_personal_encounter_performance( "tickets_earned", "total_tickets_earned", amount );
}

// Namespace cp_core_gamescore / scripts\cp\cp_core_gamescore
// Params 1
// Checksum 0x0, Offset: 0x7b3
// Size: 0x26
function zombies_endgameencounterscorefunc( override )
{
    calculate_encounter_scores( level.players, [ "money_earned" ], override );
}

