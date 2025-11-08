#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\pip_util;
#using scripts\sp\utility;

#namespace pip_util;

/#

    // Namespace pip_util / scripts\sp\pip_util
    // Params 0
    // Checksum 0x0, Offset: 0x1a2
    // Size: 0x10, Type: dev
    function pip_init()
    {
        println( "<dev string:x1c>" );
    }

#/

// Namespace pip_util / scripts\sp\pip_util
// Params 6
// Checksum 0x0, Offset: 0x1bb
// Size: 0x266
function pip_on_ent( ent, tag, fov, origin_offset, angles_offset, no_hud )
{
    if ( getdvarint( @"e3" ) )
    {
        return;
    }
    
    if ( gettime() < 500 )
    {
        println( "<dev string:x5c>" );
        wait 0.5;
    }
    
    if ( !isdefined( tag ) )
    {
        /#
            iprintlnbold( "<dev string:xac>" );
        #/
        
        return;
    }
    
    if ( !isdefined( level.pip ) )
    {
        level.pip = level.player newpip();
    }
    
    if ( pip_is_active() )
    {
        /#
            iprintln( "<dev string:xef>" );
        #/
        
        return;
    }
    
    level.pip.enableshadows = 1;
    level.pip.rendertotexture = 1;
    level.pip.clipdistance = 5000;
    level.pip.nearz = 2;
    level.pip.aspectratio = 1;
    level.pip.origin_offset = ( 0, 0, 0 );
    level.pip.angles_offset = ( 0, 0, 0 );
    level.pip.tag = tag;
    level.pip.fov = ter_op( isdefined( fov ), fov, 30 );
    
    if ( isdefined( origin_offset ) )
    {
        level.pip.origin_offset = origin_offset;
    }
    
    if ( isdefined( angles_offset ) )
    {
        level.pip.angles_offset = angles_offset;
    }
    
    level.pip.entity = ent;
    level.pip.enable = 1;
    level.pip.freecamera = 1;
    setomnvar( "ui_pip_static", 0 );
    setomnvar( "ui_pip_message_text_top", "script_pip_default_top" );
    setomnvar( "ui_pip_message_text_bottom", "script_pip_default_bottom" );
    setomnvar( "ui_pip_message_type", 1 );
    
    if ( !isdefined( no_hud ) )
    {
        setomnvar( "ui_show_pip", 1 );
        setomnvar( "ui_jackal_hide_follow_pip", 0 );
    }
}

// Namespace pip_util / scripts\sp\pip_util
// Params 1
// Checksum 0x0, Offset: 0x429
// Size: 0x116
function bink_pip( bink_name )
{
    level.player playsound( "ui_pip_on_hud_right" );
    setomnvar( "ui_pip_message_text_top", "script_pip_default_top" );
    setomnvar( "ui_pip_message_text_bottom", "script_pip_default_bottom" );
    stopcinematicingame();
    setsaveddvar( @"bg_cinematicfullscreen", "0" );
    setsaveddvar( @"hash_b9ff37d084074df3", "1" );
    setomnvar( "ui_show_pip", 1 );
    wait 0.05;
    setomnvar( "ui_show_pip", 0 );
    wait 0.05;
    setomnvar( "ui_show_pip", 1 );
    cinematicingame( bink_name );
    
    while ( !iscinematicplaying() )
    {
        wait 0.05;
    }
    
    while ( iscinematicplaying() )
    {
        wait 0.05;
    }
    
    stopcinematicingame();
    setomnvar( "ui_show_pip", 0 );
    level.player playsound( "ui_pip_off_hud_right" );
    setsaveddvar( @"bg_cinematicfullscreen", "1" );
    setsaveddvar( @"hash_b9ff37d084074df3", "1" );
}

// Namespace pip_util / scripts\sp\pip_util
// Params 1
// Checksum 0x0, Offset: 0x547
// Size: 0x52
function pip_visionset( vision )
{
    level.pip.activevisionset = "naked";
    level.pip.activevisionsetduration = 0.5;
    level.pip.visionsetnaked = vision;
}

// Namespace pip_util / scripts\sp\pip_util
// Params 0
// Checksum 0x0, Offset: 0x5a1
// Size: 0x58
function pip_close()
{
    if ( getdvarint( @"e3" ) )
    {
        return;
    }
    
    if ( !isdefined( level.pip ) )
    {
        return;
    }
    
    setomnvar( "ui_show_pip", 0 );
    setomnvar( "ui_jackal_hide_follow_pip", 1 );
    level.pip.enable = 0;
    level notify( "pip_closed" );
}

// Namespace pip_util / scripts\sp\pip_util
// Params 0
// Checksum 0x0, Offset: 0x601
// Size: 0x3b, Type: bool
function pip_is_active()
{
    return isdefined( level.pip ) && isdefined( level.pip.enable ) && level.pip.enable;
}

// Namespace pip_util / scripts\sp\pip_util
// Params 1
// Checksum 0x0, Offset: 0x645
// Size: 0x21
function pip_dialogue( the_line )
{
    face_pip();
    smart_dialogue_generic( the_line );
    scripts\sp\pip_util::pip_close();
}

// Namespace pip_util / scripts\sp\pip_util
// Params 1
// Checksum 0x0, Offset: 0x66e
// Size: 0xe2
function face_pip( no_hud )
{
    switch ( tolower( self.unittype ) )
    {
        case #"hash_198d036c171c0b3f":
            scripts\sp\pip_util::pip_on_ent( self, "tag_eye", 29, ( 18, 7, 1 ), ( 0, 200, 3 ), no_hud );
            break;
        case #"hash_8b0d967838e55b97":
            scripts\sp\pip_util::pip_on_ent( self, "tag_barrel", 13, ( 150, 0, 20 ), ( 8.5, 180, 0 ), no_hud );
            break;
        default:
            scripts\sp\pip_util::pip_on_ent( self, "tag_eye", 29, ( 18, 7, -1 ), ( 0, 200, 3 ), no_hud );
            level.pip.nearz = 17;
            break;
    }
}

// Namespace pip_util / scripts\sp\pip_util
// Params 0
// Checksum 0x0, Offset: 0x758
// Size: 0x18
function pip_vo()
{
    face_pip();
    self waittill( "close_pip" );
    pip_close();
}

