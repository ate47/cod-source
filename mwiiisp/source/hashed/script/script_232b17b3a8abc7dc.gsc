#using script_23502cee3fa89fc2;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_objectives;
#using scripts\cp\utility;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace namespace_e3954e763c70e214;

// Namespace namespace_e3954e763c70e214 / namespace_cb128c18281a7cc
// Params 0
// Checksum 0x0, Offset: 0x371
// Size: 0x20
function init()
{
    level.var_f707813a2fa1a53d = [];
    level.var_bc62db1cda14b969 = [];
    level.var_321d7c9ee241c055 = [];
}

// Namespace namespace_e3954e763c70e214 / namespace_cb128c18281a7cc
// Params 4
// Checksum 0x0, Offset: 0x399
// Size: 0x2e7
function function_be8e8b8fb21e050a( var_aeee319c47639fa9, var_1c8cba6b6772fb39, var_7ad9d12fb2dac97, var_77cca48d1d04b0b1 )
{
    init();
    flag_wait( "strike_init_done" );
    flag_wait( "infil_complete" );
    waitframe();
    assertex( isdefined( var_aeee319c47639fa9 ), " Please pass in an Array for the Non-Radioactive Objects (Structs OR Entities). Is Undefined " );
    assertex( isdefined( var_1c8cba6b6772fb39 ), " Please pass in an Array for the Radioactive Objects (Structs OR Entities). Is Undefined  " );
    assertex( isarray( var_aeee319c47639fa9 ), " Please pass in an Array for the Non-Radioactive Objects (Structs OR Entities). " );
    assertex( isarray( var_1c8cba6b6772fb39 ), " Please pass in an Array for the Radioactive Objects (Structs OR Entities). " );
    
    if ( !isdefined( var_aeee319c47639fa9 ) || !isarray( var_aeee319c47639fa9 ) )
    {
        return;
    }
    
    if ( !isdefined( var_1c8cba6b6772fb39 ) || !isarray( var_1c8cba6b6772fb39 ) )
    {
        return;
    }
    
    foreach ( obj in var_aeee319c47639fa9 )
    {
        if ( isstruct( obj ) )
        {
            /#
                if ( function_d4caa84aabf067b3() )
                {
                    print3d( obj.origin, "<dev string:x1c>", ( 0.25, 1, 0.25 ), 1, 1, 1000, 1 );
                }
            #/
            
            obj_good = function_1247dad478b96b07( obj, 1 );
            level.var_bc62db1cda14b969 = array_add( level.var_bc62db1cda14b969, obj_good );
            level.var_f707813a2fa1a53d = array_add( level.var_f707813a2fa1a53d, obj_good );
            continue;
        }
        
        if ( isent( obj ) )
        {
            obj_good = function_1247dad478b96b07( obj, 0, 1, var_7ad9d12fb2dac97 );
            level.var_bc62db1cda14b969 = array_add( level.var_bc62db1cda14b969, obj_good );
            level.var_f707813a2fa1a53d = array_add( level.var_f707813a2fa1a53d, obj_good );
        }
    }
    
    foreach ( obj in var_1c8cba6b6772fb39 )
    {
        if ( isstruct( obj ) )
        {
            /#
                if ( function_d4caa84aabf067b3() )
                {
                    print3d( obj.origin, "<dev string:x2c>", ( 0.25, 1, 0.25 ), 1, 1, 1000, 1 );
                }
            #/
            
            obj_bad = function_1247dad478b96b07( obj, 0 );
            level.var_321d7c9ee241c055 = array_add( level.var_321d7c9ee241c055, obj_bad );
            level.var_f707813a2fa1a53d = array_add( level.var_f707813a2fa1a53d, obj_bad );
        }
        else if ( isent( obj ) )
        {
            obj_bad = function_1247dad478b96b07( obj, 1, 1, var_77cca48d1d04b0b1 );
            level.var_321d7c9ee241c055 = array_add( level.var_321d7c9ee241c055, obj_bad );
            level.var_f707813a2fa1a53d = array_add( level.var_f707813a2fa1a53d, obj_bad );
        }
        
        namespace_f7a7dad273cad4ec::radiation_init( obj );
    }
}

