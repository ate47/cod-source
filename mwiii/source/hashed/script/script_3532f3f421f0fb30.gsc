#using script_5d813d45c6b1b1be;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;

#namespace namespace_a58b72ccaa110b13;

// Namespace namespace_a58b72ccaa110b13 / namespace_bc4759f7a32ebd96
// Params 1
// Checksum 0x0, Offset: 0x14b
// Size: 0x58
function init( var_5179c48492d1d2c2 )
{
    function_efabc5ae0422de9e( var_5179c48492d1d2c2, 1, undefined, "sitting" );
    trigger_struct = getstruct( var_5179c48492d1d2c2.target, "targetname" );
    trigger_box = function_698513ab21b7913d( trigger_struct );
    thread function_7de3883507acf30d( trigger_box, var_5179c48492d1d2c2 );
}

// Namespace namespace_a58b72ccaa110b13 / namespace_bc4759f7a32ebd96
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1ab
// Size: 0x7a
function private function_7de3883507acf30d( trigger_box, var_5179c48492d1d2c2 )
{
    var_5179c48492d1d2c2 endon( "MRP_FREEBIRD_NOTIFY_SUCCESS" );
    
    while ( isdefined( trigger_box ) )
    {
        trigger_box waittill( "trigger", data );
        
        if ( data scripts\common\vehicle::isvehicle() )
        {
            if ( istrue( data vehicle_isphysveh() ) && !data vehicle_isonground() )
            {
                driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver( data );
                
                if ( isplayer( driver ) )
                {
                    childthread function_d9710cca01e9c3a8( driver, data, var_5179c48492d1d2c2, trigger_box );
                }
            }
        }
    }
}

// Namespace namespace_a58b72ccaa110b13 / namespace_bc4759f7a32ebd96
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x22d
// Size: 0xa3
function private function_d9710cca01e9c3a8( player, vehicle, var_5179c48492d1d2c2, trigger_box )
{
    player notify( "MRP_FREEDBIRD_NOTIFY_COMPLETE_SINGLETON" );
    player endon( "MRP_FREEDBIRD_NOTIFY_COMPLETE_SINGLETON" );
    
    /#
        iprintlnbold( "<dev string:x1c>" );
    #/
    
    while ( isdefined( vehicle ) && !vehicle vehicle_isonground() )
    {
        wait 0.1;
    }
    
    driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver( vehicle );
    
    if ( isplayer( driver ) && driver == player )
    {
        /#
            iprintlnbold( "<dev string:x34>" );
        #/
        
        trigger_box delete();
        thread function_44bde26a853364c4( player, vehicle, var_5179c48492d1d2c2 );
        var_5179c48492d1d2c2 notify( "MRP_FREEBIRD_NOTIFY_SUCCESS" );
    }
}

// Namespace namespace_a58b72ccaa110b13 / namespace_bc4759f7a32ebd96
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2d8
// Size: 0x36
function private function_44bde26a853364c4( player, vehicle, var_5179c48492d1d2c2 )
{
    function_568b8a57e0fa955f( var_5179c48492d1d2c2, player, undefined, vehicle );
    namespace_8eedd8f6cf5d9f19::function_a4dfabe55dd4a652( player, undefined, "ob_jup_items_activity_mrp_freebird", 1 );
}

