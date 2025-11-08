#using script_443d99fe707f1d9f;
#using scripts\common\callbacks;
#using scripts\cp_mp\laststand;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;

#namespace namespace_2bf4cd4dfd211422;

// Namespace namespace_2bf4cd4dfd211422 / namespace_c3e26060241fb8a2
// Params 0
// Checksum 0x0, Offset: 0xf5
// Size: 0x39
function function_2c48f8f076e75751()
{
    function_900f562c61c6a5d6( "revive", &use_revive, &function_1e669ec449acd66c, &function_1e669ec449acd66c, &function_42d4f1d48695f537, &function_13eca89b22129fbd );
    level callback::add( "player_revived", &on_revived );
}

// Namespace namespace_2bf4cd4dfd211422 / namespace_c3e26060241fb8a2
// Params 1
// Checksum 0x0, Offset: 0x136
// Size: 0xe4
function on_revived( params )
{
    if ( isdefined( params.reviver ) && self == params.reviver && inventory_isenabled() )
    {
        for ( backpackindex = 0; backpackindex < function_1b35b10884bd8d67() ; backpackindex++ )
        {
            lootid = function_d870b2c45335bd88( backpackindex );
            quantity = function_5ce7fe3dca9c1a22( backpackindex );
            
            if ( isdefined( lootid ) && lootid > 0 )
            {
                itembundlename = function_fc925a153c7fd55c( lootid );
                itembundle = getscriptbundle( "itemspawnentry:" + itembundlename );
                
                if ( itembundle.type == "revive" )
                {
                    for ( i = 0; i < quantity ; i++ )
                    {
                        if ( scripts\cp_mp\laststand::function_85bcfa7d00b8bb6b() )
                        {
                            function_777092be5abab355( backpackindex );
                        }
                    }
                }
            }
        }
    }
}

// Namespace namespace_2bf4cd4dfd211422 / namespace_c3e26060241fb8a2
// Params 4
// Checksum 0x0, Offset: 0x222
// Size: 0x30, Type: bool
function function_1e669ec449acd66c( itembundle, item, autouse, allowswap )
{
    if ( scripts\cp_mp\laststand::function_85bcfa7d00b8bb6b() )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2bf4cd4dfd211422 / namespace_c3e26060241fb8a2
// Params 3
// Checksum 0x0, Offset: 0x25b
// Size: 0x7b
function use_revive( itembundle, item, auto_use )
{
    var_21db2712e6d4ecc7 = item.count;
    
    for ( i = 0; i < item.count ; i++ )
    {
        if ( scripts\cp_mp\laststand::function_546201bb34cf36ce() < level.gametypebundle.var_4f29dbd56f01de57 )
        {
            scripts\cp_mp\laststand::function_7eba90a4d2ef6d6f();
            var_21db2712e6d4ecc7--;
        }
    }
    
    return var_21db2712e6d4ecc7;
}

// Namespace namespace_2bf4cd4dfd211422 / namespace_c3e26060241fb8a2
// Params 0
// Checksum 0x0, Offset: 0x2df
// Size: 0x55
function function_42d4f1d48695f537()
{
    itembundle = undefined;
    quantity = 0;
    itembundlename = function_61d960957fcf3ca0( "brloot_self_revive" );
    
    if ( isdefined( itembundlename ) )
    {
        itembundle = getscriptbundle( "itemspawnentry:" + itembundlename );
        quantity = scripts\cp_mp\laststand::function_546201bb34cf36ce();
    }
    
    return [ itembundle, quantity ];
}

// Namespace namespace_2bf4cd4dfd211422 / namespace_c3e26060241fb8a2
// Params 0
// Checksum 0x0, Offset: 0x33d
// Size: 0x9
function function_13eca89b22129fbd()
{
    scripts\cp_mp\laststand::function_d7827c7865b2089b();
}

