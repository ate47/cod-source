#using scripts\cp_mp\utility\game_utility;

#namespace arbitrary_up;

// Namespace arbitrary_up / scripts\mp\arbitrary_up
// Params 0
// Checksum 0x0, Offset: 0xbe
// Size: 0x16b
function initarbitraryuptriggers()
{
    if ( isdefined( level.arbitraryuptriggers ) )
    {
        return;
    }
    
    level.arbitraryuptriggers = [];
    level.arbitraryuptriggersstructs = [];
    
    if ( getmapname() == "mp_junk" )
    {
        arbitraryuptriggers = getentarray( "mag_up", "targetname" );
        
        if ( !isdefined( arbitraryuptriggers ) || arbitraryuptriggers.size == 0 )
        {
            return;
        }
        
        level.arbitraryuptriggers = arbitraryuptriggers;
        
        foreach ( trigger in arbitraryuptriggers )
        {
            entnum = trigger getentitynumber();
            triggerstruct = spawnstruct();
            triggerstruct.trigger = trigger;
            triggerstruct.base = undefined;
            triggerstruct.entsinside = [];
            
            if ( isdefined( trigger.target ) )
            {
                triggerstruct.base = getent( trigger.target, "targetname" );
                triggerstruct.blinkloc = triggerstruct.base.origin + ( 0, 0, -175 );
            }
            
            level.arbitraryuptriggersstructs[ entnum ] = triggerstruct;
            thread watcharbitraryuptriggerenter( triggerstruct );
            thread watcharbitraryuptriggerexit( triggerstruct );
        }
    }
}

// Namespace arbitrary_up / scripts\mp\arbitrary_up
// Params 1
// Checksum 0x0, Offset: 0x231
// Size: 0x73
function watcharbitraryuptriggerenter( triggerstruct )
{
    while ( true )
    {
        triggerstruct.trigger waittill( "trigger", ent );
        
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( !shouldaddtoarbitraryuptrigger( triggerstruct, ent ) )
        {
            continue;
        }
        
        entnum = ent getentitynumber();
        triggerstruct.entsinside[ entnum ] = ent;
        ent.arbitraryuptriggerstruct = triggerstruct;
    }
}

// Namespace arbitrary_up / scripts\mp\arbitrary_up
// Params 1
// Checksum 0x0, Offset: 0x2ac
// Size: 0xc0
function watcharbitraryuptriggerexit( triggerstruct )
{
    while ( true )
    {
        foreach ( ent in triggerstruct.entsinside )
        {
            if ( !isdefined( ent ) )
            {
                continue;
            }
            
            if ( !shouldremovefromarbitraryuptrigger( triggerstruct, ent ) )
            {
                continue;
            }
            
            entnum = ent getentitynumber();
            triggerstruct.entsinside[ entnum ] = undefined;
            
            if ( isdefined( ent.arbitraryuptriggerstruct ) && ent.arbitraryuptriggerstruct == triggerstruct )
            {
                ent.arbitraryuptriggerstruct = undefined;
            }
        }
        
        waitframe();
    }
}

// Namespace arbitrary_up / scripts\mp\arbitrary_up
// Params 2
// Checksum 0x0, Offset: 0x374
// Size: 0x45, Type: bool
function shouldaddtoarbitraryuptrigger( triggerstruct, ent )
{
    if ( !isplayer( ent ) )
    {
        return false;
    }
    
    entnum = ent getentitynumber();
    
    if ( isdefined( triggerstruct.entsinside[ entnum ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace arbitrary_up / scripts\mp\arbitrary_up
// Params 2
// Checksum 0x0, Offset: 0x3c2
// Size: 0x2b, Type: bool
function shouldremovefromarbitraryuptrigger( triggerstruct, ent )
{
    if ( !ent istouching( triggerstruct.trigger ) )
    {
        return true;
    }
    
    return false;
}

// Namespace arbitrary_up / scripts\mp\arbitrary_up
// Params 0
// Checksum 0x0, Offset: 0x3f6
// Size: 0x24
function getarbitraryuptrigger()
{
    if ( !isdefined( self.arbitraryuptriggerstruct ) )
    {
        return undefined;
    }
    
    return self.arbitraryuptriggerstruct.trigger;
}

// Namespace arbitrary_up / scripts\mp\arbitrary_up
// Params 0
// Checksum 0x0, Offset: 0x423
// Size: 0x24
function getarbitraryuptriggerbase()
{
    if ( !isdefined( self.arbitraryuptriggerstruct ) )
    {
        return undefined;
    }
    
    return self.arbitraryuptriggerstruct.base;
}

// Namespace arbitrary_up / scripts\mp\arbitrary_up
// Params 0
// Checksum 0x0, Offset: 0x450
// Size: 0x24
function getarbitraryuptriggerblinkloc()
{
    if ( !isdefined( self.arbitraryuptriggerstruct ) )
    {
        return undefined;
    }
    
    return self.arbitraryuptriggerstruct.blinkloc;
}

// Namespace arbitrary_up / scripts\mp\arbitrary_up
// Params 0
// Checksum 0x0, Offset: 0x47d
// Size: 0x26, Type: bool
function isinarbitraryup()
{
    if ( isplayer( self ) )
    {
        if ( self getworldupreferenceangles() != ( 0, 0, 0 ) )
        {
            return true;
        }
    }
    
    return false;
}

