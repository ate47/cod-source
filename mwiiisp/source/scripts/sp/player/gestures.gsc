#using scripts\anim\battlechatter;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\player\gestures;
#using scripts\sp\utility;

#namespace gestures;

// Namespace gestures / scripts\sp\player\gestures
// Params 0
// Checksum 0x0, Offset: 0x291
// Size: 0x1c
function enter_demeanor_normal()
{
    thread set_demeanor_code_think( "normal" );
    thread demeanor_exit_func_wait( &exit_demeanor_normal );
}

// Namespace gestures / scripts\sp\player\gestures
// Params 0
// Checksum 0x0, Offset: 0x2b5
// Size: 0x2
function exit_demeanor_normal()
{
    
}

// Namespace gestures / scripts\sp\player\gestures
// Params 0
// Checksum 0x0, Offset: 0x2bf
// Size: 0x21
function enter_demeanor_relaxed()
{
    thread set_demeanor_code_think( "relaxed", "iw8_ges_demeanor_relaxed" );
    thread demeanor_exit_func_wait( &exit_demeanor_relaxed );
}

// Namespace gestures / scripts\sp\player\gestures
// Params 0
// Checksum 0x0, Offset: 0x2e8
// Size: 0x21
function enter_demeanor_green_beam()
{
    thread set_demeanor_code_think( "relaxed", "iw8_ges_green_laser_demeanor_relaxed" );
    thread demeanor_exit_func_wait( &exit_demeanor_relaxed );
}

// Namespace gestures / scripts\sp\player\gestures
// Params 0
// Checksum 0x0, Offset: 0x311
// Size: 0x2
function exit_demeanor_relaxed()
{
    
}

// Namespace gestures / scripts\sp\player\gestures
// Params 1
// Checksum 0x0, Offset: 0x31b
// Size: 0x2a
function enter_demeanor_safe( var_5966e857c28e93c5 )
{
    thread set_demeanor_code_think( "relaxed", "iw8_ges_demeanor_safe" );
    thread demeanor_exit_func_wait( &exit_demeanor_safe );
}

// Namespace gestures / scripts\sp\player\gestures
// Params 1
// Checksum 0x0, Offset: 0x34d
// Size: 0xb
function exit_demeanor_safe( var_8b35ad057a83d7e7 )
{
    
}

// Namespace gestures / scripts\sp\player\gestures
// Params 0
// Checksum 0x0, Offset: 0x360
// Size: 0x4a
function safe_zoom_think()
{
    self endon( "entering_new_demeanor" );
    self endon( "death" );
    self.gestures.safedefaultfov = getdvarint( @"hash_b38fcf293d1e91a8" );
    childthread safe_zoom_in_listen();
    childthread safe_zoom_out_listen();
    thread safe_zoom_end_think();
}

// Namespace gestures / scripts\sp\player\gestures
// Params 0
// Checksum 0x0, Offset: 0x3b2
// Size: 0x7f
function safe_zoom_in_listen()
{
    level.player notifyonplayercommand( "safe_zoom_pressed", "+toggleads_throw" );
    level.player notifyonplayercommand( "safe_zoom_pressed", "+ads_akimbo_accessible" );
    level.player notifyonplayercommand( "safe_zoom_pressed", "+speed_throw" );
    
    while ( true )
    {
        self waittill( "safe_zoom_pressed" );
        self modifybasefov( self.gestures.safedefaultfov - 9, 0.14 );
    }
}

// Namespace gestures / scripts\sp\player\gestures
// Params 0
// Checksum 0x0, Offset: 0x439
// Size: 0x7c
function safe_zoom_out_listen()
{
    level.player notifyonplayercommand( "safe_zoom_released", "-toggleads_throw" );
    level.player notifyonplayercommand( "safe_zoom_released", "-ads_akimbo_accessible" );
    level.player notifyonplayercommand( "safe_zoom_released", "-speed_throw" );
    
    while ( true )
    {
        self waittill( "safe_zoom_released" );
        self modifybasefov( self.gestures.safedefaultfov, 0.1 );
    }
}

// Namespace gestures / scripts\sp\player\gestures
// Params 0
// Checksum 0x0, Offset: 0x4bd
// Size: 0x30
function safe_zoom_end_think()
{
    self endon( "death" );
    self waittill( "entering_new_demeanor" );
    self modifybasefov( self.gestures.safedefaultfov, 0.1 );
}

