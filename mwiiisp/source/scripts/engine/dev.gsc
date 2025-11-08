#using scripts\engine\utility;

#namespace dev;

/#

    // Namespace dev / scripts\engine\dev
    // Params 2
    // Checksum 0x0, Offset: 0x70
    // Size: 0xa5, Type: dev
    function devcommandwatcher( dvarname, commandhandlerfunc )
    {
        setdevdvar( dvarname, "<dev string:x1c>" );
        
        while ( true )
        {
            waitframe();
            dvarvalue = getdvar( dvarname );
            
            if ( dvarvalue == "<dev string:x1c>" )
            {
                continue;
            }
            
            setdevdvar( dvarname, "<dev string:x1c>" );
            tokens = strtok( dvarvalue, "<dev string:x1d>" );
            
            if ( !isdefined( tokens ) || tokens.size < 1 )
            {
                continue;
            }
            
            command = tokens[ 0 ];
            arglist = array_slice( tokens, 1 );
            [[ commandhandlerfunc ]]( command, arglist );
        }
    }

#/
