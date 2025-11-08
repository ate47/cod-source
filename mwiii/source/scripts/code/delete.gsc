#namespace delete;

// Namespace delete / scripts\code\delete
// Params 0
// Checksum 0x0, Offset: 0x88
// Size: 0x1b
function main()
{
    assert( isdefined( self ) );
    wait 0;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

