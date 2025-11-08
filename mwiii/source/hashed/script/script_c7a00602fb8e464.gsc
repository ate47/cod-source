#namespace namespace_1e6379efa55bf4c9;

// Namespace namespace_1e6379efa55bf4c9 / namespace_538a390c2d92e94a
// Params 1
// Checksum 0x0, Offset: 0x131
// Size: 0xbd
function function_689bd8ae264f0531( var_649f9b194df395cd )
{
    if ( !isdefined( level.br_armory_kiosk ) )
    {
        return undefined;
    }
    
    var_3681b432675353b = undefined;
    
    foreach ( item in level.br_armory_kiosk.items )
    {
        if ( item.cost < var_3681b432675353b.cost || !isdefined( var_3681b432675353b ) )
        {
            if ( isdefined( var_649f9b194df395cd ) && var_649f9b194df395cd && item.cost == 0 )
            {
                continue;
            }
            
            var_3681b432675353b = item;
        }
    }
    
    return var_3681b432675353b;
}

// Namespace namespace_1e6379efa55bf4c9 / namespace_538a390c2d92e94a
// Params 1
// Checksum 0x0, Offset: 0x1f7
// Size: 0x7b
function function_380dfd54b395ec1b( entryref )
{
    if ( !isdefined( self ) )
    {
        return undefined;
    }
    
    foreach ( item in self.items )
    {
        if ( item.entryref == entryref )
        {
            return item.cost;
        }
    }
    
    return undefined;
}

// Namespace namespace_1e6379efa55bf4c9 / namespace_538a390c2d92e94a
// Params 1
// Checksum 0x0, Offset: 0x27b
// Size: 0x5a
function function_cd83759e21f3ff42( callback )
{
    self endon( "death" );
    self endon( "disconnect" );
    
    while ( true )
    {
        self waittill( "luinotifyserver", channel, class );
        
        if ( channel == "buy_menu_option_selected" || channel == "buy_menu_open" )
        {
            self [[ callback ]]();
            return;
        }
    }
}

// Namespace namespace_1e6379efa55bf4c9 / namespace_538a390c2d92e94a
// Params 1
// Checksum 0x0, Offset: 0x2dd
// Size: 0x7e
function function_b40f17685dbcc4e6( callback )
{
    self endon( "death" );
    self endon( "disconnect" );
    
    while ( true )
    {
        self waittill( "luinotifyserver", channel, class );
        
        if ( channel == "br_cancel_purchase" )
        {
            self [[ callback ]]();
            return;
        }
        
        if ( channel == "br_item_purchase" || channel == "br_loadout_purchase" )
        {
            if ( getdvarint( @"hash_ed6e4ffa933af621", 0 ) == 0 )
            {
                self [[ callback ]]();
                return;
            }
        }
    }
}

// Namespace namespace_1e6379efa55bf4c9 / namespace_538a390c2d92e94a
// Params 2
// Checksum 0x0, Offset: 0x363
// Size: 0xb0
function function_dadee81d5ce668bd( callback, var_d24af1a0b7bc04d )
{
    self endon( "death" );
    self endon( "disconnect" );
    
    while ( true )
    {
        self waittill( "luinotifyserver", channel, class );
        
        if ( channel == "br_item_purchase" || channel == "br_loadout_purchase" || channel == "br_team_revive" )
        {
            itemdata = level.br_armory_kiosk.items[ class ];
            
            if ( isdefined( var_d24af1a0b7bc04d ) )
            {
                if ( isdefined( itemdata ) && itemdata.ref == var_d24af1a0b7bc04d )
                {
                    self [[ callback ]]();
                    return;
                }
                
                continue;
            }
            
            self [[ callback ]]();
            return;
        }
    }
}

// Namespace namespace_1e6379efa55bf4c9 / namespace_538a390c2d92e94a
// Params 2
// Checksum 0x0, Offset: 0x41b
// Size: 0x8e
function function_4bfc467c67d38fe0( callback, var_8e87a15650c9e63f )
{
    self endon( "death" );
    self endon( "disconnect" );
    itemindex = 0;
    
    if ( isdefined( var_8e87a15650c9e63f ) )
    {
        itemindex = level.br_armory_kiosk function_f7826c1d489e51e( var_8e87a15650c9e63f );
    }
    
    while ( true )
    {
        self waittill( "luinotifyserver", channel, id );
        
        if ( channel == "buy_menu_option_selected" )
        {
            if ( isdefined( var_8e87a15650c9e63f ) )
            {
                if ( itemindex == id )
                {
                    self [[ callback ]]();
                    return;
                }
            }
            else
            {
                self [[ callback ]]();
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_1e6379efa55bf4c9 / namespace_538a390c2d92e94a
// Params 2
// Checksum 0x0, Offset: 0x4b1
// Size: 0x57
function function_759d3ef2d52c3723( callback, var_d24af1a0b7bc04d )
{
    self endon( "death" );
    self endon( "disconnect" );
    
    while ( true )
    {
        self waittill( "luinotifyserver", channel, class );
        
        if ( channel == "br_team_revive" )
        {
            self [[ callback ]]();
            return;
        }
    }
}

// Namespace namespace_1e6379efa55bf4c9 / namespace_538a390c2d92e94a
// Params 1
// Checksum 0x0, Offset: 0x510
// Size: 0x51
function function_f7826c1d489e51e( itemref )
{
    if ( !isdefined( self ) )
    {
        return undefined;
    }
    
    for ( index = 0; index < self.items.size ; index++ )
    {
        if ( self.items[ index ].entryref == itemref )
        {
            return index;
        }
    }
    
    return undefined;
}

