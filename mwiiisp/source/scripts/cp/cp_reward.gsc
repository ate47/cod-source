#using scripts\common\utility;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\persistence;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace cp_reward;

// Namespace cp_reward / scripts\cp\cp_reward
// Params 2
// Checksum 0x0, Offset: 0xef
// Size: 0x36b
function give_attacker_kill_rewards( attacker, shitloc )
{
    if ( self.team == "allies" )
    {
        return;
    }
    
    if ( istrue( self.died_poorly ) )
    {
        return;
    }
    
    if ( scripts\cp\cp_agent_utils::get_agent_type( self ) == "elite" || scripts\cp\cp_agent_utils::get_agent_type( self ) == "mammoth" )
    {
        reward_point = get_reward_point_for_kill();
        
        foreach ( player in level.players )
        {
            givekillreward( player, reward_point, "large" );
        }
        
        return;
    }
    
    if ( isdefined( self.attacker_damage ) || isdefined( self.marked_by_hybrid ) )
    {
        if ( isdefined( self.marked_by_hybrid ) )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( self.player_who_tagged ) && self.player_who_tagged == player && player != attacker )
                {
                    var_c514d611c295eb = getassistbonusamount();
                    givekillreward( player, var_c514d611c295eb * 2 );
                    player scripts\cp\persistence::eog_player_update_stat( "assists", 1 );
                    self.hybrid_assist = 1;
                }
            }
        }
        
        if ( !isdefined( self.hybrid_assist ) )
        {
            var_a9a6e8c32b90ca45 = 0.1;
            var_8bb17efd6eb74e3d = self.maxhealth * var_a9a6e8c32b90ca45;
            var_c514d611c295eb = getassistbonusamount();
            
            foreach ( attacker_struct in self.attacker_damage )
            {
                if ( attacker_struct.player == attacker || isdefined( attacker.owner ) && attacker_struct.player == attacker.owner )
                {
                    continue;
                }
                
                if ( attacker_struct.damage >= var_8bb17efd6eb74e3d )
                {
                    if ( isdefined( attacker_struct.player ) && attacker_struct.player != attacker )
                    {
                        assertex( isplayer( attacker_struct.player ), "Tried to give non-player rewards" );
                        attacker_struct.player scripts\cp\persistence::eog_player_update_stat( "assists", 1 );
                        givekillreward( attacker_struct.player, var_c514d611c295eb );
                    }
                }
            }
        }
    }
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    if ( !isplayer( attacker ) && ( !isdefined( attacker.owner ) || !isplayer( attacker.owner ) ) )
    {
        return;
    }
    
    var_33242ca76a448f6b = 0;
    
    if ( isdefined( attacker.owner ) )
    {
        attacker = attacker.owner;
        var_33242ca76a448f6b = 1;
    }
    
    reward_point = get_reward_point_for_kill();
    
    if ( isdefined( shitloc ) && shitloc == "soft" && !var_33242ca76a448f6b )
    {
        reward_point = int( reward_point * 1.5 );
    }
    
    givekillreward( attacker, reward_point, "large", shitloc );
}

// Namespace cp_reward / scripts\cp\cp_reward
// Params 0
// Checksum 0x0, Offset: 0x462
// Size: 0x1f
function getassistbonusamount()
{
    return level.agent_definition[ scripts\cp\cp_agent_utils::get_agent_type( self ) ][ "reward" ] * 0.5;
}

// Namespace cp_reward / scripts\cp\cp_reward
// Params 0
// Checksum 0x0, Offset: 0x48a
// Size: 0x19
function get_reward_point_for_kill()
{
    return level.agent_definition[ scripts\cp\cp_agent_utils::get_agent_type( self ) ][ "reward" ];
}

// Namespace cp_reward / scripts\cp\cp_reward
// Params 4
// Checksum 0x0, Offset: 0x4ac
// Size: 0x8c
function givekillreward( attacker, amount, size, shitloc )
{
    currency_reward = amount;
    attacker scripts\cp\persistence::give_player_currency( currency_reward, size, shitloc );
    
    if ( isdefined( level.zombie_xp ) )
    {
        attacker scripts\cp\persistence::give_player_xp( int( currency_reward ) );
    }
    
    if ( scripts\engine\utility::flag_exist( "cortex_started" ) && scripts\engine\utility::flag( "cortex_started" ) )
    {
        if ( isdefined( level.add_cortex_charge_func ) )
        {
            [[ level.add_cortex_charge_func ]]( amount );
        }
    }
}