// Namespace gestures / scripts\sp\player\gestures
// Params 1
// Checksum 0x0, Offset: 0x4f5
// Size: 0x18
function demeanor_exit_func_wait( exitfunction )
{
    self waittill( "entering_new_demeanor" );
    self [[ exitfunction ]]();
}

// Namespace gestures / scripts\sp\player\gestures
// Params 2
// Checksum 0x0, Offset: 0x515
// Size: 0x5a
function set_demeanor_code_think( demeanor, gestureoverride )
{
    self endon( "entering_new_demeanor" );
    self endon( "death" );
    
    while ( true )
    {
        if ( isdefined( gestureoverride ) )
        {
            result = self setdemeanorviewmodel( demeanor, gestureoverride );
        }
        else
        {
            result = self setdemeanorviewmodel( demeanor );
        }
        
        if ( result )
        {
            break;
        }
        
        wait 0.05;
    }
}

// Namespace gestures / scripts\sp\player\gestures
// Params 14
// Checksum 0x0, Offset: 0x577
// Size: 0x58d
function player_gestures_input_disable( gesturename, pronemovement, mantle, sprint, fire, reload, weaponswitch, ads, wallrun, doublejump, meleeattack, offhandweapons, disabletime, tag )
{
    self endon( "death" );
    
    if ( !isdefined( tag ) )
    {
        tag = "gesture";
    }
    
    if ( !isdefined( self.gestures ) )
    {
        self.gestures = spawnstruct();
    }
    
    if ( isdefined( pronemovement ) && pronemovement == 1 )
    {
        if ( level.player getstance() == "prone" )
        {
            blend_movespeedscale( 0, 0, "gesture" );
            thread scripts\sp\player\gestures::player_gestures_prone_getup_think( gesturename, tag );
            
            if ( !isdefined( self.gestures.restrictingpronespeed ) )
            {
                self.gestures.restrictingpronespeed = 0;
            }
            
            self.gestures.restrictingpronespeed++;
        }
        else
        {
            if ( !isdefined( self.gestures.restrictingpronestance ) )
            {
                self.gestures.restrictingpronestance = 0;
            }
            
            self.gestures.restrictingpronestance++;
            val::set( tag, "prone", 0 );
        }
        
        self.gestures.restrictingpronemovement = 1;
    }
    
    if ( isdefined( mantle ) && mantle == 1 )
    {
        if ( !isdefined( self.gestures.restrictingmantle ) )
        {
            self.gestures.restrictingmantle = 0;
        }
        
        self.gestures.restrictingmantle++;
        val::set( tag, "mantle", 0 );
    }
    
    if ( isdefined( sprint ) && sprint == 1 )
    {
        if ( !isdefined( self.gestures.restrictingsprint ) )
        {
            self.gestures.restrictingsprint = 0;
        }
        
        self.gestures.restrictingsprint++;
        val::set( tag, "sprint", 0 );
    }
    
    if ( isdefined( fire ) && fire == 1 )
    {
        if ( !isdefined( self.gestures.restrictingfire ) )
        {
            self.gestures.restrictingfire = 0;
        }
        
        self.gestures.restrictingfire++;
        val::set( tag, "fire", 0 );
    }
    
    if ( isdefined( reload ) && reload == 1 )
    {
        if ( !isdefined( self.gestures.restrictingreload ) )
        {
            self.gestures.restrictingreload = 0;
        }
        
        self.gestures.restrictingreload++;
        val::set( tag, "reload", 0 );
    }
    
    if ( isdefined( weaponswitch ) && weaponswitch == 1 )
    {
        if ( !isdefined( self.gestures.restrictingweaponswitch ) )
        {
            self.gestures.restrictingweaponswitch = 0;
        }
        
        self.gestures.restrictingweaponswitch++;
        val::set( tag, "weapon_switch", 0 );
    }
    
    if ( isdefined( ads ) && ads == 1 )
    {
        if ( !isdefined( self.gestures.restrictingads ) )
        {
            self.gestures.restrictingads = 0;
        }
        
        self.gestures.restrictingads++;
        val::set( tag, "ads", 0 );
    }
    
    if ( isdefined( wallrun ) && wallrun == 1 )
    {
        if ( !isdefined( self.gestures.restrictingwallrun ) )
        {
            self.gestures.restrictingwallrun = 0;
        }
        
        self.gestures.restrictingwallrun++;
        val::set( tag, "wallrun", 0 );
    }
    
    if ( isdefined( doublejump ) && doublejump == 1 )
    {
        if ( !isdefined( self.gestures.restrictingdoublejump ) )
        {
            self.gestures.restrictingdoublejump = 0;
        }
        
        self.gestures.restrictingdoublejump++;
        val::set( tag, "doublejump", 0 );
    }
    
    if ( isdefined( meleeattack ) && meleeattack == 1 )
    {
        if ( !isdefined( self.gestures.restrictingmeleeattack ) )
        {
            self.gestures.restrictingmeleeattack = 0;
        }
        
        self.gestures.restrictingmeleeattack++;
        val::set( tag, "melee", 0 );
    }
    
    if ( isdefined( offhandweapons ) && offhandweapons == 1 )
    {
        if ( !isdefined( self.gestures.restrictingoffhandweapons ) )
        {
            self.gestures.restrictingoffhandweapons = 0;
        }
        
        self.gestures.restrictingoffhandweapons++;
        val::set( tag, "offhand_weapons", 0 );
    }
    
    if ( isdefined( disabletime ) )
    {
        wait disabletime;
    }
    else
    {
        self waittill( "gesture_stopped", stoppedgesturename );
        
        if ( stoppedgesturename != gesturename )
        {
            while ( true )
            {
                if ( !self isgestureplaying( gesturename ) )
                {
                    break;
                }
                
                wait 0.05;
            }
        }
    }
    
    self notify( gesturename + "gesture_stopped_internal" );
    scripts\sp\player\gestures::player_gestures_input_enable( pronemovement, mantle, sprint, fire, reload, weaponswitch, ads, wallrun, doublejump, meleeattack, offhandweapons, tag );
}

