#using scripts\common\debug;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\visibility_mode;
#using scripts\engine\utility;

#namespace animation;

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x764
// Size: 0x7e
function anim_first_frame( guys, anime, tag )
{
    assertex( isarray( guys ), "<dev string:x1c>" );
    array = get_anim_position( tag );
    org = array[ "origin" ];
    angles = array[ "angles" ];
    guys = function_1eba925251530689( guys, anime );
    array_levelthread( guys, &anim_first_frame_on_guy, anime, org, angles );
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x7ea
// Size: 0x61
function anim_generic_first_frame( guy, anime, tag )
{
    array = get_anim_position( tag );
    org = array[ "origin" ];
    angles = array[ "angles" ];
    thread anim_first_frame_on_guy( guy, anime, org, angles, "generic" );
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x853
// Size: 0x3d
function anim_generic( guy, anime, tag )
{
    guys = [];
    guys[ 0 ] = guy;
    anim_single( guys, anime, tag, 0, "generic" );
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x898
// Size: 0x41
function anim_generic_run( guy, anime, tag )
{
    guys = [];
    guys[ 0 ] = guy;
    anim_single( guys, anime, tag, 0.25, "generic" );
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x8e1
// Size: 0x40
function anim_single_solo_run( guy, anime, tag )
{
    self endon( "death" );
    newguy[ 0 ] = guy;
    anim_single( newguy, anime, tag, 0.25 );
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x929
// Size: 0x37
function anim_first_frame_solo( guy, anime, tag )
{
    guys = [];
    guys[ 0 ] = guy;
    anim_first_frame( guys, anime, tag );
}

// Namespace animation / scripts\common\anim
// Params 5
// Checksum 0x0, Offset: 0x968
// Size: 0x1fa
function anim_first_frame_on_guy( guy, anime, org, angles, animname_override )
{
    guy.first_frame_time = gettime();
    animname = undefined;
    
    if ( isdefined( animname_override ) )
    {
        animname = animname_override;
    }
    else
    {
        animname = guy.animname;
    }
    
    isloop = 0;
    
    if ( function_f1e7ee8ddeece062( anime ) )
    {
        animation = guy function_c099f6fd9c19f5a6( anime, org, angles, animname );
    }
    else if ( isarray( level.scr_anim[ animname ][ anime ] ) )
    {
        animation = level.scr_anim[ animname ][ anime ][ 0 ];
        isloop = 1;
    }
    else
    {
        animation = level.scr_anim[ animname ][ anime ];
    }
    
    /#
        guy assert_existance_of_anim( anime, animname, animation );
    #/
    
    guy set_start_pos( anime, org, angles, animname, isloop, animation );
    
    if ( isai( guy ) )
    {
        assertex( isdefined( anim.callbacks[ "<dev string:x39>" ] ), "<dev string:x4d>" );
        guy [[ anim.callbacks[ "AIAnimFirstFrame" ] ]]( animation, animname );
        return;
    }
    
    guy stopanimscripted();
    guy setanimknob( animation, 1, 0, 0 );
    
    if ( !issp() )
    {
        if ( !isplayer( guy ) && !guy isvehicle() && isdefined( level.scr_anim[ animname ] ) && isdefined( level.scr_anim[ animname ][ anime ] ) )
        {
            if ( isarray( level.scr_anim[ animname ][ anime ] ) )
            {
                guy builtin [[ level.func[ "scriptModelPlayAnim" ] ]]( level.scr_anim[ animname ][ anime ][ 0 ], undefined, 0, 0, "none" );
                return;
            }
            
            guy builtin [[ level.func[ "scriptModelPlayAnim" ] ]]( level.scr_anim[ animname ][ anime ], undefined, 0, 0, "none" );
        }
    }
}

// Namespace animation / scripts\common\anim
// Params 6
// Checksum 0x0, Offset: 0xb6a
// Size: 0xfc
function set_start_pos( anime, org, angles, animname_override, anim_array, animation )
{
    assertex( isdefined( org ) && isdefined( angles ), "<dev string:xaa>" );
    animname = undefined;
    
    if ( isdefined( animname_override ) )
    {
        animname = animname_override;
    }
    else
    {
        animname = self.animname;
    }
    
    if ( !isdefined( animation ) )
    {
        if ( function_f1e7ee8ddeece062( anime ) )
        {
            animation = function_c099f6fd9c19f5a6( anime, org, angles, animname );
        }
        else if ( isdefined( anim_array ) && anim_array )
        {
            animation = level.scr_anim[ animname ][ anime ][ 0 ];
        }
        else
        {
            animation = level.scr_anim[ animname ][ anime ];
        }
    }
    
    neworg = getstartorigin( org, angles, animation );
    newangles = getstartangles( org, angles, animation );
    self [[ anim.callbacks[ "TeleportEnt" ] ]]( neworg, newangles );
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0xc6e
// Size: 0x60
function anim_start_pos( guyarray, anime, tag )
{
    pos = get_anim_position( tag );
    org = pos[ "origin" ];
    angles = pos[ "angles" ];
    array_thread( guyarray, &set_start_pos, anime, org, angles );
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0xcd6
// Size: 0x34
function anim_start_pos_solo( guy, anime, tag )
{
    newguy[ 0 ] = guy;
    anim_start_pos( newguy, anime, tag );
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0xd12
// Size: 0xe2
function anim_last_frame_solo( guy, anime, tag )
{
    guys = [];
    guys[ 0 ] = guy;
    anim_first_frame( guys, anime, tag );
    anim_set_time( guys, anime, 1 );
    animation = guy getanim( anime );
    translation = getmovedelta( animation );
    rotation = getangledelta3d( animation );
    rotatedtranslation = rotatevector( translation, guy.angles );
    origin = guy.origin + rotatedtranslation;
    angles = combineangles( guy.angles, rotation );
    guy [[ anim.callbacks[ "TeleportEnt" ] ]]( origin, angles );
}

// Namespace animation / scripts\common\anim
// Params 5
// Checksum 0x0, Offset: 0xdfc
// Size: 0x55
function anim_single_solo( guy, anime, tag, var_9e8a16d47a03007a, animname_override )
{
    self endon( "death" );
    newguy[ 0 ] = guy;
    
    if ( !isdefined( var_9e8a16d47a03007a ) )
    {
        var_9e8a16d47a03007a = 0;
    }
    
    anim_single( newguy, anime, tag, var_9e8a16d47a03007a, animname_override );
}

// Namespace animation / scripts\common\anim
// Params 5
// Checksum 0x0, Offset: 0xe59
// Size: 0x7a3
function anim_single_internal( guys, anime, tag, var_9e8a16d47a03007a, animname_override )
{
    entity = self;
    
    /#
        thread anim_single_failsafe( guys, anime );
    #/
    
    foreach ( guy in guys )
    {
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        if ( !isdefined( guy._animactive ) )
        {
            guy._animactive = 0;
        }
        
        guy._animactive++;
    }
    
    pos = get_anim_position( tag );
    org = pos[ "origin" ];
    angles = pos[ "angles" ];
    scriptedanimationindex = undefined;
    scriptedanimationtime = 999999;
    var_7d006c3a8c8ff60a = undefined;
    var_a3d52619ed30853a = undefined;
    scriptedfaceanim = undefined;
    scriptedheadanim = undefined;
    anim_string = "single anim";
    hasxcam = 0;
    
    if ( isdefined( level.scr_xcam ) && isdefined( level.scr_xcam[ anime ] ) )
    {
        hasxcam = 1;
    }
    
    guys = function_1eba925251530689( guys, anime );
    
    foreach ( i, guy in guys )
    {
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        dofacialanim = 0;
        doheadanim = 0;
        dodialogue = 0;
        doanimation = 0;
        dotext = 0;
        dialogue = undefined;
        facialanim = undefined;
        headanim = undefined;
        animname = undefined;
        
        if ( isdefined( animname_override ) )
        {
            animname = animname_override;
        }
        else
        {
            animname = guy.animname;
        }
        
        /#
            guy assert_existance_of_anim( anime, animname );
        #/
        
        if ( !isdefined( animname ) )
        {
            continue;
        }
        
        if ( isdefined( level.scr_sound[ animname ] ) && isdefined( level.scr_sound[ animname ][ anime ] ) )
        {
            dodialogue = 1;
            dialogue = level.scr_sound[ animname ][ anime ];
        }
        
        if ( isdefined( level.scr_face[ animname ] ) && isdefined( level.scr_face[ animname ][ anime ] ) )
        {
            dofacialanim = 1;
            facialanim = level.scr_face[ animname ][ anime ];
            scriptedfaceanim = facialanim;
            
            if ( dodialogue )
            {
                if ( animhasnotetrack( facialanim, "vo_" + dialogue ) )
                {
                    dodialogue = 0;
                    dialogue = undefined;
                }
            }
        }
        
        if ( isdefined( level.scr_head[ animname ] ) && isdefined( level.scr_head[ animname ][ anime ] ) )
        {
            doheadanim = 1;
            headanim = level.scr_head[ animname ][ anime ];
            scriptedheadanim = headanim;
        }
        
        if ( isdefined( level.scr_anim[ animname ] ) && isdefined( level.scr_anim[ animname ][ anime ] ) && self [[ anim.callbacks[ "ShouldDoAnim" ] ]]() )
        {
            doanimation = 1;
        }
        
        if ( isdefined( level.scr_animsound[ animname ] ) && isdefined( level.scr_animsound[ animname ][ anime ] ) )
        {
            guy playsound( level.scr_animsound[ animname ][ anime ] );
        }
        
        /#
            if ( isdefined( level.scr_text[ animname ] ) && isdefined( level.scr_text[ animname ][ anime ] ) )
            {
                dotext = 1;
            }
        #/
        
        if ( doanimation )
        {
            scripted_node_ent = undefined;
            
            if ( function_6bc36c81fc28a22e() )
            {
                scripted_node_ent = self;
            }
            
            assertex( isdefined( guy.model ) && guy.model != "<dev string:xd0>", "<dev string:xd4>" + function_a2eaafb222316a2( guy ) + "<dev string:xf8>" + animname + "<dev string:x10c>" + anime + "<dev string:x129>" );
            guy scripts\common\visibility_mode::function_d5f76e611c78509a();
            animtime = guy [[ anim.callbacks[ "DoAnimation" ] ]]( org, angles, animname, anime, anim_string, undefined, scripted_node_ent );
            
            if ( animtime < scriptedanimationtime )
            {
                scriptedanimationtime = animtime;
                scriptedanimationindex = i;
            }
        }
        
        if ( dofacialanim || dodialogue )
        {
            if ( guy [[ anim.callbacks[ "DoFacialAnim" ] ]]( dofacialanim, dodialogue, doanimation, anime, animname, dialogue, 0 ) )
            {
                var_a3d52619ed30853a = i;
            }
            
            var_7d006c3a8c8ff60a = i;
        }
        
        if ( isai( guy ) )
        {
            assertex( !( doanimation && guy doinglongdeath() ), "<dev string:x143>" );
        }
        
        assertex( doanimation || dofacialanim || dodialogue || dotext, "<dev string:x191>" + anime + "<dev string:x1ac>" + animname + "<dev string:x1c6>" );
        
        if ( doheadanim )
        {
            guy thread play_addtive_head_anim( guy, scriptedheadanim );
        }
        
        /#
            if ( dotext && !dodialogue )
            {
                guy thread [[ anim.callbacks[ "<dev string:x1ef>" ] ]]( level.scr_text[ animname ][ anime ] );
            }
        #/
        
        if ( !issp() )
        {
            if ( !isplayer( guy ) && !isagent( guy ) && !( guy isvehicle() || isdefined( guy.isinfilelevator ) || istrue( guy.var_dfecb928163c6c6 ) ) && isdefined( level.scr_anim[ animname ] ) && isdefined( level.scr_anim[ animname ][ anime ] ) )
            {
                blendtype = function_4a2dd4b9088bd637( animname, anime );
                
                if ( isdefined( level.var_96c8e55e70edd512 ) )
                {
                    blendtype = [[ level.var_96c8e55e70edd512 ]]( animname );
                }
                
                guy self_func( "scriptModelPlayAnim", level.scr_anim[ animname ][ anime ], undefined, undefined, undefined, blendtype );
            }
        }
        
        if ( guy function_e42b762e098c8f9e() )
        {
            guy animscripted_blendin( guy.var_37b96012304143d7, guy.var_f1a075b476ca91f1, "tag_camera" );
        }
    }
    
    if ( hasxcam )
    {
        [[ anim.callbacks[ "playXcam" ] ]]( level.scr_xcam[ anime ], org, angles );
    }
    else if ( isdefined( scriptedanimationindex ) )
    {
        ent = spawnstruct();
        ent thread anim_deathnotify( guys[ scriptedanimationindex ], anime );
        ent thread anim_animationendnotify( guys[ scriptedanimationindex ], anime, scriptedanimationtime, var_9e8a16d47a03007a );
        ent waittill( anime );
    }
    else if ( isdefined( var_a3d52619ed30853a ) )
    {
        ent = spawnstruct();
        ent thread anim_deathnotify( guys[ var_a3d52619ed30853a ], anime );
        ent thread anim_facialendnotify( guys[ var_a3d52619ed30853a ], anime, scriptedfaceanim );
        ent waittill( anime );
    }
    else if ( isdefined( var_7d006c3a8c8ff60a ) )
    {
        ent = spawnstruct();
        ent thread anim_deathnotify( guys[ var_7d006c3a8c8ff60a ], anime );
        ent thread anim_dialogueendnotify( guys[ var_7d006c3a8c8ff60a ], anime );
        ent waittill( anime );
    }
    
    foreach ( guy in guys )
    {
        if ( !isdefined( guy ) || !isdefined( guy._animactive ) )
        {
            continue;
        }
        
        scripts\common\visibility_mode::function_b6e23e71bb7ad50f( guy );
        guy._animactive--;
        guy._lastanimtime = gettime();
        assert( guy._animactive >= 0 );
    }
    
    self notify( anime );
}

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x1604
// Size: 0x5f
function function_4a2dd4b9088bd637( animname, anime )
{
    blendtype = undefined;
    
    if ( isdefined( level.scr_goaltime[ animname ] ) && isdefined( level.scr_goaltime[ animname ][ anime ] ) )
    {
        if ( level.scr_goaltime[ animname ][ anime ] == 0 )
        {
            blendtype = "none";
        }
    }
    
    return blendtype;
}

// Namespace animation / scripts\common\anim
// Params 5
// Checksum 0x0, Offset: 0x166c
// Size: 0x3f
function anim_single( guys, anime, tag, var_9e8a16d47a03007a, animname_override )
{
    if ( !isdefined( var_9e8a16d47a03007a ) )
    {
        var_9e8a16d47a03007a = 0;
    }
    
    anim_single_internal( guys, anime, tag, var_9e8a16d47a03007a, animname_override );
}

// Namespace animation / scripts\common\anim
// Params 6
// Checksum 0x0, Offset: 0x16b3
// Size: 0x5f
function anim_loop_solo( guy, anime, ender, tag, var_656e3d548572faf6, animname_override )
{
    self endon( "death" );
    guy endon( "death" );
    newguy[ 0 ] = guy;
    anim_loop( newguy, anime, ender, tag, var_656e3d548572faf6, animname_override );
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x171a
// Size: 0x79
function anim_loop_solo_with_nags( guy, anime, ender, tag )
{
    self endon( "death" );
    guy endon( "death" );
    assertex( isdefined( level.scr_anim[ guy.animname ][ anime + "<dev string:x1fc>" ] ), "<dev string:x205>" + anime );
    newguy[ 0 ] = guy;
    anim_loop( newguy, anime, ender, tag );
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x179b
// Size: 0x67
function anim_generic_loop( guy, anime, ender, tag )
{
    packet = [];
    packet[ "guy" ] = guy;
    packet[ "entity" ] = self;
    packet[ "tag" ] = tag;
    guypackets[ 0 ] = packet;
    anim_loop_packet( guypackets, anime, ender, "generic" );
}

// Namespace animation / scripts\common\anim
// Params 6
// Checksum 0x0, Offset: 0x180a
// Size: 0xc7
function anim_loop( guys, anime, ender, tag, var_656e3d548572faf6, animname_override )
{
    guypackets = [];
    
    foreach ( guy in guys )
    {
        packet = [];
        packet[ "guy" ] = guy;
        packet[ "entity" ] = self;
        packet[ "tag" ] = tag;
        packet[ "origin_offset" ] = var_656e3d548572faf6;
        guypackets[ guypackets.size ] = packet;
    }
    
    anim_loop_packet( guypackets, anime, ender, animname_override );
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x18d9
// Size: 0x40
function anim_loop_packet_solo( var_6fab270f71d41318, anime, ender, animname_override )
{
    looppacket = [];
    looppacket[ 0 ] = var_6fab270f71d41318;
    anim_loop_packet( looppacket, anime, ender, animname_override );
}

// Namespace animation / scripts\common\anim
// Params 1
// Checksum 0x0, Offset: 0x1921
// Size: 0x98
function pick_nag_anim( datastruct )
{
    naganim = undefined;
    
    if ( datastruct.nag_anims.size == 1 )
    {
        naganim = 0;
    }
    else if ( datastruct.currentnagindex == datastruct.nag_anims.size - 1 )
    {
        naganim = 0;
    }
    else
    {
        naganim = datastruct.currentnagindex + 1;
    }
    
    assert( isdefined( naganim ) );
    datastruct.currentnagindex = naganim;
    datastruct.last_nag_time = gettime();
    return datastruct.currentnagindex;
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x19c2
// Size: 0x8a0
function anim_loop_packet( guypackets, anime, ender, animname_override )
{
    assertex( !isdefined( level.scr_xcam[ anime ] ), "<dev string:x231>" );
    
    foreach ( guypacket in guypackets )
    {
        guy = guypacket[ "guy" ];
        
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        if ( !isdefined( guy._animactive ) )
        {
            guy._animactive = 0;
        }
        
        guy endon( "death" );
        guy._animactive++;
    }
    
    baseguy = guypackets[ 0 ][ "guy" ];
    
    /#
        if ( !isdefined( baseguy.loops ) )
        {
            baseguy.loops = 0;
            baseguy.loopanims = [];
        }
        
        thread printloops( baseguy, anime );
    #/
    
    if ( !isdefined( ender ) )
    {
        ender = "stop_loop";
    }
    
    thread endonremoveanimactive( ender, guypackets );
    self endon( ender );
    
    /#
        thread function_1d3c30084bbec96a( baseguy, ender, anime );
    #/
    
    anim_string = "looping anim";
    base_anime = anime;
    base_animname = undefined;
    
    if ( isdefined( animname_override ) )
    {
        base_animname = animname_override;
    }
    else
    {
        base_animname = baseguy.animname;
    }
    
    idleanim = 0;
    lastidleanim = 0;
    naginterval = 0;
    hasnags = isdefined( level.scr_anim[ base_animname ][ anime + "_nags" ] );
    
    if ( hasnags && utility::issp() )
    {
        ai = 0;
        
        foreach ( i, guypacket in guypackets )
        {
            if ( isai( guypacket[ "guy" ] ) )
            {
                ai++;
            }
        }
        
        assertex( ai == 1, "<dev string:x263>" );
        
        if ( isdefined( level.scr_anim[ base_animname ][ anime + "_nags_timer" ] ) )
        {
            naginterval = level.scr_anim[ base_animname ][ anime + "_nags_timer" ];
        }
        else
        {
            naginterval = 15;
        }
    }
    
    donag = 0;
    nagdata = undefined;
    abandonloop = 0;
    
    if ( hasnags )
    {
        setdvarifuninitialized( @"hash_e35578a601bcd680", 0 );
        nagdata = spawnstruct();
        nagdata.last_nag_time = gettime();
        nagdata.nag_anims = level.scr_anim[ base_animname ][ anime + "_nags" ];
        nagdata.currentnagindex = 0;
        childthread nag_timer( naginterval, baseguy );
    }
    
    while ( true )
    {
        if ( !donag && !isagent( baseguy ) )
        {
            anime = base_anime;
            
            for ( idleanim = anim_weight( base_animname, anime ); idleanim == lastidleanim && idleanim != 0 ; idleanim = anim_weight( base_animname, anime ) )
            {
            }
        }
        else if ( !isagent( baseguy ) )
        {
            idleanim = pick_nag_anim( nagdata );
            anime = base_anime + "_nags";
            childthread nag_timer( naginterval, baseguy );
            donag = 0;
        }
        else
        {
            idleanim = anime;
        }
        
        lastidleanim = idleanim;
        scriptedanimationindex = undefined;
        scriptedanimationtime = 999999;
        var_7d006c3a8c8ff60a = undefined;
        guy = undefined;
        
        foreach ( i, guypacket in guypackets )
        {
            entity = guypacket[ "entity" ];
            guy = guypacket[ "guy" ];
            pos = entity get_anim_position( guypacket[ "tag" ] );
            org = pos[ "origin" ];
            angles = pos[ "angles" ];
            
            if ( isdefined( guypacket[ "origin_offset" ] ) )
            {
                offset = guypacket[ "origin_offset" ];
                forward = anglestoforward( angles );
                right = anglestoright( angles );
                up = anglestoup( angles );
                org += forward * offset[ 0 ];
                org += right * offset[ 1 ];
                org += up * offset[ 2 ];
            }
            
            if ( isdefined( guy.remove_from_animloop ) )
            {
                guy.remove_from_animloop = undefined;
                guypackets[ i ] = undefined;
                continue;
            }
            
            dofacialanim = 0;
            dodialogue = 0;
            doanimation = 0;
            dotext = 0;
            facialanim = undefined;
            dialogue = undefined;
            animname = undefined;
            
            if ( isdefined( animname_override ) )
            {
                animname = animname_override;
            }
            else
            {
                animname = guy.animname;
            }
            
            if ( isdefined( level.scr_face[ animname ] ) && isdefined( level.scr_face[ animname ][ anime ] ) && isdefined( level.scr_face[ animname ][ anime ][ idleanim ] ) )
            {
                dofacialanim = 1;
                facialanim = level.scr_face[ animname ][ anime ][ idleanim ];
            }
            
            if ( isdefined( level.scr_sound[ animname ] ) && isdefined( level.scr_sound[ animname ][ anime ] ) && isdefined( level.scr_sound[ animname ][ anime ][ idleanim ] ) )
            {
                dodialogue = 1;
                dialogue = level.scr_sound[ animname ][ anime ][ idleanim ];
            }
            
            if ( isdefined( level.scr_animsound[ animname ] ) && isdefined( level.scr_animsound[ animname ][ idleanim + anime ] ) )
            {
                guy playsound( level.scr_animsound[ animname ][ idleanim + anime ] );
            }
            
            if ( isdefined( level.scr_anim[ animname ] ) && isdefined( level.scr_anim[ animname ][ anime ] ) && self [[ anim.callbacks[ "ShouldDoAnim" ] ]]() )
            {
                doanimation = 1;
            }
            else if ( isagent( guy ) && self [[ anim.callbacks[ "ShouldDoAnim" ] ]]() )
            {
                doanimation = 1;
            }
            
            /#
                if ( isdefined( level.scr_text[ animname ] ) && isdefined( level.scr_text[ animname ][ anime ] ) )
                {
                    dotext = 1;
                }
                
                if ( !dofacialanim && !dodialogue && !doanimation && !dotext )
                {
                    assertmsg( "<dev string:x29c>" + guy getentitynumber() + "<dev string:x2ab>" + anime + "<dev string:x2cc>" );
                    abandonloop = 1;
                    break;
                }
            #/
            
            if ( doanimation )
            {
                guy scripts\common\visibility_mode::function_d5f76e611c78509a();
                animtime = guy [[ anim.callbacks[ "DoAnimation" ] ]]( org, angles, animname, anime, anim_string, idleanim, undefined );
                
                if ( animtime < scriptedanimationtime )
                {
                    scriptedanimationtime = animtime;
                    scriptedanimationindex = i;
                }
            }
            
            if ( !issp() )
            {
                if ( !isplayer( guy ) && !isagent( guy ) && !guy isvehicle() && !isdefined( guy.vehiclename ) && isdefined( level.scr_anim[ animname ] ) && isdefined( level.scr_anim[ animname ][ anime ] ) && isdefined( level.scr_anim[ animname ][ anime ][ idleanim ] ) )
                {
                    guy self_func( "scriptModelPlayAnim", level.scr_anim[ animname ][ anime ][ idleanim ], undefined, undefined, undefined, function_4a2dd4b9088bd637( animname, anime ) );
                }
            }
            
            if ( dofacialanim || dodialogue )
            {
                guy [[ anim.callbacks[ "DoFacialAnim" ] ]]( dofacialanim, dodialogue, doanimation, anime, animname, dialogue, 1 );
                var_7d006c3a8c8ff60a = i;
            }
            
            /#
                if ( dotext && !dodialogue )
                {
                    guy thread [[ anim.callbacks[ "<dev string:x1ef>" ] ]]( level.scr_text[ animname ][ anime ] );
                }
            #/
        }
        
        if ( !isdefined( guy ) )
        {
            break;
        }
        
        if ( isdefined( scriptedanimationindex ) )
        {
            finishedanim = waittill_animend( guypackets[ scriptedanimationindex ][ "guy" ], anim_string, hasnags );
            
            if ( !isdefined( finishedanim ) && hasnags )
            {
                donag = 1;
                
                if ( isdefined( anim.callbacks[ "StopAnimscripted" ] ) )
                {
                    guy [[ anim.callbacks[ "StopAnimscripted" ] ]]();
                }
            }
        }
        else if ( isdefined( var_7d006c3a8c8ff60a ) )
        {
            guypackets[ var_7d006c3a8c8ff60a ][ "guy" ] waittill( anim_string );
        }
        
        if ( abandonloop )
        {
            break;
        }
    }
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x226a
// Size: 0x34, Type: bool
function waittill_animend( guy, animstring, hasnags )
{
    if ( istrue( hasnags ) )
    {
        self endon( "do_nag" );
    }
    
    guy waittillmatch( animstring, "end" );
    return true;
}

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x22a7
// Size: 0xa7
function nag_timer( timer, guy )
{
    self endon( "death" );
    temp = timer;
    currenttime = gettime();
    
    while ( currenttime + timer * 1000 > gettime() )
    {
        /#
            if ( getdvarint( @"hash_e35578a601bcd680" ) )
            {
                print3d( guy.origin + ( 0, 0, 70 ), temp + "<dev string:x2e3>", ( 1, 1, 0.5 ), 1, 0.6, 20 );
                temp--;
            }
        #/
        
        wait 1;
    }
    
    self notify( "do_nag" );
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x2356
// Size: 0x3b
function anim_set_time_solo( guy, anime, time )
{
    self endon( "death" );
    newguy[ 0 ] = guy;
    anim_set_time( newguy, anime, time );
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x2399
// Size: 0x2a
function anim_set_time( guys, anime, time )
{
    array_thread( guys, &anim_self_set_time, anime, time );
}

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x23cb
// Size: 0x3d
function anim_self_set_time( anime, time )
{
    animation = getanim( anime );
    
    if ( isarray( animation ) )
    {
        animation = animation[ 0 ];
    }
    
    self setanimtime( animation, time );
}

// Namespace animation / scripts\common\anim
// Params 0
// Checksum 0x0, Offset: 0x2410
// Size: 0x54
function last_anim_time_check()
{
    if ( !isdefined( self.last_anim_time ) )
    {
        self.last_anim_time = gettime();
        return;
    }
    
    time = gettime();
    
    if ( self.last_anim_time == time )
    {
        self endon( "death" );
        wait 0.05;
    }
    
    self.last_anim_time = time;
}

// Namespace animation / scripts\common\anim
// Params 6
// Checksum 0x0, Offset: 0x246c
// Size: 0x136
function anim_moveto( guys, anime, tag, time, acceleration_time, deceleration_time )
{
    pos = get_anim_position( tag );
    org = pos[ "origin" ];
    angles = pos[ "angles" ];
    
    foreach ( guy in guys )
    {
        startorg = getstartorigin( org, angles, level.scr_anim[ guy.animname ][ anime ] );
        startang = getstartangles( org, angles, level.scr_anim[ guy.animname ][ anime ] );
        
        if ( isai( guy ) )
        {
            assertmsg( "<dev string:x2f6>" );
            continue;
        }
        
        guy moveto( startorg, time, acceleration_time, deceleration_time );
        guy rotateto( startang, time, acceleration_time, deceleration_time );
    }
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x25aa
// Size: 0x3b
function anim_teleport_solo( guy, anime, tag )
{
    self endon( "death" );
    newguy[ 0 ] = guy;
    anim_teleport( newguy, anime, tag );
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x25ed
// Size: 0xfd
function anim_teleport( guys, anime, tag )
{
    pos = get_anim_position( tag );
    org = pos[ "origin" ];
    angles = pos[ "angles" ];
    
    foreach ( guy in guys )
    {
        startorg = getstartorigin( org, angles, level.scr_anim[ guy.animname ][ anime ] );
        startang = getstartangles( org, angles, level.scr_anim[ guy.animname ][ anime ] );
        guy [[ anim.callbacks[ "TeleportEnt" ] ]]( startorg, startang );
    }
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x26f2
// Size: 0xac
function anim_generic_teleport( guy, anime, tag )
{
    pos = get_anim_position( tag );
    org = pos[ "origin" ];
    angles = pos[ "angles" ];
    startorg = getstartorigin( org, angles, level.scr_anim[ "generic" ][ anime ] );
    startang = getstartangles( org, angles, level.scr_anim[ "generic" ][ anime ] );
    guy [[ anim.callbacks[ "TeleportEnt" ] ]]( startorg, startang );
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x27a6
// Size: 0x29
function anim_spawn_generic_model( model, anime, tag )
{
    return anim_spawn_model( model, "generic", anime, tag );
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x27d8
// Size: 0xc5
function anim_spawn_model( model, animname, anime, tag )
{
    pos = get_anim_position( tag );
    org = pos[ "origin" ];
    angles = pos[ "angles" ];
    startorg = getstartorigin( org, angles, level.scr_anim[ animname ][ anime ] );
    startangles = getstartorigin( org, angles, level.scr_anim[ animname ][ anime ] );
    spawned = spawn( "script_model", startorg );
    spawned setmodel( model );
    spawned.angles = startangles;
    return spawned;
}

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x28a6
// Size: 0x1c
function anim_spawn_tag_model( model, tag )
{
    self attach( model, tag );
}

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x28ca
// Size: 0x67
function anim_link_tag_model( model, tag )
{
    org = self gettagorigin( tag );
    spawned = spawn( "script_model", org );
    spawned setmodel( model );
    spawned linkto( self, tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    return spawned;
}

// Namespace animation / scripts\common\anim
// Params 5
// Checksum 0x0, Offset: 0x293a
// Size: 0xea
function removenotetrack( animname, notetrack, anime, notetype, ent )
{
    notetrack = tolower( notetrack );
    array = level.scr_notetrack[ animname ][ anime ][ notetrack ];
    anime = get_generic_anime( anime );
    index = -1;
    
    if ( !isdefined( array ) || !isarray( array ) || array.size < 1 )
    {
        return;
    }
    
    for ( i = 0; i < array.size ; i++ )
    {
        if ( isdefined( array[ i ][ notetype ] ) )
        {
            if ( !isdefined( ent ) || array[ i ][ notetype ] == ent )
            {
                index = i;
                break;
            }
        }
    }
    
    if ( index < 0 )
    {
        return;
    }
    
    if ( array.size == 1 )
    {
        array = [];
    }
    else
    {
        array = array_remove_index( array, index );
    }
    
    level.scr_notetrack[ animname ][ anime ][ notetrack ] = array;
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x2a2c
// Size: 0x9f
function addnotetrack_flag( animname, notetrack, theflag, anime )
{
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    array = [];
    array[ "flag" ] = theflag;
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = array;
    
    if ( utility::issp() )
    {
        if ( !isdefined( level.flag ) || !isdefined( level.flag[ theflag ] ) )
        {
            flag_init( theflag );
        }
    }
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x2ad3
// Size: 0x96
function addnotetrack_flag_clear( animname, notetrack, theflag, anime )
{
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    array = [];
    array[ "flag_clear" ] = theflag;
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = array;
    
    if ( !isdefined( level.flag ) || !isdefined( level.flag[ theflag ] ) )
    {
        flag_init( theflag );
    }
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x2b71
// Size: 0x75
function addnotetrack_dialogue( animname, notetrack, anime, soundalias )
{
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = [];
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ][ "dialog" ] = soundalias;
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x2bee
// Size: 0x3d
function add_notetrack_and_get_index( animname, notetrack, anime )
{
    notetrack = tolower( notetrack );
    add_notetrack_array( animname, notetrack, anime );
    return level.scr_notetrack[ animname ][ anime ][ notetrack ].size;
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x2c34
// Size: 0x9a
function add_notetrack_array( animname, notetrack, anime )
{
    notetrack = tolower( notetrack );
    
    if ( !isdefined( level.scr_notetrack ) )
    {
        level.scr_notetrack = [];
    }
    
    if ( !isdefined( level.scr_notetrack[ animname ] ) )
    {
        level.scr_notetrack[ animname ] = [];
    }
    
    if ( !isdefined( level.scr_notetrack[ animname ][ anime ] ) )
    {
        level.scr_notetrack[ animname ][ anime ] = [];
    }
    
    if ( !isdefined( level.scr_notetrack[ animname ][ anime ][ notetrack ] ) )
    {
        level.scr_notetrack[ animname ][ anime ][ notetrack ] = [];
    }
}

// Namespace animation / scripts\common\anim
// Params 6
// Checksum 0x0, Offset: 0x2cd6
// Size: 0xc7
function addnotetrack_sound( animname, notetrack, anime, soundalias, sound_stays_death, tag )
{
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = [];
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ][ "sound" ] = soundalias;
    
    if ( isdefined( sound_stays_death ) )
    {
        level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ][ "sound_stays_death" ] = 1;
    }
    
    if ( isdefined( tag ) )
    {
        level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ][ "sound_on_tag" ] = tag;
    }
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x2da5
// Size: 0x56
function note_track_start_sound( notetrack, soundalias, sound_stays_death, tag )
{
    scenedata = get_datascene();
    addnotetrack_sound( scenedata.animname, notetrack, scenedata.anim_sequence, soundalias, sound_stays_death, tag );
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x2e03
// Size: 0x75
function addnotetrack_playersound( animname, notetrack, anime, soundalias )
{
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = [];
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ][ "playersound" ] = soundalias;
}

// Namespace animation / scripts\common\anim
// Params 1
// Checksum 0x0, Offset: 0x2e80
// Size: 0x17
function get_generic_anime( anime )
{
    if ( !isdefined( anime ) )
    {
        return "any";
    }
    
    return anime;
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x2ea0
// Size: 0x46
function addonstart_animsound( animname, anime, soundalias )
{
    if ( !isdefined( level.scr_animsound[ animname ] ) )
    {
        level.scr_animsound[ animname ] = [];
    }
    
    level.scr_animsound[ animname ][ anime ] = soundalias;
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x2eee
// Size: 0x75
function addnotetrack_playerdialogue( animname, notetrack, anime, soundalias )
{
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = [];
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ][ "playerdialogue" ] = soundalias;
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x2f6b
// Size: 0x7a
function addnotetrack_animsound( animname, anime, notetrack, soundalias )
{
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    array = [];
    array[ "sound" ] = soundalias;
    array[ "created_by_animSound" ] = 1;
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = array;
}

// Namespace animation / scripts\common\anim
// Params 5
// Checksum 0x0, Offset: 0x2fed
// Size: 0x83
function addnotetrack_attach( animname, notetrack, model, tag, anime )
{
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    array = [];
    array[ "attach model" ] = model;
    array[ "selftag" ] = tag;
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = array;
}

// Namespace animation / scripts\common\anim
// Params 5
// Checksum 0x0, Offset: 0x3078
// Size: 0x83
function addnotetrack_detach( animname, notetrack, model, tag, anime )
{
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    array = [];
    array[ "detach model" ] = model;
    array[ "selftag" ] = tag;
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = array;
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x3103
// Size: 0x8c
function addnotetrack_detach_gun( animname, notetrack, anime, suspend )
{
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    array = [];
    array[ "detach gun" ] = 1;
    array[ "tag" ] = "tag_weapon_right";
    
    if ( isdefined( suspend ) )
    {
        array[ "suspend" ] = suspend;
    }
    
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = array;
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x3197
// Size: 0x85
function addnotetrack_attach_gun( animname, notetrack, anime, weapplacement )
{
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    array = [];
    
    if ( isdefined( weapplacement ) )
    {
        array[ "attach gun " + weapplacement ] = 1;
    }
    else
    {
        array[ "attach gun right" ] = 1;
    }
    
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = array;
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x3224
// Size: 0x70
function addnotetrack_customfunction( animname, notetrack, function, anime )
{
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    array = [];
    array[ "function" ] = function;
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = array;
}

// Namespace animation / scripts\common\anim
// Params 6
// Checksum 0x0, Offset: 0x329c
// Size: 0xa4
function addnotetrack_startfxontag( animname, notetrack, anime, effect_name, tagname, morethanthreehack )
{
    getfx( effect_name );
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    array = [];
    array[ "effect" ] = effect_name;
    array[ "selftag" ] = tagname;
    
    if ( isdefined( morethanthreehack ) )
    {
        array[ "moreThanThreeHack" ] = morethanthreehack;
    }
    
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = array;
}

// Namespace animation / scripts\common\anim
// Params 5
// Checksum 0x0, Offset: 0x3348
// Size: 0x8b
function addnotetrack_stopfxontag( animname, notetrack, anime, effect_name, tagname )
{
    getfx( effect_name );
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    array = [];
    array[ "stop_effect" ] = effect_name;
    array[ "selftag" ] = tagname;
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = array;
}

// Namespace animation / scripts\common\anim
// Params 5
// Checksum 0x0, Offset: 0x33db
// Size: 0x83
function addnotetrack_mayhemstart( animname, notetrack, animation, anime, usehatmodel )
{
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    array = [];
    array[ "mayhem_start" ] = animation;
    array[ "use_hat_model" ] = usehatmodel;
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = array;
}

// Namespace animation / scripts\common\anim
// Params 5
// Checksum 0x0, Offset: 0x3466
// Size: 0x83
function addnotetrack_mayhemend( animname, notetrack, animation, anime, usehatmodel )
{
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    array = [];
    array[ "mayhem_end" ] = animation;
    array[ "use_hat_model" ] = usehatmodel;
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = array;
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x34f1
// Size: 0x56
function note_track_swap_to_efx( notetrack, effect_path, tagname )
{
    scenedata = get_datascene();
    add_fx( effect_path, effect_path );
    addnotetrack_swapparttoefx( scenedata.animname, notetrack, scenedata.animsequence, effect_path, tagname );
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x354f
// Size: 0x56
function note_track_stop_efx_on_tag( notetrack, effect_path, tagname )
{
    scenedata = get_datascene();
    add_fx( effect_path, effect_path );
    addnotetrack_stopfxontag( scenedata.animname, notetrack, scenedata.animsequence, effect_path, tagname );
}

// Namespace animation / scripts\common\anim
// Params 5
// Checksum 0x0, Offset: 0x35ad
// Size: 0x8b
function addnotetrack_swapparttoefx( animname, notetrack, anime, effect_name, tagname )
{
    getfx( effect_name );
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    array = [];
    array[ "swap_part_to_efx" ] = effect_name;
    array[ "selftag" ] = tagname;
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = array;
}

// Namespace animation / scripts\common\anim
// Params 6
// Checksum 0x0, Offset: 0x3640
// Size: 0xcc
function note_track_trace_to_efx( notetrack, canceltrack, tagname, effect_path, waterfx_path, delete_depth )
{
    scenedata = get_datascene();
    
    if ( notetrack != "start" && !animhasnotetrack( scenedata getanim( scenedata.anim_sequence ), notetrack ) )
    {
        println( "<dev string:x319>" + scenedata.anim_sequence + "<dev string:x338>" + notetrack );
        return;
    }
    
    add_fx( effect_path, effect_path );
    
    if ( isdefined( waterfx_path ) )
    {
        add_fx( waterfx_path, waterfx_path );
    }
    
    addnotetrack_tracepartforefx( scenedata.animname, notetrack, canceltrack, scenedata.anim_sequence, tagname, effect_path, waterfx_path, delete_depth );
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x3714
// Size: 0xa1
function note_track_start_fx_on_tag( notetrack, tagname, effect_path )
{
    scenedata = get_datascene();
    
    if ( notetrack != "start" && !animhasnotetrack( scenedata getanim( scenedata.anim_sequence ), notetrack ) )
    {
        println( "<dev string:x356>" + scenedata.anim_sequence + "<dev string:x338>" + notetrack );
        return;
    }
    
    add_fx( effect_path, effect_path );
    addnotetrack_startfxontag( scenedata.animname, notetrack, scenedata.anim_sequence, effect_path, tagname, 1 );
}

// Namespace animation / scripts\common\anim
// Params 0
// Checksum 0x0, Offset: 0x37bd
// Size: 0x45
function get_datascene()
{
    assertex( isdefined( level.current_anim_data_scene ) );
    scenedata = level.current_anim_data_scene;
    assertex( isdefined( scenedata.animtree ), "<dev string:x36f>" );
    return scenedata;
}

// Namespace animation / scripts\common\anim
// Params 8
// Checksum 0x0, Offset: 0x380b
// Size: 0x105
function addnotetrack_tracepartforefx( animname, notetrack, canceltrack, anime, tagname, effect_name, waterfx_name, delete_depth )
{
    getfx( effect_name );
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    array = [];
    array[ "trace_part_for_efx" ] = effect_name;
    array[ "trace_part_for_efx_water" ] = waterfx_name;
    array[ "trace_part_for_efx_cancel" ] = canceltrack;
    array[ "trace_part_for_efx_delete_depth" ] = delete_depth;
    array[ "selftag" ] = tagname;
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = array;
    
    if ( isdefined( canceltrack ) )
    {
        array = [];
        array[ "trace_part_for_efx_canceling" ] = canceltrack;
        array[ "selftag" ] = tagname;
        index = add_notetrack_and_get_index( animname, canceltrack, anime );
        level.scr_notetrack[ animname ][ anime ][ canceltrack ][ index ] = array;
    }
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x3918
// Size: 0x70
function addnotetrack_notify( animname, notetrack, thenotify, anime )
{
    notetrack = tolower( notetrack );
    anime = get_generic_anime( anime );
    index = add_notetrack_and_get_index( animname, notetrack, anime );
    array = [];
    array[ "notify" ] = thenotify;
    level.scr_notetrack[ animname ][ anime ][ notetrack ][ index ] = array;
}

// Namespace animation / scripts\common\anim
// Params 0
// Checksum 0x0, Offset: 0x3990
// Size: 0x28
function setanimtree()
{
    id = self useanimtree( level.scr_animtree[ self.animname ] );
    return id;
}

// Namespace animation / scripts\common\anim
// Params 0
// Checksum 0x0, Offset: 0x39c1
// Size: 0x1b7
function initanim()
{
    if ( !isdefined( level.scr_notetrack ) )
    {
        level.scr_notetrack = [];
    }
    
    if ( !isdefined( level.scr_face ) )
    {
        level.scr_face = [];
    }
    
    if ( !isdefined( level.scr_head ) )
    {
        level.scr_head = [];
    }
    
    if ( !isdefined( level.scr_look ) )
    {
        level.scr_look = [];
    }
    
    if ( !isdefined( level.scr_animsound ) )
    {
        level.scr_animsound = [];
    }
    
    if ( !isdefined( level.scr_sound ) )
    {
        level.scr_sound = [];
    }
    
    if ( !isdefined( level.scr_radio ) )
    {
        level.scr_radio = [];
    }
    
    if ( !isdefined( level.scr_text ) )
    {
        level.scr_text = [];
    }
    
    if ( !isdefined( level.scr_anim ) )
    {
        level.scr_anim[ 0 ][ 0 ] = 0;
    }
    
    if ( !isdefined( level.scr_animlength ) )
    {
        level.scr_animlength[ 0 ][ 0 ] = 0;
    }
    
    if ( !isdefined( level.scr_radio ) )
    {
        level.scr_radio = [];
    }
    
    if ( !isdefined( level.scr_plrdialogue ) )
    {
        level.scr_plrdialogue = [];
    }
    
    if ( !isdefined( level.scr_goaltime ) )
    {
        level.scr_goaltime = [];
    }
    
    if ( !isdefined( level._notetrackfx ) )
    {
        level._notetrackfx = [];
    }
    
    if ( !isdefined( level.scr_xcam ) )
    {
        level.scr_xcam = [];
    }
    
    thread precache_script_models_thread();
    thread precache_weapon_models_thread();
    create_lock( "moreThanThreeHack", 3 );
    create_lock( "trace_part_for_efx", 12 );
    
    /#
        setdevdvarifuninitialized( @"hash_b46df2b57cc019b", 0 );
    #/
    
    init_animsounds();
    
    /#
        level thread function_65e9f4b64110bb5c();
    #/
}

// Namespace animation / scripts\common\anim
// Params 0
// Checksum 0x0, Offset: 0x3b80
// Size: 0xa7
function precache_script_models_thread()
{
    waittillframeend();
    
    if ( !isdefined( level.scr_model ) )
    {
        return;
    }
    
    models = getarraykeys( level.scr_model );
    
    for ( i = 0; i < models.size ; i++ )
    {
        if ( isarray( level.scr_model[ models[ i ] ] ) )
        {
            for ( modelindex = 0; modelindex < level.scr_model[ models[ i ] ].size ; modelindex++ )
            {
                precachemodel( level.scr_model[ models[ i ] ][ modelindex ] );
            }
            
            continue;
        }
        
        precachemodel( level.scr_model[ models[ i ] ] );
    }
}

// Namespace animation / scripts\common\anim
// Params 0
// Checksum 0x0, Offset: 0x3c2f
// Size: 0xd6
function precache_weapon_models_thread()
{
    waittillframeend();
    
    if ( !isdefined( level.scr_weapon ) )
    {
        return;
    }
    
    weapons = getarraykeys( level.scr_weapon );
    
    for ( i = 0; i < weapons.size ; i++ )
    {
        assertex( isarray( level.scr_weapon[ weapons[ i ] ] ), weapons[ i ] + "<dev string:x3a7>" );
        attachments = [];
        
        if ( isdefined( level.scr_weapon[ weapons[ i ] ][ 1 ] ) )
        {
            assertex( isarray( level.scr_weapon[ weapons[ i ] ][ 1 ] ), "<dev string:x3d8>" );
            attachments = level.scr_weapon[ weapons[ i ] ][ 1 ];
        }
        
        utility::make_weapon_model( level.scr_weapon[ weapons[ i ] ][ 0 ], attachments, 1, 1 );
    }
}

// Namespace animation / scripts\common\anim
// Params 0
// Checksum 0x0, Offset: 0x3d0d
// Size: 0x7c
function init_animsounds()
{
    level.animsounds = [];
    level.animsound_aliases = [];
    animnames = getarraykeys( level.scr_notetrack );
    
    for ( i = 0; i < animnames.size ; i++ )
    {
        init_notetracks_for_animname( animnames[ i ] );
    }
    
    animnames = getarraykeys( level.scr_animsound );
    
    for ( i = 0; i < animnames.size ; i++ )
    {
        init_animsounds_for_animname( animnames[ i ] );
    }
}

// Namespace animation / scripts\common\anim
// Params 1
// Checksum 0x0, Offset: 0x3d91
// Size: 0x9e
function init_animsounds_for_animname( animname )
{
    animes = getarraykeys( level.scr_animsound[ animname ] );
    
    for ( i = 0; i < animes.size ; i++ )
    {
        anime = animes[ i ];
        soundalias = level.scr_animsound[ animname ][ anime ];
        level.animsound_aliases[ animname ][ anime ][ "#" + anime ][ "soundalias" ] = soundalias;
        level.animsound_aliases[ animname ][ anime ][ "#" + anime ][ "created_by_animSound" ] = 1;
    }
}

// Namespace animation / scripts\common\anim
// Params 1
// Checksum 0x0, Offset: 0x3e37
// Size: 0x138
function init_notetracks_for_animname( animname )
{
    foreach ( anime, anime_array in level.scr_notetrack[ animname ] )
    {
        foreach ( notetrack, notetrack_array in anime_array )
        {
            foreach ( scr_notetrack in notetrack_array )
            {
                soundalias = scr_notetrack[ "sound" ];
                
                if ( !isdefined( soundalias ) )
                {
                    continue;
                }
                
                level.animsound_aliases[ animname ][ anime ][ notetrack ][ "soundalias" ] = soundalias;
                
                if ( isdefined( scr_notetrack[ "created_by_animSound" ] ) )
                {
                    level.animsound_aliases[ animname ][ anime ][ notetrack ][ "created_by_animSound" ] = 1;
                }
            }
        }
    }
}

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x3f77
// Size: 0xaf
function endonremoveanimactive( endonstring, guypackets )
{
    self waittill( endonstring );
    
    foreach ( guypacket in guypackets )
    {
        guy = guypacket[ "guy" ];
        
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        scripts\common\visibility_mode::function_b6e23e71bb7ad50f( guy );
        guy._animactive--;
        guy._lastanimtime = gettime();
        assert( guy._animactive >= 0 );
    }
}

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x402e
// Size: 0x41
function anim_deathnotify( guy, anime )
{
    self endon( anime );
    guy waittill( "death" );
    
    if ( isdefined( guy.anim_is_death ) && guy.anim_is_death )
    {
        return;
    }
    
    self notify( anime );
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x4077
// Size: 0x36
function anim_facialendnotify( guy, anime, scriptedfaceanim )
{
    self endon( anime );
    time = getanimlength( scriptedfaceanim );
    wait time;
    self notify( anime );
}

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x40b5
// Size: 0x22
function anim_dialogueendnotify( guy, anime )
{
    self endon( anime );
    guy waittill( "single dialogue" );
    self notify( anime );
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x40df
// Size: 0x6f
function anim_animationendnotify( guy, anime, scriptedanimationtime, var_9e8a16d47a03007a )
{
    self endon( anime );
    guy endon( "death" );
    scriptedanimationtime -= var_9e8a16d47a03007a;
    
    if ( var_9e8a16d47a03007a > 0 && scriptedanimationtime > 0 )
    {
        guy waittill_match_or_timeout( "single anim", "end", scriptedanimationtime );
        guy stopanimscripted();
    }
    else
    {
        guy waittillmatch( "single anim", "end" );
    }
    
    self notify( anime );
}

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x4156
// Size: 0xb6
function anim_weight( animname, anime )
{
    assertex( isdefined( level.scr_anim[ animname ][ anime ] ), "<dev string:x412>" + anime + "<dev string:x433>" + animname );
    assertex( isarray( level.scr_anim[ animname ][ anime ] ), "<dev string:x446>" + animname + "<dev string:x472>" + anime + "<dev string:x47a>" );
    total_anims = level.scr_anim[ animname ][ anime ].size;
    idleanim = randomint( total_anims );
    
    if ( isdefined( level.scr_anim[ animname ][ anime + "weight" ] ) )
    {
        idleanim = get_weighted_anim( animname, anime, total_anims );
    }
    
    return idleanim;
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x4215
// Size: 0xfe
function get_weighted_anim( animname, anime, total_anims )
{
    idleanim = undefined;
    
    if ( total_anims > 1 )
    {
        weights = 0;
        anim_weight = 0;
        
        for ( i = 0; i < total_anims ; i++ )
        {
            if ( isdefined( level.scr_anim[ animname ][ anime + "weight" ] ) )
            {
                if ( isdefined( level.scr_anim[ animname ][ anime + "weight" ][ i ] ) )
                {
                    weights++;
                    anim_weight += level.scr_anim[ animname ][ anime + "weight" ][ i ];
                }
            }
        }
        
        if ( weights == total_anims )
        {
            anim_play = randomfloat( anim_weight );
            anim_weight = 0;
            
            for ( i = 0; i < total_anims ; i++ )
            {
                anim_weight += level.scr_anim[ animname ][ anime + "weight" ][ i ];
                
                if ( anim_play < anim_weight )
                {
                    idleanim = i;
                    break;
                }
            }
        }
    }
    
    return idleanim;
}

#using_animtree( "generic_human" );

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x431c
// Size: 0x68
function play_addtive_head_anim( guy, animation )
{
    guy setanimlimited( %addtive_head_anims, 1, 0.2 );
    guy setanimlimited( animation, 1, 0.2 );
    wait getanimlength( animation );
    guy clearanim( %addtive_head_anims, 0.2 );
    guy clearanim( animation, 0.2 );
}

// Namespace animation / scripts\common\anim
// Params 1
// Checksum 0x0, Offset: 0x438c
// Size: 0x85
function get_anim_position( tag )
{
    org = undefined;
    angles = undefined;
    
    if ( isdefined( tag ) )
    {
        org = self gettagorigin( tag );
        angles = self gettagangles( tag );
    }
    else
    {
        org = self.origin;
        angles = self.angles;
        
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
    }
    
    array = [];
    array[ "angles" ] = angles;
    array[ "origin" ] = org;
    return array;
}

// Namespace animation / scripts\common\anim
// Params 5
// Checksum 0x0, Offset: 0x441a
// Size: 0x71
function function_d2e8597ff01310ed( xanim, tag, time, baseorigin, baseangles )
{
    result = self function_bbf5cb43caa911b7( xanim, tag, time );
    
    if ( isdefined( result ) )
    {
        result[ "origin" ] = coordtransform( result[ "origin" ], baseorigin, baseangles );
        result[ "angles" ] = combineangles( baseangles, result[ "angles" ] );
    }
    
    return result;
}

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x4494
// Size: 0x33
function anim_at_self( entity, tag )
{
    packet = [];
    packet[ "guy" ] = self;
    packet[ "entity" ] = self;
    return packet;
}

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x44d0
// Size: 0x3c
function anim_at_entity( entity, tag )
{
    packet = [];
    packet[ "guy" ] = self;
    packet[ "entity" ] = entity;
    packet[ "tag" ] = tag;
    return packet;
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x4515
// Size: 0x337
function assert_existance_of_anim( anime, animname, animation )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isagent( self ) )
    {
        return;
    }
    
    if ( !isdefined( animname ) )
    {
        animname = self.animname;
    }
    
    if ( !isdefined( animname ) )
    {
        assertmsg( "<dev string:x4c3>" + self.classname + "<dev string:x4e3>" );
        return;
    }
    
    has_anim = 0;
    
    if ( isdefined( level.scr_anim[ animname ] ) )
    {
        has_anim = 1;
        
        if ( isdefined( level.scr_anim[ animname ][ anime ] ) )
        {
            return;
        }
    }
    
    has_face = 0;
    
    if ( isdefined( level.scr_face[ animname ] ) )
    {
        has_face = 1;
        
        if ( isdefined( level.scr_face[ animname ][ anime ] ) )
        {
            return;
        }
    }
    
    has_sound = 0;
    
    if ( isdefined( level.scr_sound[ animname ] ) )
    {
        has_sound = 1;
        
        if ( isdefined( level.scr_sound[ animname ][ anime ] ) )
        {
            return;
        }
    }
    
    if ( has_anim || has_sound || has_face )
    {
        if ( has_anim )
        {
            array = getarraykeys( level.scr_anim[ animname ] );
            
            /#
                println( "<dev string:x4f8>" + animname + "<dev string:x513>" );
                
                foreach ( member in array )
                {
                    println( member );
                }
            #/
        }
        
        if ( has_sound )
        {
            array = getarraykeys( level.scr_sound[ animname ] );
            
            /#
                println( "<dev string:x518>" + animname + "<dev string:x513>" );
                
                foreach ( member in array )
                {
                    println( member );
                }
            #/
        }
        
        if ( has_face )
        {
            array = getarraykeys( level.scr_face[ animname ] );
            
            /#
                println( "<dev string:x537>" + animname + "<dev string:x513>" );
                
                foreach ( member in array )
                {
                    println( member );
                }
            #/
        }
        
        assertmsg( "<dev string:x555>" + function_a2eaafb222316a2( self ) + "<dev string:xf8>" + animname + "<dev string:x10c>" + anime + "<dev string:x55b>" );
        return;
    }
    
    keys = getarraykeys( level.scr_anim );
    keys = array_combine( keys, getarraykeys( level.scr_sound ) );
    
    foreach ( key in keys )
    {
        println( key );
    }
    
    assertmsg( "<dev string:x59e>" + animname + "<dev string:x5ab>" );
}

/#

    // Namespace animation / scripts\common\anim
    // Params 2
    // Checksum 0x0, Offset: 0x4854
    // Size: 0xe5, Type: dev
    function printloops( guy, anime )
    {
        if ( !isdefined( guy ) )
        {
            return;
        }
        
        guy endon( "<dev string:x5f5>" );
        waittillframeend();
        guy.loops++;
        
        if ( guy.loops > 0 )
        {
            guy.loopanims[ guy.loopanims.size ] = anime;
        }
        
        if ( guy.loops > 1 )
        {
            println( "<dev string:x5fe>" + guy.animname + "<dev string:x612>" + guy.loops + "<dev string:x61b>" );
            
            for ( i = 0; i < guy.loopanims.size ; i++ )
            {
                println( "<dev string:x63b>" + guy.loopanims[ i ] );
            }
            
            assertmsg( "<dev string:x647>" );
        }
    }

    // Namespace animation / scripts\common\anim
    // Params 3
    // Checksum 0x0, Offset: 0x4941
    // Size: 0x53, Type: dev
    function function_1d3c30084bbec96a( guy, ender, anime )
    {
        guy endon( "<dev string:x5f5>" );
        self waittill( ender );
        guy.loopanims = array_remove( guy.loopanims, anime );
        guy.loops--;
    }

#/

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x499c
// Size: 0x94
function anim_single_failsafeonguy( owner, anime )
{
    /#
        if ( getdvar( @"hash_27494f1d75fc0809" ) != "<dev string:x68a>" )
        {
            return;
        }
        
        owner endon( anime );
        owner endon( "<dev string:x5f5>" );
        self endon( "<dev string:x5f5>" );
        name = self.classname;
        num = self getentitynumber();
        wait 60;
        println( "<dev string:x690>" + name + "<dev string:x6a8>" + num );
        waittillframeend();
        assertex( 0, "<dev string:x6b8>" + anime + "<dev string:x6c7>" );
    #/
}

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x4a38
// Size: 0x62
function anim_single_failsafe( guys, anime )
{
    foreach ( guy in guys )
    {
        guy thread anim_single_failsafeonguy( self, anime );
    }
}

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x4aa2
// Size: 0x4b
function anim_get_goal_time( animname, anime )
{
    if ( isdefined( level.scr_goaltime[ animname ] ) && isdefined( level.scr_goaltime[ animname ][ anime ] ) )
    {
        return level.scr_goaltime[ animname ][ anime ];
    }
    
    return 0.5;
}

// Namespace animation / scripts\common\anim
// Params 1
// Checksum 0x0, Offset: 0x4af5
// Size: 0x1b
function function_89b3eabd606fcda3( animation )
{
    if ( utility::issp() )
    {
        return 0.5;
    }
    
    return 0;
}

// Namespace animation / scripts\common\anim
// Params 1
// Checksum 0x0, Offset: 0x4b19
// Size: 0x36, Type: bool
function function_f1e7ee8ddeece062( anime )
{
    if ( utility::issp() && isdefined( level.scr_entrances ) && istrue( level.scr_entrances[ anime ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x4b58
// Size: 0xbc
function function_1eba925251530689( guys, anime )
{
    if ( function_f1e7ee8ddeece062( anime ) && guys.size > 1 )
    {
        foreach ( guy in guys )
        {
            if ( !isdefined( guy.animname ) || !guy function_9c6a9b923786f602( guy.animname ) && !guy function_84a46f10a88351cd( guy.animname ) )
            {
                guys = array_remove( guys, guy );
                guys = array_add( guys, guy );
            }
        }
    }
    
    return guys;
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x4c1d
// Size: 0x3e
function function_56bd620e57a834af( anime, animname, animation )
{
    newanime = anime + "_entrance";
    level.scr_anim[ animname ][ newanime ] = animation;
    return newanime;
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x4c64
// Size: 0xd8
function function_c099f6fd9c19f5a6( anime, org, angles, animname )
{
    /#
        setdvarifuninitialized( @"hash_4140c00f3efa94c6", 0 );
    #/
    
    if ( function_9c6a9b923786f602( animname ) )
    {
        return function_96b3d74019cd30a( anime, org, angles, animname );
    }
    else if ( function_84a46f10a88351cd( animname ) )
    {
        return function_1ed6444c29da9045( anime, org, angles, animname );
    }
    
    if ( !isdefined( level.var_ac0205cb091a126e ) )
    {
        level.var_ac0205cb091a126e = 0;
        
        /#
            if ( getdvarint( @"hash_4140c00f3efa94c6", 0 ) )
            {
                iprintln( "<dev string:x6fc>" );
            }
        #/
    }
    
    if ( isarray( level.scr_anim[ animname ][ anime ] ) )
    {
        return level.scr_anim[ animname ][ anime ][ level.var_ac0205cb091a126e ];
    }
    
    return level.scr_anim[ animname ][ anime ];
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x4d44
// Size: 0x21f
function function_96b3d74019cd30a( anime, org, angles, animname )
{
    if ( isdefined( level.var_ac0205cb091a126e ) && istrue( level.var_99364109f9f9b3f4 ) && level.var_99364109f9f9b3f4 == gettime() )
    {
        return level.scr_anim[ animname ][ anime ][ level.var_ac0205cb091a126e ];
    }
    
    closest_anim = 0;
    closest_dist = undefined;
    level.var_ac0205cb091a126e = undefined;
    
    foreach ( i, animation in level.scr_anim[ animname ][ anime ] )
    {
        neworg = getstartorigin( org, angles, animation );
        
        /#
            if ( getdvarint( @"hash_4140c00f3efa94c6", 0 ) )
            {
                line( self.origin, neworg, ( 1, 1, 1 ), 1, 0, 1000 );
                print3d( neworg + ( 0, 0, 2 ), animation, ( 1, 1, 1 ), 1, 0.075, 1000, 1 );
                print3d( neworg, "<dev string:x724>", ( 1, 1, 1 ), 1, 0.2, 1000, 1 );
            }
        #/
        
        if ( !isdefined( closest_dist ) )
        {
            closest_dist = distancesquared( neworg, level.player.origin );
            continue;
        }
        
        dist = distancesquared( level.player.origin, neworg );
        
        if ( dist < closest_dist )
        {
            closest_anim = i;
            closest_dist = dist;
        }
    }
    
    animation = level.scr_anim[ animname ][ anime ][ closest_anim ];
    
    /#
        if ( getdvarint( @"hash_4140c00f3efa94c6", 0 ) )
        {
            iprintln( "<dev string:x729>" + animation );
        }
    #/
    
    level.var_99364109f9f9b3f4 = gettime();
    level.var_ac0205cb091a126e = closest_anim;
    return animation;
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x4f6c
// Size: 0x53
function function_1ed6444c29da9045( anime, org, angles, animname )
{
    level.var_ac0205cb091a126e = undefined;
    animation = level.scr_anim[ animname ][ anime ][ 0 ];
    level.var_ac0205cb091a126e = 0;
    return animation;
}

// Namespace animation / scripts\common\anim
// Params 1
// Checksum 0x0, Offset: 0x4fc8
// Size: 0x30, Type: bool
function function_84a46f10a88351cd( animname )
{
    if ( isdefined( level.scr_animtree[ animname ] ) && level.scr_animtree[ animname ] == #animtree )
    {
        return true;
    }
    
    return false;
}

// Namespace animation / scripts\common\anim
// Params 1
// Checksum 0x0, Offset: 0x5001
// Size: 0x1d
function function_9c6a9b923786f602( animname )
{
    return [[ anim.callbacks[ "CheckPlayerAnimtree" ] ]]( animname );
}

// Namespace animation / scripts\common\anim
// Params 1
// Checksum 0x0, Offset: 0x5027
// Size: 0x27
function function_2c88f6e05af61090( animation )
{
    if ( !animhasnotetrack( animation, "blend_into" ) )
    {
        return 0;
    }
    
    return get_notetrack_time( animation, "blend_into" );
}

// Namespace animation / scripts\common\anim
// Params 1
// Checksum 0x0, Offset: 0x5057
// Size: 0x27
function function_f92de130e8613662( animation )
{
    if ( !animhasnotetrack( animation, "blend_out" ) )
    {
        return undefined;
    }
    
    return get_notetrack_time( animation, "blend_out" );
}

// Namespace animation / scripts\common\anim
// Params 1
// Checksum 0x0, Offset: 0x5087
// Size: 0x47
function function_70b77e26541e095( animation )
{
    speed = 128;
    
    if ( animhasnotetrack( animation, "blend_speed = walk" ) )
    {
        speed = 128;
    }
    else if ( animhasnotetrack( animation, "blend_speed = run" ) )
    {
        speed = 145;
    }
    
    return speed * 0.7;
}

// Namespace animation / scripts\common\anim
// Params 1
// Checksum 0x0, Offset: 0x50d7
// Size: 0xef
function function_48af09f152896047( animation )
{
    stances = [];
    
    if ( animhasnotetrack( animation, "start_stance = stand" ) )
    {
        stances = array_add( stances, "stand" );
    }
    else if ( animhasnotetrack( animation, "start_stance = crouch" ) )
    {
        stances = array_add( stances, "crouch" );
    }
    else if ( animhasnotetrack( animation, "start_stance = prone" ) )
    {
        stances = array_add( stances, "prone" );
    }
    else
    {
        stances = array_add( stances, "none" );
    }
    
    if ( animhasnotetrack( animation, "end_stance = stand" ) )
    {
        stances = array_add( stances, "stand" );
    }
    else if ( animhasnotetrack( animation, "end_stance = crouch" ) )
    {
        stances = array_add( stances, "crouch" );
    }
    else if ( animhasnotetrack( animation, "end_stance = prone" ) )
    {
        stances = array_add( stances, "prone" );
    }
    else
    {
        stances = array_add( stances, "none" );
    }
    
    return stances;
}

// Namespace animation / scripts\common\anim
// Params 7
// Checksum 0x0, Offset: 0x51cf
// Size: 0x201
function function_d0fafbacba98a40f( playerpos, animstartpos, blendspeed, blendintotime, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous )
{
    var_ec165a067af34f8f = ter_op( isdefined( var_ec165a067af34f8f ), var_ec165a067af34f8f, 1 );
    var_8831fc7320076829 = ter_op( isdefined( var_8831fc7320076829 ), var_8831fc7320076829, 0 );
    simultaneous = ter_op( isdefined( simultaneous ), simultaneous, 0 );
    assertex( !( var_ec165a067af34f8f && var_8831fc7320076829 ), "<dev string:x743>" );
    
    if ( istrue( var_ec165a067af34f8f ) )
    {
        weapondroptime = level.player getgestureanimlength( "proto_vm_gesture_gun_drop" );
    }
    else if ( istrue( var_8831fc7320076829 ) )
    {
        weapondroptime = 0.5;
    }
    else
    {
        weapondroptime = 0;
    }
    
    weapondropquick = 0;
    
    if ( istrue( simultaneous ) )
    {
        weapondropquick = 1;
        weapondroptime = 0;
    }
    else if ( level.player getdemeanorviewmodel() == "relaxed" )
    {
        weapondropquick = 1;
        weapondroptime = 0.2;
    }
    
    blendtimecalc = distance2d( playerpos, animstartpos ) / blendspeed;
    idealblendtime = blendintotime + weapondroptime;
    
    /#
        if ( getdvarint( @"hash_398da46238160a6", 0 ) )
        {
            iprintln( "<dev string:x789>" + blendtimecalc );
        }
    #/
    
    if ( blendintotime > 0 )
    {
        frac = blendtimecalc / idealblendtime;
        
        if ( frac < 1.4 && frac > 0.4 )
        {
            blendtime = idealblendtime;
        }
        else if ( blendtimecalc < blendintotime )
        {
            blendtime = ter_op( blendintotime < 1, blendintotime + weapondroptime, 1 + weapondroptime );
        }
        else if ( blendtimecalc > 0.5 )
        {
            blendtime = blendtimecalc;
        }
        else
        {
            blendtime = 0.5;
        }
    }
    else
    {
        blendtime = 0.5;
    }
    
    if ( blendtime > idealblendtime )
    {
        /#
            if ( getdvarint( @"hash_398da46238160a6", 0 ) )
            {
                iprintln( "<dev string:x7a3>" );
            }
        #/
        
        weapondroptime = blendtime - blendintotime;
    }
    
    level.blendinfo[ "weaponDropQuick" ] = weapondropquick;
    level.blendinfo[ "weaponDropTime" ] = weapondroptime;
    return blendtime;
}

// Namespace animation / scripts\common\anim
// Params 7
// Checksum 0x0, Offset: 0x53d9
// Size: 0x222
function function_309bb9de5db13227( playerpos, animstartpos, blendspeed, blendintotime, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous )
{
    var_ec165a067af34f8f = ter_op( isdefined( var_ec165a067af34f8f ), var_ec165a067af34f8f, 1 );
    var_8831fc7320076829 = ter_op( isdefined( var_8831fc7320076829 ), var_8831fc7320076829, 0 );
    simultaneous = ter_op( isdefined( simultaneous ), simultaneous, 0 );
    
    if ( !var_8831fc7320076829 )
    {
        quickdroptime = 0;
        normaldroptime = 0;
    }
    else
    {
        quickdroptime = 0.2;
        
        if ( var_ec165a067af34f8f )
        {
            normaldroptime = level.player getgestureanimlength( "proto_vm_gesture_gun_drop" );
        }
        else
        {
            normaldroptime = 0.5;
        }
    }
    
    blendtime = distance2d( playerpos, animstartpos ) / blendspeed;
    
    /#
        if ( getdvarint( @"hash_398da46238160a6", 0 ) )
        {
            iprintln( "<dev string:x789>" + blendtime );
        }
    #/
    
    idealblendtime = blendintotime + normaldroptime;
    
    if ( idealblendtime > 0 )
    {
        frac = blendtime / idealblendtime;
        
        if ( frac < 1.4 && frac > 0.4 )
        {
            blendtime = idealblendtime;
        }
        else if ( blendtime < blendintotime )
        {
            blendtime = ter_op( blendintotime <= 1, blendintotime, 1 );
        }
    }
    
    if ( istrue( var_ec165a067af34f8f ) && istrue( var_8831fc7320076829 ) )
    {
        blendtime = ter_op( blendtime < normaldroptime, normaldroptime, blendtime );
    }
    else if ( !istrue( var_8831fc7320076829 ) )
    {
        blendtime = ter_op( blendtime < 0.5, 0.5, blendtime );
    }
    else
    {
        blendtime = ter_op( blendtime < quickdroptime, quickdroptime, blendtime );
    }
    
    weapondropquick = 0;
    weapondroptime = normaldroptime;
    
    if ( blendtime < normaldroptime || level.player getdemeanorviewmodel() == "relaxed" )
    {
        weapondropquick = 1;
        weapondroptime = quickdroptime;
    }
    else if ( blendtime > idealblendtime )
    {
        /#
            if ( getdvarint( @"hash_398da46238160a6", 0 ) )
            {
                iprintln( "<dev string:x7a3>" );
            }
        #/
        
        weapondroptime = blendtime - blendintotime;
    }
    
    if ( istrue( simultaneous ) )
    {
        weapondropquick = 1;
        weapondroptime = 0;
    }
    
    level.blendinfo[ "weaponDropQuick" ] = weapondropquick;
    level.blendinfo[ "weaponDropTime" ] = weapondroptime;
    return blendtime;
}

// Namespace animation / scripts\common\anim
// Params 5
// Checksum 0x0, Offset: 0x5604
// Size: 0x78
function function_dba8ec1939d3f1a( anime, animname, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous )
{
    if ( function_f1e7ee8ddeece062( anime ) )
    {
        animation = function_c099f6fd9c19f5a6( anime, self.origin, self.angles, animname );
    }
    else
    {
        animation = level.scr_anim[ animname ][ anime ];
    }
    
    function_1d134c1e220fb6d7( animation, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous );
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x5684
// Size: 0x1ad
function function_1d134c1e220fb6d7( animation, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous )
{
    animpos = getstartorigin( self.origin, self.angles, animation );
    level.blendinfo = [];
    blendintotime = function_2c88f6e05af61090( animation );
    blendouttime = function_f92de130e8613662( animation );
    blendspeed = function_70b77e26541e095( animation );
    blendtime = function_d0fafbacba98a40f( level.player.origin, animpos, blendspeed, blendintotime, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous );
    stances = function_48af09f152896047( animation );
    level.blendinfo[ "blendIntoTime" ] = blendintotime;
    level.blendinfo[ "blendOutTime" ] = blendouttime;
    level.blendinfo[ "blendSpeed" ] = blendspeed;
    level.blendinfo[ "blendTime" ] = blendtime;
    level.blendinfo[ "stances" ] = stances;
    
    /#
        if ( getdvarint( @"hash_398da46238160a6", 0 ) )
        {
            iprintln( "<dev string:x7f7>" + blendtime );
            iprintln( "<dev string:x806>" + blendintotime );
            
            if ( isdefined( blendouttime ) )
            {
                iprintln( "<dev string:x819>" + blendouttime );
            }
            
            iprintln( "<dev string:x82b>" + level.blendinfo[ "<dev string:x83f>" ] );
            iprintln( "<dev string:x851>" + level.blendinfo[ "<dev string:x85e>" ][ 0 ] + "<dev string:x869>" + level.blendinfo[ "<dev string:x85e>" ][ 1 ] );
        }
    #/
}

// Namespace animation / scripts\common\anim
// Params 1
// Checksum 0x0, Offset: 0x5839
// Size: 0x38
function function_5cffe82f5e70231b( bool )
{
    assertex( isdefined( bool ), "<dev string:x86f>" );
    
    if ( istrue( bool ) )
    {
        self.animscripted_collision = 1;
        return;
    }
    
    self.animscripted_collision = undefined;
}

// Namespace animation / scripts\common\anim
// Params 0
// Checksum 0x0, Offset: 0x5879
// Size: 0x13, Type: bool
function function_6bc36c81fc28a22e()
{
    if ( istrue( self.animscripted_collision ) )
    {
        return true;
    }
    
    return false;
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x5895
// Size: 0x9b
function function_1cb661b457551a3( bool, velocityent, blendtime )
{
    assertex( isdefined( bool ), "<dev string:x86f>" );
    
    if ( istrue( bool ) )
    {
        assertex( isdefined( velocityent ), "<dev string:x884>" );
        self.var_a986b9d4a1be703b = 1;
        self.var_f1a075b476ca91f1 = velocityent getvelocity();
        
        if ( isdefined( blendtime ) )
        {
            self.var_37b96012304143d7 = blendtime;
        }
        else
        {
            self.var_37b96012304143d7 = 0.2;
        }
        
        return;
    }
    
    self.var_a986b9d4a1be703b = undefined;
    self.var_f1a075b476ca91f1 = undefined;
    self.var_37b96012304143d7 = undefined;
}

// Namespace animation / scripts\common\anim
// Params 0
// Checksum 0x0, Offset: 0x5938
// Size: 0x2f, Type: bool
function function_e42b762e098c8f9e()
{
    if ( istrue( self.var_a986b9d4a1be703b ) && isdefined( self.var_f1a075b476ca91f1 ) && isdefined( self.var_37b96012304143d7 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x5970
// Size: 0xd2
function function_52351c3338da63f4( animcategory, animindex )
{
    assertex( isdefined( animcategory ) && isdefined( animindex ), "<dev string:x8a6>" );
    animlength = 0;
    
    if ( isdefined( level.scr_animlength ) && isdefined( level.scr_animlength[ animcategory ] ) && isdefined( level.scr_animlength[ animcategory ][ animindex ] ) )
    {
        animlength = level.scr_animlength[ animcategory ][ animindex ];
    }
    else if ( isdefined( level.scr_anim ) && isdefined( level.scr_anim[ animcategory ] ) && isdefined( level.scr_anim[ animcategory ][ animindex ] ) )
    {
        animlength = getanimlength( level.scr_anim[ animcategory ][ animindex ] );
    }
    else
    {
        assertmsg( "<dev string:x8df>" );
    }
    
    return animlength;
}

/#

    // Namespace animation / scripts\common\anim
    // Params 0
    // Checksum 0x0, Offset: 0x5a4b
    // Size: 0x160, Type: dev
    function function_65e9f4b64110bb5c()
    {
        while ( true )
        {
            requestflag = getdvarint( @"hash_300079a74221ae45", 0 );
            
            if ( requestflag != 0 )
            {
                origin = ( 0, 0, 0 );
                angles = ( 0, 0, 0 );
                align_target = getdvar( @"hash_43022f85e8f590a5" );
                align_tag = getdvar( @"hash_9dfd128a6efc97b4" );
                aligntarget = getent_or_struct( align_target, "<dev string:x96b>" );
                
                if ( isdefined( aligntarget ) )
                {
                    if ( isdefined( aligntarget.origin ) )
                    {
                        origin = aligntarget.origin;
                    }
                    
                    if ( isdefined( aligntarget.angles ) )
                    {
                        angles = aligntarget.angles;
                    }
                }
                
                setdvar( @"hash_aac2e2e60bc546c8", origin[ 0 ] );
                setdvar( @"hash_aac2e3e60bc548fb", origin[ 1 ] );
                setdvar( @"hash_aac2e4e60bc54b2e", origin[ 2 ] );
                setdvar( @"hash_8961ba30d631ddb0", angles[ 0 ] );
                setdvar( @"hash_8961bb30d631dfe3", angles[ 1 ] );
                setdvar( @"hash_8961bc30d631e216", angles[ 2 ] );
                setdvar( @"hash_300079a74221ae45", 0 );
            }
            
            waitframe();
        }
    }

#/

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x5bb3
// Size: 0x2f
function function_dca1a3a29d2ee467( guys_with_anims, speed_baseline )
{
    thread anim_reach_speed_control( guys_with_anims, speed_baseline );
    anim_reach_with_funcs_guys_with_anims( guys_with_anims, &reach_with_standard_adjustments_begin, &reach_with_standard_adjustments_end );
}

// Namespace animation / scripts\common\anim
// Params 7
// Checksum 0x0, Offset: 0x5bea
// Size: 0x170
function anim_reach_with_funcs( guys, anime, tag, animname_override, start_func, end_func, arrival_type )
{
    array = get_anim_position( tag );
    alignmentinfo = spawnstruct();
    alignmentinfo.origin = array[ "origin" ];
    alignmentinfo.angles = array[ "angles" ];
    guys_with_anims = [];
    
    foreach ( guy in guys )
    {
        if ( isdefined( animname_override ) )
        {
            animname = animname_override;
        }
        else
        {
            animname = guy.animname;
        }
        
        animation = undefined;
        
        if ( isdefined( level.scr_anim[ animname ][ anime ] ) )
        {
            if ( isarray( level.scr_anim[ animname ][ anime ] ) )
            {
                animation = level.scr_anim[ animname ][ anime ][ 0 ];
            }
            else
            {
                animation = level.scr_anim[ animname ][ anime ];
            }
        }
        
        guys_with_anims[ guys_with_anims.size ] = [ guy, animation, alignmentinfo ];
    }
    
    anim_reach_with_funcs_guys_with_anims( guys_with_anims, start_func, end_func, arrival_type );
}

// Namespace animation / scripts\common\anim
// Params 4
// Checksum 0x0, Offset: 0x5d62
// Size: 0x326
function anim_reach_with_funcs_guys_with_anims( guys_with_anims, start_func, end_func, arrival_type )
{
    ent = spawnstruct();
    debugstartpos = 0;
    
    /#
        debugstartpos = getdvar( @"hash_34dab4f8f3a04f4a" ) == "<dev string:x68a>";
    #/
    
    threads = 0;
    guys = [];
    
    foreach ( guy_anim in guys_with_anims )
    {
        guy = guy_anim[ 0 ];
        animation = guy_anim[ 1 ];
        alignment = guy_anim[ 2 ];
        var_93e32c180cab35b3 = guy_anim[ 3 ];
        startorg = self.origin;
        startangles = self.angles;
        
        if ( isdefined( alignment ) )
        {
            startorg = alignment.origin;
            startangles = alignment.angles;
        }
        
        if ( isdefined( animation ) )
        {
            animorg = getstartorigin( startorg, startangles, animation );
            animangles = getstartangles( startorg, startangles, animation );
            startorg = animorg;
            startangles = animangles;
        }
        
        if ( !isdefined( var_93e32c180cab35b3 ) )
        {
            var_93e32c180cab35b3 = arrival_type;
        }
        
        if ( isdefined( var_93e32c180cab35b3 ) )
        {
            if ( isdefined( guy.scriptedarrivalent ) )
            {
                guy.scriptedarrivalent delete();
                guy.scriptedarrivalent = undefined;
            }
            
            guy.scriptedarrivalent = spawn( "script_origin", startorg );
            guy.scriptedarrivalent.angles = startangles;
            guy.scriptedarrivalent.type = var_93e32c180cab35b3;
            guy.scriptedarrivalent.arrivalstance = "stand";
            guy.forcenextpathfindimmediate = 1;
            
            if ( isplayer( guy ) || isactor( guy ) )
            {
                platform = guy getmovingplatformparent();
                
                if ( isdefined( platform ) )
                {
                    guy.scriptedarrivalent linkto( platform );
                }
            }
        }
        
        threads++;
        guy thread begin_anim_reach( ent, startorg, startangles, start_func, end_func );
    }
    
    while ( threads )
    {
        ent waittill( "reach_notify" );
        threads--;
    }
    
    /#
        if ( debugstartpos )
        {
            level notify( "<dev string:x979>" + "<dev string:x97e>" );
        }
    #/
    
    foreach ( guy_anim in guys_with_anims )
    {
        guy = guy_anim[ 0 ];
        
        if ( !isalive( guy ) )
        {
            continue;
        }
        
        guy.goalradius = guy.oldgoalradius;
        
        if ( isdefined( guy.scriptedarrivalent ) )
        {
            guy.scriptedarrivalent delete();
            guy.scriptedarrivalent = undefined;
        }
        
        guy.stopanimdistsq = 0;
    }
}

// Namespace animation / scripts\common\anim
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x6090
// Size: 0x43
function private reach_death_notify( ent )
{
    waittill_either( "death", "goal" );
    
    while ( isalive( self ) && self.arriving )
    {
        wait 0.05;
    }
    
    ent notify( "reach_notify" );
}

// Namespace animation / scripts\common\anim
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x60db
// Size: 0x119
function private begin_anim_reach( ent, startorg, startangles, start_func, end_func )
{
    self endon( "death" );
    self endon( "new_anim_reach" );
    thread reach_death_notify( ent );
    startorg = [[ start_func ]]( startorg, startangles );
    points = [];
    
    if ( ( !isdefined( self.scriptedarrivalent ) || !isdefined( self.scriptedarrivalent.type ) ) && distance2dsquared( startorg, self.origin ) > 2500 )
    {
        forward = anglestoforward( startangles );
        var_b88bb2e631bcc2b3 = startorg - forward * 50;
        
        if ( navisstraightlinereachable( startorg, var_b88bb2e631bcc2b3, self ) )
        {
            points[ points.size ] = var_b88bb2e631bcc2b3;
        }
    }
    
    points[ points.size ] = startorg;
    self setgoalpath( points );
    self.reach_goal_pos = startorg;
    self.goalradius = 0;
    self.stopanimdistsq = squared( 120 );
    self waittill( "goal" );
    self notify( "anim_reach_complete" );
    [[ end_func ]]();
    self notify( "new_anim_reach" );
}

// Namespace animation / scripts\common\anim
// Params 3
// Checksum 0x0, Offset: 0x61fc
// Size: 0x5e7
function anim_reach_speed_control( guys_with_anims, speed_baseline, var_ad86b98c8c9def3d )
{
    waittillframeend();
    speed_baseline = default_to( speed_baseline, 140 );
    var_ad86b98c8c9def3d = default_to( var_ad86b98c8c9def3d, 4 );
    
    foreach ( index, guy_anim in guys_with_anims )
    {
        guy = guy_anim[ 0 ];
        var_93e32c180cab35b3 = guy_anim[ 3 ];
        moving_destination = isdefined( var_93e32c180cab35b3 ) && var_93e32c180cab35b3 == "Exposed Moving";
        track_speed = moving_destination;
        
        /#
            track_speed = track_speed || getdvarint( @"scr_debug_reach" );
        #/
        
        if ( track_speed )
        {
            guy childthread anim_reach_speed_control_avg( var_ad86b98c8c9def3d, speed_baseline );
        }
        
        guy aisetdesiredspeed( speed_baseline );
    }
    
    while ( true )
    {
        furthestguy = undefined;
        furthestdist = 0;
        dist = [];
        dist_normal = [];
        remove = [];
        
        foreach ( index, guy_anim in guys_with_anims )
        {
            guy = guy_anim[ 0 ];
            
            if ( !isalive( guy ) )
            {
                remove[ remove.size ] = index;
                continue;
            }
            
            dist[ index ] = guy pathdisttogoal();
            
            if ( dist[ index ] == 0 )
            {
                pos = guy.goalpos;
                
                if ( isdefined( guy.reach_goal_pos ) )
                {
                    pos = guy.reach_goal_pos;
                }
                
                dist[ index ] = distance( guy.origin, pos );
            }
            
            if ( dist[ index ] <= 4 )
            {
                remove[ remove.size ] = index;
                continue;
            }
            
            if ( dist[ index ] > furthestdist )
            {
                furthestguy = guy;
                furthestdist = dist[ index ];
            }
        }
        
        foreach ( index in remove )
        {
            guy = guys_with_anims[ index ][ 0 ];
            
            if ( isalive( guy ) )
            {
                guy val::reset_all( "anim_reach_speed_control" );
                guy enableavoidance( 1, 1 );
                guy.reachspeed = undefined;
                guy notify( "anim_reach_speed_control_avg" );
            }
            
            guys_with_anims[ index ] = undefined;
        }
        
        if ( guys_with_anims.size == 0 )
        {
            break;
        }
        
        foreach ( index, guy_anim in guys_with_anims )
        {
            guy = guy_anim[ 0 ];
            var_93e32c180cab35b3 = guy_anim[ 3 ];
            moving_destination = isdefined( var_93e32c180cab35b3 ) && var_93e32c180cab35b3 == "Exposed Moving";
            
            if ( dist[ index ] < 96 )
            {
                guy enableavoidance( 0, 0 );
            }
            
            dist_normal[ index ] = dist[ index ] / furthestdist;
            speedscale = 1;
            
            if ( furthestguy != guy )
            {
                if ( moving_destination && dist[ index ] <= 16 )
                {
                    speedscale = min( 1, guy.reachspeed.speed_avg + 0.05 );
                }
                else
                {
                    speedscale = max( dist_normal[ index ], 0.4 );
                }
            }
            
            desiredspeed = speedscale * speed_baseline;
            
            /#
                if ( getdvarint( @"scr_debug_reach" ) )
                {
                    if ( furthestguy == guy )
                    {
                        print3d( guy.origin + ( 0, 0, 36 ), "<dev string:x990>", ( 0, 1, 0 ), 1, 0.3, 1, 1 );
                    }
                    
                    line( guy.origin, guy.goalpos, ( 1, 1, 1 ), 1, 0, 1 );
                    print3d( guy.origin, "<dev string:xd0>" + int( speed_baseline ), ( 0, 1, 0 ), 1, 0.3, 1, 1 );
                    print3d( guy.origin + ( 0, 0, 10 ), "<dev string:xd0>" + int( desiredspeed ), ( 1, 1, 1 ), 1, 0.3, 1, 1 );
                    
                    if ( isdefined( guy.reachspeed ) )
                    {
                        print3d( guy.origin + ( 0, 0, 20 ), "<dev string:xd0>" + int( guy.reachspeed.speed_avg ), ( 0, 1, 1 ), 1, 0.3, 1, 1 );
                    }
                    
                    print3d( guy.origin + ( 0, 0, 80 ), "<dev string:xd0>" + speedscale, ( 0, 0, 1 ), 1, 0.3, 1, 1 );
                    print3d( guy.goalpos + ( 0, 0, 12 ), "<dev string:xd0>" + int( dist[ index ] ), ( 0, 0, 1 ), 1, 1, 1, 1 );
                    sphere( guy.goalpos, 16 );
                }
            #/
            
            switch ( guy getdemeanor() )
            {
                case #"hash_186d745a92c317d9":
                case #"hash_9128327eb51e0b7b":
                    guy val::set( "anim_reach_speed_control", "move_speed_scale", speedscale );
                    guy val::reset( "anim_reach_speed_control", "desired_speed" );
                    break;
                default:
                    guy val::set( "anim_reach_speed_control", "desired_speed", desiredspeed );
                    guy val::reset( "anim_reach_speed_control", "move_speed_scale" );
                    break;
            }
        }
        
        waitframe();
    }
}

// Namespace animation / scripts\common\anim
// Params 2
// Checksum 0x0, Offset: 0x67eb
// Size: 0x137
function anim_reach_speed_control_avg( var_ad86b98c8c9def3d, speed_baseline )
{
    self endon( "death" );
    self notify( "anim_reach_speed_control_avg" );
    self endon( "anim_reach_speed_control_avg" );
    self.reachspeed = spawnstruct();
    reachspeed = self.reachspeed;
    reachspeed.speed_avg = speed_baseline;
    reachspeed.speed_samples = [];
    reachspeed.speed_total = 0;
    curr = 0;
    
    while ( true )
    {
        index = mod( curr, var_ad86b98c8c9def3d );
        curr++;
        
        if ( isdefined( reachspeed.speed_samples[ index ] ) )
        {
            reachspeed.speed_total -= reachspeed.speed_samples[ index ];
        }
        
        reachspeed.speed_samples[ index ] = length( self.velocity );
        reachspeed.speed_total += reachspeed.speed_samples[ index ];
        reachspeed.speed_avg = reachspeed.speed_total / reachspeed.speed_samples.size;
        waitframe();
    }
}

// Namespace animation / scripts\common\anim
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x692a
// Size: 0x45
function private reach_with_standard_adjustments_begin( startorg, startangles )
{
    assertex( isdefined( anim.callbacks[ "<dev string:x99c>" ] ), "<dev string:x9c5>" );
    return self [[ anim.callbacks[ "reach_with_standard_adjustments_begin" ] ]]( startorg, startangles );
}

// Namespace animation / scripts\common\anim
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x6978
// Size: 0x33
function private reach_with_standard_adjustments_end()
{
    assertex( isdefined( anim.callbacks[ "<dev string:xa37>" ] ), "<dev string:xa5e>" );
    self [[ anim.callbacks[ "reach_with_standard_adjustments_end" ] ]]();
}

