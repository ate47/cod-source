#using script_35ae72be7b4fec10;
#using scripts\core_common\values_shared;
#using scripts\cp_common\gametypes\globallogic_ui;

#namespace namespace_29a279dd;

// Namespace namespace_29a279dd/namespace_29a279dd
// Params 3
// Checksum 0x129a1d57, Offset: 0xb0
// Size: 0x11c
function set_display( state, text, desc )
{
    getplayers()[ 0 ] val::set( #"hash_6420a4a05af52d6e", "show_crosshair", 0 );
    
    if ( !scripted_widgets::exists( #"hash_767355dc5e1cddfb" ) )
    {
        scripted_widgets::create( #"hash_767355dc5e1cddfb", #"hash_6420a4a05af52d6e" );
    }
    
    if ( isdefined( text ) )
    {
        scripted_widgets::set_text( #"hash_767355dc5e1cddfb", text );
    }
    
    if ( isdefined( desc ) )
    {
        scripted_widgets::function_bfdab223( #"hash_767355dc5e1cddfb", desc );
    }
    
    waitframe( 1 );
    scripted_widgets::set_state( #"hash_767355dc5e1cddfb", state );
}

// Namespace namespace_29a279dd/namespace_29a279dd
// Params 0
// Checksum 0xb5973629, Offset: 0x1d8
// Size: 0x6c
function remove()
{
    if ( scripted_widgets::exists( #"hash_767355dc5e1cddfb" ) )
    {
        scripted_widgets::remove( #"hash_767355dc5e1cddfb" );
    }
    
    getplayers()[ 0 ] val::reset_all();
}

