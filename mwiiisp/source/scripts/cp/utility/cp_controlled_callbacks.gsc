#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace cp_controlled_callbacks;

// Namespace cp_controlled_callbacks / scripts\cp\utility\cp_controlled_callbacks
// Params 9
// Checksum 0x0, Offset: 0x1f5
// Size: 0x194
function registercontrolledcallback( tag, eventcallback, timeout, evaluationcallback, bisthread, bischildthread, var_8808e5af3dd6cb90, biscodefunc, bnoself )
{
    if ( !isdefined( level.controlledcallbacks ) )
    {
        level.controlledcallbacks = [];
    }
    
    if ( !isdefined( level.controlledcallbacksqueue ) )
    {
        level.controlledcallbacksqueue = [];
    }
    
    if ( istrue( biscodefunc ) )
    {
        assertex( isbuiltinfunction( eventcallback ) || isbuiltinmethod( eventcallback ), " Parameter passed into registerControlledCallback(...) MUST be a Code Function" );
        
        if ( !isbuiltinfunction( eventcallback ) && !isbuiltinmethod( eventcallback ) )
        {
            return;
        }
    }
    else
    {
        assertex( isfunction( eventcallback ), " Parameter passed into registerControlledCallback(...) MUST be a Script function" );
        
        if ( !isfunction( eventcallback ) )
        {
            return;
        }
    }
    
    level.controlledcallbacks[ tag ] = spawnstruct();
    level.controlledcallbacks[ tag ].eventcallback = eventcallback;
    level.controlledcallbacks[ tag ].bisthread = bisthread;
    level.controlledcallbacks[ tag ].bischildthread = bischildthread;
    level.controlledcallbacks[ tag ].biscodefunc = biscodefunc;
    level.controlledcallbacks[ tag ].bnoself = bnoself;
    level.controlledcallbacks[ tag ].timeout = timeout;
    level.controlledcallbacks[ tag ].evaluationcallback = evaluationcallback;
}

