#namespace ai_pickups;

// Namespace ai_pickups / scripts\aitypes\ai_pickups
// Params 9
// Checksum 0x0, Offset: 0x87
// Size: 0x103
function function_fbc045e84cf575ae( name, seekradius, pickupgoalradius, var_47f82a4d9a77876f, var_c4356a88633f476d, var_65d0778d90ececae, canusefunc, usefunc, additionaldata )
{
    if ( !isdefined( level.var_634b074c62f96cd3 ) )
    {
        level.var_634b074c62f96cd3 = [];
    }
    
    assert( !isdefined( level.var_634b074c62f96cd3[ name ] ) );
    newpickupdef = spawnstruct();
    newpickupdef.seekradius = seekradius;
    newpickupdef.pickupgoalradius = pickupgoalradius;
    newpickupdef.var_47f82a4d9a77876f = var_47f82a4d9a77876f;
    newpickupdef.var_c4356a88633f476d = var_c4356a88633f476d;
    newpickupdef.var_65d0778d90ececae = var_65d0778d90ececae;
    newpickupdef.canusefunc = canusefunc;
    newpickupdef.usefunc = usefunc;
    newpickupdef.additionaldata = additionaldata;
    level.var_634b074c62f96cd3[ name ] = newpickupdef;
}

// Namespace ai_pickups / scripts\aitypes\ai_pickups
// Params 1
// Checksum 0x0, Offset: 0x192
// Size: 0x20
function function_7bf8496cb1c4eee8( ent )
{
    return level.var_634b074c62f96cd3[ ent.aipickupname ];
}

// Namespace ai_pickups / scripts\aitypes\ai_pickups
// Params 1
// Checksum 0x0, Offset: 0x1bb
// Size: 0x4a
function function_cb0d4933a6762cf9( pickupname )
{
    self.aipickupname = pickupname;
    pickupdef = function_7bf8496cb1c4eee8( self );
    assertex( isdefined( pickupdef ), "<dev string:x1c>" );
    addaipickup( self, pickupdef.seekradius );
}

// Namespace ai_pickups / scripts\aitypes\ai_pickups
// Params 1
// Checksum 0x0, Offset: 0x20d
// Size: 0xc2
function function_48eefcb82b853c11( taskid )
{
    pickups = getaipickups();
    pickupssorted = sortbydistance( pickups, self.origin );
    
    foreach ( pickup in pickupssorted )
    {
        pickupdef = function_7bf8496cb1c4eee8( pickup );
        
        if ( [[ pickupdef.var_47f82a4d9a77876f ]]( self, pickup ) )
        {
            self.bt.pickupitem = pickup;
            return anim.success;
        }
    }
    
    return anim.failure;
}

// Namespace ai_pickups / scripts\aitypes\ai_pickups
// Params 1
// Checksum 0x0, Offset: 0x2d8
// Size: 0xc1
function SeekPickupItem_SetGoal( taskid )
{
    if ( !isdefined( self.bt.pickupitem ) )
    {
        return anim.failure;
    }
    
    pickupdef = function_7bf8496cb1c4eee8( self.bt.pickupitem );
    self setbtgoalpos( 3, self.bt.pickupitem.origin );
    self setbtgoalradius( 3, pickupdef.pickupgoalradius );
    var_c4356a88633f476d = pickupdef.var_c4356a88633f476d;
    [[ var_c4356a88633f476d ]]( self, self.bt.pickupitem );
    return anim.success;
}

// Namespace ai_pickups / scripts\aitypes\ai_pickups
// Params 1
// Checksum 0x0, Offset: 0x3a2
// Size: 0x102
function SeekPickupItem_Update( taskid )
{
    if ( !isdefined( self.bt.pickupitem ) )
    {
        return anim.failure;
    }
    
    pickupdef = function_7bf8496cb1c4eee8( self.bt.pickupitem );
    var_65d0778d90ececae = pickupdef.var_65d0778d90ececae;
    
    if ( [[ var_65d0778d90ececae ]]( self, self.bt.pickupitem ) )
    {
        return anim.failure;
    }
    
    canusefunc = pickupdef.canusefunc;
    
    if ( [[ canusefunc ]]( self, self.bt.pickupitem ) )
    {
        usefunc = pickupdef.usefunc;
        [[ usefunc ]]( self, self.bt.pickupitem );
        self clearbtgoal( 3 );
        return anim.success;
    }
    
    return anim.running;
}

