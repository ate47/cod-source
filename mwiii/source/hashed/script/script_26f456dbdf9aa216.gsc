#using scripts\aitypes\bt_util;
#using scripts\asm\gesture;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_cbce62193111f79;

// Namespace namespace_cbce62193111f79 / namespace_a3bb9840357a7ef2
// Params 2
// Checksum 0x0, Offset: 0xb2
// Size: 0xbe
function function_5ad32ab5f21ddf93( statename, params )
{
    id = self getinteractionid();
    
    if ( params.size == 1 )
    {
        thread scripts\asm\gesture::ai_request_gesture( params[ 0 ], undefined, undefined, "gesture" );
        return;
    }
    
    if ( params.size == 2 )
    {
        thread scripts\asm\gesture::ai_request_gesture( params[ 0 ], params[ 1 ], undefined, "gesture" );
        return;
    }
    
    if ( params.size == 3 )
    {
        thread scripts\asm\gesture::ai_request_gesture( params[ 0 ], params[ 1 ], params[ 2 ], "gesture" );
        return;
    }
    
    if ( params.size == 4 )
    {
        thread scripts\asm\gesture::ai_request_gesture( params[ 0 ], params[ 1 ], params[ 2 ], params[ 3 ] );
        return;
    }
    
    assertmsg( "<dev string:x1c>" + params.size + "<dev string:x5f>" );
}

