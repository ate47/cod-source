#using script_5d813d45c6b1b1be;
#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\utility;

#namespace namespace_c9f64699b75aaf24;

// Namespace namespace_c9f64699b75aaf24 / namespace_7e65c44dbe99b93d
// Params 1
// Checksum 0x0, Offset: 0x182
// Size: 0x115
function init( var_5179c48492d1d2c2 )
{
    function_efabc5ae0422de9e( var_5179c48492d1d2c2, 1 );
    var_5179c48492d1d2c2.var_47bd5f983ddc96b8 = getstruct( var_5179c48492d1d2c2.target, "targetname" );
    start_struct = getstruct( var_5179c48492d1d2c2.var_47bd5f983ddc96b8.target, "targetname" );
    var_5179c48492d1d2c2.start_trigger = namespace_8eedd8f6cf5d9f19::function_698513ab21b7913d( start_struct );
    end_struct = getstruct( start_struct.target, "targetname" );
    var_5179c48492d1d2c2.end_trigger = namespace_8eedd8f6cf5d9f19::function_698513ab21b7913d( end_struct );
    var_5179c48492d1d2c2.reward_struct = getstruct( end_struct.target, "targetname" );
    var_1e916dfdc1857f94 = getstruct( var_5179c48492d1d2c2.reward_struct.target, "targetname" );
    function_efabc5ae0422de9e( var_5179c48492d1d2c2, 1, var_1e916dfdc1857f94 );
    thread function_391bf389129f4fa6( var_5179c48492d1d2c2, 1 );
    thread function_391bf389129f4fa6( var_5179c48492d1d2c2, 0 );
}

// Namespace namespace_c9f64699b75aaf24 / namespace_7e65c44dbe99b93d
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x29f
// Size: 0x7f
function private function_391bf389129f4fa6( var_5179c48492d1d2c2, forward )
{
    var_5179c48492d1d2c2 endon( "MRP_SPEEDWAY_NOTIFY_SUCCESS" );
    
    while ( true )
    {
        if ( forward )
        {
            var_5179c48492d1d2c2.start_trigger waittill( "trigger", data );
        }
        else
        {
            var_5179c48492d1d2c2.end_trigger waittill( "trigger", data );
        }
        
        if ( data isvehicle() )
        {
            /#
                iprintlnbold( "<dev string:x1c>" );
            #/
            
            data childthread function_5e45bd49c6bbe0e( var_5179c48492d1d2c2, forward );
        }
        
        waitframe();
    }
}

// Namespace namespace_c9f64699b75aaf24 / namespace_7e65c44dbe99b93d
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x326
// Size: 0x5f
function private function_5e45bd49c6bbe0e( var_5179c48492d1d2c2, forward )
{
    touch = forward ? var_5179c48492d1d2c2.start_trigger : var_5179c48492d1d2c2.end_trigger;
    
    if ( self vehicle_getspeed( 0.15 ) == 0 )
    {
        childthread function_4611c9ab4aa45ea5( var_5179c48492d1d2c2, forward );
        return;
    }
    
    wait 0.5;
}

// Namespace namespace_c9f64699b75aaf24 / namespace_7e65c44dbe99b93d
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x38d
// Size: 0x100
function private function_4611c9ab4aa45ea5( var_5179c48492d1d2c2, forward )
{
    self notify( "MRP_SPEEDWAY_NOTIFY_COMPLETE_SINGLETON" );
    self endon( "MRP_SPEEDWAY_NOTIFY_COMPLETE_SINGLETON" );
    self endon( "MRP_SPEEDWAY_NOTIFY_FAILED" );
    var_5179c48492d1d2c2 endon( "MRP_SPEEDWAY_NOTIFY_SUCCESS" );
    childthread function_11dd0af8e1e8199d( var_5179c48492d1d2c2 );
    thread function_6b77686cf92420a6( var_5179c48492d1d2c2, forward );
    
    while ( true )
    {
        if ( forward )
        {
            var_5179c48492d1d2c2.end_trigger waittill( "trigger", data );
        }
        else
        {
            var_5179c48492d1d2c2.start_trigger waittill( "trigger", data );
        }
        
        if ( data == self && isdefined( data.occupants[ "driver" ] ) )
        {
            if ( forward )
            {
                reward_struct = var_5179c48492d1d2c2.reward_struct;
            }
            else
            {
                reward_struct = var_5179c48492d1d2c2.var_47bd5f983ddc96b8;
            }
            
            thread function_f08bad8bfb75c7a1( var_5179c48492d1d2c2, data, reward_struct );
            var_5179c48492d1d2c2.start_trigger delete();
            var_5179c48492d1d2c2.end_trigger delete();
            var_5179c48492d1d2c2 notify( "MRP_SPEEDWAY_NOTIFY_SUCCESS" );
            return;
        }
        
        waitframe();
    }
}

// Namespace namespace_c9f64699b75aaf24 / namespace_7e65c44dbe99b93d
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x495
// Size: 0x7e
function private function_6b77686cf92420a6( var_5179c48492d1d2c2, forward )
{
    if ( !isdefined( var_5179c48492d1d2c2.hint_time ) || gettime() - var_5179c48492d1d2c2.hint_time > 12000 )
    {
        /#
            iprintlnbold( "<dev string:x30>" );
        #/
        
        var_5179c48492d1d2c2.hint_time = gettime();
        playsoundatpos( var_5179c48492d1d2c2.models[ !forward ].origin, "evt_ob_mrpeeks_stinger_speedway" );
    }
}

// Namespace namespace_c9f64699b75aaf24 / namespace_7e65c44dbe99b93d
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x51b
// Size: 0x51
function private function_f08bad8bfb75c7a1( var_5179c48492d1d2c2, data, reward_struct )
{
    player = data.occupants[ "driver" ];
    function_568b8a57e0fa955f( var_5179c48492d1d2c2, player, undefined, data );
    namespace_8eedd8f6cf5d9f19::function_a4dfabe55dd4a652( player, reward_struct, "ob_jup_items_activity_mrp_speedway" );
}

// Namespace namespace_c9f64699b75aaf24 / namespace_7e65c44dbe99b93d
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x574
// Size: 0x27
function private function_11dd0af8e1e8199d( var_5179c48492d1d2c2 )
{
    wait 15;
    
    /#
        iprintlnbold( "<dev string:x45>" );
    #/
    
    self notify( "MRP_SPEEDWAY_NOTIFY_FAILED" );
}

