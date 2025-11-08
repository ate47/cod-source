#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\friendlyfire;
#using scripts\sp\names;
#using scripts\sp\utility;

#namespace drone_base;

// Namespace drone_base / scripts\sp\drone_base
// Params 0
// Checksum 0x0, Offset: 0xce
// Size: 0xb1
function drone_give_soul()
{
    assign_drone_tree();
    self startusingheroonlylighting();
    
    if ( isdefined( self.script_moveplaybackrate ) )
    {
        self.moveplaybackrate = self.script_moveplaybackrate;
    }
    else
    {
        self.moveplaybackrate = 1;
    }
    
    if ( self.team == "allies" )
    {
        scripts\sp\names::get_name();
        self setlookattext( self.name, &"" );
    }
    
    if ( isdefined( level.dronecallbackthread ) )
    {
        self thread [[ level.dronecallbackthread ]]();
    }
    
    if ( !isdefined( self.script_friendly_fire_disable ) )
    {
        level thread scripts\sp\friendlyfire::friendly_fire_think( self );
    }
    
    if ( !isdefined( level.ai_dont_glow_in_thermal ) )
    {
        thermaldrawenabledrone();
    }
}

// Namespace drone_base / scripts\sp\drone_base
// Params 0
// Checksum 0x0, Offset: 0x187
// Size: 0x87
function thermaldrawenabledrone()
{
    if ( !isdefined( level.dronesthermalteamselect ) )
    {
        level.dronesthermalteamselect = "all";
    }
    
    enablethermal = 0;
    
    switch ( level.dronesthermalteamselect )
    {
        case #"hash_c482c6c109150a4":
            enablethermal = 1;
            break;
        case #"hash_7c2d091e6337bf54":
            enablethermal = self.team == "axis";
            break;
        default:
            break;
    }
    
    if ( enablethermal )
    {
        self thermaldrawenable();
    }
}

// Namespace drone_base / scripts\sp\drone_base
// Params 0
// Checksum 0x0, Offset: 0x216
// Size: 0x322
function drone_init_path()
{
    if ( !isdefined( self.target ) )
    {
        return;
    }
    
    if ( isdefined( level.drone_paths[ self.target ] ) )
    {
        return;
    }
    
    level.drone_paths[ self.target ] = 1;
    target = self.target;
    node = getstruct( target, "targetname" );
    
    if ( !isdefined( node ) )
    {
        return;
    }
    
    vectors = [];
    completed_nodes = [];
    original_node = node;
    
    for ( ;; )
    {
        node = original_node;
        
        for ( var_42b4575e536fb56f = 0;  ; var_42b4575e536fb56f = 1 )
        {
            if ( !isdefined( node.target ) )
            {
                break;
            }
            
            nextnodes = getstructarray( node.target, "targetname" );
            
            if ( nextnodes.size )
            {
                break;
            }
            
            nextnode = undefined;
            
            foreach ( newnode in nextnodes )
            {
                if ( isdefined( completed_nodes[ newnode.origin + "" ] ) )
                {
                    continue;
                }
                
                nextnode = newnode;
                break;
            }
            
            if ( !isdefined( nextnode ) )
            {
                break;
            }
            
            completed_nodes[ nextnode.origin + "" ] = 1;
            vectors[ node.targetname ] = nextnode.origin - node.origin;
            node.angles = vectortoangles( vectors[ node.targetname ] );
            node = nextnode;
        }
        
        if ( !var_42b4575e536fb56f )
        {
            break;
        }
    }
    
    target = self.target;
    node = getstruct( target, "targetname" );
    prevnode = node;
    completed_nodes = [];
    
    for ( ;; )
    {
        node = original_node;
        var_42b4575e536fb56f = 0;
        
        for ( ;; )
        {
            if ( !isdefined( node.target ) )
            {
                return;
            }
            
            if ( !isdefined( vectors[ node.targetname ] ) )
            {
                return;
            }
            
            nextnodes = getstructarray( node.target, "targetname" );
            
            if ( nextnodes.size )
            {
                break;
            }
            
            nextnode = undefined;
            
            foreach ( newnode in nextnodes )
            {
                if ( isdefined( completed_nodes[ newnode.origin + "" ] ) )
                {
                    continue;
                }
                
                nextnode = newnode;
                break;
            }
            
            if ( !isdefined( nextnode ) )
            {
                break;
            }
            
            if ( isdefined( node.radius ) )
            {
                vec1 = vectors[ prevnode.targetname ];
                vec2 = vectors[ node.targetname ];
                vec = ( vec1 + vec2 ) * 0.5;
                node.angles = vectortoangles( vec );
            }
            
            var_42b4575e536fb56f = 1;
            prevnode = node;
            node = nextnode;
        }
        
        if ( !var_42b4575e536fb56f )
        {
            break;
        }
    }
}

// Namespace drone_base / scripts\sp\drone_base
// Params 0
// Checksum 0x0, Offset: 0x540
// Size: 0x32
function assign_drone_tree()
{
    if ( isdefined( self.type ) )
    {
        if ( self.type == "dog" )
        {
            assign_animals_tree();
            return;
        }
        
        assign_generic_human_tree();
    }
}

#using_animtree( "generic_human" );

// Namespace drone_base / scripts\sp\drone_base
// Params 0
// Checksum 0x0, Offset: 0x57a
// Size: 0xb
function assign_generic_human_tree()
{
    self useanimtree( #animtree );
}

#using_animtree( "animals" );

// Namespace drone_base / scripts\sp\drone_base
// Params 0
// Checksum 0x0, Offset: 0x58d
// Size: 0xb
function assign_animals_tree()
{
    self useanimtree( #animtree );
}

