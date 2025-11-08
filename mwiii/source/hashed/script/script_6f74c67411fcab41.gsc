#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\mp\killstreaks\killstreaks;

#namespace namespace_de169b8ad93c38b5;

// Namespace namespace_de169b8ad93c38b5 / namespace_281a923a21486535
// Params 0
// Checksum 0x0, Offset: 0x10c
// Size: 0x4e
function function_e1a78f7ca6c76a52()
{
    function_900f562c61c6a5d6( "killstreak", &use_killstreak, &function_a6c2c08d6694cda3, &can_use_killstreak, &function_d6029511a9d0984, &function_5ef81282e50397e );
    
    if ( !isdefined( level.var_a9afa220306e1f68 ) )
    {
        level.var_a9afa220306e1f68 = inventory_isenabled();
    }
    
    level.deathretainstreaks = 1;
}

// Namespace namespace_de169b8ad93c38b5 / namespace_281a923a21486535
// Params 2
// Checksum 0x0, Offset: 0x162
// Size: 0xab
function use_killstreak( itembundle, item )
{
    if ( iskillstreakavailable() )
    {
        if ( function_e1a7409f30e3c964() )
        {
            self notify( "potential_killstreak_deployment_finish", "weapon_change" );
        }
        
        if ( istrue( item.var_4ec444a18e7fc2c0 ) )
        {
            [ var_2814cca693e6ef2d, quantity ] = function_d6029511a9d0984();
            items_dropitem( var_2814cca693e6ef2d, quantity );
        }
        
        removekillstreak( 1 );
    }
    
    awardkillstreak( itembundle.ref, "other", undefined, undefined, undefined, 1 );
    return item.count - 1;
}

// Namespace namespace_de169b8ad93c38b5 / namespace_281a923a21486535
// Params 4
// Checksum 0x0, Offset: 0x216
// Size: 0xb4, Type: bool
function can_use_killstreak( itembundle, item, autouse, allowswap )
{
    if ( isdefined( self.triggeringstreak ) || istrue( self.enabledequipdeployvfx ) || function_e1a7409f30e3c964() )
    {
        return false;
    }
    
    if ( iskillstreakavailable() )
    {
        [ var_2814cca693e6ef2d, quantity ] = function_d6029511a9d0984();
        
        if ( !isdefined( var_2814cca693e6ef2d ) )
        {
            assertmsg( "<dev string:x1c>" );
            return false;
        }
        
        if ( itembundle.ref == var_2814cca693e6ef2d.ref )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_de169b8ad93c38b5 / namespace_281a923a21486535
// Params 4
// Checksum 0x0, Offset: 0x2d3
// Size: 0x5b
function function_a6c2c08d6694cda3( itembundle, item, autouse, allowswap )
{
    if ( isdefined( self.triggeringstreak ) || istrue( self.enabledequipdeployvfx ) || function_e1a7409f30e3c964() )
    {
        return 0;
    }
    
    if ( iskillstreakavailable() )
    {
        return 0;
    }
    
    return 1;
}

// Namespace namespace_de169b8ad93c38b5 / namespace_281a923a21486535
// Params 0
// Checksum 0x0, Offset: 0x336
// Size: 0xb6
function function_d6029511a9d0984()
{
    itembundle = undefined;
    quantity = 0;
    
    if ( isdefined( self.streakdata ) && isdefined( self.streakdata.streaks ) )
    {
        if ( iskillstreakavailable() )
        {
            killstreakref = self.streakdata.streaks[ 1 ].streakname;
            
            if ( !isdefined( killstreakref ) )
            {
                return [ itembundle, quantity ];
            }
            
            killstreakbundlename = function_61d960957fcf3ca0( killstreakref );
            
            if ( isdefined( killstreakbundlename ) )
            {
                itembundle = getscriptbundle( "itemspawnentry:" + killstreakbundlename );
                quantity = 1;
            }
        }
    }
    
    return [ itembundle, quantity ];
}

// Namespace namespace_de169b8ad93c38b5 / namespace_281a923a21486535
// Params 0
// Checksum 0x0, Offset: 0x3f5
// Size: 0x14
function function_5ef81282e50397e()
{
    removekillstreak( 1 );
    updatekillstreakuislot( 1 );
}

// Namespace namespace_de169b8ad93c38b5 / namespace_281a923a21486535
// Params 0
// Checksum 0x0, Offset: 0x411
// Size: 0x53
function iskillstreakavailable()
{
    streakitem = self.streakdata.streaks[ 1 ];
    
    if ( isdefined( streakitem ) && isdefined( streakitem.streakname ) && streakitem.available == 1 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace namespace_de169b8ad93c38b5 / namespace_281a923a21486535
// Params 0
// Checksum 0x0, Offset: 0x46c
// Size: 0x11
function function_e1a7409f30e3c964()
{
    return scripts\cp_mp\utility\killstreak_utility::iskillstreakdeployweapon( self.currentweapon );
}

