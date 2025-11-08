#using script_35ae72be7b4fec10;
#using scripts\core_common\util_shared;

#namespace warning_message;

// Namespace warning_message/warning_message
// Params 4
// Checksum 0x9a957734, Offset: 0x90
// Size: 0x224
function create( message, var_400e244b, pulse, endons )
{
    if ( scripted_widgets::exists( #"warningmessage" ) )
    {
        assertmsg( "<dev string:x38>" );
        return;
    }
    
    if ( isdefined( endons ) )
    {
        self endoncallback( &remove, endons );
    }
    
    scripted_widgets::create( #"warningmessage", #"hash_6e2caf9e3aa6b810" );
    scripted_widgets::set_text( #"warningmessage", message );
    scripted_widgets::set_state( #"warningmessage", #"defaultstate" );
    
    if ( is_true( pulse ) )
    {
        util::delay( float( function_60d95f53() ) / 1000, endons, &function_b4af2e7, 1 );
    }
    
    if ( isint( var_400e244b ) || isfloat( var_400e244b ) )
    {
        wait var_400e244b;
    }
    else if ( isstring( var_400e244b ) || ishash( var_400e244b ) || isarray( var_400e244b ) )
    {
        self waittill( var_400e244b );
    }
    else
    {
        return;
    }
    
    remove();
}

// Namespace warning_message/warning_message
// Params 1
// Checksum 0x91309edf, Offset: 0x2c0
// Size: 0x54
function set_message( message )
{
    if ( scripted_widgets::exists( #"warningmessage" ) )
    {
        scripted_widgets::set_text( #"warningmessage", message );
    }
}

// Namespace warning_message/warning_message
// Params 1
// Checksum 0xc3b075e6, Offset: 0x320
// Size: 0xac
function function_b4af2e7( pulse )
{
    if ( scripted_widgets::exists( #"warningmessage" ) )
    {
        if ( is_true( pulse ) )
        {
            scripted_widgets::set_state( #"warningmessage", #"pulse" );
            return;
        }
        
        scripted_widgets::set_state( #"warningmessage", #"defaultstate" );
    }
}

// Namespace warning_message/warning_message
// Params 1
// Checksum 0xa89a8ada, Offset: 0x3d8
// Size: 0x4c
function remove( *params )
{
    if ( scripted_widgets::exists( #"warningmessage" ) )
    {
        scripted_widgets::remove( #"warningmessage" );
    }
}

