#namespace debug;

/#

    // Namespace debug / scripts\mp\utility\debug
    // Params 5
    // Checksum 0x0, Offset: 0x88
    // Size: 0xa5, Type: dev
    function drawent( ent, radius, forwardlen, drawtimeseconds, color )
    {
        drawframes = int( drawtimeseconds / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            sphere( ent.origin, radius, color );
            line( ent.origin, ent.origin + anglestoforward( ent.angles ) * forwardlen, color );
            waitframe();
        }
    }

    // Namespace debug / scripts\mp\utility\debug
    // Params 4
    // Checksum 0x0, Offset: 0x135
    // Size: 0x63, Type: dev
    function drawline( start, end, drawtimeseconds, color )
    {
        drawframes = int( drawtimeseconds / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            line( start, end, color );
            waitframe();
        }
    }

    // Namespace debug / scripts\mp\utility\debug
    // Params 4
    // Checksum 0x0, Offset: 0x1a0
    // Size: 0x63, Type: dev
    function drawsphere( origin, radius, drawtimeseconds, color )
    {
        drawframes = int( drawtimeseconds / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            sphere( origin, radius, color );
            waitframe();
        }
    }

    // Namespace debug / scripts\mp\utility\debug
    // Params 4
    // Checksum 0x0, Offset: 0x20b
    // Size: 0xf1, Type: dev
    function drawangles( origin, angles, var_3e6845817408f87e, scalar )
    {
        if ( !isdefined( scalar ) )
        {
            scalar = 1;
        }
        
        drawframes = int( var_3e6845817408f87e / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            fwd = anglestoforward( angles );
            right = anglestoright( angles );
            up = anglestoup( angles );
            line( origin, origin + fwd * 12 * scalar, ( 1, 0, 0 ) );
            line( origin, origin + right * 12 * scalar, ( 0, 1, 0 ) );
            line( origin, origin + up * 12 * scalar, ( 0, 0, 1 ) );
            waitframe();
        }
    }

#/
