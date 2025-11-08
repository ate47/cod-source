#using scripts\engine\math;

#namespace namespace_8f7beb0570b92f2f;

// Namespace namespace_8f7beb0570b92f2f / namespace_5346e7f2461d2b76
// Params 0
// Checksum 0x0, Offset: 0xde
// Size: 0x3b
function function_348924356f8bad24()
{
    assert( !isbot( self ) );
    self endon( "disconnect" );
    self.var_6c5a93f08dd4c17a = 0;
    
    while ( !self issprinting() )
    {
        waitframe();
    }
    
    self.var_6c5a93f08dd4c17a = 1;
}

// Namespace namespace_8f7beb0570b92f2f / namespace_5346e7f2461d2b76
// Params 0
// Checksum 0x0, Offset: 0x121
// Size: 0x3b
function function_d4a746782d28e9ad()
{
    assert( !isbot( self ) );
    self endon( "disconnect" );
    self.var_56e1f146cc6f124f = 0;
    
    while ( !self issupersprinting() )
    {
        waitframe();
    }
    
    self.var_56e1f146cc6f124f = 1;
}

// Namespace namespace_8f7beb0570b92f2f / namespace_5346e7f2461d2b76
// Params 0
// Checksum 0x0, Offset: 0x164
// Size: 0x3b
function function_4cf7b50740f57f7b()
{
    assert( !isbot( self ) );
    self endon( "disconnect" );
    self.var_f01dcaab58c1ab99 = 0;
    
    while ( !self function_38932cc1ef28756() )
    {
        waitframe();
    }
    
    self.var_f01dcaab58c1ab99 = 1;
}

// Namespace namespace_8f7beb0570b92f2f / namespace_5346e7f2461d2b76
// Params 3
// Checksum 0x0, Offset: 0x1a7
// Size: 0x78
function function_ee0f48a23c219539( var_a324c7cbbc4f2e30, positivecallback, negativecallback )
{
    assert( !isbot( self ) );
    self endon( "disconnect" );
    inittime = gettime();
    var_a324c7cbbc4f2e30 *= 1000;
    
    while ( !istrue( self.var_6c5a93f08dd4c17a ) )
    {
        if ( gettime() - inittime >= var_a324c7cbbc4f2e30 )
        {
            inittime = gettime();
            [[ negativecallback ]]( self );
        }
        
        waitframe();
    }
    
    [[ positivecallback ]]( self );
}

// Namespace namespace_8f7beb0570b92f2f / namespace_5346e7f2461d2b76
// Params 3
// Checksum 0x0, Offset: 0x227
// Size: 0x78
function function_4dfbc95b23a556f4( var_a324c7cbbc4f2e30, positivecallback, negativecallback )
{
    assert( !isbot( self ) );
    self endon( "disconnect" );
    inittime = gettime();
    var_a324c7cbbc4f2e30 *= 1000;
    
    while ( !istrue( self.var_56e1f146cc6f124f ) )
    {
        if ( gettime() - inittime >= var_a324c7cbbc4f2e30 )
        {
            inittime = gettime();
            [[ negativecallback ]]( self );
        }
        
        waitframe();
    }
    
    [[ positivecallback ]]( self );
}

// Namespace namespace_8f7beb0570b92f2f / namespace_5346e7f2461d2b76
// Params 3
// Checksum 0x0, Offset: 0x2a7
// Size: 0x78
function function_768aaa759077df62( var_a324c7cbbc4f2e30, positivecallback, negativecallback )
{
    assert( !isbot( self ) );
    self endon( "disconnect" );
    inittime = gettime();
    var_a324c7cbbc4f2e30 *= 1000;
    
    while ( !istrue( self.var_f01dcaab58c1ab99 ) )
    {
        if ( gettime() - inittime >= var_a324c7cbbc4f2e30 )
        {
            inittime = gettime();
            [[ negativecallback ]]( self );
        }
        
        waitframe();
    }
    
    [[ positivecallback ]]( self );
}

// Namespace namespace_8f7beb0570b92f2f / namespace_5346e7f2461d2b76
// Params 1
// Checksum 0x0, Offset: 0x327
// Size: 0x81
function function_33749fefab503510( targetdistance )
{
    assert( !isbot( self ) );
    self endon( "disconnect" );
    self.var_7cc4914a032a2df3 = 0;
    self.init_pos = self.origin;
    dist = 0;
    
    while ( dist < targetdistance * 10 )
    {
        dist = distance( self.origin, self.init_pos );
        wait 0.5;
    }
    
    self.var_7cc4914a032a2df3 = 1;
}

// Namespace namespace_8f7beb0570b92f2f / namespace_5346e7f2461d2b76
// Params 2
// Checksum 0x0, Offset: 0x3b0
// Size: 0x6f
function function_87682c85d41c2e13( targetlocation, targetdistance )
{
    assert( !isbot( self ) );
    self endon( "disconnect" );
    self.hasmovedto = 0;
    dist = targetdistance * 10;
    
    while ( dist > targetdistance )
    {
        dist = distance( self.origin, targetlocation );
        wait 0.2;
    }
    
    self.hasmovedto = 1;
}

