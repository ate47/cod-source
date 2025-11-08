#using scripts\common\utility;
#using scripts\engine\utility;

#namespace vision_utility;

// Namespace vision_utility / scripts\cp_mp\utility\vision_utility
// Params 2
// Checksum 0x0, Offset: 0xb8
// Size: 0x94
function function_27a921508cb04613( visionset, transitionduration )
{
    assertex( isdefined( visionset ) || visionset == "<dev string:x1c>", "<dev string:x20>" );
    
    if ( !isdefined( transitionduration ) )
    {
        transitionduration = 0;
    }
    
    if ( !isdefined( self.activevisionsetlist ) )
    {
        self.activevisionsetlist = [];
    }
    
    if ( !isdefined( self.activevisionsetlist[ visionset ] ) )
    {
        self.activevisionsetlist[ visionset ] = 1;
    }
    else
    {
        self.activevisionsetlist[ visionset ]++;
    }
    
    if ( self.activevisionsetlist[ visionset ] == 1 )
    {
        thread function_47c42aba7e6b41e3( visionset, transitionduration );
    }
}

// Namespace vision_utility / scripts\cp_mp\utility\vision_utility
// Params 2
// Checksum 0x0, Offset: 0x154
// Size: 0xc5
function function_9a92ae402e209ecc( visionset, removeduration )
{
    if ( !isdefined( self.activevisionsetlist ) )
    {
        return;
    }
    
    if ( !isdefined( self.activevisionsetlist[ visionset ] ) )
    {
        return;
    }
    
    self.activevisionsetlist[ visionset ]--;
    
    if ( self.activevisionsetlist[ visionset ] == 0 )
    {
        var_bfd32f432f9daccf = [];
        
        foreach ( visionindex, visionsetcount in self.activevisionsetlist )
        {
            if ( visionindex == visionset )
            {
                continue;
            }
            
            var_bfd32f432f9daccf[ visionindex ] = visionsetcount;
        }
        
        self.activevisionsetlist = var_bfd32f432f9daccf;
        thread function_5936afcd0e190a3b( removeduration );
    }
}

// Namespace vision_utility / scripts\cp_mp\utility\vision_utility
// Params 0
// Checksum 0x0, Offset: 0x221
// Size: 0x27
function function_cb1caaf18300a508()
{
    thread function_47c42aba7e6b41e3( "", 0 );
    
    if ( isdefined( self.activevisionsetlist ) )
    {
        self.activevisionsetlist = undefined;
    }
}

// Namespace vision_utility / scripts\cp_mp\utility\vision_utility
// Params 1
// Checksum 0x0, Offset: 0x250
// Size: 0x3f, Type: bool
function function_8e888e08a6ab22d3( visionset )
{
    if ( !isdefined( self.activevisionsetlist ) || !isdefined( self.activevisionsetlist[ visionset ] ) )
    {
        return false;
    }
    
    if ( self.activevisionsetlist[ visionset ] > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace vision_utility / scripts\cp_mp\utility\vision_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x298
// Size: 0x9a
function private function_5936afcd0e190a3b( removeduration )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    dur = 0;
    
    if ( isdefined( removeduration ) )
    {
        dur = removeduration;
    }
    
    thread function_47c42aba7e6b41e3( "", dur );
    
    if ( dur > 0 )
    {
        wait dur;
        waitframe();
    }
    
    foreach ( visionindex, visionsetcount in self.activevisionsetlist )
    {
        thread function_47c42aba7e6b41e3( visionindex, dur );
        waitframe();
    }
}

// Namespace vision_utility / scripts\cp_mp\utility\vision_utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x33a
// Size: 0x59
function private function_47c42aba7e6b41e3( visionset, transitionduration )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    while ( istrue( self.var_679f06b0517f5168 ) )
    {
        waitframe();
    }
    
    self.var_679f06b0517f5168 = 1;
    self visionsetnakedforplayer( visionset, transitionduration );
    
    if ( transitionduration > 0 )
    {
        wait transitionduration;
    }
    
    waitframe();
    self.var_679f06b0517f5168 = undefined;
}

