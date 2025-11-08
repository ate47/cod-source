#using script_5d813d45c6b1b1be;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_a461e274605f517e;

// Namespace namespace_a461e274605f517e / namespace_ae612cf681deb69f
// Params 1
// Checksum 0x0, Offset: 0x148
// Size: 0xda
function init( var_5179c48492d1d2c2 )
{
    function_efabc5ae0422de9e( var_5179c48492d1d2c2, 1, undefined, "sitting" );
    var_5179c48492d1d2c2.challenge_complete = 0;
    jump_struct = getstruct( var_5179c48492d1d2c2.target, "targetname" );
    jump_trigger = function_698513ab21b7913d( jump_struct );
    var_5179c48492d1d2c2.jump_trigger = jump_trigger;
    pool_struct = getstruct( jump_struct.target, "targetname" );
    pool_trigger = function_698513ab21b7913d( pool_struct );
    var_5179c48492d1d2c2.pool_trigger = pool_trigger;
    var_5179c48492d1d2c2.reward_struct = getstruct( pool_struct.target, "targetname" );
    thread function_7997e8c2ef236551( var_5179c48492d1d2c2 );
    thread function_d1db5a0838b22a18( var_5179c48492d1d2c2 );
}

// Namespace namespace_a461e274605f517e / namespace_ae612cf681deb69f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x22a
// Size: 0x96
function private function_7997e8c2ef236551( var_5179c48492d1d2c2 )
{
    while ( isdefined( var_5179c48492d1d2c2 ) && !istrue( var_5179c48492d1d2c2.challenge_complete ) )
    {
        var_5179c48492d1d2c2.jump_trigger waittill( "trigger", data );
        
        if ( isplayer( data ) && !data isonground() )
        {
            if ( !istrue( data.var_c9a127bae678ade5 ) )
            {
                /#
                    iprintlnbold( "<dev string:x1c>" );
                #/
                
                data.var_c9a127bae678ade5 = 1;
                data.var_6453e34a7bfd9886 = 1;
                data thread function_6a4ceb59f0de0801();
            }
        }
    }
}

// Namespace namespace_a461e274605f517e / namespace_ae612cf681deb69f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2c8
// Size: 0x59
function private function_6a4ceb59f0de0801()
{
    self endon( "MRP_CANNONBALL_NOTIFY_SUCCESS" );
    self endon( "MRP_CANNONBALL_NOTIFY_FAIL" );
    
    while ( !self isonground() )
    {
        wait 0.1;
    }
    
    if ( istrue( self.var_6453e34a7bfd9886 ) )
    {
        /#
            iprintlnbold( "<dev string:x38>" );
        #/
        
        self.var_c9a127bae678ade5 = undefined;
        self.var_6453e34a7bfd9886 = undefined;
        self notify( "MRP_CANNONBALL_NOTIFY_FAIL" );
    }
}

// Namespace namespace_a461e274605f517e / namespace_ae612cf681deb69f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x329
// Size: 0x4f
function private function_a3fb62f5dda0b5a()
{
    self endon( "MRP_CANNONBALL_NOTIFY_SUCCESS" );
    self endon( "MRP_CANNONBALL_NOTIFY_FAIL" );
    self waittill( "skydive_deployparachute" );
    
    if ( istrue( self.var_6453e34a7bfd9886 ) )
    {
        /#
            iprintlnbold( "<dev string:x38>" );
        #/
        
        self.var_c9a127bae678ade5 = undefined;
        self.var_6453e34a7bfd9886 = undefined;
        self notify( "MRP_CANNONBALL_NOTIFY_FAIL" );
    }
}

// Namespace namespace_a461e274605f517e / namespace_ae612cf681deb69f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x380
// Size: 0xd9
function private function_d1db5a0838b22a18( var_5179c48492d1d2c2 )
{
    var_5179c48492d1d2c2 endon( "MRP_CANNONBALL_NOTIFY_SUCCESS" );
    
    while ( isdefined( var_5179c48492d1d2c2 ) && !istrue( var_5179c48492d1d2c2.challenge_complete ) )
    {
        var_5179c48492d1d2c2.pool_trigger waittill( "trigger", data );
        
        if ( isplayer( data ) && data isswimming() && istrue( data.var_6453e34a7bfd9886 ) )
        {
            /#
                iprintlnbold( "<dev string:x4d>" );
            #/
            
            data.var_c9a127bae678ade5 = undefined;
            data.var_6453e34a7bfd9886 = undefined;
            var_5179c48492d1d2c2.challenge_complete = 1;
            var_5179c48492d1d2c2.jump_trigger delete();
            var_5179c48492d1d2c2.pool_trigger delete();
            thread function_82d05bedc3350817( data, var_5179c48492d1d2c2 );
            data notify( "MRP_CANNONBALL_NOTIFY_SUCCESS" );
            var_5179c48492d1d2c2 notify( "MRP_CANNONBALL_NOTIFY_SUCCESS" );
        }
    }
}

// Namespace namespace_a461e274605f517e / namespace_ae612cf681deb69f
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x461
// Size: 0x2c
function private function_82d05bedc3350817( player, var_5179c48492d1d2c2 )
{
    function_568b8a57e0fa955f( var_5179c48492d1d2c2, player );
    namespace_8eedd8f6cf5d9f19::function_a4dfabe55dd4a652( player, undefined, "ob_jup_items_activity_mrp_pool", 1 );
}

