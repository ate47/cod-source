#using scripts\common\utility;
#using scripts\cp_mp\interaction;
#using scripts\engine\utility;

#namespace trigger;

// Namespace trigger / scripts\mp\utility\trigger
// Params 0
// Checksum 0x0, Offset: 0x15d
// Size: 0x67
function triggerutilityinit()
{
    var_559b1c2dc581f10c = getentarray( "trigger_multiple_mp_enterexit", "classname" );
    
    foreach ( trigger in var_559b1c2dc581f10c )
    {
        makeenterexittrigger( trigger );
    }
}

// Namespace trigger / scripts\mp\utility\trigger
// Params 6
// Checksum 0x0, Offset: 0x1cc
// Size: 0x41
function makeenterexittrigger( trigger, enterfunc, exitfunc, var_1fa4e076aba70ab9, var_768b0479668f27b, filterfunc )
{
    trigger thread triggerenterthink( enterfunc, exitfunc, var_1fa4e076aba70ab9, var_768b0479668f27b, filterfunc );
}

// Namespace trigger / scripts\mp\utility\trigger
// Params 5
// Checksum 0x0, Offset: 0x215
// Size: 0x115
function triggerenterthink( enterfunc, exitfunc, var_1fa4e076aba70ab9, var_768b0479668f27b, filterfunc )
{
    level endon( "game_ended" );
    self endon( "death" );
    self.triggerenterents = [];
    self.triggerinsidetimes = [];
    thread triggerexitthink( exitfunc, var_768b0479668f27b );
    
    while ( true )
    {
        self waittill( "trigger", triggeringent );
        
        if ( isdefined( filterfunc ) && [[ filterfunc ]]( triggeringent, self ) )
        {
            continue;
        }
        
        var_6b6f0d5308b1ceab = triggeringent getentitynumber();
        
        if ( !isdefined( self.triggerenterents[ var_6b6f0d5308b1ceab ] ) )
        {
            self notify( "trigger_enter", triggeringent );
            
            if ( isdefined( enterfunc ) )
            {
                triggeringent thread [[ enterfunc ]]( triggeringent, self );
            }
            
            if ( isdefined( var_1fa4e076aba70ab9 ) )
            {
                triggeringent notify( var_1fa4e076aba70ab9, self );
            }
            
            self.triggerenterents[ var_6b6f0d5308b1ceab ] = triggeringent;
            self.triggerinsidetimes[ var_6b6f0d5308b1ceab ] = gettime();
        }
        else
        {
            self.triggerinsidetimes[ var_6b6f0d5308b1ceab ] = gettime();
        }
        
        assert( self.triggerenterents.size == self.triggerinsidetimes.size );
    }
}

// Namespace trigger / scripts\mp\utility\trigger
// Params 2
// Checksum 0x0, Offset: 0x332
// Size: 0x11d
function triggerexitthink( exitfunc, var_768b0479668f27b )
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( true )
    {
        waittillframeend();
        assert( self.triggerenterents.size == self.triggerinsidetimes.size );
        var_291148d7c3e8d5e3 = gettime();
        
        foreach ( entid, ent in self.triggerenterents )
        {
            if ( !isdefined( ent ) )
            {
                self.triggerenterents[ entid ] = undefined;
                self.triggerinsidetimes[ entid ] = undefined;
                continue;
            }
            
            assert( isdefined( self.triggerinsidetimes[ entid ] ) );
            
            if ( self.triggerinsidetimes[ entid ] < var_291148d7c3e8d5e3 )
            {
                self notify( "trigger_exit", ent );
                
                if ( isdefined( exitfunc ) )
                {
                    ent thread [[ exitfunc ]]( ent, self );
                }
                
                if ( isdefined( var_768b0479668f27b ) )
                {
                    ent notify( var_768b0479668f27b, self );
                }
                
                self.triggerenterents[ entid ] = undefined;
                self.triggerinsidetimes[ entid ] = undefined;
            }
        }
        
        waitframe();
    }
}

// Namespace trigger / scripts\mp\utility\trigger
// Params 0
// Checksum 0x0, Offset: 0x457
// Size: 0x81
function function_d7f524cd920e0c79()
{
    flag_wait( "StartGameTypeCallbackFinished" );
    waitframe();
    var_c85c96521b9fa174 = getentarray( "gesture_trigger", "script_noteworthy" );
    
    if ( !isdefined( var_c85c96521b9fa174 ) )
    {
        return;
    }
    
    foreach ( gesture_trigger in var_c85c96521b9fa174 )
    {
        function_32645103f7520635( gesture_trigger, undefined, undefined, &function_81b4c641c1611463 );
    }
}

// Namespace trigger / scripts\mp\utility\trigger
// Params 1
// Checksum 0x0, Offset: 0x4e0
// Size: 0x1e
function function_643debdd070d5477( var_6001320cbfd4d138 )
{
    if ( !isdefined( var_6001320cbfd4d138 ) )
    {
        return;
    }
    
    self giveandfireoffhand( makeweapon( var_6001320cbfd4d138 ) );
}

// Namespace trigger / scripts\mp\utility\trigger
// Params 1
// Checksum 0x0, Offset: 0x506
// Size: 0x3d
function function_81b4c641c1611463( player )
{
    grenadename = "";
    
    if ( isdefined( self.targetname ) )
    {
        grenadename = self.targetname;
    }
    
    player function_643debdd070d5477( grenadename );
}

