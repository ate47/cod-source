#using script_59ff79d681bb860c;
#using script_7845ba34dcf9b77b;
#using script_d74ae0b4aa21186;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_circle;

#namespace control_fob;

// Namespace control_fob / namespace_3c545500807c3c91
// Params 0
// Checksum 0x0, Offset: 0x108
// Size: 0xd
function function_eda57308516bfc5f()
{
    return function_bffb5b682a4ef6a2( &evaluatescore );
}

// Namespace control_fob / namespace_3c545500807c3c91
// Params 1
// Checksum 0x0, Offset: 0x11e
// Size: 0x20e
function evaluatescore( bot )
{
    finalscore = 0;
    target = undefined;
    fobs = bot namespace_ba8cfebbc70bb00b::getevent();
    
    foreach ( fob in fobs )
    {
        var_f4f69da7307e230d = fob.trigger.gameobject;
        distancetobot = distance( var_f4f69da7307e230d.origin, bot.origin );
        basescore = function_9d1ab012058221bb( distancetobot, self.constants.var_96af88c97db9ed21, self.constants.var_49e2976ca0c853ef );
        captureprogress = var_f4f69da7307e230d scripts\mp\gameobjects::getcaptureprogress();
        
        if ( bot.team != var_f4f69da7307e230d scripts\mp\gameobjects::getownerteam() )
        {
            progressmultiplier = function_9d1ab012058221bb( captureprogress, self.constants.var_ec6070e1ebb11843, self.constants.var_7fef69cec64a3cf4 );
        }
        else
        {
            progressmultiplier = function_9d1ab012058221bb( captureprogress, self.constants.var_ec6070e1ebb11843, self.constants.var_2348961fb298f28 );
        }
        
        score = basescore * progressmultiplier;
        score += function_4e58bf49977d1bfd( fob.name );
        
        if ( score > finalscore )
        {
            finalscore = score;
            target = fob.name;
        }
    }
    
    if ( isdefined( target ) )
    {
        self.var_df9d35d9b4bee654 = createactionbase( "control_fob", target, "main", target, &actionprocess, self, undefined, self.constants.var_57228f75b014a7b8, self.constants.var_daec6fd98c7cee50 );
    }
    
    return finalscore;
}

// Namespace control_fob / namespace_3c545500807c3c91
// Params 1
// Checksum 0x0, Offset: 0x335
// Size: 0x105
function actionprocess( bot )
{
    var_27a1a1e9bd5f40f0 = self.argument;
    destination = array_random( scripts\cp_mp\utility\game_utility::getlocalestructarray( var_27a1a1e9bd5f40f0 + "_bot" ) );
    randompoint = scripts\mp\gametypes\br_circle::getrandompointincircle( destination.origin, destination.radius, undefined, undefined, 1, 1, undefined, undefined );
    bot setscriptgoal( randompoint, 32 );
    result = undefined;
    timeout = gettime() + 20000;
    
    while ( gettime() < timeout )
    {
        bot botpressbutton( "sprint", 1 );
        result = bot waittill_any_in_array_or_timeout( [ "goal", "bad_path" ], 1 );
        
        if ( result == "goal" )
        {
            /#
                function_f3cf203834e48c6d( "<dev string:x1c>" );
            #/
            
            wait randomfloatrange( 1, 2.5 );
            break;
        }
        
        if ( result != "timeout" )
        {
            return result;
        }
    }
}

