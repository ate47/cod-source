#namespace dev;

/#

    // Namespace dev / scripts\common\dev
    // Params 0
    // Checksum 0x0, Offset: 0x68
    // Size: 0x13, Type: dev
    function init()
    {
        initdvars();
        initthreads();
    }

    // Namespace dev / scripts\common\dev
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x83
    // Size: 0x19, Type: dev
    function private initdvars()
    {
        setdevdvarifuninitialized( @"hash_ebdec3f29783ea70", "<dev string:x1c>" );
    }

    // Namespace dev / scripts\common\dev
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xa4
    // Size: 0xd, Type: dev
    function private initthreads()
    {
        thread function_945e8b4a4a05b526();
    }

    // Namespace dev / scripts\common\dev
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xb9
    // Size: 0x902, Type: dev
    function private function_945e8b4a4a05b526()
    {
        white = ( 1, 1, 1 );
        red = ( 1, 0, 0 );
        green = ( 0, 1, 0 );
        blue = ( 0, 0, 1 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_ebdec3f29783ea70" ) > 0 )
            {
                script_models = getentarray( "<dev string:x1e>", "<dev string:x2b>" );
                script_origins = getentarray( "<dev string:x35>", "<dev string:x2b>" );
                scriptmovercounts = spawnstruct();
                scriptmovercounts.scriptmodeltargets = [];
                scriptmovercounts.scriptmodelnoteworthy = [];
                scriptmovercounts.scriptmodelmisc = 0;
                scriptmovercounts.scriptorigintargets = [];
                scriptmovercounts.scriptoriginnoteworthy = [];
                scriptmovercounts.scriptoriginmisc = 0;
                
                foreach ( ent in script_models )
                {
                    line( ent.origin, ent.origin + anglestoforward( ent.angles ) * 10, red );
                    line( ent.origin, ent.origin + anglestoright( ent.angles ) * 10, green );
                    line( ent.origin, ent.origin + anglestoup( ent.angles ) * 10, blue );
                    
                    if ( isdefined( ent.targetname ) )
                    {
                        color = white;
                        alpha = 1;
                        scale = 1;
                        print3d( ent.origin, ent.targetname, color, alpha, scale );
                        originstring = "<dev string:x43>" + ent.origin[ 0 ] + "<dev string:x45>" + ent.origin[ 1 ] + "<dev string:x45>" + ent.origin[ 2 ] + "<dev string:x48>";
                        print3d( ent.origin + ( 0, 0, -20 ), originstring, color, alpha, scale );
                        
                        if ( isdefined( scriptmovercounts.scriptmodeltargets[ ent.targetname ] ) )
                        {
                            scriptmovercounts.scriptmodeltargets[ ent.targetname ] += 1;
                        }
                        else
                        {
                            scriptmovercounts.scriptmodeltargets[ ent.targetname ] = 1;
                        }
                        
                        continue;
                    }
                    
                    if ( isdefined( ent.script_noteworthy ) )
                    {
                        if ( isdefined( scriptmovercounts.scriptmodelnoteworthy[ ent.script_noteworthy ] ) )
                        {
                            scriptmovercounts.scriptmodelnoteworthy[ ent.script_noteworthy ] += 1;
                        }
                        else
                        {
                            scriptmovercounts.scriptmodelnoteworthy[ ent.script_noteworthy ] = 1;
                        }
                        
                        continue;
                    }
                    
                    scriptmovercounts.scriptmodelmisc += 1;
                }
                
                foreach ( ent in script_origins )
                {
                    line( ent.origin, ent.origin + anglestoforward( ent.angles ) * 10, red );
                    line( ent.origin, ent.origin + anglestoright( ent.angles ) * 10, green );
                    line( ent.origin, ent.origin + anglestoup( ent.angles ) * 10, blue );
                    
                    if ( isdefined( ent.targetname ) )
                    {
                        color = white;
                        alpha = 1;
                        scale = 1;
                        
                        switch ( ent.targetname )
                        {
                            case #"hash_b1841f3499756c6a":
                                color = red;
                                scale = 3;
                                break;
                            case #"hash_18b8d1ddd9bd830d":
                            case #"hash_c7f2713f8146c2fe":
                                color = green;
                                scale = 3;
                                break;
                        }
                        
                        print3d( ent.origin, ent.targetname, color, alpha, scale );
                        originstring = "<dev string:x43>" + ent.origin[ 0 ] + "<dev string:x45>" + ent.origin[ 1 ] + "<dev string:x45>" + ent.origin[ 2 ] + "<dev string:x48>";
                        print3d( ent.origin + ( 0, 0, -20 ), originstring, color, alpha, scale );
                        
                        if ( isdefined( scriptmovercounts.scriptorigintargets[ ent.targetname ] ) )
                        {
                            scriptmovercounts.scriptorigintargets[ ent.targetname ] += 1;
                        }
                        else
                        {
                            scriptmovercounts.scriptorigintargets[ ent.targetname ] = 1;
                        }
                        
                        continue;
                    }
                    
                    if ( isdefined( ent.script_noteworthy ) )
                    {
                        if ( isdefined( scriptmovercounts.scriptoriginnoteworthy[ ent.script_noteworthy ] ) )
                        {
                            scriptmovercounts.scriptoriginnoteworthy[ ent.script_noteworthy ] += 1;
                        }
                        else
                        {
                            scriptmovercounts.scriptoriginnoteworthy[ ent.script_noteworthy ] = 1;
                        }
                        
                        continue;
                    }
                    
                    scriptmovercounts.scriptoriginmisc += 1;
                }
                
                screenposx = 400;
                screenposy = 50;
                screenposyspacing = 15;
                printtoscreen2d( screenposx, screenposy, "<dev string:x70>" );
                screenposy += screenposyspacing;
                printtoscreen2d( screenposx, screenposy, "<dev string:x8b>" );
                screenposy += screenposyspacing;
                printtoscreen2d( screenposx, screenposy, "<dev string:x9a>" + scriptmovercounts.scriptmodelmisc );
                screenposy += screenposyspacing;
                printtoscreen2d( screenposx, screenposy, "<dev string:xaa>" );
                screenposy += screenposyspacing;
                
                foreach ( targetname, targetcount in scriptmovercounts.scriptmodeltargets )
                {
                    printtoscreen2d( screenposx, screenposy, targetname + "<dev string:xb2>" + targetcount );
                    screenposy += screenposyspacing;
                }
                
                printtoscreen2d( screenposx, screenposy, "<dev string:xb5>" );
                screenposy += screenposyspacing;
                
                foreach ( noteworthyname, noteworthycount in scriptmovercounts.scriptmodelnoteworthy )
                {
                    printtoscreen2d( screenposx, screenposy, noteworthyname + "<dev string:xb2>" + noteworthycount );
                    screenposy += screenposyspacing;
                }
                
                printtoscreen2d( screenposx, screenposy, "<dev string:xc1>" );
                screenposy += screenposyspacing;
                printtoscreen2d( screenposx, screenposy, "<dev string:x9a>" + scriptmovercounts.scriptoriginmisc );
                screenposy += screenposyspacing;
                printtoscreen2d( screenposx, screenposy, "<dev string:xaa>" );
                screenposy += screenposyspacing;
                
                foreach ( targetcount in scriptmovercounts.scriptorigintargets )
                {
                    printtoscreen2d( screenposx, screenposy, targetname + "<dev string:xb2>" + targetcount );
                    screenposy += screenposyspacing;
                }
                
                printtoscreen2d( screenposx, screenposy, "<dev string:xb5>" );
                screenposy += screenposyspacing;
                
                foreach ( noteworthycount in scriptmovercounts.scriptoriginnoteworthy )
                {
                    printtoscreen2d( screenposx, screenposy, noteworthyname + "<dev string:xb2>" + noteworthycount );
                    screenposy += screenposyspacing;
                }
            }
            
            wait 0.05;
        }
    }

#/