// Namespace namespace_e3954e763c70e214 / namespace_cb128c18281a7cc
// Params 4
// Checksum 0x0, Offset: 0x688
// Size: 0x11c
function function_1247dad478b96b07( obj, var_b3ba2d13fc1d315c, var_23765d364c6d5f3e, model )
{
    var_11fa2985452ac8cf = undefined;
    
    if ( !istrue( var_23765d364c6d5f3e ) )
    {
        var_11fa2985452ac8cf = spawn( "script_model", obj.origin );
        
        if ( isdefined( obj.angles ) )
        {
            var_11fa2985452ac8cf.angles = obj.angles;
        }
        else
        {
            var_11fa2985452ac8cf.angles = ( 0, 0, 0 );
        }
        
        if ( isdefined( model ) )
        {
            var_11fa2985452ac8cf setmodel( model );
        }
        else
        {
            var_11fa2985452ac8cf setmodel( "container_nitrate_barrel_01" );
        }
    }
    else
    {
        var_11fa2985452ac8cf = obj;
    }
    
    var_11fa2985452ac8cf show();
    var_11fa2985452ac8cf makeusable();
    var_11fa2985452ac8cf setcursorhint( "HINT_BUTTON" );
    var_11fa2985452ac8cf sethintdisplayrange( 90 );
    var_11fa2985452ac8cf sethintdisplayfov( 65 );
    var_11fa2985452ac8cf setuserange( 90 );
    var_11fa2985452ac8cf setusefov( 65 );
    var_11fa2985452ac8cf sethintonobstruction( "show" );
    var_11fa2985452ac8cf setuseholdduration( "duration_none" );
    var_11fa2985452ac8cf sethintstring( &"CP_CONVOYS/LOOT_MARK" );
    var_11fa2985452ac8cf thread function_34517aace31a5f6b( var_b3ba2d13fc1d315c );
    return var_11fa2985452ac8cf;
}

// Namespace namespace_e3954e763c70e214 / namespace_cb128c18281a7cc
// Params 1
// Checksum 0x0, Offset: 0x7ad
// Size: 0x4a
function function_34517aace31a5f6b( var_b3ba2d13fc1d315c )
{
    self endon( "death" );
    self endon( "scanned" );
    
    while ( true )
    {
        self waittill( "trigger", player );
        
        if ( !player scripts\cp\utility::is_valid_player() )
        {
            continue;
        }
        
        pickup_used( player, var_b3ba2d13fc1d315c );
    }
}

// Namespace namespace_e3954e763c70e214 / namespace_cb128c18281a7cc
// Params 2
// Checksum 0x0, Offset: 0x7ff
// Size: 0x168
function pickup_used( player, var_b3ba2d13fc1d315c )
{
    weaponobj = makeweapon( "ks_remote_device_mp" );
    interactstate = spawnstruct();
    interactstate.state = 0;
    streakinfo = player scripts\cp_mp\utility\killstreak_utility::createstreakinfo( "", player );
    streakinfo.interactstate = interactstate;
    
    if ( !istrue( player.isjuggernaut ) )
    {
        player _toggletabletallows( 1 );
        player.var_5336de1fb1a48079 = 1;
    }
    
    player.scan_result = var_b3ba2d13fc1d315c;
    var_75639ae0d134a10f = &scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon;
    switchresult = player [[ var_75639ae0d134a10f ]]( weaponobj, streakinfo, &_waituntilinteractfinished, undefined, &_ontabletpulledout, undefined, &_ontabletputaway );
    anim_finished = player function_4697c6c047891c62( var_b3ba2d13fc1d315c );
    player notify( "interact_finished" );
    
    if ( istrue( anim_finished ) )
    {
        var_e2ef0b2ffdc63372 = var_b3ba2d13fc1d315c;
        
        if ( istrue( var_e2ef0b2ffdc63372 ) )
        {
            /#
                if ( function_d4caa84aabf067b3() )
                {
                    player iprintlnbold( "<dev string:x38>" + var_e2ef0b2ffdc63372 );
                }
            #/
        }
        
        self notify( "radioactive_object_scanned" );
        self makeunusable();
        self notify( "scanned" );
        return;
    }
    
    /#
        if ( function_d4caa84aabf067b3() )
        {
            player iprintlnbold( "<dev string:x53>" );
        }
    #/
    
    player setclientomnvar( "ui_tablet_usb", 6 );
}

