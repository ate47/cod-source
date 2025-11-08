#using script_3ab210ea917601e7;
#using script_6617e2f2bb62b52b;

#namespace activity_scoring;

// Namespace activity_scoring / namespace_6a4776a9657ff96b
// Params 2
// Checksum 0x0, Offset: 0x98
// Size: 0x77
function function_4d4bdc081df1c06b( player, varianttag )
{
    if ( !isdefined( player.activities.highscores ) )
    {
        player.activities.highscores = [];
    }
    
    if ( !isdefined( player.activities.highscores[ varianttag ] ) )
    {
        player.activities.highscores[ varianttag ] = 0;
    }
}

// Namespace activity_scoring / namespace_6a4776a9657ff96b
// Params 1
// Checksum 0x0, Offset: 0x117
// Size: 0x4b
function updatescore( scorechange )
{
    self.score += scorechange;
    
    /#
        broadcast = function_ab07dddb2e50773b( "<dev string:x1c>" + self.score );
        function_2e44f2eaf470e806( broadcast );
    #/
}

// Namespace activity_scoring / namespace_6a4776a9657ff96b
// Params 1
// Checksum 0x0, Offset: 0x16a
// Size: 0x62, Type: bool
function function_580d48267e3509af( player )
{
    var_f3df5cfd2b12a463 = getscore();
    activityhighscore = getplayerhighscore( player, self.varianttag );
    
    if ( var_f3df5cfd2b12a463 > activityhighscore )
    {
        player.activities.highscores[ self.varianttag ] = var_f3df5cfd2b12a463;
        return true;
    }
    
    return false;
}

// Namespace activity_scoring / namespace_6a4776a9657ff96b
// Params 0
// Checksum 0x0, Offset: 0x1d5
// Size: 0xc
function resetscore()
{
    self.score = 0;
}

// Namespace activity_scoring / namespace_6a4776a9657ff96b
// Params 0
// Checksum 0x0, Offset: 0x1e9
// Size: 0xb
function getscore()
{
    return self.score;
}

// Namespace activity_scoring / namespace_6a4776a9657ff96b
// Params 2
// Checksum 0x0, Offset: 0x1fd
// Size: 0x2a
function getplayerhighscore( player, varianttag )
{
    return player.activities.highscores[ varianttag ];
}

/#

    // Namespace activity_scoring / namespace_6a4776a9657ff96b
    // Params 1
    // Checksum 0x0, Offset: 0x230
    // Size: 0x18, Type: dev
    function setscore( score )
    {
        self.score = score;
    }

    // Namespace activity_scoring / namespace_6a4776a9657ff96b
    // Params 1
    // Checksum 0x0, Offset: 0x250
    // Size: 0x23, Type: dev
    function broadcastscore( varianttag )
    {
        iprintln( "<dev string:x1c>" + self.score );
    }

#/
