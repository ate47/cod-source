#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_champion_task;
#using scripts\mp\gametypes\br_pickups;

#namespace namespace_90161fde3c96091c;

// Namespace namespace_90161fde3c96091c / namespace_fd6c84ecada320b
// Params 0
// Checksum 0x0, Offset: 0x166
// Size: 0x2e
function inittask()
{
    function_ac97a4f2ab8c2d53( "kfe", "tryAssignTask", &function_36f7c6b5bf8ad6f4 );
    function_ac97a4f2ab8c2d53( "kfe", "tryBindObjective", &trybindobjective );
}

// Namespace namespace_90161fde3c96091c / namespace_fd6c84ecada320b
// Params 1
// Checksum 0x0, Offset: 0x19c
// Size: 0x3c
function function_36f7c6b5bf8ad6f4( taskinstance )
{
    flag = function_87e60ed6830d13bc( taskinstance.info.subcategory );
    thread function_cf75ac38fdbda3f6( taskinstance, flag );
}

// Namespace namespace_90161fde3c96091c / namespace_fd6c84ecada320b
// Params 1
// Checksum 0x0, Offset: 0x1e0
// Size: 0x58
function function_87e60ed6830d13bc( subcategory )
{
    switch ( subcategory )
    {
        case #"hash_9593e481c78bc405":
            return "fieldUpgrade_used_";
        case #"hash_93c71e7b6c0b81d7":
            return "equipment_used_";
        case #"hash_1cac65e1b8bf24a7":
            return "killstreak_used_";
        default:
            return undefined;
    }
}

// Namespace namespace_90161fde3c96091c / namespace_fd6c84ecada320b
// Params 2
// Checksum 0x0, Offset: 0x240
// Size: 0x92
function function_cf75ac38fdbda3f6( taskinstance, flag )
{
    level endon( "game_ended" );
    taskinstance endon( "task_end" );
    
    while ( true )
    {
        level waittill( flag + taskinstance.team, itemname );
        
        if ( isdefined( itemname ) && ( itemname == taskinstance.info.ref || issubstr( taskinstance.info.ref, "any" ) ) )
        {
            function_89b8bce3baa45edc( taskinstance, 1 );
        }
    }
}

// Namespace namespace_90161fde3c96091c / namespace_fd6c84ecada320b
// Params 2
// Checksum 0x0, Offset: 0x2da
// Size: 0x158
function function_59c1dbdc2ad03ad6( taskinstance, loot )
{
    partname = loot function_ec5f4851431f3382();
    state = loot getscriptablepartstate( partname, 1 );
    
    if ( !isdefined( state ) || state == "hidden" )
    {
        return 0;
    }
    
    if ( isdefined( self.pickupitem ) && self.pickupitem == loot )
    {
        return 0;
    }
    
    scriptablename = scripts\mp\gametypes\br_pickups::lootgetscriptablename( loot );
    
    if ( !isdefined( scriptablename ) )
    {
        return 0;
    }
    
    lootref = level.br_pickups.var_14bd11727c4b6629[ scriptablename ];
    
    if ( isdefined( lootref ) && lootref == taskinstance.info.ref )
    {
        return 1;
    }
    
    if ( issubstr( taskinstance.info.ref, "any" ) )
    {
        switch ( taskinstance.info.subcategory )
        {
            case #"hash_9593e481c78bc405":
                return scripts\mp\gametypes\br_pickups::issuperpickup( scriptablename );
            case #"hash_93c71e7b6c0b81d7":
                return ( scripts\mp\gametypes\br_pickups::function_b989edd9af4f42c7( scriptablename ) || scripts\mp\gametypes\br_pickups::function_d7c5786a0c42ef6c( scriptablename ) );
            case #"hash_1cac65e1b8bf24a7":
                return scripts\mp\gametypes\br_pickups::iskillstreak( scriptablename );
            default:
                return 0;
        }
    }
    
    return 0;
}

// Namespace namespace_90161fde3c96091c / namespace_fd6c84ecada320b
// Params 1
// Checksum 0x0, Offset: 0x43b
// Size: 0x38
function trybindobjective( taskinstance )
{
    items = getlootscriptablearrayinradius( undefined, undefined, self.origin, 20000 );
    function_2e55101ffd0d483c( taskinstance, items, &function_59c1dbdc2ad03ad6 );
}