// Namespace namespace_e3954e763c70e214 / namespace_cb128c18281a7cc
// Params 1
// Checksum 0x0, Offset: 0x96f
// Size: 0x5e, Type: bool
function function_4697c6c047891c62( var_b3ba2d13fc1d315c )
{
    self endon( "death" );
    interactduration = 5000;
    var_b8cf204dd62d457f = gettime() + interactduration;
    
    while ( var_b8cf204dd62d457f > gettime() )
    {
        if ( !scripts\cp\utility::is_valid_player() )
        {
            continue;
        }
        
        if ( !self usebuttonpressed() )
        {
            return false;
        }
        
        wait 0.05;
    }
    
    return true;
}

// Namespace namespace_e3954e763c70e214 / namespace_cb128c18281a7cc
// Params 2
// Checksum 0x0, Offset: 0x9d6
// Size: 0x65
function _ontabletpulledout( streakinfo, switchresult )
{
    if ( !istrue( switchresult ) )
    {
        if ( !istrue( self.isjuggernaut ) )
        {
            _toggletabletallows( 0 );
            self.var_5336de1fb1a48079 = undefined;
        }
    }
    
    if ( istrue( self.scan_result ) )
    {
        omnvar = 4;
    }
    else
    {
        omnvar = 5;
    }
    
    self setclientomnvar( "ui_tablet_usb", omnvar );
}

// Namespace namespace_e3954e763c70e214 / namespace_cb128c18281a7cc
// Params 1
// Checksum 0x0, Offset: 0xa43
// Size: 0x2a
function _ontabletputaway( streakinfo )
{
    if ( !istrue( self.isjuggernaut ) )
    {
        _toggletabletallows( 0 );
        self.var_5336de1fb1a48079 = undefined;
    }
}

// Namespace namespace_e3954e763c70e214 / namespace_cb128c18281a7cc
// Params 1
// Checksum 0x0, Offset: 0xa75
// Size: 0x75
function _waituntilinteractfinished( streakinfo )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    interactstate = streakinfo.interactstate;
    
    if ( interactstate.state != 0 )
    {
        return;
    }
    
    self waittill( "interact_finished" );
    
    if ( interactstate.state == 2 )
    {
        successtime = 5;
        wait successtime;
    }
    
    self setclientomnvar( "ui_tablet_usb", 0 );
}

// Namespace namespace_e3954e763c70e214 / namespace_cb128c18281a7cc
// Params 1
// Checksum 0x0, Offset: 0xaf2
// Size: 0x9d
function _toggletabletallows( var_da3010af8f6be463 )
{
    if ( var_da3010af8f6be463 )
    {
        val::set( "tablet", "allow_movement", 0 );
        val::set( "tablet", "allow_jump", 0 );
        val::set( "tablet", "usability", 0 );
        val::set( "tablet", "melee", 0 );
        val::set( "tablet", "offhand_weapons", 0 );
        val::set( "tablet", "weapon_switch", 0 );
        val::set( "tablet", "freezecontrols_allowlook", 1 );
        return;
    }
    
    val::reset_all( "tablet" );
}

// Namespace namespace_e3954e763c70e214 / namespace_cb128c18281a7cc
// Params 0
// Checksum 0x0, Offset: 0xb97
// Size: 0x1a, Type: bool
function function_d4caa84aabf067b3()
{
    if ( getdvarint( @"hash_75e2d2b2a0d80a22", 0 ) != 0 )
    {
        return true;
    }
    
    return false;
}