// Namespace gestures / scripts\sp\player\gestures
// Params 12
// Checksum 0x0, Offset: 0xb0c
// Size: 0x262
function player_gestures_input_enable( pronemovement, mantle, sprint, fire, reload, weaponswitch, ads, wallrun, doublejump, meleeattack, offhandweapons, tag )
{
    if ( !isdefined( self.gestures ) )
    {
        self.gestures = spawnstruct();
    }
    
    if ( isdefined( pronemovement ) && pronemovement > 0 )
    {
        if ( isdefined( self.gestures.restrictingpronespeed ) && self.gestures.restrictingpronespeed > 0 )
        {
            if ( isdefined( level.player.movespeedscale ) && level.player.movespeedscale == 0 )
            {
                self.gestures.restrictingpronespeed--;
                
                if ( self.gestures.restrictingpronespeed <= 0 )
                {
                    blend_movespeedscale( 1, 0, "gesture" );
                }
            }
        }
        
        if ( isdefined( self.gestures.restrictingpronestance ) && self.gestures.restrictingpronestance > 0 )
        {
            self.gestures.restrictingpronestance--;
            val::reset_all( tag );
        }
    }
    
    if ( isdefined( mantle ) && mantle == 1 )
    {
        val::reset_all( tag );
    }
    
    if ( isdefined( sprint ) && sprint == 1 )
    {
        val::reset_all( tag );
    }
    
    if ( isdefined( fire ) && fire == 1 )
    {
        val::reset_all( tag );
    }
    
    if ( isdefined( reload ) && reload == 1 )
    {
        val::reset_all( tag );
    }
    
    if ( isdefined( weaponswitch ) && weaponswitch == 1 )
    {
        val::reset_all( tag );
    }
    
    if ( isdefined( ads ) && ads == 1 )
    {
        val::reset_all( tag );
    }
    
    if ( isdefined( wallrun ) && wallrun == 1 )
    {
        val::set( tag, "wallrun", 0 );
    }
    
    if ( isdefined( doublejump ) && doublejump == 1 )
    {
        val::set( tag, "doublejump", 0 );
    }
    
    if ( isdefined( meleeattack ) && meleeattack == 1 )
    {
        val::reset_all( tag );
    }
    
    if ( isdefined( offhandweapons ) && offhandweapons == 1 )
    {
        val::reset_all( tag );
    }
}

