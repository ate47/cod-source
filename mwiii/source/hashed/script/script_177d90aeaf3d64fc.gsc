#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace namespace_5b218477be05886c;

// Namespace namespace_5b218477be05886c / namespace_2b394cef24a1daec
// Params 0
// Checksum 0x0, Offset: 0xf3
// Size: 0x2a
function function_845878bc3f891199()
{
    if ( !isdefined( level.var_e2dd33ac17a3b091 ) )
    {
        level.var_e2dd33ac17a3b091 = [];
    }
    
    function_6d507460d23bd8b2( "yellow_cargo", "ob_jup_items_reward_region_cache_cargo" );
}

// Namespace namespace_5b218477be05886c / namespace_2b394cef24a1daec
// Params 2
// Checksum 0x0, Offset: 0x125
// Size: 0x94
function function_6d507460d23bd8b2( region_name, var_8943bcdf726f10bf )
{
    if ( !isdefined( level.var_e2dd33ac17a3b091 ) )
    {
        level.var_e2dd33ac17a3b091 = [];
    }
    
    if ( isdefined( level.var_e2dd33ac17a3b091[ region_name ] ) )
    {
        assertmsg( "<dev string:x1c>" + region_name + "<dev string:x28>" );
        return;
    }
    
    var_9560f99f5fb06178 = getscriptbundle( "itemspawnlist:" + var_8943bcdf726f10bf );
    
    if ( isdefined( var_9560f99f5fb06178 ) )
    {
        level.var_e2dd33ac17a3b091[ region_name ] = var_8943bcdf726f10bf;
        return;
    }
    
    assertmsg( "<dev string:x41>" + var_8943bcdf726f10bf + "<dev string:x57>" );
    return;
}

