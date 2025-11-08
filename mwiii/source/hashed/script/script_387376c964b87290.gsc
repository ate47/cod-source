#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_955644017be51149;

// Namespace namespace_955644017be51149 / namespace_2035ffc4aceb67f0
// Params 0
// Checksum 0x0, Offset: 0x27e
// Size: 0x12d
function function_c1b99bc04c9cfe4a()
{
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    animatedobjs = getentarray( "manipulate_ent", "script_noteworthy" );
    assertex( animatedobjs.size < 200, animatedobjs.size + "<dev string:x1c>" );
    
    foreach ( obj in animatedobjs )
    {
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
            
            continue;
        }
        
        obj thread animsuite_rotation( "rotation_continuous" );
    }
    
    level.animatedobjs = animatedobjs;
    
    /#
        level thread function_d6355f012701ccd5();
    #/
}

// Namespace namespace_955644017be51149 / namespace_2035ffc4aceb67f0
// Params 1
// Checksum 0x0, Offset: 0x3b3
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

// Namespace namespace_955644017be51149 / namespace_2035ffc4aceb67f0
// Params 1
// Checksum 0x0, Offset: 0x544
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

// Namespace namespace_955644017be51149 / namespace_2035ffc4aceb67f0
// Params 2
// Checksum 0x0, Offset: 0x5ac
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

// Namespace namespace_955644017be51149 / namespace_2035ffc4aceb67f0
// Params 1
// Checksum 0x0, Offset: 0x627
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

// Namespace namespace_955644017be51149 / namespace_2035ffc4aceb67f0
// Params 0
// Checksum 0x0, Offset: 0x666
// Size: 0x179
function animsuite_translation_pingpong()
{
    self notify( "anim_started" );
    level endon( "game_ended" );
    self endon( "anim_started" );
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
        wait translationtime[ 0 ] + pause;
        
        if ( !isvalidanimsuiteentity( "animSuite_Translation_PingPong()", self ) )
        {
            return;
        }
        
        self moveto( firstpos, translationtime[ 0 ], translationtime[ 1 ], translationtime[ 2 ] );
        wait translationtime[ 0 ] + pause;
        
        if ( !isvalidanimsuiteentity( "animSuite_Translation_PingPong()", self ) )
        {
            return;
        }
    }
}

// Namespace namespace_955644017be51149 / namespace_2035ffc4aceb67f0
// Params 0
// Checksum 0x0, Offset: 0x7e7
// Size: 0x97
function animsuite_translation_once()
{
    self notify( "anim_started" );
    level endon( "game_ended" );
    self endon( "anim_started" );
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

// Namespace namespace_955644017be51149 / namespace_2035ffc4aceb67f0
// Params 1
// Checksum 0x0, Offset: 0x886
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

// Namespace namespace_955644017be51149 / namespace_2035ffc4aceb67f0
// Params 0
// Checksum 0x0, Offset: 0x8c5
// Size: 0x101
function animsuite_rotation_pingpong()
{
    self notify( "anim_started" );
    level endon( "game_ended" );
    self endon( "anim_started" );
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
        wait rotatetime[ 0 ] + rotatepause;
        
        if ( !isvalidanimsuiteentity( "animSuite_Rotation_PingPong()", self ) )
        {
            return;
        }
        
        self rotateby( var_88c3a0fd4d89c1f4 * -1, rotatetime[ 0 ], rotatetime[ 1 ], rotatetime[ 2 ] );
        wait rotatetime[ 0 ] + rotatepause;
        
        if ( !isvalidanimsuiteentity( "animSuite_Rotation_PingPong()", self ) )
        {
            return;
        }
    }
}

// Namespace namespace_955644017be51149 / namespace_2035ffc4aceb67f0
// Params 0
// Checksum 0x0, Offset: 0x9ce
// Size: 0xb6
function animsuite_rotation_continuous()
{
    self notify( "anim_started" );
    level endon( "game_ended" );
    self endon( "anim_started" );
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

// Namespace namespace_955644017be51149 / namespace_2035ffc4aceb67f0
// Params 2
// Checksum 0x0, Offset: 0xa8c
// Size: 0x2c, Type: bool
function isvalidanimsuiteentity( funcname, ent )
{
    if ( !isdefined( ent ) )
    {
        assertmsg( funcname + "<dev string:x8a>" );
        return false;
    }
    
    return true;
}

// Namespace namespace_955644017be51149 / namespace_2035ffc4aceb67f0
// Params 0
// Checksum 0x0, Offset: 0xac1
// Size: 0x27b
function function_d6355f012701ccd5()
{
    level endon( "game_ended" );
    level.var_541f214d076eb549 = undefined;
    
    while ( true )
    {
        var_3a0baf8f0c5bd7f1 = getdvarint( @"hash_e9197f745a6b494", 0 );
        
        switch ( var_3a0baf8f0c5bd7f1 )
        {
            case 1:
                if ( !isdefined( level.var_541f214d076eb549 ) )
                {
                    obj = spawn( "script_model", ( -5910.26, -3473.5, 0 ) );
                    obj setmodel( "veh9_mil_lnd_jltv_lobby" );
                    level.var_541f214d076eb549 = obj;
                }
                
                level.var_541f214d076eb549 thread animsuite_rotation( "continuous" );
                break;
            case 2:
                if ( !isdefined( level.var_541f214d076eb549 ) )
                {
                    obj = spawn( "script_model", ( -5910.26, -3473.5, 0 ) );
                    obj setmodel( "veh9_mil_lnd_jltv_lobby" );
                    level.var_541f214d076eb549 = obj;
                }
                
                level.var_541f214d076eb549 thread animsuite_translation( "once" );
                break;
            case 3:
                if ( !isdefined( level.var_541f214d076eb549 ) )
                {
                    obj = spawn( "script_model", ( -5910.26, -3473.5, 0 ) );
                    obj setmodel( "veh9_mil_lnd_jltv_lobby" );
                    level.var_541f214d076eb549 = obj;
                }
                
                level.var_541f214d076eb549 thread animsuite_rotation( "pingpong" );
                break;
            case 4:
                if ( !isdefined( level.var_541f214d076eb549 ) )
                {
                    obj = spawn( "script_model", ( -5910.26, -3473.5, 0 ) );
                    obj setmodel( "veh9_mil_lnd_jltv_lobby" );
                    level.var_541f214d076eb549 = obj;
                }
                
                level.var_541f214d076eb549 thread animsuite_translation( "pingpong" );
                break;
            case 5:
                if ( !isdefined( level.animatedobjs[ 0 ] ) )
                {
                    break;
                }
                
                forward = vectornormalize( anglestoforward( level.animatedobjs[ 0 ].angles ) );
                level.xcam_anchor.origin = forward * 100 + level.animatedobjs[ 0 ].origin;
                level.animatedobjs[ 0 ] thread animsuite_rotation( "continuous" );
                break;
            default:
                break;
        }
        
        setdvar( @"hash_e9197f745a6b494", 0 );
        waitframe();
    }
}

