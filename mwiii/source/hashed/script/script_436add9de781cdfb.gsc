#namespace namespace_9cede1970b303649;

// Namespace namespace_9cede1970b303649 / namespace_d9d9691c846bdad7
// Params 0
// Checksum 0x0, Offset: 0xb3
// Size: 0x22
function init()
{
    if ( !isdefined( level.var_cbf08f5916cab0b0 ) )
    {
        level.var_cbf08f5916cab0b0 = [];
    }
    
    level thread function_5b1d60872d5f7d1f();
}

// Namespace namespace_9cede1970b303649 / namespace_d9d9691c846bdad7
// Params 0
// Checksum 0x0, Offset: 0xdd
// Size: 0x22
function function_5b1d60872d5f7d1f()
{
    for ( ;; )
    {
        level waittill( "connected", player );
        player thread function_30ae32f045a9401();
    }
}

// Namespace namespace_9cede1970b303649 / namespace_d9d9691c846bdad7
// Params 1
// Checksum 0x0, Offset: 0x107
// Size: 0x38
function function_3a363ae38f309166( callback )
{
    if ( !isdefined( level.var_cbf08f5916cab0b0 ) )
    {
        level.var_cbf08f5916cab0b0 = [];
    }
    
    level.var_cbf08f5916cab0b0[ level.var_cbf08f5916cab0b0.size ] = callback;
}

// Namespace namespace_9cede1970b303649 / namespace_d9d9691c846bdad7
// Params 1
// Checksum 0x0, Offset: 0x147
// Size: 0x78
function function_c954b1a939feae65( removecallback )
{
    temparray = [];
    
    foreach ( callback in level.var_cbf08f5916cab0b0 )
    {
        if ( removecallback != callback )
        {
            temparray[ temparray.size ] = callback;
        }
    }
    
    level.var_cbf08f5916cab0b0 = temparray;
}

// Namespace namespace_9cede1970b303649 / namespace_d9d9691c846bdad7
// Params 0
// Checksum 0x0, Offset: 0x1c7
// Size: 0x65
function function_30ae32f045a9401()
{
    self endon( "disconnect" );
    
    for ( ;; )
    {
        self waittill( "reload_start" );
        
        foreach ( callback in level.var_cbf08f5916cab0b0 )
        {
            self [[ callback ]]();
        }
    }
}

