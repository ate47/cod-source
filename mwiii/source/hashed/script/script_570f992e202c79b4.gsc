#using scripts\common\linked_list;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_3e8924d2d52a5e37;

// Namespace namespace_3e8924d2d52a5e37 / namespace_b294929e0e35387a
// Params 1
// Checksum 0x0, Offset: 0x9f
// Size: 0x68
function function_63555ee8e5fb64fc( cachesize )
{
    assertex( cachesize > 0, "<dev string:x1c>" );
    var_f9c88d9020c8956c = spawnstruct();
    var_f9c88d9020c8956c.cachesize = cachesize;
    var_f9c88d9020c8956c.var_f4087a1ca01febee = createstruct_linkedlist();
    var_f9c88d9020c8956c.datamap = [];
    var_f9c88d9020c8956c.var_6331b84385d676bc = 1;
    return var_f9c88d9020c8956c;
}

// Namespace namespace_3e8924d2d52a5e37 / namespace_b294929e0e35387a
// Params 1
// Checksum 0x0, Offset: 0x110
// Size: 0x23, Type: bool
function function_6331b84385d676bc( var_c41e3f9d7499501f )
{
    return isstruct( var_c41e3f9d7499501f ) && var_c41e3f9d7499501f.var_6331b84385d676bc == 1;
}

// Namespace namespace_3e8924d2d52a5e37 / namespace_b294929e0e35387a
// Params 2
// Checksum 0x0, Offset: 0x13c
// Size: 0x16d
function addtocache( datakey, datacontents )
{
    assertex( function_6331b84385d676bc( self ), "<dev string:x4c>" );
    var_f9c88d9020c8956c = self;
    
    if ( isdefined( var_f9c88d9020c8956c.datamap[ datakey ] ) )
    {
        linkedlistnode = var_f9c88d9020c8956c.datamap[ datakey ];
        var_f9c88d9020c8956c.var_f4087a1ca01febee movenodetostart( linkedlistnode );
        return;
    }
    
    linkedlistnode = function_11a80ea7fe6ea9e0();
    linkedlistnode.contents = datacontents;
    linkedlistnode.datakey = datakey;
    var_f9c88d9020c8956c.datamap[ datakey ] = linkedlistnode;
    var_f9c88d9020c8956c.var_f4087a1ca01febee addnode( linkedlistnode, 1 );
    
    /#
        if ( var_f9c88d9020c8956c function_63fe00fb459ea917() )
        {
            function_cb7caa09a0749df4( "<dev string:xa0>" + datakey + "<dev string:xd0>" );
        }
    #/
    
    if ( var_f9c88d9020c8956c.var_f4087a1ca01febee getsize() > var_f9c88d9020c8956c.cachesize )
    {
        var_3c81bd8cfe859fc3 = var_f9c88d9020c8956c.var_f4087a1ca01febee getendnode();
        var_f9c88d9020c8956c removefromcache( var_3c81bd8cfe859fc3.datakey );
        
        /#
            if ( var_f9c88d9020c8956c function_63fe00fb459ea917() )
            {
                function_cb7caa09a0749df4( "<dev string:xd5>" + var_f9c88d9020c8956c.cachesize + "<dev string:x102>" + datakey + "<dev string:x12d>" + var_3c81bd8cfe859fc3.datakey + "<dev string:x15d>" );
            }
        #/
    }
}

// Namespace namespace_3e8924d2d52a5e37 / namespace_b294929e0e35387a
// Params 1
// Checksum 0x0, Offset: 0x2b1
// Size: 0x80
function removefromcache( datakey )
{
    assertex( function_6331b84385d676bc( self ), "<dev string:x4c>" );
    var_f9c88d9020c8956c = self;
    
    if ( isdefined( var_f9c88d9020c8956c.datamap[ datakey ] ) )
    {
        linkedlistnode = var_f9c88d9020c8956c.datamap[ datakey ];
        var_f9c88d9020c8956c.var_f4087a1ca01febee removenode( linkedlistnode );
        linkedlistnode.contents = undefined;
        var_f9c88d9020c8956c.datamap[ datakey ] = undefined;
    }
}

// Namespace namespace_3e8924d2d52a5e37 / namespace_b294929e0e35387a
// Params 1
// Checksum 0x0, Offset: 0x339
// Size: 0x75
function function_c908ab3353601192( datakey )
{
    assertex( function_6331b84385d676bc( self ), "<dev string:x4c>" );
    var_f9c88d9020c8956c = self;
    
    if ( isdefined( var_f9c88d9020c8956c.datamap[ datakey ] ) )
    {
        linkedlistnode = var_f9c88d9020c8956c.datamap[ datakey ];
        var_f9c88d9020c8956c.var_f4087a1ca01febee movenodetostart( linkedlistnode );
        return linkedlistnode.contents;
    }
    
    return undefined;
}

/#

    // Namespace namespace_3e8924d2d52a5e37 / namespace_b294929e0e35387a
    // Params 0
    // Checksum 0x0, Offset: 0x3b7
    // Size: 0x5, Type: dev
    function function_b070450a1a879374()
    {
        
    }

    // Namespace namespace_3e8924d2d52a5e37 / namespace_b294929e0e35387a
    // Params 0
    // Checksum 0x0, Offset: 0x3c4
    // Size: 0x21, Type: dev
    function function_7f5414a2ec3af004()
    {
        var_e7bd49da3939ba59 = function_63555ee8e5fb64fc();
        var_e7bd49da3939ba59 function_e72dd453d0c738eb();
        return var_e7bd49da3939ba59;
    }

    // Namespace namespace_3e8924d2d52a5e37 / namespace_b294929e0e35387a
    // Params 1
    // Checksum 0x0, Offset: 0x3ed
    // Size: 0x5a, Type: dev
    function function_e72dd453d0c738eb( var_f6db2dc3ab7b9a12 )
    {
        assertex( function_6331b84385d676bc( self ), "<dev string:x4c>" );
        var_e7bd49da3939ba59 = self;
        var_e7bd49da3939ba59.var_1a19bd75a8860186 = 1;
        
        if ( istrue( var_f6db2dc3ab7b9a12 ) )
        {
            var_e7bd49da3939ba59.var_f4087a1ca01febee function_3a28dcc9cc1b6ae3( &function_b96df1db6657354e );
        }
    }

    // Namespace namespace_3e8924d2d52a5e37 / namespace_b294929e0e35387a
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x44f
    // Size: 0x34, Type: dev
    function private function_63fe00fb459ea917()
    {
        assertex( function_6331b84385d676bc( self ), "<dev string:x171>" );
        var_f9c88d9020c8956c = self;
        return istrue( var_f9c88d9020c8956c.var_1a19bd75a8860186 );
    }

    // Namespace namespace_3e8924d2d52a5e37 / namespace_b294929e0e35387a
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x48b
    // Size: 0x26, Type: dev
    function private function_b96df1db6657354e( nodereference )
    {
        function_cb7caa09a0749df4( "<dev string:x1cf>" + nodereference.datakey );
    }

    // Namespace namespace_3e8924d2d52a5e37 / namespace_b294929e0e35387a
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x4b9
    // Size: 0xb, Type: dev
    function private function_c3b303ae9042d994()
    {
        return "<dev string:x1dd>";
    }

    // Namespace namespace_3e8924d2d52a5e37 / namespace_b294929e0e35387a
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x4cc
    // Size: 0x1c, Type: dev
    function private function_cb7caa09a0749df4( var_f0443bfaa4783689 )
    {
        iprintln( function_c3b303ae9042d994() + var_f0443bfaa4783689 );
    }

#/
