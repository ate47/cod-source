#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\shared\utility;
#using scripts\common\debug;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace notetracks;

/#

    // Namespace notetracks / scripts\anim\notetracks
    // Params 1
    // Checksum 0x0, Offset: 0xa91
    // Size: 0x1a6, Type: dev
    function shownotetrack( note )
    {
        if ( getdvarint( @"hash_a19781010239d2e6" ) != 1 && getdvarint( @"hash_a19781010239d2e6" ) != self getentitynumber() )
        {
            return;
        }
        
        self endon( "<dev string:x1c>" );
        anim.shownotetrackspeed = 30;
        anim.shownotetrackduration = 20;
        duration = anim.shownotetrackduration + int( 20 / anim.shownotetrackspeed );
        color = ( 0.5, 0.75, 1 );
        
        if ( note == "<dev string:x25>" || note == "<dev string:x2c>" )
        {
            color = ( 0.25, 0.4, 0.5 );
        }
        else if ( note == "<dev string:x36>" )
        {
            color = ( 1, 0.5, 0.5 );
        }
        
        for ( i = 0; i < duration ; i++ )
        {
            if ( duration - i <= anim.shownotetrackduration )
            {
                amnt = 1 * ( i - duration - anim.shownotetrackduration ) / anim.shownotetrackduration;
            }
            else
            {
                amnt = 0;
            }
            
            time = 1 * i / 20;
            alpha = 1 - amnt * amnt;
            
            if ( isai( self ) )
            {
                pos = self geteye() + ( 0, 0, 20 + anim.shownotetrackspeed * time );
            }
            else
            {
                pos = self.origin;
            }
            
            print3d( pos, note, color, alpha, 0.5 );
            waitframe();
        }
    }

#/

