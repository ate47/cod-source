#namespace namespace_712ed31f24d3b469;

// Namespace namespace_712ed31f24d3b469 / namespace_1bc2e7966ef15029
// Params 0
// Checksum 0x0, Offset: 0x73
// Size: 0x15
function init()
{
    level.var_1569f12089147662 = [];
    level thread ongameended();
}

// Namespace namespace_712ed31f24d3b469 / namespace_1bc2e7966ef15029
// Params 1
// Checksum 0x0, Offset: 0x90
// Size: 0x21
function function_7a894394e9924dc6( callback )
{
    level.var_1569f12089147662[ level.var_1569f12089147662.size ] = callback;
}

// Namespace namespace_712ed31f24d3b469 / namespace_1bc2e7966ef15029
// Params 0
// Checksum 0x0, Offset: 0xb9
// Size: 0x59
function ongameended()
{
    level waittill( "game_ended" );
    
    foreach ( callback in level.var_1569f12089147662 )
    {
        level thread [[ callback ]]();
    }
}