// Namespace gestures / scripts\sp\player\gestures
// Params 2
// Checksum 0x0, Offset: 0xd76
// Size: 0x110
function player_gestures_prone_getup_think( gesturename, tag )
{
    self endon( "death" );
    self endon( gesturename + "gesture_stopped_internal" );
    stillprone = 1;
    
    while ( stillprone )
    {
        if ( self getstance() != "prone" )
        {
            waittillframeend();
            
            if ( isdefined( level.player.movespeedscale ) && level.player.movespeedscale == 0 )
            {
                self.gestures.restrictingpronespeed--;
                
                if ( self.gestures.restrictingpronespeed <= 0 )
                {
                    blend_movespeedscale( 1, 0, "gesture" );
                }
            }
            
            if ( !isdefined( self.gestures.restrictingpronestance ) )
            {
                self.gestures.restrictingpronestance = 0;
            }
            
            self.gestures.restrictingpronestance++;
            val::set( tag, "prone", 0 );
            stillprone = 0;
        }
        
        wait 0.05;
    }
}

// Namespace gestures / scripts\sp\player\gestures
// Params 0
// Checksum 0x0, Offset: 0xe8e
// Size: 0xc0
function function_5231b0f285527a15()
{
    level.player endon( "death" );
    
    while ( true )
    {
        while ( function_a233e21442860e82() )
        {
            waitframe();
        }
        
        if ( !function_e4c009184c8a30e6() )
        {
            var_b173118a12ea61b0 = undefined;
            
            while ( !time_has_passed( var_b173118a12ea61b0, 0.5 ) )
            {
                if ( !function_e4c009184c8a30e6() )
                {
                    var_b173118a12ea61b0 = gettime();
                }
                
                waitframe();
            }
        }
        
        level.player set_player_demeanor( "relaxed" );
        var_fbe80fd3686a42fd = undefined;
        
        while ( !time_has_passed( var_fbe80fd3686a42fd, 1 ) )
        {
            if ( function_a233e21442860e82() )
            {
                break;
            }
            
            if ( function_e4c009184c8a30e6() )
            {
                var_fbe80fd3686a42fd = gettime();
            }
            
            waitframe();
        }
        
        level.player set_player_demeanor( "normal" );
    }
}

// Namespace gestures / scripts\sp\player\gestures
// Params 0
// Checksum 0x0, Offset: 0xf56
// Size: 0x6b, Type: bool
function function_a233e21442860e82()
{
    if ( level.player.currentweapon.type != "bullet" || istrue( level.player.incombat ) )
    {
        return true;
    }
    
    return !getdvarint( @"hash_92edcd4e782939e5", 0 ) || istrue( level.player.var_336db6c8b15ad3df );
}

// Namespace gestures / scripts\sp\player\gestures
// Params 3
// Checksum 0x0, Offset: 0xfca
// Size: 0x49, Type: bool
function wait_combat_cooldown( cooltime, timeout, radius )
{
    while ( !isdefined( timeout ) || timeout > 0 )
    {
        if ( !function_53f1cff70b5d2981( timeout, radius ) )
        {
            return false;
        }
        
        waitframe();
        
        if ( isdefined( timeout ) )
        {
            timeout -= 0.05;
        }
    }
    
    return true;
}

