#using scripts\anim\dialogue;
#using scripts\cp\laststand;
#using scripts\engine\utility;

#namespace namespace_720324fc2825f6b9;

// Namespace namespace_720324fc2825f6b9 / namespace_d3c2a7ff4bcf34e0
// Params 5
// Checksum 0x0, Offset: 0xfa
// Size: 0x3e9
function function_8e12a06df7f7b5a6( worldstate, stopflag, var_16b772b16d97af4b, var_e852b681bf0fbfc0, var_8de67ca83b99be42 )
{
    assertex( isdefined( level.var_f740dcfe6d515900 ) && isdefined( level.var_c7fdcd075be6fa67 ) && isdefined( level.var_a9016d2b6b364c4d ) && isdefined( level.var_7467bfae31bc08ed ) && isdefined( level.investigate_deck ), "One or more decks are not defined." );
    var_ed1e225d2f4e55c9 = "none";
    
    while ( !utility::flag( stopflag ) )
    {
        if ( isdefined( var_8de67ca83b99be42 ) && [[ var_8de67ca83b99be42 ]]() )
        {
            return;
        }
        
        closest_site = [[ var_16b772b16d97af4b ]]();
        
        if ( distancesquared( closest_site.origin, self.origin ) < 22500 || [[ var_e852b681bf0fbfc0 ]]() || scripts\cp\laststand::player_in_laststand( self ) )
        {
            wait 1;
            continue;
        }
        
        if ( worldstate == "hidden" && getstealthdetectstate() == "spotted" || worldstate == "spotted" && getstealthdetectstate() == "hidden" )
        {
            worldstate = getstealthdetectstate();
            
            switch ( worldstate )
            {
                case #"hash_61f1a95d6bf95699":
                    wait 1;
                    
                    if ( getstealthdetectstate() == "hidden" && !flag( "vo_hidden_said" ) )
                    {
                        if ( stealthgetanyaiinhunt() && var_ed1e225d2f4e55c9 != "hunt" )
                        {
                            flag_set( "vo_hidden_said" );
                            said = function_705b9bbd3a47d1e6( level.var_f740dcfe6d515900 deck_draw(), 0.4, 4, 0, 0.3 );
                            
                            if ( istrue( said ) )
                            {
                                var_ed1e225d2f4e55c9 = "hunt";
                            }
                        }
                        else if ( getstealthdetectstate() == "hidden" && !stealthgetanyaiininvestigate() && var_ed1e225d2f4e55c9 != "clear" )
                        {
                            flag_set( "vo_hidden_said" );
                            said = function_705b9bbd3a47d1e6( level.var_c7fdcd075be6fa67 deck_draw(), 0.4, 4, 0, 0.3 );
                            
                            if ( istrue( said ) )
                            {
                                var_ed1e225d2f4e55c9 = "clear";
                            }
                        }
                        
                        wait 1;
                    }
                    else
                    {
                        worldstate = getstealthdetectstate();
                    }
                    
                    flag_clear_delayed( "vo_hidden_said", 1 );
                    break;
                case #"hash_7ba904b9ea76ffca":
                    wait 1;
                    
                    if ( getstealthdetectstate() == "spotted" && !flag( "vo_alert_said" ) )
                    {
                        if ( stealthgetanyaiincombat() && var_ed1e225d2f4e55c9 != "combat" && function_14a67b26aa91919( 3 ) > 1 )
                        {
                            flag_set( "vo_alert_said" );
                            said = function_705b9bbd3a47d1e6( level.var_a9016d2b6b364c4d deck_draw(), 0.4, 3, 0, 0.2 );
                            
                            if ( self isswimming() )
                            {
                                function_705b9bbd3a47d1e6( level.var_7467bfae31bc08ed deck_draw(), 0.4, 4, 0, 0.6 );
                            }
                            
                            if ( istrue( said ) )
                            {
                                var_ed1e225d2f4e55c9 = "combat";
                            }
                        }
                        else if ( !stealthgetanyaiincombat() && stealthgetanyaiinhunt() && var_ed1e225d2f4e55c9 != "hunt" && function_14a67b26aa91919( 2 ) > 1 )
                        {
                            flag_set( "vo_alert_said" );
                            said = function_705b9bbd3a47d1e6( level.var_f740dcfe6d515900 deck_draw(), 0.4, 4, 0, 0.3 );
                            
                            if ( istrue( said ) )
                            {
                                var_ed1e225d2f4e55c9 = "hunt";
                            }
                        }
                        else if ( !stealthgetanyaiincombat() && !stealthgetanyaiinhunt() && stealthgetanyaiininvestigate() && var_ed1e225d2f4e55c9 != "investigate_up" && function_14a67b26aa91919( 1 ) > 1 )
                        {
                            flag_set( "vo_alert_said" );
                            said = function_705b9bbd3a47d1e6( level.investigate_deck deck_draw(), 0.4, 4, 0, 0.3 );
                            
                            if ( istrue( said ) )
                            {
                                var_ed1e225d2f4e55c9 = "investigate_up";
                            }
                        }
                        
                        wait 1;
                    }
                    else
                    {
                        worldstate = getstealthdetectstate();
                    }
                    
                    flag_clear( "vo_alert_said" );
                    break;
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_720324fc2825f6b9 / namespace_d3c2a7ff4bcf34e0
// Params 5
// Checksum 0x0, Offset: 0x4eb
// Size: 0x42
function function_705b9bbd3a47d1e6( alias, priority, timeout, overlap, delay )
{
    played = say_team( alias, priority, timeout, overlap, delay );
    return played;
}

// Namespace namespace_720324fc2825f6b9 / namespace_d3c2a7ff4bcf34e0
// Params 2
// Checksum 0x0, Offset: 0x536
// Size: 0x1d
function flag_clear_delayed( message, delay )
{
    wait delay;
    flag_clear( message );
}

// Namespace namespace_720324fc2825f6b9 / namespace_d3c2a7ff4bcf34e0
// Params 1
// Checksum 0x0, Offset: 0x55b
// Size: 0xa9
function function_14a67b26aa91919( state )
{
    ai_array = getaiarray( "axis" );
    ai_array = array_removedead_or_dying( ai_array );
    count = 0;
    
    foreach ( ai in ai_array )
    {
        if ( isdefined( ai.stealth ) && isdefined( ai.stealth_bsmstate ) )
        {
            if ( ai.stealth_bsmstate == state )
            {
                count++;
            }
        }
    }
    
    return count;
}

