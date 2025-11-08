#using script_22594d942a4f2fa9;
#using script_40e63dd222434655;
#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_br;
#using scripts\mp\bots\bots_util;

#namespace search_threat;

// Namespace search_threat / namespace_f579db4f1fdf0250
// Params 0
// Checksum 0x0, Offset: 0xf1
// Size: 0xd
function function_eda57308516bfc5f()
{
    return function_bffb5b682a4ef6a2( &evaluatescore );
}

// Namespace search_threat / namespace_f579db4f1fdf0250
// Params 1
// Checksum 0x0, Offset: 0x107
// Size: 0x1cb
function evaluatescore( bot )
{
    finalscore = -100;
    target = undefined;
    var_3a689e7b1e721c9d = bot namespace_e3ef90d32ac66277::getevent();
    
    foreach ( entnum, lastview in var_3a689e7b1e721c9d )
    {
        if ( !lastview.valid )
        {
            continue;
        }
        
        if ( !scripts\mp\bots\bots_gametype_br::ispointincurrentcircle( lastview.origin ) )
        {
            continue;
        }
        
        /#
            if ( getdvar( @"bot_notarget" ) == "<dev string:x1c>" )
            {
                targetplayer = getentbynum( entnum );
                
                if ( function_40034c2faf09a87b( targetplayer ) )
                {
                    continue;
                }
            }
        #/
        
        dist = distance( lastview.origin, bot.origin );
        score = function_9d1ab012058221bb( dist, self.constants.var_96af88c97db9ed21, self.constants.var_7d7f72df5616d9e8 );
        time = gettime() - lastview.time;
        score += function_9d1ab012058221bb( time, self.constants.var_d114ba8784fcab24, self.constants.var_bf755758ae9ab4ed );
        
        if ( score > finalscore )
        {
            target = lastview;
            finalscore = score;
        }
    }
    
    if ( !isdefined( target ) )
    {
        return finalscore;
    }
    
    self.var_df9d35d9b4bee654 = createactionbase( "Search Threat", target, "main", "$e" + target.entnum, &actionprocess, self );
    return finalscore;
}

// Namespace search_threat / namespace_f579db4f1fdf0250
// Params 1
// Checksum 0x0, Offset: 0x2db
// Size: 0xfd
function actionprocess( bot )
{
    target = self.argument;
    assert( isdefined( target ) );
    
    while ( true )
    {
        targetpos = function_f8350ab882cc2439( target.origin );
        bot setscriptgoal( targetpos, 64 );
        result = bot waittill_any_in_array_or_timeout( [ "goal", "bad_path" ], 1 );
        
        if ( result == "goal" )
        {
            bot namespace_e3ef90d32ac66277::invalidateentry( target.entnum );
            break;
        }
        
        if ( result == "bad_path" )
        {
            println( "<dev string:x2d>" + self.decision.name + "<dev string:x47>" + targetpos + "<dev string:x60>" + bot.origin );
            bot namespace_e3ef90d32ac66277::invalidateentry( target.entnum );
            return result;
        }
    }
}