// Namespace gestures / scripts\sp\player\gestures
// Params 2
// Checksum 0x0, Offset: 0x101c
// Size: 0x22c, Type: bool
function function_53f1cff70b5d2981( time, radius )
{
    fired_recently = isdefined( level.player.var_a350546e224ce766 ) && !time_has_passed( level.player.var_a350546e224ce766, time );
    aimed_recently = isdefined( level.player.var_2216ecbcdd3468a4 ) && !time_has_passed( level.player.var_2216ecbcdd3468a4, time );
    var_d13b91a3e165b579 = isdefined( level.player.var_b4410f6c6f5b0f5 ) && !time_has_passed( level.player.var_b4410f6c6f5b0f5, time );
    damaged = level.player.health < level.player.maxhealth;
    
    if ( level.player isfiring() || fired_recently || aimed_recently || damaged )
    {
        return true;
    }
    
    if ( istrue( radius ) )
    {
        radius_sq = radius * radius;
        nearby_ai = getaiarray();
        
        foreach ( ai in nearby_ai )
        {
            if ( !isalive( ai ) || !isdefined( ai.team ) || ai.team == "dead" || ai.team == "neutral" )
            {
                continue;
            }
            
            if ( !is_equal( ai.enemy, level.player ) && distancesquared( ai.origin, level.player.origin ) > radius_sq )
            {
                continue;
            }
            
            if ( ai scripts\anim\battlechatter::function_45f570789ff9a0fd( time ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace gestures / scripts\sp\player\gestures
// Params 0
// Checksum 0x0, Offset: 0x1251
// Size: 0xf2
function function_160704ee50b41fa()
{
    level.player endon( "death" );
    childthread function_ca0fe6201120df5();
    
    /#
        setdevdvarifuninitialized( @"hash_62f50e8fe08148c9", 0 );
    #/
    
    var_f678598e33cef6a5 = 800;
    var_f7fb28bc06e2a38e = 900;
    var_4ab685c88f4b57ba = 1.5;
    
    while ( true )
    {
        /#
            thread function_a71bc808f2d1aa2b( "<dev string:x1c>" );
        #/
        
        level.player.incombat = 0;
        setsaveddvar( @"quickdraw_enabled", 0 );
        
        while ( !function_53f1cff70b5d2981( var_4ab685c88f4b57ba * 2, var_f678598e33cef6a5 ) )
        {
            wait var_4ab685c88f4b57ba;
        }
        
        /#
            thread function_a71bc808f2d1aa2b( "<dev string:x2a>" );
        #/
        
        level.player.incombat = 1;
        setsaveddvar( @"quickdraw_enabled", 1 );
        
        while ( function_53f1cff70b5d2981( var_4ab685c88f4b57ba * 2, var_f7fb28bc06e2a38e ) )
        {
            wait var_4ab685c88f4b57ba;
        }
    }
}

/#

    // Namespace gestures / scripts\sp\player\gestures
    // Params 1
    // Checksum 0x0, Offset: 0x134b
    // Size: 0x52, Type: dev
    function function_a71bc808f2d1aa2b( state )
    {
        level notify( "<dev string:x34>" );
        level endon( "<dev string:x34>" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_62f50e8fe08148c9" ) )
            {
                printtoscreen2d( 100, 800, state, ( 1, 1, 1 ), 2 );
            }
            
            waitframe();
        }
    }

#/

// Namespace gestures / scripts\sp\player\gestures
// Params 0
// Checksum 0x0, Offset: 0x13a5
// Size: 0xe7
function function_ca0fe6201120df5()
{
    var_38c64aefbd73546a = -9999;
    
    while ( true )
    {
        result = level.player scripts\engine\utility::waittill_any_return( "weapon_fired", "aim", "bulletwhizby", "damage" );
        
        switch ( result )
        {
            case #"hash_21a23ad4b32e4f8e":
                level.player.last_weapon_fire_time = gettime();
                continue;
            case #"hash_c57516c109cc3d6":
                if ( gettime() - var_38c64aefbd73546a > 50 )
                {
                    level.player.var_2216ecbcdd3468a4 = gettime();
                }
                
                var_38c64aefbd73546a = gettime();
                continue;
            case #"hash_1cc8a923a608c2a0":
            case #"hash_de811d1d5fa7e6b4":
                level.player.var_b4410f6c6f5b0f5 = gettime();
                continue;
        }
    }
}

// Namespace gestures / scripts\sp\player\gestures
// Params 0
// Checksum 0x0, Offset: 0x1494
// Size: 0x159, Type: bool
function function_e4c009184c8a30e6()
{
    allies = getaiarrayinradius( level.player.origin, 1500, "allies" );
    civs = getaiarrayinradius( level.player.origin, 1500, "neutral" );
    
    foreach ( civ in civs )
    {
        if ( istrue( civ.forcegundown ) )
        {
            allies[ allies.size ] = civ;
        }
    }
    
    player_eye = level.player geteye();
    player_forward = anglestoforward( level.player getplayerangles() );
    end = player_eye + anglestoforward( level.player getplayerangles() ) * 1500;
    result = scripts\engine\trace::ray_trace( player_eye, end, level.player );
    return isdefined( result[ "entity" ] ) && !istrue( result[ "entity" ].bisincombat ) && array_contains( allies, result[ "entity" ] );
}

// Namespace gestures / scripts\sp\player\gestures
// Params 5
// Checksum 0x0, Offset: 0x15f8
// Size: 0x93
function function_b2385036531deb4d( ent, max_dist, player_eye, player_forward, var_b1edb654de127cc7 )
{
    ent_point = ent getapproxeyepos() - ( 0, 0, 15 );
    var_132a7e059d13e4da = vectordot( ent_point - player_eye, player_forward ) > 0;
    var_5979848104c205bc = length( vectorfromlinetopoint( player_eye, player_eye + player_forward, ent_point ) );
    
    if ( !var_132a7e059d13e4da || var_5979848104c205bc > var_b1edb654de127cc7 )
    {
        return 0;
    }
    
    return scripts\engine\trace::ray_trace_passed( player_eye, ent_point, ent );
}

