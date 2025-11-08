#using script_47366beb5ba9fa22;
#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;

#namespace capture_flag;

// Namespace capture_flag / namespace_4c49d1b7e0800f5
// Params 0
// Checksum 0x0, Offset: 0xf5
// Size: 0xd
function function_eda57308516bfc5f()
{
    return function_bffb5b682a4ef6a2( &evaluatescore );
}

// Namespace capture_flag / namespace_4c49d1b7e0800f5
// Params 1
// Checksum 0x0, Offset: 0x10b
// Size: 0xb7
function evaluatescore( bot )
{
    domflag = undefined;
    
    if ( isdefined( self.var_13b45daa3e1c211a ) && bot.team != self.var_13b45daa3e1c211a scripts\mp\gameobjects::getownerteam() )
    {
        domflag = self.var_13b45daa3e1c211a;
    }
    else
    {
        self.var_13b45daa3e1c211a = undefined;
        domflags = bot namespace_45524b6bc7f1f3ac::getevent();
        
        if ( domflags.size <= 0 )
        {
            return 0;
        }
        
        domflag = function_2613aec5fa0a8620( domflags );
    }
    
    self.var_df9d35d9b4bee654 = createactionbase( "Capture Flag", domflag, "main", "", &actionprocess, self );
    return self.constants.basescore;
}

// Namespace capture_flag / namespace_4c49d1b7e0800f5
// Params 1
// Checksum 0x0, Offset: 0x1cb
// Size: 0xae
function function_2613aec5fa0a8620( domflags )
{
    weights = self.constants.var_563192eda3cf18c5;
    weightssize = min( weights.size, domflags.size );
    weightstotal = 0;
    
    for ( i = 0; i < weightssize ; i++ )
    {
        weightstotal += weights[ i ];
    }
    
    index = 0;
    var_77b777bd75db2ff0 = 0;
    weight = randomintrange( 0, weightstotal );
    
    while ( index < weightssize )
    {
        var_77b777bd75db2ff0 += weights[ index ];
        
        if ( weight < var_77b777bd75db2ff0 )
        {
            break;
        }
        
        index++;
    }
    
    return domflags[ index ];
}

// Namespace capture_flag / namespace_4c49d1b7e0800f5
// Params 1
// Checksum 0x0, Offset: 0x282
// Size: 0xee
function actionprocess( bot )
{
    assert( isdefined( self.argument ) );
    domflag = self.argument;
    self.decision.var_13b45daa3e1c211a = domflag;
    var_9920c1b439193f77 = 16;
    
    while ( bot.team != domflag scripts\mp\gameobjects::getownerteam() )
    {
        randompoint = function_6f7d8428f06122a7( domflag.curorigin, domflag.trigger.radius, domflag.trigger.height, var_9920c1b439193f77 );
        bot setscriptgoal( randompoint, var_9920c1b439193f77 );
        result = waittill_any_ents_or_timeout_return( 15, bot, "bad_path", bot, "long_path", bot, "goal" );
        
        if ( result == "goal" )
        {
            wait 1;
        }
    }
}

// Namespace capture_flag / namespace_4c49d1b7e0800f5
// Params 4
// Checksum 0x0, Offset: 0x378
// Size: 0xc6
function function_6f7d8428f06122a7( flagorigin, flagradius, flagheight, wanderradius )
{
    maxdistpercent = ( flagradius - wanderradius ) / flagradius;
    r = randomfloatrange( 0, flagradius * maxdistpercent );
    theta = randomfloat( 360 );
    offset = ( r * cos( theta ), r * sin( theta ), 0 );
    var_c1d1fc4d9d46438d = ( flagheight + 30 ) * -1;
    contents = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
    randompoint = scripts\engine\utility::drop_to_ground( flagorigin + offset, flagheight, var_c1d1fc4d9d46438d, undefined, contents );
    return getclosestpointonnavmesh( randompoint );
}

