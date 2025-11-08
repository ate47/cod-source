#using scripts\cp_mp\currency;
#using scripts\cp_mp\loot\common_item;

#namespace namespace_f9e8a327d793c098;

// Namespace namespace_f9e8a327d793c098 / namespace_3bb9f9a385df1918
// Params 0
// Checksum 0x0, Offset: 0xb2
// Size: 0x39
function function_b60c68caa2f279ab()
{
    if ( isdefined( level.var_27475bb0d1b06044 ) )
    {
        [[ level.var_27475bb0d1b06044 ]]();
        return;
    }
    
    function_900f562c61c6a5d6( "currency", &use_currency, &function_794ffcdb7828ea7a, &function_794ffcdb7828ea7a );
}

// Namespace namespace_f9e8a327d793c098 / namespace_3bb9f9a385df1918
// Params 4
// Checksum 0x0, Offset: 0xf3
// Size: 0x25, Type: bool
function function_794ffcdb7828ea7a( itembundle, item, auto_use, var_18fc734ec7194ede )
{
    return true;
}

// Namespace namespace_f9e8a327d793c098 / namespace_3bb9f9a385df1918
// Params 3
// Checksum 0x0, Offset: 0x121
// Size: 0xc0, Type: bool
function use_currency( itembundle, item, auto_use )
{
    currencytype = itembundle.subtype;
    currencyamount = function_b8bfea9514c89a77( item.count );
    
    if ( !isdefined( currencytype ) || currencytype == "" )
    {
        itembundlename = function_2cdc55ba39d97d70( item.type );
        assertmsg( "<dev string:x1c>" + itembundlename + "<dev string:x55>" );
        return false;
    }
    
    if ( currencytype == "essence" && isdefined( self.zombie_point_scalar ) )
    {
        currencyamount *= self.zombie_point_scalar;
    }
    
    scripts\cp_mp\currency::function_3036cef61495210f( currencytype, currencyamount );
    return false;
}