// Namespace cp_controlled_callbacks / scripts\cp\utility\cp_controlled_callbacks
// Params 9
// Checksum 0x0, Offset: 0x391
// Size: 0x7f6
function runcontrolledcallback( tag, var1, var2, var3, var4, var5, var6, var7, var8 )
{
    assertex( isdefined( level.controlledcallbacks[ tag ] ), " tag isn't registered as a controlled event. Please call registerControlledCallback(...) first " );
    
    if ( !isdefined( level.controlledcallbacks[ tag ] ) )
    {
        return;
    }
    
    process = level.controlledcallbacks[ tag ].eventcallback;
    var_76422ef20493dcd8 = &evaluatecontrolledcallback;
    var_782b865a4e685610 = 1;
    
    if ( isdefined( var8 ) )
    {
        var_782b865a4e685610 = [[ var_76422ef20493dcd8 ]]( tag, var1, var2, var3, var4, var5, var6, var7, var8 );
    }
    else if ( isdefined( var7 ) )
    {
        var_782b865a4e685610 = [[ var_76422ef20493dcd8 ]]( tag, var1, var2, var3, var4, var5, var6, var7 );
    }
    else if ( isdefined( var6 ) )
    {
        var_782b865a4e685610 = [[ var_76422ef20493dcd8 ]]( tag, var1, var2, var3, var4, var5, var6 );
    }
    else if ( isdefined( var5 ) )
    {
        var_782b865a4e685610 = [[ var_76422ef20493dcd8 ]]( tag, var1, var2, var3, var4, var5 );
    }
    else if ( isdefined( var4 ) )
    {
        var_782b865a4e685610 = [[ var_76422ef20493dcd8 ]]( tag, var1, var2, var3, var4 );
    }
    else if ( isdefined( var3 ) )
    {
        var_782b865a4e685610 = [[ var_76422ef20493dcd8 ]]( tag, var1, var2, var3 );
    }
    else if ( isdefined( var2 ) )
    {
        var_782b865a4e685610 = [[ var_76422ef20493dcd8 ]]( tag, var1, var2 );
    }
    else if ( isdefined( var1 ) )
    {
        var_782b865a4e685610 = [[ var_76422ef20493dcd8 ]]( tag, var1 );
    }
    else
    {
        var_782b865a4e685610 = [[ var_76422ef20493dcd8 ]]( tag );
    }
    
    if ( var_782b865a4e685610 )
    {
        thread managecontrolledcallbacktimeout( tag );
        
        if ( istrue( level.controlledcallbacks[ tag ].biscodefunc ) )
        {
            if ( istrue( level.controlledcallbacks[ tag ].bnoself ) )
            {
                if ( isdefined( var8 ) )
                {
                    if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                    {
                        builtin [[ process ]]( var1, var2, var3, var4, var5, var6, var7, var8 );
                        return;
                    }
                    
                    [[ process ]]( var1, var2, var3, var4, var5, var6, var7, var8 );
                    return;
                }
                
                if ( isdefined( var7 ) )
                {
                    if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                    {
                        builtin [[ process ]]( var1, var2, var3, var4, var5, var6, var7 );
                        return;
                    }
                    
                    [[ process ]]( var1, var2, var3, var4, var5, var6, var7 );
                    return;
                }
                
                if ( isdefined( var6 ) )
                {
                    if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                    {
                        builtin [[ process ]]( var1, var2, var3, var4, var5, var6 );
                        return;
                    }
                    
                    [[ process ]]( var1, var2, var3, var4, var5, var6 );
                    return;
                }
                
                if ( isdefined( var5 ) )
                {
                    if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                    {
                        builtin [[ process ]]( var1, var2, var3, var4, var5 );
                        return;
                    }
                    
                    [[ process ]]( var1, var2, var3, var4, var5 );
                    return;
                }
                
                if ( isdefined( var4 ) )
                {
                    if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                    {
                        builtin [[ process ]]( var1, var2, var3, var4 );
                        return;
                    }
                    
                    [[ process ]]( var1, var2, var3, var4 );
                    return;
                }
                
                if ( isdefined( var3 ) )
                {
                    if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                    {
                        builtin [[ process ]]( var1, var2, var3 );
                        return;
                    }
                    
                    [[ process ]]( var1, var2, var3 );
                    return;
                }
                
                if ( isdefined( var2 ) )
                {
                    if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                    {
                        builtin [[ process ]]( var1, var2 );
                        return;
                    }
                    
                    [[ process ]]( var1, var2 );
                    return;
                }
                
                if ( isdefined( var1 ) )
                {
                    if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                    {
                        builtin [[ process ]]( var1 );
                        return;
                    }
                    
                    [[ process ]]( var1 );
                    return;
                }
                
                if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                {
                    builtin [[ process ]]();
                    return;
                }
                
                [[ process ]]();
                return;
            }
            else
            {
                if ( isdefined( var8 ) )
                {
                    if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                    {
                        self builtin [[ process ]]( var1, var2, var3, var4, var5, var6, var7, var8 );
                        return;
                    }
                    
                    self [[ process ]]( var1, var2, var3, var4, var5, var6, var7, var8 );
                    return;
                }
                
                if ( isdefined( var7 ) )
                {
                    if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                    {
                        self builtin [[ process ]]( var1, var2, var3, var4, var5, var6, var7 );
                        return;
                    }
                    
                    self [[ process ]]( var1, var2, var3, var4, var5, var6, var7 );
                    return;
                }
                
                if ( isdefined( var6 ) )
                {
                    if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                    {
                        self builtin [[ process ]]( var1, var2, var3, var4, var5, var6 );
                        return;
                    }
                    
                    self [[ process ]]( var1, var2, var3, var4, var5, var6 );
                    return;
                }
                
                if ( isdefined( var5 ) )
                {
                    if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                    {
                        self builtin [[ process ]]( var1, var2, var3, var4, var5 );
                        return;
                    }
                    
                    self [[ process ]]( var1, var2, var3, var4, var5 );
                    return;
                }
                
                if ( isdefined( var4 ) )
                {
                    if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                    {
                        self builtin [[ process ]]( var1, var2, var3, var4 );
                        return;
                    }
                    
                    self [[ process ]]( var1, var2, var3, var4 );
                    return;
                }
                
                if ( isdefined( var3 ) )
                {
                    if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                    {
                        self builtin [[ process ]]( var1, var2, var3 );
                        return;
                    }
                    
                    self [[ process ]]( var1, var2, var3 );
                    return;
                }
                
                if ( isdefined( var2 ) )
                {
                    if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                    {
                        self builtin [[ process ]]( var1, var2 );
                        return;
                    }
                    
                    self [[ process ]]( var1, var2 );
                    return;
                }
                
                if ( isdefined( var1 ) )
                {
                    if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                    {
                        self builtin [[ process ]]( var1 );
                        return;
                    }
                    
                    self [[ process ]]( var1 );
                    return;
                }
                
                if ( isbuiltinfunction( process ) || isbuiltinmethod( process ) )
                {
                    self builtin [[ process ]]();
                    return;
                }
                
                self [[ process ]]();
                return;
            }
        }
        
        assertex( !istrue( level.controlledcallbacks[ tag ].biscodefunc ), " .bIsCodeFunc should not be set to true for Script Functions. Check call registerControlledCallback(...) " );
        
        if ( istrue( level.controlledcallbacks[ tag ].bisthread ) )
        {
            if ( isdefined( var8 ) )
            {
                self thread [[ process ]]( var1, var2, var3, var4, var5, var6, var7, var8 );
                return;
            }
            
            if ( isdefined( var7 ) )
            {
                self thread [[ process ]]( var1, var2, var3, var4, var5, var6, var7 );
                return;
            }
            
            if ( isdefined( var6 ) )
            {
                self thread [[ process ]]( var1, var2, var3, var4, var5, var6 );
                return;
            }
            
            if ( isdefined( var5 ) )
            {
                self thread [[ process ]]( var1, var2, var3, var4, var5 );
                return;
            }
            
            if ( isdefined( var4 ) )
            {
                self thread [[ process ]]( var1, var2, var3, var4 );
                return;
            }
            
            if ( isdefined( var3 ) )
            {
                self thread [[ process ]]( var1, var2, var3 );
                return;
            }
            
            if ( isdefined( var2 ) )
            {
                self thread [[ process ]]( var1, var2 );
                return;
            }
            
            if ( isdefined( var1 ) )
            {
                self thread [[ process ]]( var1 );
                return;
            }
            
            self thread [[ process ]]();
            return;
        }
        
        if ( istrue( level.controlledcallbacks[ tag ].bischildthread ) )
        {
            if ( isdefined( var8 ) )
            {
                self childthread [[ process ]]( var1, var2, var3, var4, var5, var6, var7, var8 );
                return;
            }
            
            if ( isdefined( var7 ) )
            {
                self childthread [[ process ]]( var1, var2, var3, var4, var5, var6, var7 );
                return;
            }
            
            if ( isdefined( var6 ) )
            {
                self childthread [[ process ]]( var1, var2, var3, var4, var5, var6 );
                return;
            }
            
            if ( isdefined( var5 ) )
            {
                self childthread [[ process ]]( var1, var2, var3, var4, var5 );
                return;
            }
            
            if ( isdefined( var4 ) )
            {
                self childthread [[ process ]]( var1, var2, var3, var4 );
                return;
            }
            
            if ( isdefined( var3 ) )
            {
                self childthread [[ process ]]( var1, var2, var3 );
                return;
            }
            
            if ( isdefined( var2 ) )
            {
                self childthread [[ process ]]( var1, var2 );
                return;
            }
            
            if ( isdefined( var1 ) )
            {
                self childthread [[ process ]]( var1 );
                return;
            }
            
            self childthread [[ process ]]();
            return;
        }
        
        if ( isdefined( var8 ) )
        {
            self [[ process ]]( var1, var2, var3, var4, var5, var6, var7, var8 );
            return;
        }
        
        if ( isdefined( var7 ) )
        {
            self [[ process ]]( var1, var2, var3, var4, var5, var6, var7 );
            return;
        }
        
        if ( isdefined( var6 ) )
        {
            self [[ process ]]( var1, var2, var3, var4, var5, var6 );
            return;
        }
        
        if ( isdefined( var5 ) )
        {
            self [[ process ]]( var1, var2, var3, var4, var5 );
            return;
        }
        
        if ( isdefined( var4 ) )
        {
            self [[ process ]]( var1, var2, var3, var4 );
            return;
        }
        
        if ( isdefined( var3 ) )
        {
            self [[ process ]]( var1, var2, var3 );
            return;
        }
        
        if ( isdefined( var2 ) )
        {
            self [[ process ]]( var1, var2 );
            return;
        }
        
        if ( isdefined( var1 ) )
        {
            self [[ process ]]( var1 );
            return;
        }
        
        self [[ process ]]();
        return;
    }
    
    /#
        if ( getdvarint( @"hash_4943aa29d7acc892", 0 ) != 0 )
        {
            iprintln( "<dev string:x1c>" + tag );
        }
    #/
}