// Namespace notetracks / scripts\anim\notetracks
// Params 0
// Checksum 0x0, Offset: 0xc3f
// Size: 0x4dd
function registernotetracks()
{
    thread function_1f7bb66025f2aedf();
    anim.notetracks[ "anim_movement = \"stop\"" ] = &notetrackmovementstop;
    anim.notetracks[ "anim_movement = \"walk\"" ] = &notetrackmovementwalk;
    anim.notetracks[ "anim_movement = \"run\"" ] = &notetrackmovementrun;
    anim.notetracks[ "anim_movement = stop" ] = &notetrackmovementstop;
    anim.notetracks[ "anim_movement = walk" ] = &notetrackmovementwalk;
    anim.notetracks[ "anim_movement = run" ] = &notetrackmovementrun;
    anim.notetracks[ "anim_movement_gun_pose_override = run_gun_down" ] = &notetrackmovementgunposeoverride;
    anim.notetracks[ "anim_coverpose = cover_left" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_coverpose = cover_right" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_coverpose = cover_crouch" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_coverpose = cover_stand" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_coverpose = cover_left_crouch" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_coverpose = cover_right_crouch" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_coverpose = exposed" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_coverpose = exposed_crouch" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_coverpose = prone" ] = &notetrackcoverposerequest;
    anim.notetracks[ "anim_aiming = 1" ] = &notetrackalertnessaiming;
    anim.notetracks[ "anim_aiming = 0" ] = &notetrackalertnessalert;
    anim.notetracks[ "anim_alertness = causal" ] = &notetrackalertnesscasual;
    anim.notetracks[ "anim_alertness = alert" ] = &notetrackalertnessalert;
    anim.notetracks[ "anim_alertness = aiming" ] = &notetrackalertnessaiming;
    anim.notetracks[ "gravity on" ] = &notetrackgravity;
    anim.notetracks[ "gravity off" ] = &notetrackgravity;
    anim.notetracks[ "bodyfall large" ] = &notetrackbodyfall;
    anim.notetracks[ "bodyfall small" ] = &notetrackbodyfall;
    anim.notetracks[ "code_move" ] = &notetrackcodemove;
    anim.notetracks[ "face_enemy" ] = &notetrackfaceenemy;
    anim.notetracks[ "pistol_rechamber" ] = &notetrackpistolrechamber;
    anim.notetracks[ "load_shell" ] = &notetrackloadshell;
    anim.notetracks[ "fire_if_loaded" ] = &function_df92aadf78bfcf42;
    anim.notetracks[ "fire" ] = &notetrackfire;
    anim.notetracks[ "fire_spray" ] = &notetrackfirespray;
    anim.notetracks[ "gun_2_chest" ] = &notetrackguntochest;
    anim.notetracks[ "gun_2_back" ] = &notetrackguntoback;
    anim.notetracks[ "gun_2_right" ] = &notetrackguntoright;
    anim.notetracks[ "gun_2_hand" ] = &function_12e1635911fd2716;
    anim.notetracks[ "secondary_pickup" ] = &function_c99ec552dfea0f86;
    anim.notetracks[ "secondary_putaway" ] = &function_316d2ec7583a1e29;
    anim.notetracks[ "pistol_pickup" ] = &notetrackpistolpickup;
    anim.notetracks[ "pistol_putaway" ] = &notetrackpistolputaway;
    anim.notetracks[ "refill clip" ] = &notetrackrefillclip;
    anim.notetracks[ "reload done" ] = &notetrackrefillclip;
    anim.notetracks[ "ht_on" ] = &notetrackhton0;
    anim.notetracks[ "ht_on_0" ] = &notetrackhton0;
    anim.notetracks[ "ht_on_1" ] = &notetrackhton1;
    anim.notetracks[ "ht_off" ] = &notetrackhtoff;
    anim.notetracks[ "hp_on" ] = &function_5a8f2c4ba78d7bff;
    anim.notetracks[ "hp_on_pos" ] = &function_ab37da002eddaf9f;
    anim.notetracks[ "hp_off" ] = &function_b67df3617c4f2903;
    anim.notetracks[ "notify" ] = &notetracknotify;
    anim.notetracks[ "viewunlinkmodel" ] = &function_5b7a0a74bd3d5e0b;
    anim.notetracks[ "charge_abort" ] = &function_28b89c4ec5292326;
    anim.notetracks[ "melee_swipe" ] = &function_1777a8463e80f52e;
    
    if ( isdefined( level._notetrackfx ) )
    {
        keys = getarraykeys( level._notetrackfx );
        
        foreach ( key in keys )
        {
            anim.notetracks[ key ] = &customnotetrackfx;
        }
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x1124
// Size: 0x13
function notetrackstopanim( note, flagname )
{
    
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x113f
// Size: 0xdd
function notetrackcoverposerequest( note, flagname )
{
    assert( issubstr( note, "<dev string:x43>" ) );
    coverpose = strtok( note, " = " )[ 1 ];
    
    switch ( coverpose )
    {
        case #"hash_175771022bc5e75d":
        case #"hash_4ddb655e251e06c8":
        case #"hash_9d76c99eddd14433":
        case #"hash_c475427a998ee26c":
        case #"hash_d165cddb82d41e6a":
        case #"hash_d44cb989edc40ab3":
        case #"hash_d91940431ed7c605":
        case #"hash_e7aface284179b3b":
        case #"hash_f1676baca0ae608b":
            self.coverposerequest = coverpose;
            break;
        default:
            assertmsg( "<dev string:x58>" );
            break;
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x1224
// Size: 0x2c
function notetrackmovementstop( note, flagname )
{
    self.a.movement = "stop";
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x1258
// Size: 0x2c
function notetrackmovementwalk( note, flagname )
{
    self.a.movement = "walk";
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x128c
// Size: 0x2c
function notetrackmovementrun( note, flagname )
{
    self.a.movement = "run";
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x12c0
// Size: 0x2c
function notetrackmovementgunposeoverride( note, flagname )
{
    self.asm.movementgunposeoverride = "run_gun_down";
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x12f4
// Size: 0x13
function notetrackalertnessaiming( note, flagname )
{
    
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x130f
// Size: 0x13
function notetrackalertnesscasual( note, flagname )
{
    
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x132a
// Size: 0x13
function notetrackalertnessalert( note, flagname )
{
    
}

/#

    // Namespace notetracks / scripts\anim\notetracks
    // Params 2
    // Checksum 0x0, Offset: 0x1345
    // Size: 0x6e, Type: dev
    function function_48e7a4a270c0d370( note, flagname )
    {
        setdvarifuninitialized( @"hash_d54f2997c58912ce", "<dev string:x7b>" );
        
        if ( getdvarint( @"hash_d54f2997c58912ce" ) < 1 )
        {
            return;
        }
        
        if ( !isdefined( flagname ) )
        {
            flagname = "<dev string:x80>";
        }
        
        if ( issubstr( note, "<dev string:x85>" ) )
        {
            println( "<dev string:x8a>" + note + "<dev string:xbd>" + flagname );
        }
    }

#/

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x13bb
// Size: 0x13
function notetrackloadshell( note, flagname )
{
    
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x13d6
// Size: 0x13
function notetrackpistolrechamber( note, flagname )
{
    
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x13f1
// Size: 0x4a
function notetrackgravity( note, flagname )
{
    if ( issubstr( note, "on" ) )
    {
        self animmode( "gravity" );
        return;
    }
    
    if ( issubstr( note, "off" ) )
    {
        self animmode( "nogravity" );
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x1443
// Size: 0x141
function customnotetrackfx( note, flagname )
{
    assert( isdefined( level._notetrackfx[ note ] ) );
    
    if ( isdefined( self.groundtype ) )
    {
        groundtype = self.groundtype;
    }
    else
    {
        groundtype = "dirt";
    }
    
    struct = undefined;
    
    if ( isdefined( level._notetrackfx[ note ][ groundtype ] ) )
    {
        struct = level._notetrackfx[ note ][ groundtype ];
    }
    else if ( isdefined( level._notetrackfx[ note ][ "all" ] ) )
    {
        struct = level._notetrackfx[ note ][ "all" ];
    }
    
    if ( !isdefined( struct ) )
    {
        return;
    }
    
    if ( isai( self ) && isdefined( struct.fx ) )
    {
        playfxontag( struct.fx, self, struct.tag );
    }
    
    if ( !isdefined( struct.sound_prefix ) && !isdefined( struct.sound_suffix ) )
    {
        return;
    }
    
    alias = "" + struct.sound_prefix + groundtype + struct.sound_suffix;
    
    if ( soundexists( alias ) )
    {
        self playsound( alias );
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x158c
// Size: 0x18
function notetrackcodemove( note, flagname )
{
    return "code_move";
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x15ad
// Size: 0x1f
function notetrackfaceenemy( note, flagname )
{
    self orientmode( "face enemy" );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x15d4
// Size: 0x8a
function notetrackbodyfall( note, flagname )
{
    suffix = "_small";
    
    if ( issubstr( note, "large" ) )
    {
        suffix = "_large";
    }
    
    if ( isdefined( self.groundtype ) )
    {
        groundtype = self.groundtype;
    }
    else
    {
        groundtype = "dirt";
    }
    
    if ( suffix == "_large" )
    {
        self playsurfacesound( "bodyfall_torso", groundtype );
        return;
    }
    
    self playsurfacesound( "bodyfall_limb_small", groundtype );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 3
// Checksum 0x0, Offset: 0x1666
// Size: 0xb9
function donotetracks( flagname, customfunction, debugidentifier )
{
    for ( ;; )
    {
        self waittill( flagname, notes );
        
        if ( !isdefined( notes ) )
        {
            notes = [ "undefined" ];
        }
        
        if ( !isarray( notes ) )
        {
            notes = [ notes ];
        }
        
        validatenotetracks( flagname, notes );
        
        foreach ( note in notes )
        {
            val = handlenotetrack( note, flagname, customfunction );
            
            if ( isdefined( val ) )
            {
                return val;
            }
        }
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 4
// Checksum 0x0, Offset: 0x1727
// Size: 0x78
function handlenotetrack( note, flagname, customfunction, customparams )
{
    if ( isdefined( self.fnasm_handlenotetrack ) )
    {
        return [[ self.fnasm_handlenotetrack ]]( note, flagname, customfunction, customparams );
    }
    
    if ( isdefined( level._defaultnotetrackhandler ) )
    {
        return [[ level._defaultnotetrackhandler ]]( note, flagname, customfunction, customparams );
    }
    
    assertmsg( "<dev string:xc8>" + self getentitynumber() );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x17a7
// Size: 0x3b, Type: bool
function hascustomnotetrackhandler( note )
{
    notetrackfunc = anim.notetracks[ note ];
    
    if ( isdefined( notetrackfunc ) )
    {
        return true;
    }
    
    if ( isdefined( self.customnotetrackhandler ) )
    {
        return true;
    }
    
    return false;
}

// Namespace notetracks / scripts\anim\notetracks
// Params 4
// Checksum 0x0, Offset: 0x17eb
// Size: 0x98
function handlecustomnotetrackhandler( note, flagname, customfunction, customparams )
{
    assert( hascustomnotetrackhandler( note ) );
    notetrackfunc = anim.notetracks[ note ];
    
    /#
        function_48e7a4a270c0d370( note, flagname );
    #/
    
    if ( isdefined( notetrackfunc ) )
    {
        return [[ notetrackfunc ]]( note, flagname );
    }
    
    if ( isdefined( self.customnotetrackhandler ) )
    {
        if ( isdefined( customparams ) )
        {
            return [[ self.customnotetrackhandler ]]( note, flagname, customfunction, customparams );
        }
        
        return [[ self.customnotetrackhandler ]]( note, flagname, customfunction );
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 4
// Checksum 0x0, Offset: 0x188b
// Size: 0x27b
function handlecommonnotetrack( note, flagname, customfunction, customparams )
{
    /#
        thread shownotetrack( note );
    #/
    
    switch ( note )
    {
        case #"hash_b61583709daf623":
        case #"hash_247cc07ab83949f2":
        case #"hash_2a91eda16e3944d1":
        case #"hash_ed49946bfff8e78a":
            return note;
        case #"hash_1962676868099dfd":
            if ( isdefined( self.enemy ) )
            {
                return note;
            }
            
            break;
        case #"hash_49af0c46b8bd5fb2":
            thread play_sound_in_space( "melee_swing_small", self gettagorigin( "TAG_WEAPON_RIGHT" ) );
            break;
        case #"hash_466ca7b853d8962e":
            thread play_sound_in_space( "melee_swing_large", self gettagorigin( "TAG_WEAPON_RIGHT" ) );
            break;
        case #"hash_e01205bce6c9351c":
            self.a.nodeath = 1;
            break;
        case #"hash_96585dbff62202c2":
            self.allowpain = 0;
            break;
        case #"hash_fc9342b5a91869ea":
            self.allowpain = 1;
            break;
        case #"hash_39305061b0d59e1e":
        case #"hash_83ed1371a36bf0b6":
            self.a.meleestate = "right";
            break;
        case #"hash_d97e6d5be66b4c5":
        case #"hash_31521d11dde26e47":
            self.a.meleestate = "left";
            break;
        case #"hash_7701f1d5cbc5085d":
            if ( isdefined( self.hatmodel ) )
            {
                if ( isdefined( self.helmetsidemodel ) )
                {
                    self detach( self.helmetsidemodel, "TAG_HELMETSIDE" );
                    self.helmetsidemodel = undefined;
                }
                
                self detach( self.hatmodel, "" );
                self attach( self.hatmodel, "TAG_WEAPON_LEFT" );
                self.hatmodel = undefined;
            }
            
            break;
        case #"hash_6f55d0ff4f5a774":
            level notify( "glass_break", self );
            break;
        case #"hash_275f5641f230746b":
            level notify( "glass_break", self );
            break;
        case #"hash_ff2ad0514dabb22b":
            if ( !self.fixednode )
            {
                self animmode( "physics_drift" );
            }
            
            break;
        default:
            return "__unhandled";
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 3
// Checksum 0x0, Offset: 0x1b0e
// Size: 0xfb
function donotetracksintercept( flagname, interceptfunction, debugidentifier )
{
    assert( isdefined( interceptfunction ) );
    
    for ( ;; )
    {
        self waittill( flagname, notes );
        
        if ( !isdefined( notes ) )
        {
            notes = [ "undefined" ];
        }
        
        if ( !isarray( notes ) )
        {
            notes = [ notes ];
        }
        
        validatenotetracks( flagname, notes );
        intercepted = [[ interceptfunction ]]( notes );
        
        if ( isdefined( intercepted ) && intercepted )
        {
            continue;
        }
        
        defined_val = undefined;
        
        foreach ( note in notes )
        {
            val = handlenotetrack( note, flagname );
            
            if ( isdefined( val ) )
            {
                defined_val = val;
                break;
            }
        }
        
        if ( isdefined( defined_val ) )
        {
            return defined_val;
        }
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x1c11
// Size: 0xd7
function donotetrackspostcallback( flagname, postfunction )
{
    assert( isdefined( postfunction ) );
    
    for ( ;; )
    {
        self waittill( flagname, notes );
        
        if ( !isdefined( notes ) )
        {
            notes = [ "undefined" ];
        }
        
        if ( !isarray( notes ) )
        {
            notes = [ notes ];
        }
        
        validatenotetracks( flagname, notes );
        defined_val = undefined;
        
        foreach ( note in notes )
        {
            val = handlenotetrack( note, flagname );
            
            if ( isdefined( val ) )
            {
                defined_val = val;
                break;
            }
        }
        
        [[ postfunction ]]( notes );
        
        if ( isdefined( defined_val ) )
        {
            return defined_val;
        }
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 4
// Checksum 0x0, Offset: 0x1cf0
// Size: 0x2d
function donotetracksfortimeout( flagname, killstring, customfunction, debugidentifier )
{
    donotetracks( flagname, customfunction, debugidentifier );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 4
// Checksum 0x0, Offset: 0x1d25
// Size: 0x33
function donotetracksforever( flagname, killstring, customfunction, debugidentifier )
{
    donotetracksforeverproc( &donotetracks, flagname, killstring, customfunction, debugidentifier );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 4
// Checksum 0x0, Offset: 0x1d60
// Size: 0x33
function donotetracksforeverintercept( flagname, killstring, interceptfunction, debugidentifier )
{
    donotetracksforeverproc( &donotetracksintercept, flagname, killstring, interceptfunction, debugidentifier );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 5
// Checksum 0x0, Offset: 0x1d9b
// Size: 0xe0
function donotetracksforeverproc( notetracksfunc, flagname, killstring, customfunction, debugidentifier )
{
    if ( isdefined( killstring ) )
    {
        self endon( killstring );
    }
    
    self endon( "killanimscript" );
    
    if ( !isdefined( debugidentifier ) )
    {
        debugidentifier = "undefined";
    }
    
    for ( ;; )
    {
        time = gettime();
        returnednote = [[ notetracksfunc ]]( flagname, customfunction, debugidentifier );
        timetaken = gettime() - time;
        
        if ( timetaken < 0.05 )
        {
            time = gettime();
            returnednote = [[ notetracksfunc ]]( flagname, customfunction, debugidentifier );
            timetaken = gettime() - time;
            
            if ( timetaken < 0.05 )
            {
                println( gettime() + "<dev string:xea>" + debugidentifier + "<dev string:xef>" + flagname + "<dev string:x14b>" + returnednote + "<dev string:x15a>" );
                wait 0.05 - timetaken;
            }
        }
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 4
// Checksum 0x0, Offset: 0x1e83
// Size: 0x4e
function donotetrackswithtimeout( flagname, time, customfunction, debugidentifier )
{
    ent = spawnstruct();
    ent thread donotetracksfortimeendnotify( time );
    donotetracksfortimeproc( &donotetracksfortimeout, flagname, customfunction, debugidentifier, ent );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 4
// Checksum 0x0, Offset: 0x1ed9
// Size: 0x4e
function donotetracksfortime( time, flagname, customfunction, debugidentifier )
{
    ent = spawnstruct();
    ent thread donotetracksfortimeendnotify( time );
    donotetracksfortimeproc( &donotetracksforever, flagname, customfunction, debugidentifier, ent );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 4
// Checksum 0x0, Offset: 0x1f2f
// Size: 0x4e
function donotetracksfortimeintercept( time, flagname, interceptfunction, debugidentifier )
{
    ent = spawnstruct();
    ent thread donotetracksfortimeendnotify( time );
    donotetracksfortimeproc( &donotetracksforeverintercept, flagname, interceptfunction, debugidentifier, ent );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 5
// Checksum 0x0, Offset: 0x1f85
// Size: 0x3a
function donotetracksfortimeproc( donotetracksforeverfunc, flagname, customfunction, debugidentifier, ent )
{
    ent endon( "stop_notetracks" );
    [[ donotetracksforeverfunc ]]( flagname, undefined, customfunction, debugidentifier );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x1fc7
// Size: 0x15
function donotetracksfortimeendnotify( time )
{
    wait time;
    self notify( "stop_notetracks" );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x1fe4
// Size: 0x2a
function notetrack_prefix_handler( notetrack )
{
    assert( isdefined( level.fnnotetrackprefixhandler ) );
    return [[ level.fnnotetrackprefixhandler ]]( notetrack );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x2017
// Size: 0x1b
function function_8b5c774e7238fec5( guy, notetrack )
{
    function_580423f29d7d5065( notetrack );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 0
// Checksum 0x0, Offset: 0x203a
// Size: 0x7d
function function_6ba70af530538250()
{
    if ( utility::iscp() || utility::ismp() )
    {
        linked_children = self getlinkedchildren();
        
        foreach ( ent in linked_children )
        {
            if ( isplayer( ent ) )
            {
                return ent;
            }
        }
    }
    
    return level.player;
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x20c0
// Size: 0xa9e
function notetrack_prefix_handler_common( notetrack )
{
    prefix3 = getsubstr( notetrack, 0, 3 );
    
    if ( prefix3 == "sm_" )
    {
        model = cleanup_string( getsubstr( notetrack, 3 ) );
        self setmodel( model );
    }
    else if ( prefix3 == "fb_" )
    {
        player = function_6ba70af530538250();
        assertex( isdefined( player ), "<dev string:x15f>" + notetrack );
        fade_data = strtok( notetrack, "_" );
        fade_action = tolower( fade_data[ 1 ] );
        var_3e748cf38c614200 = undefined;
        var_21e5d264c2eefa94 = undefined;
        var_9f075c08a89eab6f = undefined;
        
        if ( fade_action == "to" )
        {
            var_3e748cf38c614200 = float( fade_data[ 2 ] );
        }
        else if ( fade_action == "from" )
        {
            var_9f075c08a89eab6f = float( fade_data[ 2 ] );
        }
        else if ( fade_action == "tofrom" )
        {
            var_3e748cf38c614200 = float( fade_data[ 2 ] );
            var_21e5d264c2eefa94 = float( fade_data[ 3 ] );
            var_9f075c08a89eab6f = float( fade_data[ 4 ] );
        }
        
        player thread function_f74121b03472e19d( var_3e748cf38c614200, var_21e5d264c2eefa94, var_9f075c08a89eab6f );
        return 1;
    }
    else if ( prefix3 == "rm_" )
    {
        player = function_6ba70af530538250();
        assertex( isdefined( player ), "<dev string:x15f>" + notetrack );
        rumble = getsubstr( notetrack, 3 );
        player playrumbleonentity( rumble );
        return 1;
    }
    else if ( prefix3 == "at_" )
    {
        function_fdb7ea91bda694dc( getsubstr( notetrack, 3 ) );
        return 1;
    }
    else if ( prefix3 == "dt_" )
    {
        params = getsubstr( notetrack, 3 );
        
        if ( params == "all" )
        {
            function_78157f1bf846e991();
        }
        else
        {
            function_a06953a984b6a42a( params );
        }
        
        return 1;
    }
    else if ( prefix3 == "ds_" )
    {
        function_45f825a87c104b8e( getsubstr( notetrack, 3 ) );
        return 1;
    }
    else if ( prefix3 == "as_" )
    {
        function_8ecc4b9e8758773e( getsubstr( notetrack, 3 ) );
        return 1;
    }
    else if ( prefix3 == "fs_" )
    {
        flag_set( getsubstr( notetrack, 3 ) );
        return 1;
    }
    else if ( prefix3 == "fc_" )
    {
        flag_clear( getsubstr( notetrack, 3 ) );
        return 1;
    }
    
    prefix4 = getsubstr( notetrack, 0, 4 );
    
    if ( prefix4 == "fsf_" )
    {
        player = function_6ba70af530538250();
        assertex( isdefined( player ), "<dev string:x15f>" + notetrack );
        var_985c64fc7f3f4b6 = strtok( notetrack, "_" );
        var_80698c7167df0cb7 = float( var_985c64fc7f3f4b6[ 1 ] );
        var_19fd165b9d684b3d = float( var_985c64fc7f3f4b6[ 2 ] );
        player lerpfovscalefactor( var_80698c7167df0cb7, var_19fd165b9d684b3d );
        return 1;
    }
    else if ( prefix4 == "rms_" )
    {
        rumble = function_6add3fe5d360337b( notetrack, prefix4 );
        
        if ( rumble == "all" )
        {
            stopallrumbles();
        }
        else
        {
            player = function_6ba70af530538250();
            assertex( isdefined( player ), "<dev string:x15f>" + notetrack );
            player stoprumble( rumble );
        }
        
        return 1;
    }
    else if ( prefix4 == "rml_" )
    {
        player = function_6ba70af530538250();
        assertex( isdefined( player ), "<dev string:x15f>" + notetrack );
        rumble = function_6add3fe5d360337b( notetrack, prefix4 );
        player playrumblelooponentity( rumble );
        return 1;
    }
    else if ( prefix4 == "fov_" )
    {
        player = function_6ba70af530538250();
        assertex( isdefined( player ), "<dev string:x15f>" + notetrack );
        
        if ( !isdefined( player ) )
        {
            return 1;
        }
        
        fov_data = strtok( notetrack, "_" );
        fov_action = tolower( fov_data[ 1 ] );
        fov_value = undefined;
        fov_time = undefined;
        var_4ddc157b83fb4768 = undefined;
        var_d774055d7a1b20db = undefined;
        ease_param_offset = undefined;
        
        if ( fov_action == "start" )
        {
            fov_value = float( fov_data[ 2 ] );
            
            if ( isdefined( fov_data[ 3 ] ) )
            {
                fov_time = float( fov_data[ 3 ] );
            }
            
            ease_param_offset = 4;
        }
        else
        {
            fov_value = 65;
            
            if ( isdefined( fov_data[ 2 ] ) )
            {
                fov_time = float( fov_data[ 2 ] );
            }
            
            ease_param_offset = 3;
        }
        
        var_52f71a00dd433a4a = fov_data[ ease_param_offset ];
        
        if ( isdefined( var_52f71a00dd433a4a ) )
        {
            if ( var_52f71a00dd433a4a == "easein" )
            {
                var_4ddc157b83fb4768 = float( fov_data[ ease_param_offset + 1 ] );
                var_f2cba4268aa5b3c7 = fov_data[ ease_param_offset + 2 ];
                
                if ( isdefined( var_f2cba4268aa5b3c7 ) && var_f2cba4268aa5b3c7 == "easeout" )
                {
                    var_d774055d7a1b20db = float( fov_data[ ease_param_offset + 3 ] );
                }
            }
            else if ( var_52f71a00dd433a4a == "easeout" )
            {
                var_d774055d7a1b20db = float( fov_data[ ease_param_offset + 1 ] );
            }
        }
        
        player modifybasefov( fov_value, fov_time, var_4ddc157b83fb4768, var_d774055d7a1b20db );
        return 1;
    }
    else if ( prefix4 == "dof_" )
    {
        player = function_6ba70af530538250();
        assertex( isdefined( player ), "<dev string:x15f>" + notetrack );
        dof_tokens = strtok( notetrack, "," );
        dof_action = tolower( dof_tokens[ 0 ] );
        
        if ( dof_action == "dof_auto" )
        {
            if ( !isdefined( dof_tokens[ 1 ] ) )
            {
                assertmsg( "<dev string:x182>" + notetrack + "<dev string:x193>" + function_a2eaafb222316a2( self ) + "<dev string:x19c>" );
                return;
            }
            
            fstop = float( dof_tokens[ 1 ] );
            var_f94941fb655b0a39 = function_305541769c1da042( dof_tokens[ 2 ] );
            var_b225076a313507bb = function_305541769c1da042( dof_tokens[ 3 ] );
            player scripts\common\utility::dof_enable_autofocus( fstop, undefined, var_f94941fb655b0a39, var_b225076a313507bb );
        }
        else if ( dof_action == "dof_ent" || dof_action == "dof_ent1" )
        {
            if ( !isdefined( dof_tokens[ 1 ] ) )
            {
                assertmsg( "<dev string:x182>" + notetrack + "<dev string:x193>" + function_a2eaafb222316a2( self ) + "<dev string:x19c>" );
                return;
            }
            
            fstop = float( dof_tokens[ 1 ] );
            var_f94941fb655b0a39 = function_305541769c1da042( dof_tokens[ 2 ] );
            var_b225076a313507bb = function_305541769c1da042( dof_tokens[ 3 ] );
            override_bone = undefined;
            
            if ( isdefined( dof_tokens[ 4 ] ) )
            {
                override_bone = cleanup_string( dof_tokens[ 4 ] );
                
                if ( isdefined( override_bone ) && !self tagexists( override_bone ) )
                {
                    assertmsg( "<dev string:x182>" + notetrack + "<dev string:x193>" + function_a2eaafb222316a2( self ) + "<dev string:x1c5>" );
                    return;
                }
            }
            
            var_d6c219c0784f4dc6 = function_b8ba8f3c8f62ace7( dof_tokens[ 5 ] );
            focus_ent = self;
            
            if ( dof_action == "dof_ent" )
            {
                player scripts\common\utility::dof_enable_autofocus( fstop, focus_ent, var_f94941fb655b0a39, var_b225076a313507bb, undefined, override_bone, undefined, var_d6c219c0784f4dc6, 1 );
            }
            else
            {
                focus_distance = distance( player geteye(), focus_ent.origin );
                player utility::dof_enable( fstop, focus_distance, undefined, var_f94941fb655b0a39, var_b225076a313507bb, undefined, override_bone );
            }
        }
        else if ( dof_action == "dof_distance" || dof_action == "dof_distance1" )
        {
            if ( !isdefined( dof_tokens[ 1 ] ) )
            {
                assertmsg( "<dev string:x182>" + notetrack + "<dev string:x193>" + function_a2eaafb222316a2( self ) + "<dev string:x216>" );
                return;
            }
            
            focus_distance = float( dof_tokens[ 1 ] );
            
            if ( !isdefined( dof_tokens[ 2 ] ) )
            {
                assertmsg( "<dev string:x182>" + notetrack + "<dev string:x193>" + function_a2eaafb222316a2( self ) + "<dev string:x19c>" );
                return;
            }
            
            fstop = float( dof_tokens[ 2 ] );
            var_f94941fb655b0a39 = function_305541769c1da042( dof_tokens[ 3 ] );
            var_b225076a313507bb = function_305541769c1da042( dof_tokens[ 4 ] );
            
            if ( dof_action == "dof_distance" )
            {
                player scripts\common\utility::dof_enable_autofocus( fstop, undefined, var_f94941fb655b0a39, var_b225076a313507bb, undefined, focus_distance, undefined, 1 );
            }
            else
            {
                player utility::dof_enable( fstop, focus_distance, undefined, var_f94941fb655b0a39, var_b225076a313507bb );
            }
        }
        else if ( dof_action == "dof_pos" || dof_action == "dof_pos1" )
        {
            focus_pos = function_71da05b697e393a1( dof_tokens[ 1 ], dof_tokens[ 2 ], dof_tokens[ 3 ] );
            
            if ( !isdefined( focus_pos ) )
            {
                assertmsg( "<dev string:x248>" + notetrack + "<dev string:x193>" + function_a2eaafb222316a2( self ) + "<dev string:x257>" );
                return;
            }
            
            if ( !isdefined( dof_tokens[ 4 ] ) )
            {
                assertmsg( "<dev string:x182>" + notetrack + "<dev string:x193>" + function_a2eaafb222316a2( self ) + "<dev string:x19c>" );
                return;
            }
            
            fstop = float( dof_tokens[ 4 ] );
            var_f94941fb655b0a39 = function_305541769c1da042( dof_tokens[ 5 ] );
            var_b225076a313507bb = function_305541769c1da042( dof_tokens[ 6 ] );
            
            if ( dof_action == "dof_pos" )
            {
                player scripts\common\utility::dof_enable_autofocus( fstop, undefined, var_f94941fb655b0a39, var_b225076a313507bb, undefined, focus_pos, undefined, 1 );
            }
            else
            {
                focus_distance = distance( player geteye(), focus_pos );
                player utility::dof_enable( fstop, focus_distance, undefined, var_f94941fb655b0a39, var_b225076a313507bb, focus_pos );
            }
        }
        else if ( dof_action == "dof_stop" )
        {
            player scripts\common\utility::dof_disable_autofocus();
        }
        else
        {
            assertmsg( "<dev string:x182>" + notetrack + "<dev string:x2cd>" + function_a2eaafb222316a2( self ) + "<dev string:x2d7>" );
        }
        
        return 1;
    }
    
    if ( isstartstr( notetrack, "linkmodel" ) )
    {
        params = getsubstr( notetrack, 10 );
        function_f22b886a2036c871( params );
        return 1;
    }
    else if ( isstartstr( notetrack, "unlinkmodel" ) )
    {
        params = getsubstr( notetrack, 12 );
        
        if ( params == "all" )
        {
            function_b305ad01e100f851();
        }
        else
        {
            function_e5e7e79093ba26ea( params );
        }
        
        return 1;
    }
    else if ( isstartstr( notetrack, "hide" ) )
    {
        params = getsubstr( notetrack, 5 );
        var_78057acea4f71dbc = strtok( params, "," );
        tag = var_78057acea4f71dbc[ 0 ];
        
        if ( isdefined( tag ) )
        {
            if ( utility::issp() )
            {
                if ( isdefined( var_78057acea4f71dbc[ 1 ] ) )
                {
                    self hidepart( tag, var_78057acea4f71dbc[ 1 ] );
                }
                else
                {
                    self hidepart( tag );
                }
            }
        }
        else
        {
            self hide();
        }
        
        return 1;
    }
    else if ( isstartstr( notetrack, "show" ) )
    {
        params = getsubstr( notetrack, 5 );
        var_78057acea4f71dbc = strtok( params, "," );
        tag = var_78057acea4f71dbc[ 0 ];
        
        if ( isdefined( tag ) )
        {
            if ( utility::issp() )
            {
                params = getsubstr( notetrack, 5 );
                var_3750d248dfe18f81 = strtok( params, "," );
                
                if ( isdefined( var_3750d248dfe18f81[ 1 ] ) )
                {
                    self showpart( tag, var_3750d248dfe18f81[ 1 ] );
                }
                else
                {
                    self showpart( tag );
                }
            }
        }
        else
        {
            self show();
        }
        
        return 1;
    }
    
    return 0;
}

// Namespace notetracks / scripts\anim\notetracks
// Params 0
// Checksum 0x0, Offset: 0x2b67
// Size: 0x9f
function shootnotetrack()
{
    waittillframeend();
    
    if ( isdefined( self ) && isalive( self ) && gettime() > self._blackboard.shootparams_lastshoottime )
    {
        if ( istrue( self._blackboard.shootparams_valid ) )
        {
            var_9bc9d0ee2a8a46f5 = self._blackboard.shootparams_shotsperburst == 1;
        }
        else
        {
            var_9bc9d0ee2a8a46f5 = 1;
        }
        
        shootenemywrapper( var_9bc9d0ee2a8a46f5 );
        decrementbulletsinclip();
        
        if ( weaponclass( self.weapon ) == "rocketlauncher" )
        {
            self.rocketammo--;
        }
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x2c0e
// Size: 0x28
function function_df92aadf78bfcf42( note, flagname )
{
    if ( self.bulletsinclip )
    {
        notetrackfire( note, flagname );
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x2c3e
// Size: 0x5a
function notetrackfire( note, flagname )
{
    if ( isdefined( self.script ) && isdefined( anim.fire_notetrack_functions[ self.script ] ) )
    {
        thread [[ anim.fire_notetrack_functions[ self.script ] ]]();
        return;
    }
    
    thread shootnotetrack();
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x2ca0
// Size: 0x1e7
function notetrackfirespray( note, flagname )
{
    if ( !isalive( self ) && self isbadguy() )
    {
        if ( isdefined( self.changed_team ) )
        {
            return;
        }
        
        self.changed_team = 1;
        teams[ "axis" ] = "team3";
        teams[ "team3" ] = "axis";
        assertex( isdefined( teams[ self.team ] ), "<dev string:x366>" + self.team );
        self.team = teams[ self.team ];
    }
    
    if ( !issentient( self ) )
    {
        self notify( "fire" );
        return;
    }
    
    if ( isundefinedweapon( self.a.weaponpos[ "right" ] ) )
    {
        return;
    }
    
    weaporig = self getmuzzlepos();
    dir = anglestoforward( self getmuzzleangle() );
    ang = 10;
    
    if ( isdefined( self.isrambo ) )
    {
        ang = 20;
    }
    
    hitenemy = 0;
    
    if ( isalive( self.enemy ) && issentient( self.enemy ) && self canshootenemy() )
    {
        enemydir = vectornormalize( self.enemy geteye() - weaporig );
        
        if ( vectordot( dir, enemydir ) > cos( ang ) )
        {
            hitenemy = 1;
        }
    }
    
    if ( hitenemy )
    {
        shootenemywrapper();
    }
    else
    {
        dir += ( ( randomfloat( 2 ) - 1 ) * 0.1, ( randomfloat( 2 ) - 1 ) * 0.1, ( randomfloat( 2 ) - 1 ) * 0.1 );
        pos = weaporig + dir * 1000;
        self [[ anim.shootposwrapper_func ]]( pos );
    }
    
    decrementbulletsinclip();
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x2e8f
// Size: 0x1a
function notetrackrefillclip( note, flagname )
{
    scripts\anim\weaponlist::refillclip();
}

// Namespace notetracks / scripts\anim\notetracks
// Params 3
// Checksum 0x0, Offset: 0x2eb1
// Size: 0x49
function notetracknotify( note, flagname, customparams )
{
    player = level.players[ customparams[ 0 ] ];
    
    if ( customparams.size == 3 && isdefined( player ) )
    {
        player notify( customparams[ 2 ] );
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 3
// Checksum 0x0, Offset: 0x2f02
// Size: 0x73
function function_5b7a0a74bd3d5e0b( note, flagname, customparams )
{
    if ( customparams.size == 3 )
    {
        params = strtok( customparams[ 2 ], "," );
        
        if ( params.size >= 1 )
        {
            entitytargetname = params[ 0 ];
            var_f67659ab5e885a58 = getent( entitytargetname, "targetname" );
            
            if ( isdefined( var_f67659ab5e885a58 ) )
            {
                var_f67659ab5e885a58 delete();
            }
        }
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 0
// Checksum 0x0, Offset: 0x2f7d
// Size: 0x6c
function getpreferredweapon()
{
    if ( self._blackboard.weaponrequest == weaponclass( self.primaryweapon ) )
    {
        return self.primaryweapon;
    }
    else if ( self._blackboard.weaponrequest == weaponclass( self.secondaryweapon ) )
    {
        return self.secondaryweapon;
    }
    
    return self.primaryweapon;
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x2ff2
// Size: 0x3b
function notetrackguntochest( note, flagname )
{
    if ( isdefined( self.fnplaceweaponon ) )
    {
        self [[ self.fnplaceweaponon ]]( self.weapon, "chest" );
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x3035
// Size: 0x61
function notetrackguntoback( note, flagname )
{
    if ( isdefined( self.fnplaceweaponon ) )
    {
        self [[ self.fnplaceweaponon ]]( self.weapon, "back" );
    }
    
    self.weapon = getpreferredweapon();
    self.bulletsinclip = weaponclipsize( self.weapon );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x309e
// Size: 0x106
function notetrackpistolpickup( note, flagname )
{
    pistolposition = "right";
    
    if ( !isdefined( self.sidearm ) || isnullweapon( self.sidearm ) || self.weapon == self.sidearm && isdefined( self.a.weaponpos[ pistolposition ] ) && self.a.weaponpos[ pistolposition ] == self.weapon )
    {
        return;
    }
    
    if ( isdefined( self.fnplaceweaponon ) )
    {
        self [[ self.fnplaceweaponon ]]( self.sidearm, pistolposition );
    }
    
    if ( isdefined( self.stowsidearmposition ) )
    {
        self.a.weaponpos[ self.stowsidearmposition ] = undefined;
    }
    
    self.bulletsinclip = weaponclipsize( self.weapon );
    self notify( "weapon_switch_done" );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x31ac
// Size: 0x90
function notetrackpistolputaway( note, flagname )
{
    if ( isdefined( self.fnplaceweaponon ) )
    {
        if ( isdefined( self.stowsidearmposition ) )
        {
            self [[ self.fnplaceweaponon ]]( self.sidearm, self.stowsidearmposition );
        }
        else
        {
            self [[ self.fnplaceweaponon ]]( self.sidearm, "none" );
        }
    }
    
    self.weapon = getpreferredweapon();
    self.bulletsinclip = weaponclipsize( self.weapon );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x3244
// Size: 0xef
function function_c99ec552dfea0f86( note, flagname )
{
    pistolposition = "right";
    assert( isdefined( self.secondaryweapon ) );
    
    if ( !isdefined( self.secondaryweapon ) || isnullweapon( self.secondaryweapon ) || self.weapon == self.secondaryweapon && isdefined( self.a.weaponpos[ pistolposition ] ) && self.a.weaponpos[ pistolposition ] == self.secondaryweapon )
    {
        return;
    }
    
    if ( isdefined( self.fnplaceweaponon ) )
    {
        self [[ self.fnplaceweaponon ]]( self.secondaryweapon, pistolposition );
    }
    
    self.bulletsinclip = weaponclipsize( self.weapon );
    self notify( "weapon_switch_done" );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x333b
// Size: 0x90
function function_316d2ec7583a1e29( note, flagname )
{
    if ( isdefined( self.fnplaceweaponon ) )
    {
        if ( isdefined( self.var_ef50854f0fa381a9 ) )
        {
            self [[ self.fnplaceweaponon ]]( self.secondaryweapon, self.var_ef50854f0fa381a9 );
        }
        else
        {
            self [[ self.fnplaceweaponon ]]( self.secondaryweapon, "none" );
        }
    }
    
    self.weapon = getpreferredweapon();
    self.bulletsinclip = weaponclipsize( self.weapon );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x33d3
// Size: 0x52
function notetrackguntoright( note, flagname )
{
    if ( isdefined( self.fnplaceweaponon ) )
    {
        self [[ self.fnplaceweaponon ]]( self.weapon, "right" );
    }
    
    self.bulletsinclip = weaponclipsize( self.weapon );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x342d
// Size: 0x52
function function_12e1635911fd2716( note, flagname )
{
    if ( isdefined( self.fnplaceweaponon ) )
    {
        self [[ self.fnplaceweaponon ]]( self.weapon, "inhand" );
    }
    
    self.bulletsinclip = weaponclipsize( self.weapon );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x3487
// Size: 0x30
function notetrackhton0( note, flagname )
{
    if ( !isai( self ) )
    {
        return;
    }
    
    if ( !self isinscriptedstate() )
    {
        self enablestatelookat( 1, 0 );
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x34bf
// Size: 0x31
function notetrackhton1( note, flagname )
{
    if ( !isai( self ) )
    {
        return;
    }
    
    if ( !self isinscriptedstate() )
    {
        self enablestatelookat( 1, 1 );
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x34f8
// Size: 0x2e
function notetrackhtoff( note, flagname )
{
    if ( !isai( self ) )
    {
        return;
    }
    
    if ( !self isinscriptedstate() )
    {
        self enablestatelookat( 0 );
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x352e
// Size: 0x41
function function_5a8f2c4ba78d7bff( note, flagname )
{
    if ( isai( self ) )
    {
        self setlookatstate( "request" );
        
        if ( utility::issp() )
        {
            self function_5621e511b99964a7( level.player );
        }
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x3577
// Size: 0x2f
function function_ab37da002eddaf9f( note, flagname )
{
    if ( isai( self ) )
    {
        self setlookatstate( "request" );
        self function_504a5e2df31069a4();
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x35ae
// Size: 0x2f
function function_b67df3617c4f2903( note, flagname )
{
    if ( isai( self ) )
    {
        self setlookatstate( "prohibit" );
        self setlookatentity();
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x35e5
// Size: 0x2d
function function_28b89c4ec5292326( note, flagname )
{
    if ( isai( self ) )
    {
        self asmfireevent( self.asmname, note );
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x361a
// Size: 0x2e
function function_1777a8463e80f52e( note, flagname )
{
    if ( isdefined( self.var_9087e842f157d27c ) )
    {
        return [[ self.var_9087e842f157d27c ]]( note, flagname );
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x3650
// Size: 0x1eb
function function_6b6fe2ba8bff11cd( var_bed488ee5acfc2b9 )
{
    info = strtok( var_bed488ee5acfc2b9, ",", 1 );
    model = info[ 0 ];
    tag = info[ 1 ];
    boolstring = info[ 2 ];
    var_14ee0603c207e865 = info[ 3 ];
    var_14ee0503c207e632 = info[ 4 ];
    var_14ee0403c207e3ff = info[ 5 ];
    var_ed521c3c847b0289 = info[ 6 ];
    var_8884c57621afac10 = info[ 7 ];
    var_832509d239257e56 = info[ 8 ];
    
    if ( !isdefined( model ) )
    {
        return [ undefined, undefined, undefined, undefined, undefined ];
    }
    
    if ( isdefined( level.fnnotetrackmodeltranslate ) )
    {
        model = [[ level.fnnotetrackmodeltranslate ]]( model );
    }
    
    if ( isdefined( model ) )
    {
        model = cleanup_string( model );
    }
    
    if ( isdefined( tag ) )
    {
        tag = cleanup_string( tag );
    }
    
    var_ee3807ab9a6a9c73 = function_b8ba8f3c8f62ace7( boolstring );
    offs_pos = function_71da05b697e393a1( var_14ee0603c207e865, var_14ee0503c207e632, var_14ee0403c207e3ff );
    offs_ang = function_71da05b697e393a1( var_ed521c3c847b0289, var_8884c57621afac10, var_832509d239257e56 );
    
    if ( !isdefined( tag ) || tag == "" )
    {
        tag = "";
    }
    else if ( isent( self ) && !self tagexists( tag ) )
    {
        assertmsg( "<dev string:x182>" + var_bed488ee5acfc2b9 + "<dev string:x193>" + function_a2eaafb222316a2( self ) + "<dev string:x376>" + tag + "<dev string:x38f>" );
        return undefined;
    }
    
    if ( !isdefined( model ) )
    {
        assertmsg( "<dev string:x182>" + var_bed488ee5acfc2b9 + "<dev string:x193>" + function_a2eaafb222316a2( self ) + "<dev string:x3ce>" );
        return undefined;
    }
    
    return [ model, tag, var_ee3807ab9a6a9c73, offs_pos, offs_ang ];
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x3844
// Size: 0xa7
function function_fdb7ea91bda694dc( attachinfo )
{
    [ model, tag, var_ee3807ab9a6a9c73 ] = function_6b6fe2ba8bff11cd( attachinfo );
    
    if ( isdefined( self.notetrackattach ) && isdefined( self.notetrackattach[ tag ] ) )
    {
        function_bccbbce06002296d( tag );
    }
    
    if ( model != "none" && model != "" )
    {
        self attach( model, tag, 1 );
        self.notetrackattach[ tag ] = model;
        self.var_da5fb6e1939953ca[ tag ] = var_ee3807ab9a6a9c73;
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x38f3
// Size: 0x15b
function function_f22b886a2036c871( attachinfo )
{
    [ model, tag, var_ee3807ab9a6a9c73, offs_org, offs_ang ] = function_6b6fe2ba8bff11cd( attachinfo );
    
    if ( isdefined( self.var_42d97b626fd6d9cf ) && isdefined( self.var_42d97b626fd6d9cf[ tag ] ) )
    {
        function_ef14ac1aa72b102c( tag );
    }
    
    spawned = undefined;
    
    if ( model != "none" && model != "" )
    {
        spawned = spawn( "script_model", self.origin );
        spawned setmodel( model );
        
        if ( !isdefined( offs_org ) )
        {
            offs_org = ( 0, 0, 0 );
        }
        
        if ( !isdefined( offs_ang ) )
        {
            offs_ang = ( 0, 0, 0 );
        }
        
        tagactual = tag;
        
        if ( tagactual == "" )
        {
            tagactual = spawned function_557f8f6e8a4de1af( 0 );
            
            if ( !self tagexists( tagactual ) )
            {
                tagactual = self function_557f8f6e8a4de1af( 0 );
            }
        }
        
        spawned linkto( self, tagactual, offs_org, offs_ang );
        self.var_42d97b626fd6d9cf[ tag ] = spawned;
        self.var_f97c1baea165488c[ tag ] = var_ee3807ab9a6a9c73;
        script_func( "notetrack_linkmodel_callback", spawned );
    }
    
    return spawned;
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x3a57
// Size: 0x6b
function function_a06953a984b6a42a( attachinfo )
{
    [ model, tag ] = function_6b6fe2ba8bff11cd( attachinfo );
    
    if ( isdefined( self.notetrackattach ) && isdefined( self.notetrackattach[ tag ] ) )
    {
        function_bccbbce06002296d( tag );
        return;
    }
    
    self detach( model, tag );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3aca
// Size: 0x34
function private function_bccbbce06002296d( tag )
{
    self detach( self.notetrackattach[ tag ], tag );
    self.notetrackattach[ tag ] = undefined;
    self.var_da5fb6e1939953ca[ tag ] = undefined;
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x3b06
// Size: 0xdd
function function_e5e7e79093ba26ea( attachinfo )
{
    [ model, tag ] = function_6b6fe2ba8bff11cd( attachinfo );
    
    if ( isdefined( self.var_42d97b626fd6d9cf ) && isdefined( self.var_42d97b626fd6d9cf[ tag ] ) )
    {
        function_ef14ac1aa72b102c( tag );
        return;
    }
    
    children = self getlinkedchildren();
    
    foreach ( child in children )
    {
        if ( isdefined( child.model ) && child.model == model )
        {
            child delete();
        }
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3beb
// Size: 0x32
function private function_ef14ac1aa72b102c( tag )
{
    self.var_42d97b626fd6d9cf[ tag ] delete();
    self.var_42d97b626fd6d9cf[ tag ] = undefined;
    self.var_f97c1baea165488c[ tag ] = undefined;
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x3c25
// Size: 0xa5
function function_45f825a87c104b8e( attachinfo )
{
    [ modelname, tag ] = function_6b6fe2ba8bff11cd( attachinfo );
    model = spawn( "script_model", self gettagorigin( tag ) );
    model.angles = self gettagangles( tag );
    model setmodel( modelname );
    
    if ( !isdefined( self.var_1fec75f88c15aed8 ) )
    {
        self.var_1fec75f88c15aed8 = [];
    }
    
    self.var_1fec75f88c15aed8[ self.var_1fec75f88c15aed8.size ] = model;
    function_a06953a984b6a42a( attachinfo );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x3cd2
// Size: 0x91
function function_8ecc4b9e8758773e( info )
{
    info = strtok( info, "," );
    tag = info[ 0 ];
    index = self.var_1fec75f88c15aed8.size - 1;
    ent = self.var_1fec75f88c15aed8[ index ];
    self.var_1fec75f88c15aed8[ index ] = undefined;
    self attach( ent.model, tag, 1 );
    self.notetrackattach[ tag ] = ent.model;
    ent delete();
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x3d6b
// Size: 0xb5
function function_78157f1bf846e991( var_9d5f59d543dcaaab )
{
    if ( isdefined( self.notetrackattach ) )
    {
        tags = getarraykeys( self.notetrackattach );
        
        foreach ( tag in tags )
        {
            if ( !istrue( var_9d5f59d543dcaaab ) || istrue( self.var_da5fb6e1939953ca[ tag ] ) )
            {
                function_bccbbce06002296d( tag );
            }
        }
        
        if ( self.notetrackattach.size == 0 )
        {
            self.notetrackattach = undefined;
            self.var_da5fb6e1939953ca = undefined;
        }
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x3e28
// Size: 0xb5
function function_b305ad01e100f851( var_9d5f59d543dcaaab )
{
    if ( isdefined( self.var_42d97b626fd6d9cf ) )
    {
        tags = getarraykeys( self.var_42d97b626fd6d9cf );
        
        foreach ( tag in tags )
        {
            if ( !istrue( var_9d5f59d543dcaaab ) || istrue( self.var_f97c1baea165488c[ tag ] ) )
            {
                function_ef14ac1aa72b102c( tag );
            }
        }
        
        if ( self.var_42d97b626fd6d9cf.size == 0 )
        {
            self.var_42d97b626fd6d9cf = undefined;
            self.var_f97c1baea165488c = undefined;
        }
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x3ee5
// Size: 0x1d
function function_580423f29d7d5065( note )
{
    function_78157f1bf846e991( 1 );
    function_b305ad01e100f851( 1 );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 3
// Checksum 0x0, Offset: 0x3f0a
// Size: 0x3c
function function_f74121b03472e19d( var_3e748cf38c614200, var_21e5d264c2eefa94, var_9f075c08a89eab6f )
{
    if ( isdefined( var_3e748cf38c614200 ) )
    {
        fadetoblack( var_3e748cf38c614200 );
    }
    
    if ( isdefined( var_21e5d264c2eefa94 ) )
    {
        wait var_21e5d264c2eefa94;
    }
    
    if ( isdefined( var_9f075c08a89eab6f ) )
    {
        fadefromblack( var_9f075c08a89eab6f );
    }
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x3f4e
// Size: 0x100
function fadetoblack( fadetime )
{
    self notify( "do_fade_from_black" );
    self notify( "do_fade_to_black" );
    self endon( "do_fade_to_black" );
    
    if ( !isdefined( self.var_6eb3b97622fc45cd ) )
    {
        self.var_6eb3b97622fc45cd = newclienthudelem( self );
        self.var_6eb3b97622fc45cd setshader( "black", 640, 480 );
        self.var_6eb3b97622fc45cd.sort = 1;
        self.var_6eb3b97622fc45cd.horzalign = "fullscreen";
        self.var_6eb3b97622fc45cd.vertalign = "fullscreen";
        self.var_6eb3b97622fc45cd.foreground = 1;
    }
    
    if ( fadetime > 0 )
    {
        self.var_6eb3b97622fc45cd.alpha = 0;
        self.var_6eb3b97622fc45cd fadeovertime( fadetime );
    }
    
    self.var_6eb3b97622fc45cd.alpha = 1;
    wait fadetime;
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x4056
// Size: 0x10f
function fadefromblack( fadetime )
{
    self notify( "do_fade_from_black" );
    self notify( "do_fade_to_black" );
    self endon( "do_fade_from_black" );
    
    if ( !isdefined( self.var_6eb3b97622fc45cd ) )
    {
        self.var_6eb3b97622fc45cd = newclienthudelem( self );
        self.var_6eb3b97622fc45cd setshader( "black", 640, 480 );
        self.var_6eb3b97622fc45cd.sort = 1;
        self.var_6eb3b97622fc45cd.horzalign = "fullscreen";
        self.var_6eb3b97622fc45cd.vertalign = "fullscreen";
        self.var_6eb3b97622fc45cd.foreground = 1;
    }
    
    if ( fadetime > 0 )
    {
        self.var_6eb3b97622fc45cd.alpha = 1;
        self.var_6eb3b97622fc45cd fadeovertime( fadetime );
    }
    
    self.var_6eb3b97622fc45cd.alpha = 0;
    wait fadetime;
    self.var_6eb3b97622fc45cd destroy();
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x416d
// Size: 0x4f
function function_305541769c1da042( numberstring )
{
    if ( isdefined( numberstring ) )
    {
        numberstring = cleanup_string( numberstring );
        
        if ( isstartstr( numberstring, "undef" ) )
        {
            return undefined;
        }
        
        time = float( numberstring );
        magic_time = utility::function_32fd8e6a43da67b8( time );
        return magic_time;
    }
    
    return undefined;
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x41c5
// Size: 0x3d
function function_b8ba8f3c8f62ace7( boolstring )
{
    if ( isdefined( boolstring ) )
    {
        boolstring = tolower( boolstring );
        
        if ( issubstr( boolstring, "f" ) )
        {
            return 0;
        }
        else if ( issubstr( boolstring, "t" ) )
        {
            return 1;
        }
    }
    
    return undefined;
}

// Namespace notetracks / scripts\anim\notetracks
// Params 3
// Checksum 0x0, Offset: 0x420b
// Size: 0x4e
function function_71da05b697e393a1( stringx, stringy, stringz )
{
    if ( isdefined( stringx ) && isdefined( stringy ) && isdefined( stringz ) )
    {
        vector = ( float( stringx ), float( stringy ), float( stringz ) );
        return vector;
    }
    
    return undefined;
}

// Namespace notetracks / scripts\anim\notetracks
// Params 1
// Checksum 0x0, Offset: 0x4262
// Size: 0x59
function cleanup_string( string )
{
    string = tolower( string );
    len = string.size;
    
    if ( isstartstr( string, " " ) || isendstr( string, " " ) )
    {
        [ string ] = strtok( string, " " );
    }
    
    return string;
}

// Namespace notetracks / scripts\anim\notetracks
// Params 2
// Checksum 0x0, Offset: 0x42c4
// Size: 0x1b
function function_6add3fe5d360337b( notetrack, note_prefix )
{
    return getsubstr( notetrack, note_prefix.size );
}

// Namespace notetracks / scripts\anim\notetracks
// Params 0
// Checksum 0x0, Offset: 0x42e8
// Size: 0x2ad
function function_1f7bb66025f2aedf()
{
    if ( !issp() )
    {
        return;
    }
    
    waittillframeend();
    
    if ( !isdefined( level.scr_anim ) )
    {
        return;
    }
    
    var_2076c164305ff2a6[ 0 ] = "at_";
    var_2076c164305ff2a6[ 1 ] = "linkmodel_";
    var_2076c164305ff2a6[ 2 ] = "sm_";
    var_2076c164305ff2a6[ 3 ] = "dt_";
    var_2076c164305ff2a6[ 4 ] = "unlinkmodel_";
    var_e681aa5d14129651[ 0 ] = "rm_";
    var_e681aa5d14129651[ 1 ] = "rml_";
    var_e681aa5d14129651[ 2 ] = "rms_";
    prefix_array = array_combine( var_2076c164305ff2a6, var_e681aa5d14129651 );
    
    foreach ( var_5452e6acec0818e1 in level.scr_anim )
    {
        foreach ( var_b0051352d1332656 in var_5452e6acec0818e1 )
        {
            if ( !isarray( var_b0051352d1332656 ) )
            {
                var_b0051352d1332656 = [ var_b0051352d1332656 ];
            }
            
            foreach ( animation in var_b0051352d1332656 )
            {
                foreach ( note_prefix in prefix_array )
                {
                    if ( !isanimation( animation ) )
                    {
                        continue;
                    }
                    
                    searchresults = getnotetracks( animation, note_prefix, 1 );
                    
                    foreach ( result in searchresults )
                    {
                        if ( isstartstr( note_prefix, "rm" ) )
                        {
                            rumble = function_6add3fe5d360337b( result[ "name" ], note_prefix );
                            
                            if ( isdefined( rumble ) )
                            {
                                precacherumble( rumble );
                            }
                            
                            continue;
                        }
                        
                        notetrack_substring = getsubstr( result[ "name" ], note_prefix.size );
                        [ model, tag ] = function_6b6fe2ba8bff11cd( notetrack_substring );
                        
                        if ( isdefined( model ) )
                        {
                            if ( model != "all" )
                            {
                                precachemodel( model );
                            }
                        }
                    }
                }
            }
        }
    }
}

