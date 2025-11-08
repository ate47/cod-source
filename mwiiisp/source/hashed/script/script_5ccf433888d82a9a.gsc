#using script_3a8f9ace195c9da9;
#using scripts\common\utility;
#using scripts\cp\cp_hud_message;
#using scripts\cp\utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;

#namespace namespace_4256b08ee38a2255;

// Namespace namespace_4256b08ee38a2255 / namespace_a7031d28ff46706
// Params 0
// Checksum 0x0, Offset: 0x155
// Size: 0x9
function function_ed68c9be9d1ddd23()
{
    function_7f6ae2b525a3e12a();
}

// Namespace namespace_4256b08ee38a2255 / namespace_a7031d28ff46706
// Params 0
// Checksum 0x0, Offset: 0x166
// Size: 0x34
function splash_monitor()
{
    level.splash_active = 0;
    
    while ( true )
    {
        level waittill( "new_splash" );
        level.splash_active = 1;
        wait 4;
        level.splash_active = 0;
    }
}

// Namespace namespace_4256b08ee38a2255 / namespace_a7031d28ff46706
// Params 0
// Checksum 0x0, Offset: 0x1a2
// Size: 0x1d
function function_7f6ae2b525a3e12a()
{
    function_dc6d1b40589ca236();
    thread splash_monitor();
    scripts\engine\scriptable::scriptable_addusedcallback( &function_de1149fa62dbfe47 );
}

// Namespace namespace_4256b08ee38a2255 / namespace_a7031d28ff46706
// Params 0
// Checksum 0x0, Offset: 0x1c7
// Size: 0xbd
function function_dc6d1b40589ca236()
{
    switch ( level.mapname )
    {
        case #"hash_5c03122b70ff4094":
            level.var_f4a36f82e38789b5 = 0;
            break;
        case #"hash_c3c819184bc33817":
            level.var_f4a36f82e38789b5 = 1;
            break;
        case #"hash_619829c7b3c4c3e3":
            level.var_f4a36f82e38789b5 = 2;
            break;
        case #"hash_3705bde815a332ea":
            level.var_f4a36f82e38789b5 = 3;
            break;
        case #"hash_6b2477606925177a":
            level.var_f4a36f82e38789b5 = 4;
            break;
        case #"hash_8e2389607af0427b":
            level.var_f4a36f82e38789b5 = 5;
            break;
        default:
            break;
    }
}

// Namespace namespace_4256b08ee38a2255 / namespace_a7031d28ff46706
// Params 0
// Checksum 0x0, Offset: 0x28c
// Size: 0x3c
function function_c607ddea71489857()
{
    total = 0;
    
    for ( i = 0; i <= 5 ; i++ )
    {
        total += level.player function_7d97fa985af1c8a5( i );
    }
    
    return total;
}

// Namespace namespace_4256b08ee38a2255 / namespace_a7031d28ff46706
// Params 0
// Checksum 0x0, Offset: 0x2d1
// Size: 0x2c
function function_f0010a76794e4fa7()
{
    for ( i = 0; i <= 5 ; i++ )
    {
        level.player function_5e2bfc80545dc98e( i );
    }
}

// Namespace namespace_4256b08ee38a2255 / namespace_a7031d28ff46706
// Params 6
// Checksum 0x0, Offset: 0x305
// Size: 0x13b
function function_de1149fa62dbfe47( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( level.var_f4a36f82e38789b5 ) )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"hash_a0f041fa705e80e6", 0 ) )
        {
            function_f0010a76794e4fa7();
        }
    #/
    
    var_5ed46ecac4c54ddd = player function_7d97fa985af1c8a5( level.var_f4a36f82e38789b5 );
    var_5ed46ecac4c54ddd = default_to( var_5ed46ecac4c54ddd, 0 );
    
    if ( var_5ed46ecac4c54ddd < 3 )
    {
        if ( issubstr( part, "brloot_super" ) )
        {
            var_aa14ab078fd0313d = function_c607ddea71489857();
            
            if ( var_aa14ab078fd0313d < 5 )
            {
                while ( level.splash_active )
                {
                    wait 0.1;
                }
                
                tutorial_state = player getclientomnvar( "ui_tutorial_message_state" );
                
                if ( tutorial_state == 1 )
                {
                    wait 4;
                    tutorial_state = player getclientomnvar( "ui_tutorial_message_state" );
                    
                    if ( tutorial_state == 1 )
                    {
                        return;
                    }
                }
                
                if ( player usinggamepad() )
                {
                    player thread scripts\cp\cp_hud_message::tutorialprint( &"CP_JUP_CHEMICAL/FIELDUPGRADE", 6 );
                }
                else
                {
                    player thread scripts\cp\cp_hud_message::tutorialprint( &"CP_JUP_CHEMICAL/FIELDUPGRADE_KBM", 6 );
                }
                
                player function_f12562902f6f598b( level.var_f4a36f82e38789b5, var_5ed46ecac4c54ddd + 1 );
            }
        }
    }
}

