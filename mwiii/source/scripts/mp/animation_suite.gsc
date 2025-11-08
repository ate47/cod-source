#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\debug;

#namespace animation_suite;

// Namespace animation_suite / scripts\mp\animation_suite
// Params 0
// Checksum 0x0, Offset: 0x2d4
// Size: 0x137
function animationsuite()
{
    while ( !istrue( game[ "gamestarted" ] ) )
    {
        waitframe();
    }
    
    animatedobjs = getentarray( "animObj", "targetname" );
    assertex( animatedobjs.size < 200, animatedobjs.size + "<dev string:x1c>" );
    groups = gathergroups( animatedobjs );
    setupvfxobjs( animatedobjs );
    setupsfxobjs( animatedobjs );
    
    foreach ( obj in animatedobjs )
    {
        if ( scripts\cp_mp\utility\game_utility::islargemap() )
        {
            obj forcenetfieldhighlod( 1 );
        }
        
        if ( isdefined( obj.script_animation_type ) )
        {
            switch ( obj.script_animation_type )
            {
                case #"hash_7bbd660a0ef1a992":
                case #"hash_dac7d62cc377c033":
                    obj thread animsuite_rotation( obj.script_animation_type );
                    break;
                case #"hash_2fc0e960a17f77d0":
                case #"hash_cb20eda5e00181ef":
                    obj thread animsuite_translation( obj.script_animation_type );
                    break;
            }
        }
    }
}

// Namespace animation_suite / scripts\mp\animation_suite
// Params 1
// Checksum 0x0, Offset: 0x413
// Size: 0x10c
function setupvfxobjs( objects )
{
    foreach ( obj in objects )
    {
        if ( isdefined( obj.script_noteworthy ) && string_starts_with( obj.script_noteworthy, "vfx_" ) )
        {
            model = obj spawn_tag_origin();
            model show();
            model linkto( obj );
            assertex( isdefined( level._effect[ obj.script_noteworthy ] ), obj.script_noteworthy + "<dev string:x8a>" );
            waitframe();
            
            if ( !isvalidanimsuiteentity( "setupVFXObjs(): obj", obj ) )
            {
                continue;
            }
            
            if ( !isvalidanimsuiteentity( "setupVFXObjs(): model", model ) )
            {
                continue;
            }
            
            thread delayfxcall( getfx( obj.script_noteworthy ), model, "tag_origin" );
        }
    }
}

// Namespace animation_suite / scripts\mp\animation_suite
// Params 3
// Checksum 0x0, Offset: 0x527
// Size: 0x37
function delayfxcall( fx, model, tag )
{
    wait 5;
    
    if ( !isvalidanimsuiteentity( "delayFXCall()", model ) )
    {
        return;
    }
    
    playfxontag( fx, model, tag );
}

// Namespace animation_suite / scripts\mp\animation_suite
// Params 1
// Checksum 0x0, Offset: 0x566
// Size: 0x92
function setupsfxobjs( objects )
{
    foreach ( obj in objects )
    {
        if ( isdefined( obj.script_noteworthy ) && string_starts_with( obj.script_noteworthy, "sfx_" ) )
        {
            obj setmodel( "tag_origin" );
            obj thread play_loop_sound_on_entity( "mp_quarry_lg_crane_loop" );
        }
    }
}

// Namespace animation_suite / scripts\mp\animation_suite
// Params 0
// Checksum 0x0, Offset: 0x600
// Size: 0x34
function debug_temp_sphere()
{
    while ( true )
    {
        drawsphere( self.origin, 32, 0.1, ( 0, 0, 255 ) );
        wait 0.1;
    }
}

// Namespace animation_suite / scripts\mp\animation_suite
// Params 1
// Checksum 0x0, Offset: 0x63c
// Size: 0x188
function gathergroups( objects )
{
    groups = [];
    groupssorted = [];
    
    foreach ( obj in objects )
    {
        if ( isdefined( obj.script_noteworthy ) && issubstr( obj.script_noteworthy, "group" ) )
        {
            groups = array_add( groups, obj );
        }
    }
    
    foreach ( item in groups )
    {
        if ( !isdefined( groupssorted[ item.script_noteworthy ] ) )
        {
            groupssorted[ item.script_noteworthy ] = [ item ];
            continue;
        }
        
        groupssorted[ item.script_noteworthy ] = array_add( groupssorted[ item.script_noteworthy ], item );
    }
    
    foreach ( group in groupssorted )
    {
        parent = animsuite_getparentobject( group );
        animsuite_linkchildrentoparentobject( parent, group );
    }
    
    return groupssorted;
}

