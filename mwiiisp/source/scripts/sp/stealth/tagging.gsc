#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\utility;
#using scripts\stealth\utility;

#namespace tagging;

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0x40c
// Size: 0x37
function tagging_player_thread()
{
    if ( !isdefined( self.tagging ) )
    {
        tagging_player_init();
    }
    
    if ( istrue( level.ship_assault ) )
    {
    }
    else
    {
        thread tagging_think();
    }
    
    tagging_set_enabled( 1 );
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0x44b
// Size: 0x12
function tagging_player_stop()
{
    tagging_set_enabled( 0 );
    self notify( "tagging_think" );
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 2
// Checksum 0x0, Offset: 0x465
// Size: 0x5a
function tagging_set_enabled( enabled, action_slot )
{
    if ( !isdefined( self.tagging ) )
    {
        tagging_player_init();
    }
    
    if ( !isdefined( action_slot ) )
    {
        action_slot = 4;
    }
    
    self.tagging[ "enabled" ] = enabled;
    self.tagging[ "action_slot" ] = action_slot;
    tagging_set_marking_enabled( enabled );
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 1
// Checksum 0x0, Offset: 0x4c7
// Size: 0x159
function tagging_set_marking_enabled( enabled )
{
    if ( !isdefined( self.tagging ) )
    {
        tagging_player_init();
    }
    
    self.tagging[ "marking_enabled" ] = enabled;
    entitylist = tagging_entity_list();
    
    if ( !self.tagging[ "marking_enabled" ] )
    {
        foreach ( entity in entitylist )
        {
            if ( !isdefined( entity ) )
            {
                continue;
            }
            
            if ( issentient( entity ) && !isalive( entity ) )
            {
                continue;
            }
            
            entity tag_trace_update( "none", self );
            entity notify( "tagged_entity_death_cleanup" );
            entity tagged_status_hide();
        }
        
        return;
    }
    
    foreach ( entity in entitylist )
    {
        if ( !isdefined( entity ) )
        {
            continue;
        }
        
        if ( issentient( entity ) && !isalive( entity ) )
        {
            continue;
        }
        
        if ( isdefined( entity.tagged ) && isdefined( entity.tagged[ self getentitynumber() ] ) )
        {
            entity tag_entity( self );
        }
    }
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 2
// Checksum 0x0, Offset: 0x628
// Size: 0x114
function tag_entity( player, var_47eb02bf85de33e5 )
{
    /#
        if ( !isdefined( self ) || !isdefined( self.model ) )
        {
            assertmsg( "<dev string:x1c>" );
        }
    #/
    
    if ( !isdefined( level.tagginginit ) )
    {
        level tracking_init();
        level.tagginginit = 1;
    }
    
    if ( !isdefined( var_47eb02bf85de33e5 ) )
    {
        var_47eb02bf85de33e5 = 1;
    }
    
    if ( !isdefined( self ) || issentient( self ) && !isalive( self ) )
    {
        if ( isdefined( self ) )
        {
            tag_outline_entity( 0 );
        }
        
        return;
    }
    
    if ( var_47eb02bf85de33e5 && ( !isdefined( self.tagged ) || !isdefined( self.tagged[ player getentitynumber() ] ) || !self.tagged[ player getentitynumber() ] ) )
    {
        player thread play_sound_on_entity( "drone_tag_success" );
    }
    
    self.tagged[ player getentitynumber() ] = 1;
    tag_outline_entity( 1 );
    self.tag_trace_state = undefined;
    self.tag_trace_pulse = undefined;
    self.tag_trace_track = undefined;
    tagged_status_show();
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 2
// Checksum 0x0, Offset: 0x744
// Size: 0x1b8
function tag_flash_entity( player, flashing )
{
    if ( isdefined( self.tag_flashing ) && self.tag_flashing == flashing )
    {
        return;
    }
    
    self.tag_flashing = flashing;
    self notify( "tag_flash_entity" );
    self endon( "tag_flash_entity" );
    self endon( "death" );
    player endon( "death" );
    player endon( "disconnect" );
    
    /#
        if ( !isdefined( self ) || !isdefined( self.model ) )
        {
            assertmsg( "<dev string:x52>" );
        }
    #/
    
    if ( !isdefined( self ) || issentient( self ) && !isalive( self ) )
    {
        if ( isdefined( self ) )
        {
            tag_outline_entity( 0 );
        }
        
        return;
    }
    
    playerentnum = player getentitynumber();
    
    if ( !isdefined( player.tag_next_flash ) )
    {
        player.tag_next_flash = 0;
    }
    
    var_870df669effdb2b1 = isdefined( self.tagged ) && istrue( self.tagged[ playerentnum ] );
    flash = 1;
    
    while ( flashing && getdvarint( @"ai_threatsight", 1 ) )
    {
        self.tagged_flickered = 1;
        
        if ( flash )
        {
            tag_outline_entity( 1, "dead" );
        }
        else
        {
            tag_outline_entity( var_870df669effdb2b1 );
        }
        
        waittime = player.tag_next_flash - gettime();
        
        if ( waittime > 0 )
        {
            wait float( waittime ) / 1000;
        }
        
        flash = !flash;
        player.tag_next_flash = gettime() + 200;
        var_870df669effdb2b1 = isdefined( self.tagged ) && istrue( self.tagged[ playerentnum ] );
    }
    
    tag_outline_entity( var_870df669effdb2b1 );
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0x904
// Size: 0xbd
function tagging_player_init()
{
    if ( !isdefined( level.tagginginit ) )
    {
        level tracking_init();
        level.tagginginit = 1;
    }
    
    self.tagging = [];
    self.tagging[ "enabled" ] = undefined;
    self.tagging[ "marking_enabled" ] = 1;
    self.tagging[ "outline_enabled" ] = 1;
    self.tagging[ "tagging_mode" ] = 0;
    self.tagging[ "last_tag_start" ] = 0;
    self.tagging[ "action_slot" ] = 4;
    self.tagging[ "tagging_fade_min" ] = 500;
    self.tagging[ "tagging_fade_max" ] = 3000;
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0x9c9
// Size: 0xdd
function tracking_init()
{
    setdvarifuninitialized( @"hash_f05c8f3735320c7c", 3000 );
    setdvarifuninitialized( @"hash_804a2291b4a8b92e", 10 );
    setdvarifuninitialized( @"hash_a51875d7d6abf72", 50 );
    setdvarifuninitialized( @"hash_af0e1bddfb8d06f7", 250 );
    setdvarifuninitialized( @"hash_744c07d95523175f", 500 );
    setdvarifuninitialized( @"hash_2c74e15f8d4b6c58", 100 );
    setdvarifuninitialized( @"hash_f3a9396ca64643d", 500 );
    setdvarifuninitialized( @"hash_3fd7f3a2c9ccfda1", 1000 );
    setdvarifuninitialized( @"hash_b1c9cc21222ca5f1", 0 );
    setdvarifuninitialized( @"hash_d7fb76123edd5b2d", 0 );
    hudoutline_add_channel( "tagging", -1, &tagging_hudoutline_settings );
    thread lerp_hudoutline_occlusion();
    setsaveddvar( @"r_hudoutlineenable", 1 );
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0xaae
// Size: 0x5a
function tagging_hudoutline_settings()
{
    hudoutlinesettings = [];
    hudoutlinesettings[ "r_hudoutlineFillColor0" ] = "0.5 0.5 0.5 0";
    hudoutlinesettings[ "r_hudoutlineFillColor1" ] = "0.5 0.5 0.5 0";
    hudoutlinesettings[ "r_hudoutlineOccludedOutlineColor" ] = "0.5 0.5 0.5 0";
    hudoutlinesettings[ "r_hudoutlineOccludedInlineColor" ] = "0.5 0.5 0.5 0";
    hudoutlinesettings[ "r_hudoutlineOccludedInteriorColor" ] = "0.5 0.5 0.5 0";
    hudoutlinesettings[ "r_hudOutlineOccludedColorFromFill" ] = 1;
    return hudoutlinesettings;
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0xb11
// Size: 0x135
function lerp_hudoutline_occlusion()
{
    alpha = 0;
    time = 0.05;
    value = "0.5 0.5 0.5";
    bool = 1;
    cycles = 0;
    
    while ( true )
    {
        for ( i = 1; i < 11 ; i++ )
        {
            if ( isdefined( level.hudoutlinecurchannel ) && level.hudoutlinecurchannel == "tagging" )
            {
                setsaveddvar( @"r_hudoutlineoccludedoutlinecolor", value + alpha + "" );
                setsaveddvar( @"r_hudoutlineoccludedinlinecolor", value + alpha + "" );
                setsaveddvar( @"r_hudoutlineoccludedinteriorcolor", value + alpha + "" );
                
                if ( bool )
                {
                    alpha = ter_op( i == 10, 0.9, alpha + 0.1 );
                }
                else
                {
                    alpha = ter_op( i == 10, 0, alpha - 0.1 );
                }
                
                wait time;
            }
        }
        
        cycles++;
        
        if ( cycles == 2 )
        {
            level notify( "tagging_cycle" );
            wait 2;
            cycles = 0;
        }
        else
        {
            wait 0.05;
        }
        
        if ( bool )
        {
            bool = 0;
            continue;
        }
        
        bool = 1;
    }
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0xc4e
// Size: 0x52
function tagging_shutdown_player()
{
    self notify( "tagging_shutdown" );
    tagging_set_enabled( 0 );
    
    if ( isdefined( self.tagging ) && isdefined( self.tagging[ "camera" ] ) )
    {
        self.tagging[ "camera" ] delete();
    }
    
    self.tagging = undefined;
}

/#

    // Namespace tagging / scripts\sp\stealth\tagging
    // Params 1
    // Checksum 0x0, Offset: 0xca8
    // Size: 0x83, Type: dev
    function function_5dfb4dd763f46cb3( hudelem )
    {
        self notify( "<dev string:x8e>" );
        self endon( "<dev string:x8e>" );
        self endon( "<dev string:xa8>" );
        
        while ( isdefined( hudelem ) )
        {
            hudelem.color = ( getdvarfloat( @"hash_85d2b91461a769e7" ), getdvarfloat( @"hash_85d2a41461a73bb8" ), getdvarfloat( @"hash_85d2a91461a746b7" ) );
            hudelem.alpha = getdvarfloat( @"hash_85d2aa1461a748ea" );
            wait 0.05;
        }
    }

#/

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0xd33
// Size: 0x84
function tagging_entity_list()
{
    enemyai = level.stealth.enemies[ self.team ];
    var_4417ddf013b240ba = getentarray( "rss_static_robot", "script_noteworthy" );
    allies = getaiarray( self.team );
    enemies = scripts\engine\utility::array_combine( enemyai, var_4417ddf013b240ba );
    result = scripts\engine\utility::array_combine( enemies, allies );
    return result;
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0xdc0
// Size: 0xb7
function tagging_think()
{
    self notify( "tagging_think" );
    self endon( "tagging_think" );
    self endon( "death" );
    self endon( "disconnect" );
    
    while ( isdefined( self ) && isdefined( self.tagging ) )
    {
        if ( !isdefined( self.tagging[ "enabled" ] ) )
        {
            return;
        }
        
        if ( !isdefined( self.tagging[ "outline_enabled" ] ) )
        {
            return;
        }
        
        var_e025306f5374186a = self.tagging[ "enabled" ] && self.tagging[ "outline_enabled" ] && !level.player islinked();
        
        if ( var_e025306f5374186a && isads() )
        {
            tag_update_enemy_in_sights();
        }
        
        wait 0.05;
    }
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0xe7f
// Size: 0x339
function tag_update_enemy_in_sights()
{
    entitylist = tagging_entity_list();
    eye = self geteye();
    var_87ea8542a557d603 = anglestoforward( self getplayerangles() );
    var_bffac07b1b82af17 = undefined;
    var_5c5bc7719e4b1c11 = max( 0.01, getdvarfloat( @"hash_f05c8f3735320c7c" ) );
    var_2cebd0c753447713 = cos( getdvarfloat( @"hash_804a2291b4a8b92e" ) );
    checkpoints = [ 0, 0.5, 1 ];
    
    if ( scripts\stealth\utility::tagging_shield() )
    {
        var_5c5bc7719e4b1c11 = level.player.tagging[ "tagging_fade_max" ];
        var_2cebd0c753447713 = cos( getdvarfloat( @"cg_fov" ) );
    }
    
    trace = scripts\engine\trace::_bullet_trace( eye, eye + var_87ea8542a557d603 * 32000, 1, self );
    var_bffac07b1b82af17 = trace[ "entity" ];
    
    foreach ( entity in entitylist )
    {
        if ( !isdefined( entity ) )
        {
            continue;
        }
        
        if ( issentient( entity ) && !isalive( entity ) )
        {
            continue;
        }
        
        if ( isdefined( entity.tagged ) && isdefined( entity.tagged[ self getentitynumber() ] ) )
        {
            continue;
        }
        
        if ( !getdvarint( @"hash_d7fb76123edd5b2d" ) && isdefined( entity.vehicle_ride ) && entity.vehicle_ride.veh_speed > 0 )
        {
            continue;
        }
        
        tracking = isdefined( var_bffac07b1b82af17 ) && var_bffac07b1b82af17 == entity;
        
        if ( !tracking )
        {
            enemyeye = entity gettagorigin( "tag_origin" );
            
            if ( isai( entity ) )
            {
                enemyeye = entity geteye();
            }
            
            dist = distance( enemyeye, eye );
            
            if ( dist <= var_5c5bc7719e4b1c11 )
            {
                var_f290de2119e68c76 = min( 1, var_2cebd0c753447713 + ( 1 - var_2cebd0c753447713 ) * dist / var_5c5bc7719e4b1c11 );
                
                foreach ( check in checkpoints )
                {
                    testpoint = vectorlerp( entity.origin, enemyeye, check );
                    delta = testpoint - eye;
                    dir = vectornormalize( delta );
                    dot = vectordot( dir, var_87ea8542a557d603 );
                    
                    if ( dot > var_f290de2119e68c76 )
                    {
                        if ( enemy_sight_trace_passed( entity ) )
                        {
                            tracking = 1;
                            break;
                        }
                    }
                }
            }
        }
        
        if ( tracking )
        {
            entity tag_trace_update( "tracking", self, 1 );
            continue;
        }
        
        entity tag_trace_update( "none", self, 0 );
    }
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0x11c0
// Size: 0x6b
function enemy_sight_trace_request()
{
    if ( isdefined( self.tagging_sight_traced_queued ) )
    {
        return;
    }
    
    if ( !isdefined( self.tagging_sight_trace_passed ) )
    {
        self.tagging_sight_trace_passed = 0;
    }
    
    if ( !isdefined( level.tagging_sight_trace_queue ) )
    {
        level.tagging_sight_trace_queue = [];
        level thread enemy_sight_trace_process();
    }
    
    level.tagging_sight_trace_queue = array_add( level.tagging_sight_trace_queue, self );
    self.tagging_sight_traced_queued = 1;
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0x1233
// Size: 0xb8
function enemy_sight_trace_process()
{
    self notify( "enemy_sight_trace_process" );
    self endon( "enemy_sight_trace_process" );
    var_98cfcdbee7100d1 = 3;
    
    while ( true )
    {
        level.tagging_sight_trace_queue = array_removeundefined( level.tagging_sight_trace_queue );
        
        for ( i = 0; i < min( var_98cfcdbee7100d1, level.tagging_sight_trace_queue.size ) ; i++ )
        {
            enemy = level.tagging_sight_trace_queue[ 0 ];
            level.tagging_sight_trace_queue = array_remove( level.tagging_sight_trace_queue, enemy );
            enemy.tagging_sight_trace_passed = enemy_sight_trace( enemy );
            enemy.tagging_sight_traced_queued = undefined;
        }
        
        wait 0.05;
    }
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 1
// Checksum 0x0, Offset: 0x12f3
// Size: 0x1e
function enemy_sight_trace_passed( enemy )
{
    enemy enemy_sight_trace_request();
    return enemy.tagging_sight_trace_passed;
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 1
// Checksum 0x0, Offset: 0x131a
// Size: 0x12f
function enemy_sight_trace( enemy )
{
    result = 0;
    eyepos = level.player geteye();
    
    if ( !result && enemy hastag( enemy.model, "j_head" ) )
    {
        if ( sighttracepassed( eyepos, enemy gettagorigin( "j_head" ), 0, enemy.sight_ignore, enemy, 0 ) )
        {
            result = 1;
        }
    }
    
    if ( !result && enemy hastag( enemy.model, "j_spinelower" ) )
    {
        if ( sighttracepassed( eyepos, enemy gettagorigin( "j_spinelower" ), 0, enemy.sight_ignore, enemy, 0 ) )
        {
            result = 1;
        }
    }
    
    if ( !result && enemy hastag( enemy.model, "tag_attach" ) )
    {
        if ( sighttracepassed( eyepos, enemy gettagorigin( "tag_attach" ), 0, enemy.sight_ignore, enemy, 0 ) )
        {
            result = 1;
        }
    }
    
    if ( !result && sighttracepassed( eyepos, enemy.origin, 0, enemy.sight_ignore, enemy, 0 ) )
    {
        result = 1;
    }
    
    return result;
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 3
// Checksum 0x0, Offset: 0x1452
// Size: 0x224
function tag_trace_update( var_1b84be526a9c06f2, player, var_cc6f6a269ef25dca )
{
    now = gettime();
    
    if ( !isdefined( var_cc6f6a269ef25dca ) )
    {
        var_cc6f6a269ef25dca = 0;
    }
    
    pulserate = getdvarint( @"hash_a51875d7d6abf72" );
    var_321a8156113cfdea = getdvarint( @"hash_af0e1bddfb8d06f7" );
    var_a39f3dc28acd7edc = getdvarint( @"hash_744c07d95523175f" );
    outofview = 0;
    
    if ( !player.tagging[ "marking_enabled" ] )
    {
        var_1b84be526a9c06f2 = "range";
    }
    
    switch ( var_1b84be526a9c06f2 )
    {
        case #"hash_3293967944b10658":
            outofview = 1;
            self.tag_trace_state = 0;
            self.tag_trace_track = undefined;
            break;
        case #"hash_e8392ab0bfe96fb2":
            self.tag_trace_state = 0;
            self.tag_trace_track = undefined;
            break;
        case #"hash_a51479b7a82ab324":
            pulserate = getdvarint( @"hash_2c74e15f8d4b6c58" );
            var_321a8156113cfdea = getdvarint( @"hash_f3a9396ca64643d" );
            var_a39f3dc28acd7edc = getdvarint( @"hash_3fd7f3a2c9ccfda1" );
        case #"hash_125ae3420ba0fbdc":
            if ( !isdefined( self.tag_trace_track ) )
            {
                if ( ( gettime() - player.tagging[ "last_tag_start" ] ) / 1000 <= 0.25 )
                {
                    return;
                }
                
                self.tag_trace_track = now;
                player.tagging[ "last_tag_start" ] = now;
            }
            
            break;
        case #"hash_696f35aa003adfec":
        case #"hash_db653a4972b3c13b":
        default:
            tag_outline_entity( 0 );
            self.tag_trace_track = undefined;
            return;
    }
    
    var_f4fa69353ba530ae = var_a39f3dc28acd7edc + var_321a8156113cfdea;
    var_b6024bb6422c13b9 = 0;
    
    if ( isdefined( self.tag_trace_track ) )
    {
        var_b6024bb6422c13b9 = now - self.tag_trace_track;
    }
    
    if ( var_b6024bb6422c13b9 >= var_f4fa69353ba530ae )
    {
        if ( var_cc6f6a269ef25dca )
        {
            player.tagged_ads = 1;
        }
        
        tag_entity( player );
    }
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 2
// Checksum 0x0, Offset: 0x167e
// Size: 0x47
function tag_outline_entity( outline, forcedteam )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( outline )
    {
        tagged_status_show( forcedteam );
        thread tagged_entity_death_cleanup();
        thread tagged_entity_update();
        return;
    }
    
    tagged_status_hide();
    self notify( "tagged_entity_update" );
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0x16cd
// Size: 0x10a
function tagged_entity_update()
{
    self endon( "death" );
    self notify( "tagged_entity_update" );
    self endon( "tagged_entity_update" );
    
    while ( true )
    {
        if ( !getdvarint( @"hash_d7fb76123edd5b2d" ) && isdefined( self.vehicle_ride ) && self.vehicle_ride.veh_speed > 0 )
        {
            tag_outline_entity( 0 );
            self notify( "tagged_entity_death_cleanup" );
            self.tagged = undefined;
            return;
        }
        
        if ( !isdefined( self.tagged_flickered ) )
        {
            if ( !isdefined( self.tagged_time ) )
            {
                self.tagged_time = gettime();
            }
            
            cycle = int( ( gettime() - self.tagged_time ) / 100 );
            
            if ( cycle % 2 )
            {
                tagged_status_hide();
            }
            else
            {
                tagged_status_show();
            }
            
            if ( cycle > 3 )
            {
                tagged_status_show();
                self.tagged_flickered = 1;
            }
        }
        
        if ( isdefined( self.shieldhudoutline ) )
        {
            thread tagged_wait_shield_off();
        }
        
        wait 0.05;
    }
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0x17df
// Size: 0x27
function tagged_wait_shield_off()
{
    self notify( "tagged_wait_shield_off" );
    self endon( "tagged_wait_shield_off" );
    self endon( "death" );
    self waittill( "hudoutline_off" );
    tagged_status_show();
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0x180e
// Size: 0x6a
function tagged_hudoutline()
{
    var_9c3219ab2e3b0d50[ "allies" ] = "outlinefill_nodepth_cyan";
    var_9c3219ab2e3b0d50[ "axis" ] = "outlinefill_nodepth_red";
    var_9c3219ab2e3b0d50[ "team3" ] = "outlinefill_nodepth_white";
    var_9c3219ab2e3b0d50[ "dead" ] = "outlinefill_nodepth_white";
    team = "dead";
    
    if ( isdefined( self.team ) )
    {
        team = self.team;
    }
    
    return var_9c3219ab2e3b0d50[ team ];
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 1
// Checksum 0x0, Offset: 0x1881
// Size: 0x49
function tagged_status_show( forcedteam )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    tagged_status_hide();
    hudoutlineasset = tagged_hudoutline();
    hudoutline_enable_new( hudoutlineasset, "tagging" );
    thread tagged_status_update();
    self.tagging_visible = 1;
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 1
// Checksum 0x0, Offset: 0x18d2
// Size: 0xf2
function _create_tagging_highlight( color )
{
    if ( isdefined( self.highlight_ent ) )
    {
        return;
    }
    
    if ( isdefined( self.model ) && hastag( self.model, "j_mainroot" ) )
    {
        self.highlight_ent = spawn_script_origin( self gettagorigin( "tag_eye" ) + ( 0, 0, 20 ), self.angles );
        self.highlight_ent linkto( self, "tag_origin" );
        range = 3000;
        self.highlight_ent makeusable();
        self.highlight_ent setcursorhint( "hint_button" );
        self.highlight_ent sethintdisplayrange( range );
        self.highlight_ent setuserange( 1 );
        self.highlight_ent sethintonobstruction( "show" );
        thread _remove_tagging_highlight_on_death();
    }
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 1
// Checksum 0x0, Offset: 0x19cc
// Size: 0xac
function tagging_highlight_dist_fade( range )
{
    self endon( "death" );
    cutoff = squared( range / 2 );
    
    while ( true )
    {
        while ( distance2dsquared( self.origin, level.player.origin ) > cutoff )
        {
            wait 0.1;
        }
        
        self.highlight_ent sethintdisplayrange( 0 );
        
        while ( distance2dsquared( self.origin, level.player.origin ) < cutoff )
        {
            wait 0.1;
        }
        
        self.highlight_ent sethintdisplayrange( range );
    }
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0x1a80
// Size: 0x52
function _remove_tagging_highlight_on_death()
{
    highlight_ent = self.highlight_ent;
    waittill_any( "death", "tagging_remove_highlight" );
    
    if ( isdefined( highlight_ent ) )
    {
        if ( target_istarget( highlight_ent ) )
        {
            target_remove( highlight_ent );
        }
        
        highlight_ent delete();
    }
    
    if ( isdefined( self ) )
    {
        self.highlight_ent = undefined;
    }
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0x1ada
// Size: 0x61
function _end_tagging_highlighting()
{
    level notify( "end_tagging_highlighting" );
    
    foreach ( ai in getaiarray( "axis", "allies" ) )
    {
        ai notify( "tagging_remove_highlight" );
    }
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0x1b43
// Size: 0x26
function tagged_status_hide()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( "tagged_status_update" );
    hudoutline_disable( "tagging" );
    self.tagging_visible = undefined;
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0x1b71
// Size: 0xb1
function tagged_status_update()
{
    self notify( "tagged_status_update" );
    self endon( "tagged_status_update" );
    self endon( "death" );
    
    while ( isdefined( self ) && ( !issentient( self ) || isalive( self ) ) )
    {
        maxdist = level.player.tagging[ "tagging_fade_max" ];
        maxdistsq = maxdist * maxdist;
        distsq = lengthsquared( level.player.origin - self.origin );
        
        if ( distsq > maxdistsq )
        {
            tagged_status_hide();
        }
        else
        {
            tagged_status_show();
        }
        
        wait 0.05;
    }
}

// Namespace tagging / scripts\sp\stealth\tagging
// Params 0
// Checksum 0x0, Offset: 0x1c2a
// Size: 0x10e
function tagged_entity_death_cleanup()
{
    if ( isdefined( self.tagged_entity_death_cleanup ) )
    {
        return;
    }
    
    self notify( "tagged_entity_death_cleanup" );
    self endon( "tagged_entity_death_cleanup" );
    self.tagged_entity_death_cleanup = 1;
    self waittill( "death", killer, dmgmod );
    
    if ( isplayer( killer ) )
    {
        wait 0.1;
        
        if ( isdefined( self ) && distancesquared( self.origin, level.player.origin ) > 90000 )
        {
            start = gettime();
            state = 1;
            
            while ( isdefined( self ) && gettime() - start < 1000 )
            {
                if ( state == 0 && randomint( 100 ) < 30 )
                {
                    tag_outline_entity( 1 );
                    state = 1;
                }
                else if ( state == 1 )
                {
                    tag_outline_entity( 0 );
                    state = 0;
                }
                
                wait 0.05;
            }
        }
    }
    
    if ( isdefined( self ) )
    {
        tag_outline_entity( 0 );
    }
    
    self.tagged_entity_death_cleanup = undefined;
}

