#using script_239a365a92ee4476;
#using script_32d93a194074fa6a;
#using script_44102c05f33e9b1e;
#using script_530f3ea26428deba;
#using script_5693b37bfb748170;
#using script_5a37c8d34c31ea89;
#using script_5dfa1fb6b030bdcb;
#using script_6981400abfcd765c;
#using script_782ed84671b152fb;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\utility\game;

#namespace ftue_br;

// Namespace ftue_br / namespace_13e4e9def5bc390d
// Params 0
// Checksum 0x0, Offset: 0x120
// Size: 0x58
function init()
{
    function_c5ebc1fd82f62050();
    
    if ( function_94b952789d039abb() )
    {
        function_a6ca80cf4f22e262( "ftuetiplist:ftuetips_list_br" );
        function_34c0594d8a03efe4( "JUP_BR" );
        function_8d0bcd24e525ca55();
        thread namespace_91fad7208d9cd856::init( &namespace_a1922e5b976f9ad7::function_9fcc9920ba3dbe3, undefined, &namespace_a1922e5b976f9ad7::function_8d9c94a186b2f39a, &namespace_d3289d7a0f087014::playertriggercallback );
        
        /#
            scripts\mp\gametypes\br_dev::registerhandlecommand( &function_f0581ccaa73a651d );
        #/
    }
}

// Namespace ftue_br / namespace_13e4e9def5bc390d
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x180
// Size: 0x10
function private function_c5ebc1fd82f62050()
{
    level.var_114256fded8103cd = "ftueDataWZ";
}

// Namespace ftue_br / namespace_13e4e9def5bc390d
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x198
// Size: 0x2
function private function_6a00940e598a7d11()
{
    
}

/#

    // Namespace ftue_br / namespace_13e4e9def5bc390d
    // Params 2
    // Checksum 0x0, Offset: 0x1a2
    // Size: 0xf4, Type: dev
    function function_f0581ccaa73a651d( command, args )
    {
        switch ( command )
        {
            case #"hash_b5a6af7cf5041e12":
                namespace_91fad7208d9cd856::function_69d2bf97401ca611( args[ 0 ] );
                break;
            case #"hash_a68a5252e80fe0a7":
                if ( !isdefined( args ) || args.size == 0 )
                {
                    tooltipscompleted = 0;
                }
                else
                {
                    tooltipscompleted = namespace_b97271dc63a81cc0::function_1e6d534caef3039f();
                    
                    foreach ( tipref in args )
                    {
                        tipid = namespace_91fad7208d9cd856::function_b4641ae08979f8ce( tipref );
                        
                        if ( isdefined( tipid ) )
                        {
                            mask = 1 << tipid;
                            tooltipscompleted &= ~mask;
                        }
                    }
                }
                
                namespace_b97271dc63a81cc0::function_a25d14ecf8dcb49e( tooltipscompleted );
                break;
            default:
                break;
        }
    }

#/
