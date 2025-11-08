#using script_3bf3f0172d4a2247;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_keypad_util;
#using scripts\mp\utility\lower_message;

#namespace vault_door;

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 0
// Checksum 0x0, Offset: 0x473
// Size: 0x21
function init()
{
    initbunkervfx();
    function_2fcaee708b41d832();
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "maphint_keypad_bunker_interior", &keypadscriptableused );
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 0
// Checksum 0x0, Offset: 0x49c
// Size: 0x9e
function initbunkervfx()
{
    level._effect[ "vfx_br_bunker_open" ] = loadfx( "vfx/iw8_br/gameplay/bunker/vfx_br_bunker_open.vfx" );
    level._effect[ "vfx_br_bunker_open_2" ] = loadfx( "vfx/iw8_br/gameplay/bunker/vfx_br_bunker_open_2.vfx" );
    level._effect[ "vfx_br_bunker_open_puzzle" ] = loadfx( "vfx/iw8_br/gameplay/bunker/vfx_br_bunker_open_puzzle.vfx" );
    level._effect[ "vfx_br_bulb_vault_green" ] = loadfx( "vfx/jup/lighting/vfx_br_bulb_lensflare_green.vfx" );
    level._effect[ "vfx_br_bulb_vault_red" ] = loadfx( "vfx/jup/lighting/vfx_br_bulb_lensflare_red.vfx" );
    level._effect[ "vfx_br_bulb_vault_red_blink" ] = loadfx( "vfx/jup/lighting/vfx_br_bulb_lensflare_red_blinking.vfx" );
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 1
// Checksum 0x0, Offset: 0x542
// Size: 0xc5
function initvaultdoor( door )
{
    level thread function_c3bf2f88b7bdad0f( door );
    forward = anglestoforward( door.angles );
    forwardoffset = 128;
    patchposition = door.origin + ( 0, 0, -110 ) + forward * forwardoffset;
    patch7 = getent( "clip256x256x256", "targetname" );
    
    if ( isdefined( patch7 ) )
    {
        var_10688b3021acc893 = spawn( "script_model", patchposition );
        var_10688b3021acc893.angles = ( 0, 0, 0 );
        var_10688b3021acc893 clonebrushmodeltoscriptmodel( patch7 );
        door.addedcollision = var_10688b3021acc893;
    }
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 1
// Checksum 0x0, Offset: 0x60f
// Size: 0xbf
function function_c3bf2f88b7bdad0f( door )
{
    forward = anglestoforward( door.angles );
    toright = anglestoright( door.angles );
    effectposition = door.origin + ( 0, 0, 135 ) + forward * -18 + toright * -38;
    door.lightscriptable = spawnscriptable( "vault_indicator_light", effectposition );
    assertex( isdefined( door.lightscriptable ), "<dev string:x1c>" );
    door.lightscriptable.var_50054f8ed68966d5 = 1;
    function_a5d6387bab61ba00( door );
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 1
// Checksum 0x0, Offset: 0x6d6
// Size: 0x33
function function_8ba0ae9d52f5f35f( team )
{
    if ( !isdefined( level.teamdata[ team ][ "vault_doors" ] ) )
    {
        level.teamdata[ team ][ "vault_doors" ] = [];
    }
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 1
// Checksum 0x0, Offset: 0x711
// Size: 0x2d, Type: bool
function function_f35b8fbc776c2211( lightscriptable )
{
    return isdefined( lightscriptable ) && isdefined( lightscriptable.var_50054f8ed68966d5 ) && istrue( lightscriptable.var_50054f8ed68966d5 );
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 1
// Checksum 0x0, Offset: 0x747
// Size: 0x3a
function function_ea45f200ad54ab3d( door )
{
    if ( function_f35b8fbc776c2211( door.lightscriptable ) )
    {
        door.lightscriptable setscriptablepartstate( "vault_indicator_light", "alarm" );
    }
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 1
// Checksum 0x0, Offset: 0x789
// Size: 0x3a
function function_78ef9be55a4536cb( door )
{
    if ( function_f35b8fbc776c2211( door.lightscriptable ) )
    {
        door.lightscriptable setscriptablepartstate( "vault_indicator_light", "active" );
    }
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 1
// Checksum 0x0, Offset: 0x7cb
// Size: 0x3a
function function_a5d6387bab61ba00( door )
{
    if ( function_f35b8fbc776c2211( door.lightscriptable ) )
    {
        door.lightscriptable setscriptablepartstate( "vault_indicator_light", "inactive" );
    }
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 1
// Checksum 0x0, Offset: 0x80d
// Size: 0x7c
function function_702f682e2a3526df( door )
{
    if ( isdefined( door ) )
    {
        if ( soundexists( "br_bunker_door_open_02" ) )
        {
            door playsound( "br_bunker_door_open_02" );
        }
        
        accelerationtime = 4;
        decelerationtime = 4;
        door rotateyaw( -120, 8, accelerationtime, decelerationtime );
        wait 4;
        
        if ( isdefined( door.addedcollision ) )
        {
            door.addedcollision delete();
        }
    }
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 0
// Checksum 0x0, Offset: 0x891
// Size: 0xd9
function function_2fcaee708b41d832()
{
    level.bunkerinteriorkeypads = [];
    var_c347d25e165ac454 = getstructarray( "bunker_back_keypad", "targetname" );
    
    foreach ( keypadloc in var_c347d25e165ac454 )
    {
        scriptable = spawnscriptable( "maphint_keypad_bunker_interior", keypadloc.origin );
        scriptable.backwallkeypad = 1;
        
        if ( isdefined( keypadloc.script_noteworthy ) )
        {
            scriptable.bunkernum = int( keypadloc.script_noteworthy );
            level.bunkerinteriorkeypads[ scriptable.bunkernum ] = scriptable;
        }
    }
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 6
// Checksum 0x0, Offset: 0x972
// Size: 0x41
function keypadscriptableused( instance, part, state, player, bautouse, usestring )
{
    level thread _keypadscriptableused( instance, part, state, player, bautouse );
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 5
// Checksum 0x0, Offset: 0x9bb
// Size: 0x92
function _keypadscriptableused( instance, part, state, player, bautouse )
{
    assert( part == "<dev string:x72>" );
    instance setscriptablepartstate( part, "off" );
    player keypad_playerinteractwithkeypadloop( instance );
    
    if ( isdefined( player ) )
    {
        if ( instance.codestatus == 0 )
        {
            wait 2;
        }
        
        player playersetkeypadstateindex( 0 );
    }
    
    if ( instance.codestatus != 0 )
    {
        wait 1;
        instance setscriptablepartstate( part, "on" );
    }
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 1
// Checksum 0x0, Offset: 0xa55
// Size: 0x312
function keypad_playerinteractwithkeypadloop( instance )
{
    level endon( "game_ended" );
    self endon( "keypad_kickPlayerFromKeypadMSG" );
    thread keypad_damagedeathdisconnectwatch();
    thread keypad_playeridlewatch();
    playersetkeypadstateindex( 1 );
    codelength = 8;
    
    if ( isdefined( instance.codelength ) )
    {
        codelength = instance.codelength;
    }
    
    playersetkeypadcodelengthindex( codelength );
    
    if ( !isdefined( instance.startingattempts ) )
    {
        instance.startingattempts = 3;
    }
    
    if ( !isdefined( instance.attemptsremaining ) )
    {
        instance.attemptsremaining = 3;
    }
    
    function_5392765d56bf59ea( instance.attemptsremaining );
    team = self.pers[ "team" ];
    var_7ad93963b383039d = level.teamdata[ team ][ "vault_doors" ];
    
    if ( isdefined( var_7ad93963b383039d ) )
    {
        var_e0a02e8974284d15 = var_7ad93963b383039d[ instance.door.index ];
        
        if ( isdefined( var_e0a02e8974284d15 ) )
        {
            if ( isdefined( var_e0a02e8974284d15.var_2e46f15e79793691 ) )
            {
                function_b899a0471538d3d4( var_e0a02e8974284d15.var_2e46f15e79793691 );
            }
            
            objid = namespace_5aecb7b921208f15::function_c2e1be16e83ddac0( instance.door );
            
            if ( isdefined( objid ) )
            {
                function_da718c8ec624b4da( objid );
            }
            
            function_b751dd55c6c31d6d( instance.code[ "array" ], var_e0a02e8974284d15.var_fa0f2d5aeb7a3af9, objid );
        }
        else
        {
            function_b751dd55c6c31d6d( instance.code[ "array" ], 0, undefined );
        }
    }
    
    while ( isdefined( self ) && getkeypadstatefromomnvar() != 0 )
    {
        self waittill( "luinotifyserver", message, value );
        
        if ( isdefined( message ) )
        {
            if ( message == "submit_br_keypad" )
            {
                thread keypad_playeridlewatch();
                
                if ( isdefined( instance.code ) && iscodecorrect( instance, value ) )
                {
                    playersetkeypadstateindex( 2 );
                    instance.codestatus = 0;
                    
                    if ( isdefined( instance.successfunction ) )
                    {
                        [[ instance.successfunction ]]( instance, self );
                    }
                    
                    break;
                }
                else
                {
                    if ( soundexists( "br_keypad_deny" ) )
                    {
                        playsoundatpos( self.origin, "br_keypad_deny" );
                    }
                    
                    if ( instance.attemptsremaining > 0 )
                    {
                        instance.attemptsremaining -= 1;
                    }
                    
                    function_5392765d56bf59ea( instance.attemptsremaining );
                    instance.codestatus = 1;
                    playersetkeypadstateindex( 3 );
                    waitframe();
                    
                    if ( isdefined( instance.code ) && isdefined( instance.failfunction ) )
                    {
                        [[ instance.failfunction ]]( instance, self );
                    }
                    
                    if ( isdefined( self ) )
                    {
                        playersetkeypadstateindex( 1 );
                    }
                }
                
                continue;
            }
            
            if ( message == "exit_br_keypad" )
            {
                instance.codestatus = 1;
                break;
            }
        }
    }
    
    self notify( "doneWithKeypad" );
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 0
// Checksum 0x0, Offset: 0xd6f
// Size: 0x2e
function keypad_damagedeathdisconnectwatch()
{
    self endon( "keypad_kickPlayerFromKeypadMSG" );
    level endon( "game_ended" );
    waittill_any_3( "death", "disconnect", "damage" );
    self notify( "keypad_kickPlayerFromKeypadMSG" );
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 0
// Checksum 0x0, Offset: 0xda5
// Size: 0x23
function keypad_playeridlewatch()
{
    self endon( "keypad_kickPlayerFromKeypadMSG" );
    self notify( "keypad_playerIdleWatch" );
    self endon( "keypad_playerIdleWatch" );
    wait 30;
    self notify( "keypad_kickPlayerFromKeypadMSG" );
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 2
// Checksum 0x0, Offset: 0xdd0
// Size: 0x55
function iscodecorrect( instance, value )
{
    if ( !isdefined( instance.code[ "string" ] ) )
    {
        return;
    }
    
    var_391df67337eedff2 = int( instance.code[ "string" ] );
    
    if ( value == var_391df67337eedff2 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace vault_door / scripts\mp\gametypes\vault_door
// Params 4
// Checksum 0x0, Offset: 0xe2e
// Size: 0x30c
function generatenumbercode( codelength, codestruct, var_2e698aed0de1ce13, var_d3da81df8d468200 )
{
    numbers = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ];
    codestruct.code = [];
    
    if ( !isdefined( var_2e698aed0de1ce13 ) )
    {
        var_2e698aed0de1ce13 = 0;
    }
    else
    {
        codestruct.code[ "doubles" ] = [];
    }
    
    if ( !isdefined( var_d3da81df8d468200 ) )
    {
        var_d3da81df8d468200 = 0;
    }
    else
    {
        codestruct.code[ "triples" ] = [];
    }
    
    var_6cb4c9e48f55503e = codelength - var_2e698aed0de1ce13 - var_d3da81df8d468200 * 2;
    assert( var_6cb4c9e48f55503e > var_2e698aed0de1ce13 + var_d3da81df8d468200, "<dev string:x94>" );
    numbers = array_randomize( numbers );
    
    for ( i = 0; i < var_6cb4c9e48f55503e ; i++ )
    {
        codestruct.code[ "array" ][ i ] = numbers[ i ];
    }
    
    var_91ef66919bfe4233 = codestruct.code[ "array" ];
    
    for ( i = 0; i < var_2e698aed0de1ce13 ; i++ )
    {
        var_19f414b6862a5d43 = var_91ef66919bfe4233[ i ];
        codestruct.code[ "array" ][ codestruct.code[ "array" ].size ] = var_19f414b6862a5d43;
        codestruct.code[ "doubles" ][ codestruct.code[ "doubles" ].size ] = var_19f414b6862a5d43;
        var_91ef66919bfe4233 = array_remove( var_91ef66919bfe4233, var_91ef66919bfe4233[ i ] );
    }
    
    for ( i = 0; i < var_d3da81df8d468200 ; i++ )
    {
        var_7e2e31fbe4946a0a = var_91ef66919bfe4233[ i ];
        
        for ( x = 0; x < 2 ; x++ )
        {
            codestruct.code[ "array" ][ codestruct.code[ "array" ].size ] = var_7e2e31fbe4946a0a;
        }
        
        codestruct.code[ "triples" ][ codestruct.code[ "triples" ].size ] = var_7e2e31fbe4946a0a;
        var_91ef66919bfe4233 = array_remove( var_91ef66919bfe4233, var_91ef66919bfe4233[ i ] );
    }
    
    codestruct.code[ "array" ] = array_randomize( codestruct.code[ "array" ] );
    codestruct.code[ "string" ] = "";
    
    foreach ( num in codestruct.code[ "array" ] )
    {
        newstring = "" + num;
        codestruct.code[ "string" ] = codestruct.code[ "string" ] + newstring;
    }
}

