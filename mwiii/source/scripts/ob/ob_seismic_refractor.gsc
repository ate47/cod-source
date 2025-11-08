#using script_7534b1d3ac3ea47a;
#using scripts\common\utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;

#namespace ob_seismic_refractor;

/#

    // Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
    // Params 0
    // Checksum 0x0, Offset: 0x1ce
    // Size: 0x5, Type: dev
    function function_8086d05fcf37c41e()
    {
        
    }

#/

// Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
// Params 3
// Checksum 0x0, Offset: 0x1db
// Size: 0x17b
function spawn_refractor( spawn_struct, var_cd74e8066ff626a6, var_c974765ba1e28e93 )
{
    if ( !isdefined( var_cd74e8066ff626a6 ) )
    {
        var_cd74e8066ff626a6 = "ob_seismic_refractor";
    }
    
    if ( !isdefined( var_c974765ba1e28e93 ) )
    {
        var_c974765ba1e28e93 = "jup_hacking_device_ob";
    }
    
    if ( !isdefined( level.scriptable_notify_callback_funcs[ "refractor_activated" ] ) || !array_contains( level.scriptable_notify_callback_funcs[ "refractor_activated" ], &function_aa84440f79224493 ) )
    {
        scripts\engine\scriptable::scriptable_addnotifycallback( "refractor_activated", &function_aa84440f79224493 );
    }
    
    if ( !isdefined( level.scriptable_notify_callback_funcs[ "refractor_hammer" ] ) || !array_contains( level.scriptable_notify_callback_funcs[ "refractor_hammer" ], &function_81edae2f148e254e ) )
    {
        scripts\engine\scriptable::scriptable_addnotifycallback( "refractor_hammer", &function_81edae2f148e254e );
    }
    
    refractor = spawnscriptable( var_cd74e8066ff626a6, spawn_struct.origin, spawn_struct.angles );
    refractor.hammer = spawnscriptable( "ob_seismic_refractor_hammer", spawn_struct.origin, spawn_struct.angles );
    refractor setscriptablepartstate( "model", "unusable", 0 );
    refractor.var_aa599c358ec2ad3e = [];
    refractor.var_19cb4df4192822ca = [];
    refractor.var_fb285d0793a4040c = [];
    refractor.var_8b222c47a4c5bc24 = [];
    refractor.var_f9b8a1126400b110 = [];
    namespace_29b5250e9959ea::function_3cec1b2981075936( var_c974765ba1e28e93, refractor, &function_7192fa51a97ee5e9, &function_cbbab99365ff243f, &function_d62d4fe8da417ddd );
    return refractor;
}

// Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
// Params 1
// Checksum 0x0, Offset: 0x35f
// Size: 0x2a
function function_d5c87e3695f5b16( callback )
{
    if ( isfunction( callback ) )
    {
        self.var_aa599c358ec2ad3e[ self.var_aa599c358ec2ad3e.size ] = callback;
    }
}

// Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
// Params 1
// Checksum 0x0, Offset: 0x391
// Size: 0x2a
function function_d290ab656c9cd6e2( callback )
{
    if ( isfunction( callback ) )
    {
        self.var_19cb4df4192822ca[ self.var_19cb4df4192822ca.size ] = callback;
    }
}

// Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
// Params 1
// Checksum 0x0, Offset: 0x3c3
// Size: 0x2a
function function_3c5ad201440cf164( callback )
{
    if ( isfunction( callback ) )
    {
        self.var_fb285d0793a4040c[ self.var_fb285d0793a4040c.size ] = callback;
    }
}

// Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
// Params 1
// Checksum 0x0, Offset: 0x3f5
// Size: 0x2a
function function_9cdaad2239acc1fc( callback )
{
    if ( isfunction( callback ) )
    {
        self.var_8b222c47a4c5bc24[ self.var_8b222c47a4c5bc24.size ] = callback;
    }
}

// Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
// Params 1
// Checksum 0x0, Offset: 0x427
// Size: 0x2a
function function_938ec5691a0782f8( callback )
{
    if ( isfunction( callback ) )
    {
        self.var_f9b8a1126400b110[ self.var_f9b8a1126400b110.size ] = callback;
    }
}

/#

    // Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
    // Params 0
    // Checksum 0x0, Offset: 0x459
    // Size: 0x5, Type: dev
    function function_c31851330ac22c3c()
    {
        
    }

#/

// Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x466
// Size: 0x5e
function private function_cbbab99365ff243f( player )
{
    foreach ( func in self.var_fb285d0793a4040c )
    {
        self thread [[ func ]]( player );
    }
}

// Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4cc
// Size: 0x67
function private function_d62d4fe8da417ddd( player )
{
    thread function_f083c5f7558264f4( player );
    
    foreach ( func in self.var_8b222c47a4c5bc24 )
    {
        self thread [[ func ]]( player );
    }
}

// Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x53b
// Size: 0x92
function private function_f083c5f7558264f4( player )
{
    player endon( "interaction_complete" );
    self setscriptablepartstate( "flipbook", "activating", 0 );
    player waittill( "cancel" );
    waitframe();
    self setscriptablepartstate( "flipbook", "idle", 0 );
    
    foreach ( func in self.var_f9b8a1126400b110 )
    {
        self thread [[ func ]]( player );
    }
}

// Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5d5
// Size: 0x9f
function private function_7192fa51a97ee5e9( player )
{
    if ( isdefined( self.var_db4f5c48c8cb9a3c ) )
    {
        self thread [[ self.var_db4f5c48c8cb9a3c ]]( player );
        return;
    }
    
    self setscriptablepartstate( "model", "just_used", 0 );
    self setscriptablepartstate( "effects", "Initial", 0 );
    
    foreach ( func in self.var_19cb4df4192822ca )
    {
        self thread [[ func ]]( player );
    }
}

// Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x67c
// Size: 0x15
function private function_cf139bdff2bdcaad( func )
{
    self.var_db4f5c48c8cb9a3c = func;
}

// Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
// Params 0
// Checksum 0x0, Offset: 0x699
// Size: 0x25
function function_e23f7699eb3f384e()
{
    if ( isdefined( self.hammer ) )
    {
        self.hammer freescriptable();
    }
    
    self freescriptable();
}

/#

    // Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
    // Params 0
    // Checksum 0x0, Offset: 0x6c6
    // Size: 0x5, Type: dev
    function function_8a76744810afe9be()
    {
        
    }

#/

// Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x6d3
// Size: 0x7d
function private function_aa84440f79224493( instance, notif, param, var_535d9c3fdddab5a9 )
{
    foreach ( func in instance.var_aa599c358ec2ad3e )
    {
        instance thread [[ func ]]( instance, notif, param, var_535d9c3fdddab5a9 );
    }
}

// Namespace ob_seismic_refractor / scripts\ob\ob_seismic_refractor
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x758
// Size: 0x113
function private function_81edae2f148e254e( instance, notif, params, var_535d9c3fdddab5a9 )
{
    if ( !isdefined( instance.hammer ) )
    {
        return;
    }
    
    switch ( params )
    {
        case 0:
            instance.hammer setscriptablepartstate( "model", "Hidden", 0 );
            break;
        case 1:
            instance.hammer setscriptablepartstate( "model", "static", 0 );
            break;
        case 2:
            instance.hammer setscriptablepartstate( "model", "initial", 0 );
            break;
        case 3:
            instance.hammer setscriptablepartstate( "model", "drop", 0 );
            break;
        case 4:
            instance.hammer setscriptablepartstate( "model", "rise", 0 );
            break;
    }
}

