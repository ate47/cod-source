#using script_5d813d45c6b1b1be;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_d453071709327eb4;

// Namespace namespace_d453071709327eb4 / namespace_db605e7dcda0ea09
// Params 1
// Checksum 0x0, Offset: 0x168
// Size: 0x13b
function init( var_5179c48492d1d2c2 )
{
    function_efabc5ae0422de9e( var_5179c48492d1d2c2 );
    bounds_struct = getstruct( var_5179c48492d1d2c2.target, "targetname" );
    var_5179c48492d1d2c2.bounds_trigger = namespace_8eedd8f6cf5d9f19::function_698513ab21b7913d( bounds_struct );
    start_struct = getstruct( bounds_struct.target, "targetname" );
    var_5179c48492d1d2c2.start_trigger = namespace_8eedd8f6cf5d9f19::function_698513ab21b7913d( start_struct );
    var_cf17d26636794c7 = getstruct( start_struct.target, "targetname" );
    var_8283ec5a812caf98 = getstruct( var_cf17d26636794c7.target, "targetname" );
    var_6659a5f662c10265 = getstruct( var_8283ec5a812caf98.target, "targetname" );
    end_struct = getstruct( var_6659a5f662c10265.target, "targetname" );
    var_5179c48492d1d2c2.end_trigger = namespace_8eedd8f6cf5d9f19::function_698513ab21b7913d( end_struct );
    var_5179c48492d1d2c2.reward_struct = getstruct( end_struct.target, "targetname" );
    thread function_afc2853526e95132( var_5179c48492d1d2c2 );
}

// Namespace namespace_d453071709327eb4 / namespace_db605e7dcda0ea09
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2ab
// Size: 0x63
function private function_afc2853526e95132( var_5179c48492d1d2c2 )
{
    var_5179c48492d1d2c2 endon( "MRP_CARDIO_NOTIFY_SUCCESS" );
    
    while ( true )
    {
        var_5179c48492d1d2c2.start_trigger waittill( "trigger", data );
        
        if ( isplayer( data ) && data isonground() )
        {
            /#
                iprintlnbold( "<dev string:x1c>" );
            #/
            
            data childthread function_bb60e753f1d92392( var_5179c48492d1d2c2 );
        }
    }
}

// Namespace namespace_d453071709327eb4 / namespace_db605e7dcda0ea09
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x316
// Size: 0x6d
function private function_bb60e753f1d92392( var_5179c48492d1d2c2 )
{
    self notify( "MRP_CARDIO_NOTIFY_COMPLETE_SINGLETON" );
    self endon( "MRP_CARDIO_NOTIFY_COMPLETE_SINGLETON" );
    self endon( "MRP_CARDIO_NOTIFY_FAILURE" );
    childthread function_4fb766a044b83739( var_5179c48492d1d2c2 );
    childthread function_62039698fe5ac26e( var_5179c48492d1d2c2 );
    
    while ( true )
    {
        var_5179c48492d1d2c2.bounds_trigger waittill( "trigger", data );
        
        if ( data == self )
        {
            self notify( "MRP_CARDIO_NOTIFY_CONTINUE" );
        }
        
        wait 2;
    }
}

// Namespace namespace_d453071709327eb4 / namespace_db605e7dcda0ea09
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x38b
// Size: 0x4c
function private function_4fb766a044b83739( var_5179c48492d1d2c2 )
{
    while ( true )
    {
        result = waittill_any_timeout_1( 3, "MRP_CARDIO_NOTIFY_CONTINUE" );
        
        if ( result == "timeout" )
        {
            /#
                iprintlnbold( "<dev string:x2c>" );
            #/
            
            self notify( "MRP_CARDIO_NOTIFY_FAILURE" );
        }
    }
}

// Namespace namespace_d453071709327eb4 / namespace_db605e7dcda0ea09
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3df
// Size: 0x7b
function private function_62039698fe5ac26e( var_5179c48492d1d2c2 )
{
    while ( true )
    {
        var_5179c48492d1d2c2.end_trigger waittill( "trigger", data );
        
        if ( data == self )
        {
            var_5179c48492d1d2c2.bounds_trigger delete();
            var_5179c48492d1d2c2.start_trigger delete();
            var_5179c48492d1d2c2.end_trigger delete();
            thread function_f2170158cdfd04ea( var_5179c48492d1d2c2 );
            var_5179c48492d1d2c2 notify( "MRP_CARDIO_NOTIFY_SUCCESS" );
        }
    }
}

// Namespace namespace_d453071709327eb4 / namespace_db605e7dcda0ea09
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x462
// Size: 0x2c
function private function_f2170158cdfd04ea( var_5179c48492d1d2c2 )
{
    function_568b8a57e0fa955f( var_5179c48492d1d2c2, self );
    namespace_8eedd8f6cf5d9f19::function_a4dfabe55dd4a652( self, var_5179c48492d1d2c2.reward_struct, "ob_jup_items_activity_mrp_cardio" );
}

