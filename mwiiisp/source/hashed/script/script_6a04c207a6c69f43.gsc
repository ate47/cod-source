#using scripts\sp\lights;

#namespace namespace_4ba6e399ec22a6d9;

/#

    // Namespace namespace_4ba6e399ec22a6d9 / namespace_c1a759e9577e490f
    // Params 0
    // Checksum 0x0, Offset: 0x70
    // Size: 0x58, Type: dev
    function function_851b7e474a5af3e7()
    {
        if ( isofflinetoolrun( 64 | 2 | 4 ) )
        {
            scripts\sp\lights::init();
            println( "<dev string:x1c>" );
            level waittill( "<dev string:x68>" );
            return;
        }
        
        if ( isofflinetoolrun( 1 ) && offlinetoolrunexitwhendone() )
        {
            println( "<dev string:x71>" );
            level waittill( "<dev string:x68>" );
        }
    }

#/