// Namespace cp_controlled_callbacks / scripts\cp\utility\cp_controlled_callbacks
// Params 9
// Checksum 0x0, Offset: 0xb8f
// Size: 0x1bb
function evaluatecontrolledcallback( tag, var1, var2, var3, var4, var5, var6, var7, var8 )
{
    if ( array_contains( level.controlledcallbacksqueue, tag ) )
    {
        return 0;
    }
    
    if ( isdefined( level.controlledcallbacks[ tag ].evaluationcallback ) )
    {
        if ( isdefined( var8 ) )
        {
            return [[ level.controlledcallbacks[ tag ].evaluationcallback ]]( var1, var2, var3, var4, var5, var6, var7, var8 );
        }
        
        if ( isdefined( var7 ) )
        {
            return [[ level.controlledcallbacks[ tag ].evaluationcallback ]]( var1, var2, var3, var4, var5, var6, var7 );
        }
        
        if ( isdefined( var6 ) )
        {
            return [[ level.controlledcallbacks[ tag ].evaluationcallback ]]( var1, var2, var3, var4, var5, var6 );
        }
        
        if ( isdefined( var5 ) )
        {
            return [[ level.controlledcallbacks[ tag ].evaluationcallback ]]( var1, var2, var3, var4, var5 );
        }
        
        if ( isdefined( var4 ) )
        {
            return [[ level.controlledcallbacks[ tag ].evaluationcallback ]]( var1, var2, var3, var4 );
        }
        
        if ( isdefined( var3 ) )
        {
            return [[ level.controlledcallbacks[ tag ].evaluationcallback ]]( var1, var2, var3 );
        }
        
        if ( isdefined( var2 ) )
        {
            return [[ level.controlledcallbacks[ tag ].evaluationcallback ]]( var1, var2 );
        }
        
        if ( isdefined( var1 ) )
        {
            return [[ level.controlledcallbacks[ tag ].evaluationcallback ]]( var1 );
        }
        
        return [[ level.controlledcallbacks[ tag ].evaluationcallback ]]();
    }
    
    return 1;
}

// Namespace cp_controlled_callbacks / scripts\cp\utility\cp_controlled_callbacks
// Params 1
// Checksum 0x0, Offset: 0xd53
// Size: 0x86
function managecontrolledcallbacktimeout( tag )
{
    level endon( "game_ended" );
    timeout = 0.05;
    level.controlledcallbacksqueue = array_add_safe( level.controlledcallbacksqueue, tag );
    
    if ( isdefined( level.controlledcallbacks[ tag ].timeout ) )
    {
        timeout = level.controlledcallbacks[ tag ].timeout;
    }
    
    wait timeout;
    level.controlledcallbacksqueue = array_remove( level.controlledcallbacksqueue, tag );
}