// Namespace animation_suite / scripts\mp\animation_suite
// Params 1
// Checksum 0x0, Offset: 0x7cd
// Size: 0x60
function animsuite_getparentobject( group )
{
    foreach ( entry in group )
    {
        if ( isdefined( entry.script_linkname ) )
        {
            return entry;
        }
    }
}

// Namespace animation_suite / scripts\mp\animation_suite
// Params 2
// Checksum 0x0, Offset: 0x835
// Size: 0x73
function animsuite_linkchildrentoparentobject( parent, group )
{
    if ( isdefined( parent ) && isdefined( group ) )
    {
        foreach ( entry in group )
        {
            if ( entry == parent )
            {
                continue;
            }
            
            entry linkto( parent );
        }
    }
}

// Namespace animation_suite / scripts\mp\animation_suite
// Params 1
// Checksum 0x0, Offset: 0x8b0
// Size: 0x37
function animsuite_translation( translation_type )
{
    if ( issubstr( translation_type, "pingpong" ) )
    {
        thread animsuite_translation_pingpong();
    }
    
    if ( issubstr( translation_type, "once" ) )
    {
        thread animsuite_translation_once();
    }
}

// Namespace animation_suite / scripts\mp\animation_suite
// Params 0
// Checksum 0x0, Offset: 0x8ef
// Size: 0x1b6
function animsuite_translation_pingpong()
{
    level endon( "game_ended" );
    var_d62c5724671299ba = ( 0, 90, 0 );
    translationtime = 5;
    pause = 0.5;
    start = undefined;
    Stop = undefined;
    loop = undefined;
    
    if ( isdefined( self.script_translation_amount ) )
    {
        var_d62c5724671299ba = self.script_translation_amount;
    }
    
    if ( isdefined( self.script_translation_time ) )
    {
        translationtime = self.script_translation_time;
    }
    
    if ( isdefined( self.script_audio_parameters ) )
    {
        if ( issubstr( self.script_audio_parameters, "start" ) )
        {
            start = "mp_quarry_lg_crane_start";
        }
        
        if ( issubstr( self.script_audio_parameters, "stop" ) )
        {
            Stop = "mp_quarry_lg_crane_stop";
        }
        
        if ( issubstr( self.script_audio_parameters, "loop" ) )
        {
            loop = "mp_quarry_lg_crane_loop";
        }
    }
    
    while ( true )
    {
        firstpos = self.origin;
        self moveto( self.origin + var_d62c5724671299ba, translationtime[ 0 ], translationtime[ 1 ], translationtime[ 2 ] );
        
        if ( isdefined( Stop ) )
        {
            thread animsuite_playthreadedsound( translationtime[ 0 ], Stop );
        }
        
        wait translationtime[ 0 ] + pause;
        
        if ( !isvalidanimsuiteentity( "animSuite_Translation_PingPong()", self ) )
        {
            return;
        }
        
        if ( isdefined( start ) )
        {
            playsoundatpos( self.origin, start );
        }
        
        self moveto( firstpos, translationtime[ 0 ], translationtime[ 1 ], translationtime[ 2 ] );
        
        if ( isdefined( Stop ) )
        {
            thread animsuite_playthreadedsound( translationtime[ 0 ], Stop );
        }
        
        wait translationtime[ 0 ] + pause;
        
        if ( !isvalidanimsuiteentity( "animSuite_Translation_PingPong()", self ) )
        {
            return;
        }
        
        if ( isdefined( start ) )
        {
            playsoundatpos( self.origin, start );
        }
    }
}

// Namespace animation_suite / scripts\mp\animation_suite
// Params 2
// Checksum 0x0, Offset: 0xaad
// Size: 0x35
function animsuite_playthreadedsound( waittime, alias )
{
    wait waittime;
    
    if ( !isvalidanimsuiteentity( "animSuite_playThreadedSound()", self ) )
    {
        return;
    }
    
    playsoundatpos( self.origin, alias );
}

