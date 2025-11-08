#using scripts\engine\hud_management;

#namespace namespace_cee9ba48af751d44;

// Namespace namespace_cee9ba48af751d44 / namespace_417b627dcd8f5453
// Params 3
// Checksum 0x0, Offset: 0xbb
// Size: 0x6e
function init_countdown( timeout, var_61f0278fde0a9f65, cancel_notify )
{
    if ( !isdefined( var_61f0278fde0a9f65 ) )
    {
        var_61f0278fde0a9f65 = "progressBar";
    }
    
    var_675b56b3f2d87528 = function_6cd0a8e23ff14e13( "scripted_widget_countdown" );
    function_90de31b2cbef19f9( "coundown_display", var_675b56b3f2d87528 );
    function_d28fa5295a04d555( "coundown_display", var_61f0278fde0a9f65 );
    
    if ( isdefined( cancel_notify ) )
    {
        thread function_6c96b4865151ccc7( cancel_notify );
    }
    
    thread function_3e142abcacc03229( timeout );
}

// Namespace namespace_cee9ba48af751d44 / namespace_417b627dcd8f5453
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x131
// Size: 0x1d
function private function_6c96b4865151ccc7( cancel_notify )
{
    self endon( "countdown_end" );
    self waittill( cancel_notify );
    function_6a07800c221ecb09();
}

// Namespace namespace_cee9ba48af751d44 / namespace_417b627dcd8f5453
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x156
// Size: 0x32
function private function_3e142abcacc03229( time )
{
    self endon( "countdown_end" );
    self endon( "death" );
    function_ddc9d8c3b0ef6b87( "coundown_display", 1, 0, time );
    wait time;
    function_6a07800c221ecb09();
}

// Namespace namespace_cee9ba48af751d44 / namespace_417b627dcd8f5453
// Params 0
// Checksum 0x0, Offset: 0x190
// Size: 0x16
function function_6a07800c221ecb09()
{
    scripted_widget_destroy( "coundown_display" );
    self notify( "countdown_end" );
}

