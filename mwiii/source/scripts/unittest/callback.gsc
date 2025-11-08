#namespace callback;

// Namespace callback / scripts\unittest\callback
// Params 2
// Checksum 0x0, Offset: 0x88
// Size: 0x24
function exec_callback( func, data )
{
    if ( isdefined( data ) )
    {
        [[ func ]]( data );
        return;
    }
    
    [[ func ]]();
}