// Namespace animation_suite / scripts\mp\animation_suite
// Params 0
// Checksum 0x0, Offset: 0xaea
// Size: 0x88
function animsuite_translation_once()
{
    level endon( "game_ended" );
    var_d62c5724671299ba = ( 0, 90, 0 );
    translationtime = 5;
    
    if ( isdefined( self.script_translation_amount ) )
    {
        var_d62c5724671299ba = self.script_translation_amount;
    }
    
    if ( isdefined( self.script_translation_time ) )
    {
        translationtime = length( self.script_translation_time );
    }
    
    while ( true )
    {
        self rotateby( var_d62c5724671299ba, translationtime, 0, 0 );
        wait translationtime;
        
        if ( !isvalidanimsuiteentity( "animSuite_Translation_Once()", self ) )
        {
            return;
        }
    }
}

// Namespace animation_suite / scripts\mp\animation_suite
// Params 1
// Checksum 0x0, Offset: 0xb7a
// Size: 0x37
function animsuite_rotation( rotation_type )
{
    if ( issubstr( rotation_type, "pingpong" ) )
    {
        thread animsuite_rotation_pingpong();
    }
    
    if ( issubstr( rotation_type, "continuous" ) )
    {
        thread animsuite_rotation_continuous();
    }
}

// Namespace animation_suite / scripts\mp\animation_suite
// Params 0
// Checksum 0x0, Offset: 0xbb9
// Size: 0x14a
function animsuite_rotation_pingpong()
{
    level endon( "game_ended" );
    var_88c3a0fd4d89c1f4 = ( 0, 90, 0 );
    rotatetime = ( 5, 0, 0 );
    rotatepause = 0;
    start = undefined;
    Stop = undefined;
    loop = undefined;
    
    if ( isdefined( self.script_rotation_amount ) )
    {
        var_88c3a0fd4d89c1f4 = self.script_rotation_amount;
    }
    
    if ( isdefined( self.script_rotation_speed ) )
    {
        rotatetime = self.script_rotation_speed;
    }
    
    while ( true )
    {
        self rotateby( var_88c3a0fd4d89c1f4, rotatetime[ 0 ], rotatetime[ 1 ], rotatetime[ 2 ] );
        
        if ( isdefined( Stop ) )
        {
            thread animsuite_playthreadedsound( rotatetime[ 0 ] * 0.9, Stop );
        }
        
        wait rotatetime[ 0 ] + rotatepause;
        
        if ( !isvalidanimsuiteentity( "animSuite_Rotation_PingPong()", self ) )
        {
            return;
        }
        
        if ( isdefined( start ) )
        {
            playsoundatpos( self.origin, start );
        }
        
        self rotateby( var_88c3a0fd4d89c1f4 * -1, rotatetime[ 0 ], rotatetime[ 1 ], rotatetime[ 2 ] );
        
        if ( isdefined( Stop ) )
        {
            thread animsuite_playthreadedsound( rotatetime[ 0 ] * 0.9, Stop );
        }
        
        wait rotatetime[ 0 ] + rotatepause;
        
        if ( !isvalidanimsuiteentity( "animSuite_Rotation_PingPong()", self ) )
        {
            return;
        }
        
        if ( isdefined( start ) )
        {
            playsoundatpos( self.origin, start );
        }
    }
}

// Namespace animation_suite / scripts\mp\animation_suite
// Params 0
// Checksum 0x0, Offset: 0xd0b
// Size: 0xa7
function animsuite_rotation_continuous()
{
    level endon( "game_ended" );
    var_88c3a0fd4d89c1f4 = ( 0, 90, 0 );
    rotatetime = ( 5, 0, 0 );
    rotatepause = 0.5;
    
    if ( isdefined( self.script_rotation_amount ) )
    {
        var_88c3a0fd4d89c1f4 = self.script_rotation_amount;
    }
    
    if ( isdefined( self.script_rotation_speed ) )
    {
        rotatetime = self.script_rotation_speed;
    }
    
    while ( true )
    {
        self rotateby( var_88c3a0fd4d89c1f4, rotatetime[ 0 ], rotatetime[ 1 ], rotatetime[ 2 ] );
        wait rotatetime[ 0 ];
        
        if ( !isvalidanimsuiteentity( "animSuite_Rotation_Continuous()", self ) )
        {
            return;
        }
    }
}

// Namespace animation_suite / scripts\mp\animation_suite
// Params 2
// Checksum 0x0, Offset: 0xdba
// Size: 0x2c, Type: bool
function isvalidanimsuiteentity( funcname, ent )
{
    if ( !isdefined( ent ) )
    {
        assertmsg( funcname + "<dev string:xab>" );
        return false;
    }
    
    return true;
}

