#using scripts\mp\gametypes\br_rewards;

#namespace namespace_f12bb34d03822f82;

// Namespace namespace_f12bb34d03822f82 / namespace_d4c274f52daa4e49
// Params 3
// Checksum 0x0, Offset: 0x108
// Size: 0x56
function function_80e9e5ae4de38d22( player, position, callback )
{
    var_c46075dfa7ca36d4 = scripts\mp\gametypes\br_rewards::getdropbagspawntypeenum( 0, 0, 0, 0, 0, 1 );
    player scripts\mp\gametypes\br_rewards::spawndropbagatposition( position, var_c46075dfa7ca36d4 );
    level thread scripts\mp\gametypes\br_rewards::managedropbags();
    
    if ( isdefined( callback ) )
    {
        player thread function_9f43fc17ca294d1b( callback );
    }
}

// Namespace namespace_f12bb34d03822f82 / namespace_d4c274f52daa4e49
// Params 0
// Checksum 0x0, Offset: 0x166
// Size: 0x15
function function_83964876b5d39a1e()
{
    return level.br_pickups.crates;
}

// Namespace namespace_f12bb34d03822f82 / namespace_d4c274f52daa4e49
// Params 1
// Checksum 0x0, Offset: 0x184
// Size: 0x49
function function_4ae36036bf751abe( callback )
{
    self endon( "death_or_disconnect" );
    
    while ( true )
    {
        self waittill( "luinotifyserver", channel, class );
        
        if ( channel == "open_loadout_bag" )
        {
            self [[ callback ]]();
            return;
        }
        
        waitframe();
    }
}

// Namespace namespace_f12bb34d03822f82 / namespace_d4c274f52daa4e49
// Params 1
// Checksum 0x0, Offset: 0x1d5
// Size: 0x5f
function function_43a9b7793648c22a( callback )
{
    self endon( "death_or_disconnect" );
    
    while ( true )
    {
        self waittill( "luinotifyserver", channel, class );
        
        if ( channel == "exit_loadout_bag" )
        {
            self [[ callback ]]( -1 );
            return;
        }
        else if ( channel == "class_select" )
        {
            self [[ callback ]]( class );
            return;
        }
        
        waitframe();
    }
}

// Namespace namespace_f12bb34d03822f82 / namespace_d4c274f52daa4e49
// Params 1
// Checksum 0x0, Offset: 0x23c
// Size: 0x9d
function function_9f43fc17ca294d1b( callback )
{
    self endon( "death" );
    self endon( "disconnect" );
    
    for ( originalcratecount = level.br_pickups.crates.size; originalcratecount == level.br_pickups.crates.size ; originalcratecount = level.br_pickups.crates.size )
    {
        waitframe();
        
        if ( level.br_pickups.crates.size < originalcratecount )
        {
        }
    }
    
    self [[ callback ]]( level.br_pickups.crates );
}

