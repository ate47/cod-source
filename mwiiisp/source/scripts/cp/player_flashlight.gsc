#using scripts\common\utility;
#using scripts\cp\cp_debug;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;

#namespace player_flashlight;

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 0
// Checksum 0x0, Offset: 0x5e0
// Size: 0x36
function function_41b2475a04910ba()
{
    level._effect[ "1st_person_flashlight" ] = loadfx( "vfx/iw9/cp/vfx_helmet_bright_light_player.vfx" );
    level._effect[ "3rd_person_flashlight" ] = loadfx( "vfx/iw9/core/flashlight/vfx_flashlight_3rd_person.vfx" );
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 0
// Checksum 0x0, Offset: 0x61e
// Size: 0x19
function function_b9b3106c0cef675e()
{
    self endon( "disconnect" );
    wait 0.5;
    thread toggle_flashlight( 1 );
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 1
// Checksum 0x0, Offset: 0x63f
// Size: 0x8c
function toggle_flashlight( enable )
{
    if ( !isdefined( self ) || !isplayer( self ) || !isalive( self ) )
    {
        return;
    }
    
    if ( !isdefined( enable ) )
    {
        enable = !isdefined( self.var_4aad4f06d972e6b2 );
    }
    
    if ( enable )
    {
        if ( isdefined( self.var_4aad4f06d972e6b2 ) )
        {
            return;
        }
        
        if ( function_54846d3aa2d31163() )
        {
            return;
        }
        
        thread scripts\cp\utility::playerplaypickupanim( "iw9_vm_ges_helmet_light" );
        thread flashlight_on();
        return;
    }
    
    if ( !isdefined( self.var_4aad4f06d972e6b2 ) )
    {
        return;
    }
    
    if ( function_54846d3aa2d31163() )
    {
        return;
    }
    
    thread flashlight_off();
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 2
// Checksum 0x0, Offset: 0x6d3
// Size: 0x54
function function_cbfcb92384926a17( var_4a626586e20b384d, delay )
{
    if ( istrue( var_4a626586e20b384d ) )
    {
        if ( !isdefined( self.var_4aad4f06d972e6b2 ) )
        {
            return;
        }
    }
    
    minimum = 3;
    
    if ( !isdefined( delay ) )
    {
        delay = minimum;
    }
    
    if ( delay < minimum )
    {
        delay = minimum;
    }
    
    toggle_flashlight();
    wait delay;
    toggle_flashlight();
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x72f
// Size: 0x169
function private flashlight_on( ent, tag )
{
    self playlocalsound( "weap_variable_scope_click" );
    self.var_4aad4f06d972e6b2 = 1;
    
    if ( !isdefined( self.var_cad18c06d2fad5c2 ) )
    {
        self.var_cad18c06d2fad5c2 = spawn( "script_model", self.origin );
        self.var_cad18c06d2fad5c2 setmodel( "tag_origin" );
        self.var_cad18c06d2fad5c2.angles = self.angles;
        self.var_cad18c06d2fad5c2 linkto( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    if ( !isdefined( self.var_d10dad930a698f9 ) )
    {
        self.var_d10dad930a698f9 = spawn( "script_model", self.origin );
        self.var_d10dad930a698f9 setmodel( "tag_origin" );
        self.var_d10dad930a698f9.angles = self.angles;
        self.var_d10dad930a698f9 linkto( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    wait 0.1;
    
    if ( !isdefined( level.var_219755583dc9479b ) )
    {
        level.var_219755583dc9479b = 0;
    }
    
    thread function_75d93edf3e7e2b10();
    thread flashlight_off_on_death();
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x8a0
// Size: 0x6f
function private flashlight_off( ent, tag )
{
    self notify( "turn_off_flashlight" );
    self playlocalsound( "weap_variable_scope_click" );
    wait 0.1;
    
    if ( isdefined( self.var_cad18c06d2fad5c2 ) )
    {
        self.var_cad18c06d2fad5c2 delete();
    }
    
    if ( isdefined( self.var_d10dad930a698f9 ) )
    {
        self.var_d10dad930a698f9 delete();
    }
    
    self.var_4aad4f06d972e6b2 = undefined;
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x917
// Size: 0x1a2
function private function_b7f79cecb63ff5bc( player, var_25bbc3661dfe101e )
{
    var_dd1d08b0c203d5ce = player getcamerathirdperson();
    
    if ( istrue( var_25bbc3661dfe101e ) )
    {
        var_25622a3c0a7eb960 = !var_dd1d08b0c203d5ce;
    }
    else
    {
        var_25622a3c0a7eb960 = var_dd1d08b0c203d5ce;
    }
    
    if ( istrue( var_25622a3c0a7eb960 ) )
    {
        player.var_cad18c06d2fad5c2 hide();
        player.var_d10dad930a698f9 show();
        wait 0.1;
        playfxontag( level._effect[ "3rd_person_flashlight" ], player.var_d10dad930a698f9, "tag_origin" );
        return;
    }
    
    player.var_cad18c06d2fad5c2 show();
    
    foreach ( otherplayer in level.players )
    {
        if ( player != otherplayer )
        {
            player.var_d10dad930a698f9 showtoplayer( otherplayer );
        }
    }
    
    wait 0.1;
    
    foreach ( otherplayer in level.players )
    {
        if ( player != otherplayer )
        {
            playfxontagforclients( level._effect[ "3rd_person_flashlight" ], player.var_d10dad930a698f9, "tag_origin", otherplayer );
        }
    }
    
    playfxontagforclients( level._effect[ "1st_person_flashlight" ], player.var_cad18c06d2fad5c2, "tag_origin", player );
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 0
// Checksum 0x0, Offset: 0xac1
// Size: 0x182
function function_41c3302121be1a40()
{
    player = self;
    var_dd1d08b0c203d5ce = player getcamerathirdperson();
    
    if ( istrue( var_dd1d08b0c203d5ce ) )
    {
        player.var_cad18c06d2fad5c2 hide();
        player.var_d10dad930a698f9 show();
        wait 0.1;
        playfxontag( level._effect[ "3rd_person_flashlight" ], player.var_d10dad930a698f9, "tag_origin" );
        return;
    }
    
    player.var_cad18c06d2fad5c2 show();
    
    foreach ( otherplayer in level.players )
    {
        if ( player != otherplayer )
        {
            player.var_d10dad930a698f9 showtoplayer( otherplayer );
        }
    }
    
    wait 0.1;
    
    foreach ( otherplayer in level.players )
    {
        if ( player != otherplayer )
        {
            playfxontagforclients( level._effect[ "3rd_person_flashlight" ], player.var_d10dad930a698f9, "tag_origin", otherplayer );
        }
    }
    
    playfxontagforclients( level._effect[ "1st_person_flashlight" ], player.var_cad18c06d2fad5c2, "tag_origin", player );
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xc4b
// Size: 0x465
function private function_75d93edf3e7e2b10()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "turn_off_flashlight" );
    
    for ( notifyresult = undefined; true ; notifyresult = waittill_any_return_4( "toggled_third_person_camera", "pickedupweapon", "update_flashlight_tags" ) )
    {
        if ( self tagexists( "TAG_helmetlight" ) )
        {
            self.var_cad18c06d2fad5c2 linkto( self, "TAG_helmetlight", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        }
        else if ( self tagexists( "j_helmet" ) )
        {
            self.var_cad18c06d2fad5c2 linkto( self, "j_helmet", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        }
        else if ( self tagexists( "tag_helmet" ) )
        {
            self.var_cad18c06d2fad5c2 linkto( self, "tag_helmet", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        }
        else
        {
            self.var_cad18c06d2fad5c2 linkto( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        }
        
        if ( self tagexists( "J_Shoulder_LE" ) )
        {
            if ( isdefined( self.currentprimaryweapon ) )
            {
                if ( self.currentprimaryweapon.basename == "iw9_me_pushfists" )
                {
                    self.var_d10dad930a698f9 linkto( self, "tag_helmetlight", ( -5, 0, 5 ), ( 0, 0, 0 ) );
                }
                else if ( self.currentprimaryweapon.basename == "iw9_oxygenmask" )
                {
                    self.var_d10dad930a698f9 linkto( self, "tag_origin", ( 0, 0, 60 ), ( 0, 0, 0 ) );
                }
                else
                {
                    self.var_d10dad930a698f9 linkto( self, "J_Shoulder_LE", ( 0, 10, -5 ), ( -25, -15, 0 ) );
                }
            }
            else if ( isdefined( self.prevweaponobj ) )
            {
                if ( self.prevweaponobj.basename == "iw9_me_riotshield_mp" )
                {
                    self.var_d10dad930a698f9 linkto( self, "tag_origin", ( 0, 20, 0 ), ( 0, 0, 0 ) );
                }
                else if ( self.prevweaponobj.basename == "iw9_oxygenmask" )
                {
                    self.var_d10dad930a698f9 linkto( self, "tag_origin", ( 0, 0, 70 ), ( 0, 0, 0 ) );
                }
                else
                {
                    self.var_d10dad930a698f9 linkto( self, "J_Shoulder_LE", ( 0, 10, -5 ), ( -25, -15, 0 ) );
                }
            }
            else
            {
                self.var_d10dad930a698f9 linkto( self, "J_Shoulder_LE", ( 0, 10, -5 ), ( -25, -15, 0 ) );
            }
        }
        else if ( self tagexists( "j_helmet" ) )
        {
            self.var_d10dad930a698f9 linkto( self, "j_helmet", ( -5, -5, 0 ), ( 0, 270, 0 ) );
        }
        else if ( self tagexists( "tag_helmet" ) )
        {
            self.var_d10dad930a698f9 linkto( self, "tag_helmet", ( -5, -5, 0 ), ( 0, 270, 0 ) );
        }
        else
        {
            self.var_d10dad930a698f9 linkto( self, "tag_origin", ( 0, 0, 0 ), ( 90, 0, 0 ) );
        }
        
        if ( isdefined( notifyresult ) )
        {
            if ( notifyresult != "toggled_third_person_camera" )
            {
                if ( isdefined( self.currentprimaryweapon.basename ) && ( self.currentprimaryweapon.basename == "iw9_me_pushfists" || self.currentprimaryweapon.basename == "none" ) )
                {
                    function_b7f79cecb63ff5bc( self, 1 );
                }
                else
                {
                    function_b7f79cecb63ff5bc( self, 0 );
                }
            }
            else
            {
                function_b7f79cecb63ff5bc( self, 1 );
            }
            
            continue;
        }
        
        function_b7f79cecb63ff5bc( self, 0 );
    }
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x10b8
// Size: 0x3f
function private flashlight_off_on_death()
{
    self notify( "flashlight_off_on_death" );
    self endon( "flashlight_off_on_death" );
    self endon( "disconnect" );
    self waittill( "death" );
    
    if ( !isdefined( self.var_4aad4f06d972e6b2 ) )
    {
        return;
    }
    
    flashlight_off();
    self.var_4aad4f06d972e6b2 = undefined;
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x10ff
// Size: 0x37, Type: bool
function private function_54846d3aa2d31163()
{
    if ( isdefined( self.var_1d66399e95195d21 ) && self.var_1d66399e95195d21 > gettime() - 200 )
    {
        return true;
    }
    
    self.var_1d66399e95195d21 = gettime();
    return false;
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 0
// Checksum 0x0, Offset: 0x113f
// Size: 0x79
function function_491a6611a0b52b99()
{
    level.var_f2e48424baec7c2e = getentarray( "flashlight_trigger", "targetname" );
    
    if ( isdefined( level.var_f2e48424baec7c2e ) )
    {
        foreach ( trigger in level.var_f2e48424baec7c2e )
        {
            trigger thread function_7fcb92efb596bd83();
        }
    }
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 0
// Checksum 0x0, Offset: 0x11c0
// Size: 0x2c
function function_7fcb92efb596bd83()
{
    if ( isdefined( self.entstouching ) )
    {
        return;
    }
    
    self.entstouching = [];
    thread trigger_watchflashlighttriggerexit( self );
    thread trigger_watchflashlighttriggerenter( self );
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 1
// Checksum 0x0, Offset: 0x11f4
// Size: 0x59
function trigger_watchflashlighttriggerenter( trigger )
{
    level endon( "game_ended" );
    trigger notify( "trigger_watchFlashlightTriggerEnter" );
    trigger endon( "trigger_watchFlashlightTriggerEnter" );
    trigger endon( "death" );
    
    while ( true )
    {
        trigger waittill( "trigger", ent );
        
        if ( !function_dc0a66796f616fce( ent ) )
        {
            continue;
        }
        
        function_7df3c090beee2450( trigger, ent );
    }
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 1
// Checksum 0x0, Offset: 0x1255
// Size: 0xd8
function trigger_watchflashlighttriggerexit( trigger )
{
    level endon( "game_ended" );
    trigger notify( "trigger_watchFlashlightTriggerExit" );
    trigger endon( "trigger_watchFlashlightTriggerExit" );
    trigger endon( "death" );
    
    while ( true )
    {
        temparr = trigger.entstouching;
        
        foreach ( ent in temparr )
        {
            if ( !isdefined( ent ) )
            {
                trigger.entstouching[ id ] = undefined;
                continue;
            }
            
            valid = trigger istouching( ent );
            
            if ( isplayer( ent ) && !isalive( ent ) )
            {
                valid = 0;
            }
            
            if ( isdefined( ent ) && !valid )
            {
                function_bd8f6ed981f07aaa( trigger, ent );
            }
        }
        
        waitframe();
    }
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 1
// Checksum 0x0, Offset: 0x1335
// Size: 0x27, Type: bool
function function_dc0a66796f616fce( ent )
{
    if ( isdefined( ent ) )
    {
        if ( isplayer( ent ) )
        {
            if ( ent scripts\cp_mp\utility\player_utility::_isalive() )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 2
// Checksum 0x0, Offset: 0x1365
// Size: 0x46
function function_bd8f6ed981f07aaa( trigger, ent )
{
    entnum = ent getentitynumber();
    trigger.entstouching[ entnum ] = undefined;
    
    if ( !function_5aa17b8039e280d( trigger, ent ) )
    {
        ent thread toggle_flashlight( 0 );
    }
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 2
// Checksum 0x0, Offset: 0x13b3
// Size: 0x50
function function_7df3c090beee2450( trigger, ent )
{
    entnum = ent getentitynumber();
    
    if ( isdefined( trigger.entstouching[ entnum ] ) )
    {
        return;
    }
    
    trigger.entstouching[ entnum ] = ent;
    ent thread toggle_flashlight( 1 );
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 2
// Checksum 0x0, Offset: 0x140b
// Size: 0x8b, Type: bool
function function_5aa17b8039e280d( trigger, ent )
{
    entnum = ent getentitynumber();
    
    foreach ( other_trigger in level.var_f2e48424baec7c2e )
    {
        if ( other_trigger == trigger )
        {
            continue;
        }
        
        if ( isdefined( other_trigger.entstouching[ entnum ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 0
// Checksum 0x0, Offset: 0x149f
// Size: 0xef
function function_47f4f9f3fa1a644d()
{
    cmd = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Toggle Flashlight P1\" \"togglep scr_cpflashlightp1_toggle 1\" \n";
    addentrytodevgui( cmd );
    level thread function_eef8fed381e4deec( @"hash_e39637fee7dc2c32", &function_692ed79ca5616c4e );
    cmd = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Toggle Flashlight P2\" \"togglep scr_cpflashlightp2_toggle 1\" \n";
    addentrytodevgui( cmd );
    level thread function_eef8fed381e4deec( @"hash_39097cbf328765f5", &function_692ed69ca5616a1b );
    cmd = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Toggle Flashlight P3\" \"togglep scr_cpflashlightp3_toggle 1\" \n";
    addentrytodevgui( cmd );
    level thread function_eef8fed381e4deec( @"hash_4e79247efa17ec98", &function_692ed59ca56167e8 );
    cmd = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Flash x4 Flashlight P1\" \"togglep scr_cpflashlightp1_flash 1\" \n";
    addentrytodevgui( cmd );
    level thread function_eef8fed381e4deec( @"hash_5afbd1775ccd6b80", &function_d3810fcc0316553b );
    cmd = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Flash x4 Flashlight P2\" \"togglep scr_cpflashlightp2_flash 1\" \n";
    addentrytodevgui( cmd );
    level thread function_eef8fed381e4deec( @"hash_b70c1770b63fba59", &function_33703dd50c607cce );
    cmd = "devgui_cmd \"CP Debug:2 / Debug / CP Flashlight / Flash x4 Flashlight P3\" \"togglep scr_cpflashlightp3_flash 1\" \n";
    addentrytodevgui( cmd );
    level thread function_eef8fed381e4deec( @"hash_b3c0c4997d226c4e", &function_36bb90ac457dcad9 );
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1596
// Size: 0x24
function private function_692ed79ca5616c4e()
{
    if ( isdefined( level.players[ 0 ] ) )
    {
        level.players[ 0 ] thread toggle_flashlight();
    }
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x15c2
// Size: 0x26
function private function_692ed69ca5616a1b()
{
    if ( isdefined( level.players[ 1 ] ) )
    {
        level.players[ 1 ] thread toggle_flashlight();
    }
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x15f0
// Size: 0x26
function private function_692ed59ca56167e8()
{
    if ( isdefined( level.players[ 2 ] ) )
    {
        level.players[ 2 ] thread toggle_flashlight();
    }
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x161e
// Size: 0x24
function private function_d3810fcc0316553b()
{
    if ( isdefined( level.players[ 0 ] ) )
    {
        level.players[ 0 ] thread function_f25f2e91dbd65167();
    }
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x164a
// Size: 0x26
function private function_33703dd50c607cce()
{
    if ( isdefined( level.players[ 1 ] ) )
    {
        level.players[ 1 ] thread function_f25f2e91dbd65167();
    }
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1678
// Size: 0x26
function private function_36bb90ac457dcad9()
{
    if ( isdefined( level.players[ 2 ] ) )
    {
        level.players[ 2 ] thread function_f25f2e91dbd65167();
    }
}

// Namespace player_flashlight / scripts\cp\player_flashlight
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x16a6
// Size: 0x5c
function private function_f25f2e91dbd65167()
{
    if ( isdefined( self ) )
    {
        announcement( "flash 1 / 4, enable" );
        thread toggle_flashlight();
        wait 3;
        announcement( "flash 2 / 4, disable" );
        thread toggle_flashlight();
        wait 3;
        announcement( "flash 3 / 4, enable" );
        thread toggle_flashlight();
        wait 3;
        announcement( "flash 4 / 4, disable" );
        thread toggle_flashlight();
    }
}

