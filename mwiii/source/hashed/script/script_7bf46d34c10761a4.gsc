#using script_47366beb5ba9fa22;
#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_common;

#namespace capture_hardpoint;

// Namespace capture_hardpoint / namespace_ef3d9df38f736e0
// Params 0
// Checksum 0x0, Offset: 0x107
// Size: 0xd
function function_eda57308516bfc5f()
{
    return function_bffb5b682a4ef6a2( &evaluatescore );
}

// Namespace capture_hardpoint / namespace_ef3d9df38f736e0
// Params 1
// Checksum 0x0, Offset: 0x11d
// Size: 0x131
function evaluatescore( bot )
{
    currenthardpoint = bot namespace_45524b6bc7f1f3ac::getevent()[ 0 ];
    var_6f378a329663705a = currenthardpoint.numtouching[ bot.team ];
    var_b5aeb4a2ae3657fd = ( level.var_a18063a06c258143 - gettime() ) / 1000;
    finalscore = self.constants.basescore;
    finalscore += function_9d1ab012058221bb( var_b5aeb4a2ae3657fd, self.constants.var_50cf5a797d61ae47, self.constants.var_f65cad93a3671678 );
    finalscore += self.constants.teammatemodifier[ var_6f378a329663705a ];
    finalhardpoint = currenthardpoint;
    
    if ( finalscore < self.constants.var_cc2f39e2d76f6b7d )
    {
        finalscore = self.constants.var_cc2f39e2d76f6b7d;
        finalhardpoint = namespace_45524b6bc7f1f3ac::function_b4e30a9548aa351b();
    }
    
    self.var_df9d35d9b4bee654 = createactionbase( "Capture Flag", finalhardpoint, "main", finalhardpoint.objectivekey, &actionprocess, self );
    return finalscore;
}

// Namespace capture_hardpoint / namespace_ef3d9df38f736e0
// Params 1
// Checksum 0x0, Offset: 0x257
// Size: 0xae
function actionprocess( bot )
{
    assert( isdefined( self.argument ) );
    targethardpoint = self.argument;
    var_9920c1b439193f77 = 10;
    nodes = function_62f98fd3d37278dc( targethardpoint );
    
    while ( true )
    {
        nodepoint = array_random( nodes );
        bot setscriptgoal( nodepoint.origin, var_9920c1b439193f77 );
        result = waittill_any_ents_or_timeout_return( 15, bot, "bad_path", bot, "long_path", bot, "goal" );
        
        if ( result == "goal" )
        {
            wait 1;
        }
    }
}

// Namespace capture_hardpoint / namespace_ef3d9df38f736e0
// Params 2
// Checksum 0x0, Offset: 0x30d
// Size: 0x130
function function_62f98fd3d37278dc( targethardpoint, allowempty )
{
    nodes = [];
    
    if ( isdefined( targethardpoint.trigger ) )
    {
        if ( !isdefined( targethardpoint.nodes ) )
        {
            nodes = scripts\mp\bots\bots_gametype_common::bot_get_valid_nodes_in_trigger( targethardpoint.trigger );
        }
        
        if ( nodes.size <= 0 && isdefined( targethardpoint.trigger.target ) )
        {
            target = targethardpoint.trigger.target;
            possibleents = getentarray( "script_origin", "classname" );
            
            if ( isdefined( possibleents ) )
            {
                foreach ( ent in possibleents )
                {
                    if ( isdefined( ent.targetname ) && ent.targetname == target )
                    {
                        nodes[ nodes.size ] = ent;
                    }
                }
            }
        }
    }
    
    if ( !istrue( allowempty ) )
    {
        assertex( nodes.size > 0, "<dev string:x1c>" );
    }
    
    return nodes;
}

