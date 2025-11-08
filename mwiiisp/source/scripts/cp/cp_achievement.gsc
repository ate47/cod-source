#using scripts\common\utility;
#using scripts\engine\utility;

#namespace cp_achievement;

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 0
// Checksum 0x0, Offset: 0x18e
// Size: 0xb0
function register_default_achievements()
{
    register_achievement( "threestarbadsit", 1, &default_init, &default_should_update, &equal_to_goal );
    register_achievement( "threestarvehesc", 1, &default_init, &default_should_update, &equal_to_goal );
    register_achievement( "threestarobservatory", 1, &default_init, &default_should_update, &equal_to_goal );
    register_achievement( "noalarmbadsit", 1, &default_init, &default_should_update, &equal_to_goal );
    register_achievement( "onestarcp", 1, &default_init, &default_should_update, &equal_to_goal );
    register_achievement( "fullsse", 1, &default_init, &default_should_update, &equal_to_goal );
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 5
// Checksum 0x0, Offset: 0x246
// Size: 0x50
function register_achievement( reference, goal, init_func, should_update_func, is_goal_reached_func )
{
    achievement = spawnstruct();
    achievement [[ init_func ]]( goal, should_update_func, is_goal_reached_func );
    self.achievement_list[ reference ] = achievement;
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 3
// Checksum 0x0, Offset: 0x29e
// Size: 0x4d
function default_init( goal, should_update_func, is_goal_reached_func )
{
    self.progress = 0;
    self.goal = goal;
    self.should_update_func = should_update_func;
    self.is_goal_reached_func = is_goal_reached_func;
    self.achievement_completed = 0;
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 10
// Checksum 0x0, Offset: 0x2f3
// Size: 0x66
function default_should_update( player, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9, unused_10 )
{
    if ( !player are_achievements_allowed() )
    {
        return 0;
    }
    
    return 1;
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 1
// Checksum 0x0, Offset: 0x361
// Size: 0x1f
function update_progress( progress_amount )
{
    self.progress += progress_amount;
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 0
// Checksum 0x0, Offset: 0x388
// Size: 0x15, Type: bool
function at_least_goal()
{
    return self.progress >= self.goal;
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 1
// Checksum 0x0, Offset: 0x3a6
// Size: 0x1e, Type: bool
function equal_to_goal( player )
{
    return self.progress == self.goal;
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 0
// Checksum 0x0, Offset: 0x3cd
// Size: 0xb
function is_completed()
{
    return self.achievement_completed;
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 0
// Checksum 0x0, Offset: 0x3e1
// Size: 0xd
function mark_completed()
{
    self.achievement_completed = 1;
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 1
// Checksum 0x0, Offset: 0x3f6
// Size: 0xd, Type: bool
function is_valid_achievement( achievement )
{
    return isdefined( achievement );
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 1
// Checksum 0x0, Offset: 0x40c
// Size: 0x79
function init_player_achievements( player )
{
    if ( isdefined( level.script ) )
    {
        player.achievement_list = [ "threestarbadsit", "threestarvehesc", "threestarobservatory", "noalarmbadsit", "onestarcp", "fullsse" ];
    }
    
    if ( isdefined( player.achievement_registration_func ) )
    {
        player [[ player.achievement_registration_func ]]();
    }
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 12
// Checksum 0x0, Offset: 0x48d
// Size: 0x103
function update_achievement( reference, progress_amt, param_1, param_2, param_3, param_4, param_5, param_6, param_7, param_8, param_9, param_10 )
{
    achievement = self.achievement_list[ reference ];
    
    if ( !is_valid_achievement( achievement ) )
    {
        return;
    }
    
    if ( achievement is_completed() )
    {
        return;
    }
    
    if ( achievement [[ achievement.should_update_func ]]( self, param_2, param_3, param_4, param_5, param_6, param_7, param_8, param_9, param_10 ) )
    {
        achievement update_progress( progress_amt );
        
        if ( achievement [[ achievement.is_goal_reached_func ]]( self ) )
        {
            /#
                self iprintlnbold( "<dev string:x1c>" + reference );
            #/
            
            self giveachievement( reference );
            self setplayerdata( "cp", "tacOpsAchievements", reference, 1 );
            achievement mark_completed();
        }
    }
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 2
// Checksum 0x0, Offset: 0x598
// Size: 0x66
function update_achievement_all_players( reference, progress_amt )
{
    foreach ( player in level.players )
    {
        player update_achievement( reference, progress_amt );
    }
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 0
// Checksum 0x0, Offset: 0x606
// Size: 0x3c, Type: bool
function are_achievements_allowed()
{
    if ( !isdefined( self.spawntimestamp ) )
    {
        return true;
    }
    
    if ( !isdefined( level.blockachievementstimestamp ) )
    {
        return true;
    }
    
    if ( level.blockachievementstimestamp > self.spawntimestamp )
    {
        return false;
    }
    
    return true;
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 0
// Checksum 0x0, Offset: 0x64b
// Size: 0x10
function set_achievements_blocker()
{
    level.blockachievementstimestamp = gettime();
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 0
// Checksum 0x0, Offset: 0x663
// Size: 0x1d
function function_ee76c2b537f53629()
{
    if ( !istrue( game[ "stealth_was_broken" ] ) )
    {
        level thread update_achievement_all_players( "noalarmbadsit", 1 );
    }
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 0
// Checksum 0x0, Offset: 0x688
// Size: 0x10
function function_5979446ee216f232()
{
    update_achievement( "fullsse", 1 );
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 0
// Checksum 0x0, Offset: 0x6a0
// Size: 0x12
function function_42ae9dfc72534d75()
{
    level thread update_achievement_all_players( "onestarcp", 1 );
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 0
// Checksum 0x0, Offset: 0x6ba
// Size: 0x80
function function_57b06ac64f28dc4a()
{
    switch ( level.script )
    {
        case #"hash_d9c138fad5b09bff":
            level thread update_achievement_all_players( "threestarbadsit", 1 );
            break;
        case #"hash_e7978e13d7ba3321":
            if ( istrue( level.var_5f694efafeb95d7 ) )
            {
            }
            else
            {
                level thread update_achievement_all_players( "threestarvehesc", 1 );
            }
            
            break;
        case #"hash_fac4357bd021125d":
            level thread update_achievement_all_players( "threestarobservatory", 1 );
            break;
    }
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 1
// Checksum 0x0, Offset: 0x742
// Size: 0x60
function trapachievementboom( player )
{
    var_59e88214927ce64e = player getplayerdata( "cp", "cpCommonAchievements", "boom" );
    
    if ( var_59e88214927ce64e > 3 )
    {
        return;
    }
    
    var_59e88214927ce64e++;
    player setplayerdata( "cp", "cpCommonAchievements", "boom", var_59e88214927ce64e );
    
    if ( var_59e88214927ce64e >= 3 )
    {
        player giveachievement( "boom" );
    }
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 0
// Checksum 0x0, Offset: 0x7aa
// Size: 0xee
function function_4d0a3cba9de1db93()
{
    var_bbc24b1f18a9a23a = 3;
    var_1a2abcea976d90af = self getplayerdata( "cp", "cpCommonAchievements", "wallofduty" );
    
    if ( !isdefined( var_1a2abcea976d90af ) )
    {
        var_1a2abcea976d90af = 0;
        self setplayerdata( "cp", "cpCommonAchievements", "wallofduty", var_1a2abcea976d90af );
    }
    
    if ( var_1a2abcea976d90af >= var_bbc24b1f18a9a23a )
    {
        return;
    }
    
    while ( var_1a2abcea976d90af < var_bbc24b1f18a9a23a )
    {
        level waittill( "ai_killed", vpos, sweapon, smeansofdeath, eattacker );
        
        if ( isdefined( eattacker ) && eattacker == self )
        {
            if ( isdefined( sweapon ) && isdefined( sweapon.type ) && sweapon.type == "riotshield" )
            {
                var_1a2abcea976d90af++;
                self setplayerdata( "cp", "cpCommonAchievements", "wallofduty", var_1a2abcea976d90af );
            }
        }
    }
    
    self giveachievement( "wallofduty" );
}

// Namespace cp_achievement / scripts\cp\cp_achievement
// Params 1
// Checksum 0x0, Offset: 0x8a0
// Size: 0x46
function function_1798ae18b940195a( objweapon )
{
    if ( isdefined( objweapon ) && ( objweapon.basename == "toma_proj_mp" || objweapon.basename == "toma_proj_jup_mp" ) )
    {
        self function_6a369480dbaf1090( "jup_sp_thatsonewaytodoit" );
    }
}

