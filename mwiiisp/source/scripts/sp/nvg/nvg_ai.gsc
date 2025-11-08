#using scripts\anim\shared;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\utility;
#using scripts\stealth\debug;

#namespace nvg_ai;

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x202
// Size: 0xc5
function nvg_ai_init()
{
    ai = getaiarray();
    
    foreach ( guy in ai )
    {
        guy thread nvg_ai();
    }
    
    add_global_spawn_function( "axis", &nvg_ai );
    add_global_spawn_function( "allies", &nvg_ai );
    add_global_spawn_function( "neutral", &nvg_ai );
    
    /#
        setdvarifuninitialized( @"hash_4249b712406badc9", 0 );
        thread function_94e2c55578304a2();
    #/
    
    array_thread( getentarray( "dynolight_area", "targetname" ), &dynolight_area_trigger_logic );
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x2cf
// Size: 0x25
function nvg_ai()
{
    self endon( "death" );
    wait 0.05;
    local_init();
    ai_nvg_player_update();
    thread nvg_death_cleanup();
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 1
// Checksum 0x0, Offset: 0x2fc
// Size: 0xb
function do_flir_footsteps( vfx_override )
{
    
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x30f
// Size: 0x2
function dont_do_flir_footsteps()
{
    
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x319
// Size: 0x33
function local_init()
{
    ent_flag_init( "react_to_dynolights" );
    ent_flag_init( "in_the_dark" );
    
    if ( istrue( level.is_dark ) )
    {
        ent_flag_set( "in_the_dark" );
    }
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x354
// Size: 0x41
function ai_nvg_player_update()
{
    if ( !should_update_ai_nvg_state() )
    {
        return;
    }
    
    nvg_state = level.player isnightvisionon();
    
    if ( isdefined( self.custom_nvg_update_func ) )
    {
        self thread [[ self.custom_nvg_update_func ]]( nvg_state );
    }
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x39d
// Size: 0x18, Type: bool
function should_update_ai_nvg_state()
{
    if ( self.classname == "script_vehicle_blackhornet" )
    {
        return false;
    }
    
    return true;
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x3be
// Size: 0x5a
function dynolight_area_trigger_logic()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "trigger", whom );
        
        if ( !isai( whom ) )
        {
            continue;
        }
        
        if ( !isdefined( whom.in_dynolight_trigger ) && !isdefined( whom.nvg_goggles ) )
        {
            whom childthread dynolight_area_ai( self );
        }
    }
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 1
// Checksum 0x0, Offset: 0x420
// Size: 0x3e
function dynolight_area_ai( trigger )
{
    self endon( "death" );
    self.in_dynolight_trigger = trigger;
    thread enable_ai_dynolight_behavior();
    
    while ( self istouching( trigger ) )
    {
        wait 0.05;
    }
    
    disable_ai_dynolight_behavior();
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x466
// Size: 0xe
function enable_ai_dynolight_behavior()
{
    ent_flag_set( "react_to_dynolights" );
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x47c
// Size: 0x5fa
function updatelightmeter()
{
    if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() && !istrue( self.reacttodynolightsinhunt ) )
    {
        self.lightmeter = undefined;
        return;
    }
    
    if ( distancesquared( self.origin, level.player.origin ) > 4000000 )
    {
        return;
    }
    
    if ( !isdefined( level.castingdynolights ) || level.castingdynolights.size == 0 )
    {
        self.lightmeter = ter_op( istrue( level.is_dark ), 0, 1 );
        return;
    }
    
    curtime = gettime();
    
    if ( !isdefined( level.lastdynolightcleantime ) || curtime == level.lastdynolightcleantime )
    {
        level.castingdynolights = array_removeundefined( level.castingdynolights );
        level.lastdynolightcleantime = curtime;
    }
    
    mylights = sortbydistance( level.castingdynolights, self.origin );
    myeyepos = self getapproxeyepos();
    var_3db0657c6e27055b = 9999999;
    
    if ( isdefined( self.lightmeter_lastcheckpos ) )
    {
        var_3db0657c6e27055b = distancesquared( self.lightmeter_lastcheckpos, self.origin );
    }
    
    if ( !isdefined( self.lightmeter_lastchecktime ) )
    {
        self.lightmeter_lastchecktime = -1000;
    }
    
    lightstocheck = [];
    distsqtocheck = [];
    radiitocheck = [];
    var_ffa6a55a441d9138 = var_3db0657c6e27055b > 900;
    cmaxdistsq = 998001;
    numlights = mylights.size;
    
    for ( ilight = 0; ilight < numlights ; ilight++ )
    {
        dynolight = mylights[ ilight ];
        dist_sq = distancesquared( myeyepos, dynolight.origin );
        
        if ( dist_sq > cmaxdistsq )
        {
            break;
        }
        
        if ( !var_ffa6a55a441d9138 && dynolight.timeoflaststatechange >= self.lightmeter_lastchecktime )
        {
            var_ffa6a55a441d9138 = 1;
        }
        
        if ( !dynolight.alive )
        {
            continue;
        }
        
        if ( dynolight getscriptablepartstate( "onoff" ) == "off" )
        {
            continue;
        }
        
        radiustocheck = 650;
        
        if ( isdefined( dynolight.data ) )
        {
            if ( istrue( dynolight.data.script_ignoreme ) )
            {
                continue;
            }
            
            if ( istrue( dynolight.data.script_radius ) )
            {
                radiustocheck = dynolight.data.script_radius;
                
                if ( dist_sq > radiustocheck * radiustocheck )
                {
                    continue;
                }
            }
            
            if ( is_equal( dynolight.data.script_type, "light_spot" ) )
            {
                /#
                    if ( getdvarint( @"hash_4249b712406badc9" ) )
                    {
                        dynolight draw_spotlight_fov();
                    }
                #/
                
                fov = dynolight.data.script_fov_inner;
                angles = dynolight.data.angles;
                start = dynolight.lightpos;
                
                if ( !within_fov( start, angles, myeyepos, cos( fov ) ) )
                {
                    continue;
                }
            }
        }
        
        if ( !dynolight istouching( self.in_dynolight_trigger ) )
        {
            continue;
        }
        
        var_4d1fb8faeda31cd6 = lightstocheck.size;
        lightstocheck[ var_4d1fb8faeda31cd6 ] = dynolight;
        radiitocheck[ var_4d1fb8faeda31cd6 ] = radiustocheck;
        distsqtocheck[ var_4d1fb8faeda31cd6 ] = dist_sq;
    }
    
    if ( var_ffa6a55a441d9138 )
    {
        var_c544587b4f919b5c = 0;
        tracedata = spawnstruct();
        disttogoal = self pathdisttogoal();
        var_46ffbdd31c409329 = 32;
        tracedata.bmoving = lengthsquared( self.velocity ) > 1 || disttogoal > var_46ffbdd31c409329;
        eyeoffset = self getapproxeyepos() - self.origin;
        
        if ( tracedata.bmoving )
        {
            tracedata.pointsonpath = [];
            tracedata.pointsonpath[ 0 ] = self.origin + eyeoffset;
            tracedata.pointsonpath[ 1 ] = self getposonpath( var_46ffbdd31c409329 ) + eyeoffset;
            
            if ( disttogoal > var_46ffbdd31c409329 * 2 )
            {
                tracedata.pointsonpath[ 2 ] = self getposonpath( var_46ffbdd31c409329 * 2 ) + eyeoffset;
            }
        }
        
        numlights = lightstocheck.size;
        
        for ( ilight = 0; ilight < numlights ; ilight++ )
        {
            dynolight = lightstocheck[ ilight ];
            dist = sqrt( distsqtocheck[ ilight ] );
            radiustocheck = radiitocheck[ ilight ];
            falloff_dist = 0;
            
            if ( isdefined( dynolight.data ) && isdefined( dynolight.data.script_percent ) )
            {
                falloff_dist = dynolight.data.script_percent;
            }
            else if ( isdefined( level.dynolight_falloff_dist ) )
            {
                falloff_dist = level.dynolight_falloff_dist;
            }
            
            light_factor = ( 1 - math::normalize_value( radiustocheck * falloff_dist, radiustocheck, dist ) ) * dynolight.intensity;
            
            if ( !dynolight_trace_passed( dynolight, tracedata ) )
            {
                continue;
            }
            
            var_c544587b4f919b5c += light_factor;
            
            /#
                if ( getdvarint( @"hash_4249b712406badc9" ) )
                {
                    line( dynolight.lightpos, self.origin, ( light_factor, light_factor, light_factor ), 1, 0, 10 );
                }
            #/
            
            if ( var_c544587b4f919b5c > 0.5 )
            {
                break;
            }
        }
        
        self.lightmeter = var_c544587b4f919b5c;
        self.lightmeter_lastchecktime = gettime();
        self.lightmeter_lastcheckpos = self.origin;
    }
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 2
// Checksum 0x0, Offset: 0xa7e
// Size: 0x14e
function dynolight_trace_passed( dynolight, tracedata )
{
    ignorearray = [ level.player ];
    
    if ( isdefined( dynolight.linked_ents ) )
    {
        ignorearray = array_combine( ignorearray, dynolight.linked_ents );
    }
    
    if ( istrue( tracedata.bmoving ) )
    {
        ignorearray = array_combine( ignorearray, [ dynolight, self ] );
        assert( isdefined( tracedata.pointsonpath ) );
        var_e47e37dbc6d59dfe = tracedata.pointsonpath.size;
        
        for ( i = 0; i < var_e47e37dbc6d59dfe ; i++ )
        {
            pathpos = tracedata.pointsonpath[ i ];
            
            if ( ray_trace_passed( dynolight.lightpos, pathpos, ignorearray, level.dynolight_trace_contents ) )
            {
                /#
                    if ( getdvarint( @"hash_4249b712406badc9" ) && i != 0 )
                    {
                        line( dynolight.lightpos, pathpos, ( 0, 1, 0.5 ), 1, 0, 20 );
                    }
                #/
                
                return 1;
            }
        }
        
        return 0;
    }
    
    return dynolight can_trace_to_ai( dynolight.lightpos, self, ignorearray, level.dynolight_trace_contents );
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0xbd5
// Size: 0x35, Type: bool
function is_gun_raised()
{
    if ( isnullweapon( self.weapon ) )
    {
        return false;
    }
    
    return self gettagorigin( "tag_eye" )[ 2 ] - self gettagorigin( "tag_flash" )[ 2 ] <= 15;
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0xc13
// Size: 0x10b
function draw_spotlight_fov()
{
    fov_yaw = acos( cos( self.data.script_fov_inner ) );
    eye_yaw = self.data.angles[ 1 ];
    pitch = self.data.angles[ 0 ];
    color = ( 1, 0, 0 );
    viewdist = self.data.script_radius;
    start = self.lightpos;
    arc_segs = 10;
    
    /#
        if ( abs( pitch - 90 ) < 1 )
        {
            thread draw_circle( start, viewdist, ( 1, 0, 0 ), 1, 0, 4 );
            return;
        }
        
        scripts\stealth\debug::draw_arc( start, -1 * fov_yaw, fov_yaw, ( pitch, eye_yaw, 0 ), viewdist, 1, arc_segs, color );
    #/
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0xd26
// Size: 0xa8
function draw_flashlight_fov()
{
    dot = cos( 30 );
    color = ( 1, 0, 0 );
    fov_yaw = acos( dot );
    eye_yaw = self gettagangles( "tag_flash" )[ 1 ];
    viewdist = 500;
    start = self gettagorigin( "tag_flash" );
    arc_segs = 10;
    
    /#
        scripts\stealth\debug::draw_arc( start, -1 * fov_yaw, fov_yaw, self gettagangles( "<dev string:x1c>" ), viewdist, 1, arc_segs, color );
    #/
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0xdd6
// Size: 0x6d
function disable_ai_dynolight_behavior()
{
    self.in_dynolight_trigger = undefined;
    self.lightmeter = undefined;
    self.maxsightdistsqrd = 67108864;
    level.player.dontmeleeme = 0;
    ent_flag_clear( "react_to_dynolights" );
    
    if ( istrue( level.is_dark ) )
    {
        ent_flag_set( "in_the_dark" );
        return;
    }
    
    ent_flag_clear( "in_the_dark" );
}

/#

    // Namespace nvg_ai / scripts\sp\nvg\nvg_ai
    // Params 0
    // Checksum 0x0, Offset: 0xe4b
    // Size: 0x247, Type: dev
    function function_94e2c55578304a2()
    {
        answer = "<dev string:x26>";
        
        while ( true )
        {
            foreach ( guy in getaiarray() )
            {
                if ( isdefined( guy.lightmeter ) && guy ent_flag_exist( "<dev string:x27>" ) )
                {
                    num = guy getentitynumber();
                    answer = ter_op( guy.lightmeter < 0.5, "<dev string:x3b>", "<dev string:x3f>" );
                    
                    if ( getdvarint( @"hash_4249b712406badc9" ) )
                    {
                        print3d( guy.origin + ( 0, 0, 85 ), "<dev string:x42>" + num + "<dev string:x47>" + distance2d( guy.origin, level.player.origin ), ( 1, 1, 1 ), 1, 0.6, 1 );
                        print3d( guy.origin + ( 0, 0, 78 ), "<dev string:x42>" + num + "<dev string:x59>" + sqrt( guy.maxsightdistsqrd ), ( 1, 1, 1 ), 1, 0.6, 1 );
                        print3d( guy.origin + ( 0, 0, 71 ), "<dev string:x42>" + num + "<dev string:x69>" + guy.lightmeter, ( guy.lightmeter, guy.lightmeter, guy.lightmeter ), 1, 0.6, 1 );
                        print3d( guy.origin + ( 0, 0, 64 ), "<dev string:x78>" + answer, ( 1, 1, 1 ), 1, 0.6, 1 );
                        
                        if ( istrue( guy.flashlight ) && guy is_gun_raised() )
                        {
                            guy thread draw_flashlight_fov();
                        }
                    }
                }
            }
            
            wait 0.05;
        }
    }

#/

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x109a
// Size: 0x21
function nvg_death_cleanup()
{
    self waittill( "death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( is_using_flashlight() )
    {
        kill_flashlight_fx( 0 );
    }
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 1
// Checksum 0x0, Offset: 0x10c3
// Size: 0x4d
function flashlight_on( bsafe )
{
    if ( !can_use_flashlight() )
    {
        return;
    }
    
    if ( is_using_flashlight() )
    {
        return;
    }
    
    function_d73f1b97acba6597();
    self.flashlight = 1;
    play_flashlight_fx( bsafe );
    
    if ( isdefined( self.flashlightlaserweapon ) )
    {
        flashlight_laser_on();
    }
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x1118
// Size: 0x125
function function_d73f1b97acba6597()
{
    attachments_names = [ "flashlight_box01", "flashlight_cyl01", "flashlight_pstl01" ];
    currweapon = self.weapon;
    newweapon = undefined;
    
    foreach ( attachment_name in attachments_names )
    {
        if ( currweapon canuseattachment( attachment_name ) )
        {
            newweapon = currweapon withattachment( attachment_name );
            self.flashlight_attachment = attachment_name;
            break;
        }
    }
    
    if ( !isdefined( newweapon ) )
    {
        return;
    }
    
    slot = "primary";
    
    if ( self.secondaryweapon == currweapon )
    {
        slot = "secondary";
    }
    
    if ( self.lastweapon == currweapon )
    {
        self.lastweapon = newweapon;
    }
    
    self.flashlightfxtag = "tag_laser";
    self.flashlightfxoverridetag = "tag_laser";
    self.flashlight_slot = slot;
    scripts\anim\shared::detachweapon( currweapon );
    scripts\anim\shared::forceuseweapon( newweapon, slot );
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 1
// Checksum 0x0, Offset: 0x1245
// Size: 0x3b
function flashlight_off( bsafe )
{
    if ( !is_using_flashlight() )
    {
        return;
    }
    
    self.flashlight = 0;
    kill_flashlight_fx( bsafe );
    
    if ( isdefined( self.flashlightlaserweapon ) )
    {
        flashlight_laser_off();
    }
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x1288
// Size: 0x92
function flashlight_laser_on()
{
    if ( isdefined( self.flashlightlaser ) )
    {
        return;
    }
    
    laser = spawn( "script_model", ( 0, 0, 0 ) );
    laser linkto( self, self.flashlightfxtag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    laser setmodel( "tag_laser" );
    laser setmoverlaserweapon( self.flashlightlaserweapon );
    laser laserforceon();
    self.flashlightlaser = laser;
    thread flashlight_laser_cleanup();
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x1322
// Size: 0x2f
function flashlight_laser_cleanup()
{
    self endon( "flashlight_laser_off" );
    self waittill( "death" );
    self.flashlightlaser laserforceoff();
    self.flashlightlaser delete();
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x1359
// Size: 0x40
function flashlight_laser_off()
{
    if ( !isdefined( self.flashlightlaser ) )
    {
        return;
    }
    
    self notify( "flashlight_laser_off" );
    self.flashlightlaser laserforceoff();
    self.flashlightlaser delete();
    self.flashlightlaser = undefined;
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 1
// Checksum 0x0, Offset: 0x13a1
// Size: 0xbb
function play_flashlight_fx( bsafe )
{
    tag = "tag_flash";
    
    if ( isdefined( self.flashlightfxoverridetag ) )
    {
        tag = self.flashlightfxoverridetag;
    }
    
    fx = "npc_flashlight";
    
    if ( isdefined( self.flashlightfxoverride ) )
    {
        fx = self.flashlightfxoverride;
    }
    
    self.flashlightfx = fx;
    self.flashlightfxtag = tag;
    
    if ( !isdefined( bsafe ) )
    {
        bsafe = 1;
    }
    
    if ( bsafe )
    {
        fx_playontag_safe( self.flashlightfx, self.flashlightfxtag, undefined, undefined, 1 );
        return;
    }
    
    playfxontag( getfx( self.flashlightfx ), self, self.flashlightfxtag );
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 1
// Checksum 0x0, Offset: 0x1464
// Size: 0xd6
function kill_flashlight_fx( bsafe )
{
    if ( !isdefined( self.flashlightfxtag ) || self.flashlightfxtag == "tag_flash" || self.flashlightfxtag == "tag_laser" )
    {
        if ( isnullweapon( self.weapon ) )
        {
            return;
        }
    }
    
    if ( isdefined( self.flashlightfx ) )
    {
        tag = "tag_flash";
        
        if ( isdefined( self.flashlightfxtag ) )
        {
            tag = self.flashlightfxtag;
        }
        
        if ( !isdefined( bsafe ) )
        {
            bsafe = 1;
        }
        
        if ( bsafe )
        {
            fx_killontag_safe( self.flashlightfx, tag, undefined, undefined, 1 );
        }
        else
        {
            killfxontag( getfx( self.flashlightfx ), self, tag );
        }
    }
    
    self.flashlightfx = undefined;
    self.flashlightfxtag = undefined;
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x1542
// Size: 0x17
function is_using_flashlight()
{
    if ( istrue( self.flashlight ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x1561
// Size: 0x17
function is_using_nvg()
{
    if ( istrue( self.nvg ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace nvg_ai / scripts\sp\nvg\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x1580
// Size: 0x6a, Type: bool
function can_use_flashlight()
{
    if ( isdefined( self.noflashlight ) && self.noflashlight )
    {
        return false;
    }
    
    if ( !isdefined( self.a ) || !isdefined( self.a.weaponpos ) || isundefinedweapon( self.a.weaponpos[ "right" ] ) )
    {
        return false;
    }
    
    return true;
}

