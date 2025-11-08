#using scripts\common\system;
#using scripts\common\utility;
#using scripts\engine\hud_management;
#using scripts\engine\utility;

#namespace hud_management;

// Namespace hud_management / scripts\game\sp\hud_management
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x10e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_7a72c0b5b88f5ace", #"hud_management", &pre_main, undefined );
}

// Namespace hud_management / scripts\game\sp\hud_management
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x137
// Size: 0x7e
function private pre_main()
{
    settings = spawnstruct();
    settings.state = "BottomCenter";
    settings.root = ( 0, -200, 0 );
    settings.step = ( 0, -35, 0 );
    settings.anchorhorz = 1;
    settings.anchorvert = 2;
    function_63dc22f0e4afaf41( "BottomCenter", settings );
}

// Namespace hud_management / scripts\game\sp\hud_management
// Params 3
// Checksum 0x0, Offset: 0x1bd
// Size: 0xfa
function function_bd850d4d3b0d537c( layer, locstring, groupname )
{
    assert( isplayer( self ) );
    player = self;
    groupname = default_to( groupname, "BottomCenter" );
    
    if ( !isdefined( player.hud_management ) )
    {
        player.hud_management = spawnstruct();
    }
    
    if ( !isdefined( player.hud_management.hint_group ) )
    {
        player.hud_management.hint_group = [];
    }
    
    if ( !isdefined( player.hud_management.hint_group[ groupname ] ) )
    {
        player.hud_management.hint_group[ groupname ] = [];
    }
    
    player.hud_management.hint_group[ groupname ][ "prompt_group_" + groupname + "_" + layer ] = locstring;
    player function_1517a14bb9c788b5( groupname );
}

// Namespace hud_management / scripts\game\sp\hud_management
// Params 2
// Checksum 0x0, Offset: 0x2bf
// Size: 0x12e
function function_8aa54007d532f449( layer, groupname )
{
    assert( isplayer( self ) );
    player = self;
    groupname = default_to( groupname, "BottomCenter" );
    
    if ( !isdefined( player.hud_management ) )
    {
        return;
    }
    
    if ( !isdefined( player.hud_management.hint_group ) )
    {
        return;
    }
    
    if ( !isdefined( player.hud_management.hint_group[ groupname ] ) )
    {
        return;
    }
    
    if ( isdefined( layer ) )
    {
        player.hud_management.hint_group[ groupname ][ "prompt_group_" + groupname + "_" + layer ] = -1;
    }
    else
    {
        foreach ( locstring in player.hud_management.hint_group )
        {
            player.hud_management.hint_group[ groupname ][ refname ] = -1;
        }
    }
    
    player function_1517a14bb9c788b5( groupname );
}

// Namespace hud_management / scripts\game\sp\hud_management
// Params 2
// Checksum 0x0, Offset: 0x3f5
// Size: 0x88
function function_63dc22f0e4afaf41( groupname, settings )
{
    groupname = default_to( groupname, "BottomCenter" );
    
    if ( !isdefined( level.hud_management ) )
    {
        assertmsg( "prompt_group_setup() called before enginehud_management::pre_main() for '" + groupname + "'" );
        return;
    }
    
    if ( !isdefined( level.hud_management.var_2942d2c381b69899 ) )
    {
        level.hud_management.var_2942d2c381b69899 = [];
    }
    
    level.hud_management.var_2942d2c381b69899[ groupname ] = settings;
}

// Namespace hud_management / scripts\game\sp\hud_management
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x485
// Size: 0x1e2
function private function_1517a14bb9c788b5( groupname )
{
    assert( isplayer( self ) );
    player = self;
    assert( isdefined( groupname ) );
    assert( isdefined( player.hud_management ) );
    assert( isdefined( player.hud_management.hint_group ) );
    assert( isdefined( player.hud_management.hint_group[ groupname ] ) );
    assert( isdefined( level.hud_management.var_2942d2c381b69899[ groupname ] ) );
    settings = level.hud_management.var_2942d2c381b69899[ groupname ];
    var_ed4126f0b51385b9 = -1;
    
    foreach ( refname, locstring in player.hud_management.hint_group[ groupname ] )
    {
        isactive = player function_ada0825249682644( refname );
        
        if ( isistring( locstring ) )
        {
            var_ed4126f0b51385b9++;
            position = settings.root + settings.step * var_ed4126f0b51385b9;
            
            if ( !isactive )
            {
                player function_90de31b2cbef19f9( refname, "scripted_widget_generic_text" );
                player function_d28fa5295a04d555( refname, settings.state );
            }
            
            player function_b52897e8afbb0968( refname, getlocstringindex( locstring ) );
            player function_f4c37324750dc183( refname, position[ 0 ], position[ 1 ], settings.anchorhorz, settings.anchorvert );
            continue;
        }
        
        if ( isactive )
        {
            player scripted_widget_destroy( refname );
        }
    }
}