// Namespace namespace_8f7beb0570b92f2f / namespace_5346e7f2461d2b76
// Params 1
// Checksum 0x0, Offset: 0x428
// Size: 0x9f
function function_105bd25b72f6ea55( anglediff )
{
    assert( !isbot( self ) );
    self endon( "disconnect" );
    self.var_c3661355a5b3083d = 0;
    init_angles = anglestoforward( self getplayerangles( 0 ) );
    init_angles = vectornormalize( init_angles );
    
    while ( true )
    {
        current_angles = anglestoforward( self getplayerangles( 0 ) );
        current_angles = vectornormalize( current_angles );
        dist_angles = anglebetweenvectors( current_angles, init_angles );
        
        if ( isdefined( dist_angles ) && dist_angles >= anglediff )
        {
            self.var_c3661355a5b3083d = 1;
            break;
        }
        
        waitframe();
    }
}

// Namespace namespace_8f7beb0570b92f2f / namespace_5346e7f2461d2b76
// Params 2
// Checksum 0x0, Offset: 0x4d0
// Size: 0x3d
function function_4f94f7b207e54b3f( targetdistance, anglediff )
{
    assert( !isbot( self ) );
    self endon( "disconnect" );
    self.var_e36371bc08c4f3e7 = 0;
    function_a67db5cf006fc19e( targetdistance, anglediff );
}

// Namespace namespace_8f7beb0570b92f2f / namespace_5346e7f2461d2b76
// Params 2
// Checksum 0x0, Offset: 0x516
// Size: 0xe5
function function_a67db5cf006fc19e( targetdistance, anglediff )
{
    assert( !isbot( self ) );
    self endon( "disconnect" );
    self endon( "currentContextualTipCompleted" );
    self endon( "currentContextualTipAborted" );
    self.var_e36371bc08c4f3e7 = 0;
    init_pos = self.origin;
    init_angles = anglestoforward( self getplayerangles( 0 ) );
    
    while ( true )
    {
        dist_pos = distance( self.origin, init_pos );
        current_angles = anglestoforward( self getplayerangles( 0 ) );
        
        if ( current_angles != init_angles )
        {
            dist_angles = anglebetweenvectorsunit( current_angles, init_angles );
            
            if ( isdefined( dist_angles ) && isdefined( dist_pos ) && dist_angles >= anglediff && dist_pos > targetdistance )
            {
                self.var_e36371bc08c4f3e7 = 1;
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_8f7beb0570b92f2f / namespace_5346e7f2461d2b76
// Params 3
// Checksum 0x0, Offset: 0x603
// Size: 0x78
function function_7c4b6588a387e2d5( var_a324c7cbbc4f2e30, positivecallback, negativecallback )
{
    assert( !isbot( self ) );
    self endon( "disconnect" );
    inittime = gettime();
    var_a324c7cbbc4f2e30 *= 1000;
    
    while ( !istrue( self.var_7cc4914a032a2df3 ) )
    {
        if ( gettime() - inittime >= var_a324c7cbbc4f2e30 )
        {
            inittime = gettime();
            [[ negativecallback ]]( self );
        }
        
        waitframe();
    }
    
    [[ positivecallback ]]( self );
}

// Namespace namespace_8f7beb0570b92f2f / namespace_5346e7f2461d2b76
// Params 3
// Checksum 0x0, Offset: 0x683
// Size: 0x78
function function_e58bb74ec5f54731( var_a324c7cbbc4f2e30, positivecallback, negativecallback )
{
    assert( !isbot( self ) );
    self endon( "disconnect" );
    inittime = gettime();
    var_a324c7cbbc4f2e30 *= 1000;
    
    while ( !istrue( self.var_c3661355a5b3083d ) )
    {
        if ( gettime() - inittime >= var_a324c7cbbc4f2e30 )
        {
            inittime = gettime();
            [[ negativecallback ]]( self );
        }
        
        waitframe();
    }
    
    [[ positivecallback ]]( self );
}

// Namespace namespace_8f7beb0570b92f2f / namespace_5346e7f2461d2b76
// Params 3
// Checksum 0x0, Offset: 0x703
// Size: 0x78
function function_e7a33bfb4cba7633( var_a324c7cbbc4f2e30, positivecallback, negativecallback )
{
    assert( !isbot( self ) );
    self endon( "disconnect" );
    inittime = gettime();
    var_a324c7cbbc4f2e30 *= 1000;
    
    while ( !istrue( self.var_e36371bc08c4f3e7 ) )
    {
        if ( gettime() - inittime >= var_a324c7cbbc4f2e30 )
        {
            inittime = gettime();
            [[ negativecallback ]]( self );
        }
        
        waitframe();
    }
    
    [[ positivecallback ]]( self );
}

// Namespace namespace_8f7beb0570b92f2f / namespace_5346e7f2461d2b76
// Params 0
// Checksum 0x0, Offset: 0x783
// Size: 0x1a
function function_f656ad666eda6d08()
{
    result = self isonground();
    return self isonground();
}

