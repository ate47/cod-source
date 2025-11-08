#using scripts\anim\shared;
#using scripts\common\utility;
#using scripts\cp\nvg_ai;
#using scripts\cp\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;

#namespace nvg_ai;

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x197
// Size: 0x20
function function_928ede0ff50c28b9()
{
    self waittill( "death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( is_using_flashlight() )
    {
        kill_flashlight_fx();
    }
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 3
// Checksum 0x0, Offset: 0x1bf
// Size: 0x45
function enable_flashlight( enable, safe, var_ee8db5defc52493e )
{
    if ( !isdefined( enable ) )
    {
        enable = 1;
    }
    
    if ( !isdefined( safe ) )
    {
        safe = 1;
    }
    
    if ( enable )
    {
        flashlight_on( safe, var_ee8db5defc52493e );
        return;
    }
    
    flashlight_off( safe );
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 2
// Checksum 0x0, Offset: 0x20c
// Size: 0x64
function flashlight_on( bsafe, var_f1c7168882d3b44b )
{
    if ( is_using_flashlight() )
    {
        return;
    }
    
    if ( !can_use_flashlight() )
    {
        return;
    }
    
    found_attachment = function_d73f1b97acba6597();
    
    if ( !found_attachment )
    {
        play_flashlight_fx( bsafe, var_f1c7168882d3b44b );
        
        if ( isdefined( self.flashlightlaserweapon ) )
        {
            flashlight_laser_on();
        }
    }
    
    self.flashlight = 1;
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 1
// Checksum 0x0, Offset: 0x278
// Size: 0x51
function flashlight_off( bsafe )
{
    if ( !is_using_flashlight() )
    {
        return;
    }
    
    self.flashlight = 0;
    
    if ( isdefined( self.flashlight_slot ) )
    {
        self laserforceoff();
        return;
    }
    
    kill_flashlight_fx();
    
    if ( isdefined( self.flashlightlaserweapon ) )
    {
        flashlight_laser_off();
    }
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x2d1
// Size: 0x8b
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
    self.flashlightlaser = laser;
    thread flashlight_laser_cleanup();
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x364
// Size: 0x20
function flashlight_laser_cleanup()
{
    self endon( "flashlight_laser_off" );
    self waittill( "death" );
    self.flashlightlaser delete();
}

/#

    // Namespace nvg_ai / scripts\cp\nvg_ai
    // Params 1
    // Checksum 0x0, Offset: 0x38c
    // Size: 0xcf, Type: dev
    function function_67a3c31d72df6540( tag )
    {
        self endon( "<dev string:x1c>" );
        
        while ( true )
        {
            waitframe();
            angles = self gettagangles( tag );
            origin = self gettagorigin( tag );
            forward = anglestoforward( angles );
            right = anglestoright( angles );
            up = anglestoup( angles );
            scale = 4;
            line( origin, origin + forward * scale, ( 1, 0, 0 ) );
            line( origin, origin + right * scale, ( 0, 1, 0 ) );
            line( origin, origin + up * scale, ( 0, 0, 1 ) );
        }
    }

#/

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x463
// Size: 0x31
function flashlight_laser_off()
{
    if ( !isdefined( self.flashlightlaser ) )
    {
        return;
    }
    
    self notify( "flashlight_laser_off" );
    self.flashlightlaser delete();
    self.flashlightlaser = undefined;
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x49c
// Size: 0x12e
function function_d73f1b97acba6597()
{
    if ( isdefined( self.flashlight_slot ) )
    {
        self laserforceon();
        return 1;
    }
    
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
        return 0;
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
    
    self.flashlight_slot = slot;
    scripts\anim\shared::detachweapon( currweapon );
    scripts\anim\shared::forceuseweapon( newweapon, slot );
    self laserforceon();
    return 1;
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 2
// Checksum 0x0, Offset: 0x5d2
// Size: 0x277
function play_flashlight_fx( bsafe, var_f1c7168882d3b44b )
{
    var_bb3c46dde7fae668 = undefined;
    tag = "tag_flash";
    
    if ( isdefined( self.flashlightfxoverridetag ) )
    {
        tag = self.flashlightfxoverridetag;
    }
    
    if ( isdefined( self.var_f0d1eee70e5eba76 ) || isdefined( self.var_f574a9d5d2e0f22c ) )
    {
        offsetangles = ( 0, 0, 0 );
        offsetorigin = ( 0, 0, 0 );
        
        if ( isdefined( self.var_f574a9d5d2e0f22c ) )
        {
            offsetangles = self.var_f574a9d5d2e0f22c;
        }
        
        if ( isdefined( self.var_f0d1eee70e5eba76 ) )
        {
            offsetorigin = self.var_f0d1eee70e5eba76;
        }
        
        if ( isdefined( self.var_67d990a8286f0787 ) )
        {
            self.var_67d990a8286f0787 delete();
        }
        
        offsetorigin = self gettagorigin( tag ) + offsetorigin;
        offsetangles = self gettagangles( tag ) + offsetangles;
        self.var_67d990a8286f0787 = spawn_tag_origin( offsetorigin, offsetangles );
        self.var_67d990a8286f0787 linkto( self, tag );
    }
    
    fx = "vfx_flashlight_npc_perf";
    
    if ( isdefined( level.flashlightfxoverride ) )
    {
        fx = level.flashlightfxoverride;
    }
    
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
    
    if ( !isdefined( self.var_67d990a8286f0787 ) && ( !isdefined( self.weapon ) || isnullweapon( self.weapon ) ) )
    {
        if ( isdefined( self.flashlightfxtag ) && !self tagexists( self.flashlightfxtag ) )
        {
            return;
        }
    }
    
    if ( isdefined( self.var_67d990a8286f0787 ) )
    {
        if ( bsafe )
        {
            self.var_67d990a8286f0787 fx_playontag_safe( self.flashlightfx, "tag_origin", undefined, undefined, 1 );
        }
        else
        {
            playfxontag( getfx( self.flashlightfx ), self.var_67d990a8286f0787, "tag_origin" );
        }
    }
    else if ( bsafe )
    {
        fx_playontag_safe( self.flashlightfx, self.flashlightfxtag, undefined, undefined, 1 );
    }
    else
    {
        playfxontag( getfx( self.flashlightfx ), self, self.flashlightfxtag );
    }
    
    self.var_f1c7168882d3b44b = var_f1c7168882d3b44b;
    thread nvg_death_cleanup();
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0x851
// Size: 0xd4
function nvg_death_cleanup()
{
    var_5275110113be1abc = self.flashlightfx;
    var_c3c074f635452c74 = self.flashlightfxtag;
    var_ffea00d321b63230 = self.var_67d990a8286f0787;
    var_ea7a7bc86b924c06 = self.var_f1c7168882d3b44b;
    var_dd43c1f2b37371c8 = self.var_32df275e39840fc1;
    msg = waittill_any_return_2( "entitydeleted", "death" );
    
    if ( !isdefined( self ) || isdefined( self ) && isdefined( self getcorpseentity() ) )
    {
        if ( isdefined( var_ea7a7bc86b924c06 ) )
        {
            wait var_ea7a7bc86b924c06;
        }
        
        my_corpse = isdefined( self ) ? self getcorpseentity() : undefined;
        thread function_c0cbbd50d2a290f0( my_corpse, var_5275110113be1abc, var_c3c074f635452c74, var_dd43c1f2b37371c8, var_ffea00d321b63230 );
        return;
    }
    
    thread kill_flashlight_fx( 1 );
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 1
// Checksum 0x0, Offset: 0x92d
// Size: 0x14
function kill_flashlight_fx( bsafe )
{
    thread function_567dd5104ab8d245( bsafe );
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 1
// Checksum 0x0, Offset: 0x949
// Size: 0x154
function function_567dd5104ab8d245( bsafe )
{
    if ( !isdefined( self.flashlightfxtag ) )
    {
        return;
    }
    
    ai_entnum = self getentitynumber();
    var_5275110113be1abc = self.flashlightfx;
    var_c3c074f635452c74 = self.flashlightfxtag;
    var_ffea00d321b63230 = self.var_67d990a8286f0787;
    var_dd43c1f2b37371c8 = istrue( self.var_32df275e39840fc1 );
    self.flashlightfx = undefined;
    self.flashlightfxtag = undefined;
    
    if ( isdefined( self.var_f1c7168882d3b44b ) && !isalive( self ) )
    {
        wait self.var_f1c7168882d3b44b;
    }
    
    if ( !isdefined( bsafe ) )
    {
        bsafe = 1;
    }
    
    my_corpse = isdefined( self ) ? self getcorpseentity() : undefined;
    
    if ( isdefined( var_5275110113be1abc ) )
    {
        if ( !isdefined( self ) || isdefined( my_corpse ) )
        {
            function_c0cbbd50d2a290f0( my_corpse, var_5275110113be1abc, var_c3c074f635452c74, var_dd43c1f2b37371c8, var_ffea00d321b63230 );
            return;
        }
        
        tag = "tag_flash";
        
        if ( isdefined( var_c3c074f635452c74 ) )
        {
            tag = var_c3c074f635452c74;
        }
        
        if ( isdefined( var_ffea00d321b63230 ) )
        {
            function_11168df3524b02f2( var_ffea00d321b63230, var_5275110113be1abc );
            return;
        }
        
        if ( !var_dd43c1f2b37371c8 || var_dd43c1f2b37371c8 && self tagexists( var_c3c074f635452c74 ) )
        {
            if ( bsafe )
            {
                fx_killontag_safe( var_5275110113be1abc, tag, undefined, undefined, 1 );
                return;
            }
            
            killfxontag( getfx( var_5275110113be1abc ), self, tag );
        }
    }
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 5
// Checksum 0x0, Offset: 0xaa5
// Size: 0x68
function function_c0cbbd50d2a290f0( my_corpse, var_5275110113be1abc, var_c3c074f635452c74, var_dd43c1f2b37371c8, var_ffea00d321b63230 )
{
    if ( isdefined( var_ffea00d321b63230 ) )
    {
        function_11168df3524b02f2( var_ffea00d321b63230, var_5275110113be1abc );
        return;
    }
    
    if ( isdefined( my_corpse ) )
    {
        if ( isdefined( var_c3c074f635452c74 ) && !istrue( var_dd43c1f2b37371c8 ) && my_corpse tagexists( var_c3c074f635452c74 ) )
        {
            killfxontag( getfx( var_5275110113be1abc ), my_corpse, var_c3c074f635452c74 );
        }
        
        return;
    }
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 2
// Checksum 0x0, Offset: 0xb15
// Size: 0x2d
function function_11168df3524b02f2( var_ffea00d321b63230, var_5275110113be1abc )
{
    killfxontag( getfx( var_5275110113be1abc ), var_ffea00d321b63230, "tag_origin" );
    var_ffea00d321b63230 delete();
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0xb4a
// Size: 0x17
function is_using_flashlight()
{
    if ( istrue( self.flashlight ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0xb69
// Size: 0x17
function is_using_nvg()
{
    if ( istrue( self.nvg ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0xb88
// Size: 0x82, Type: bool
function can_use_flashlight()
{
    if ( getdvarint( @"hash_2d59deb63c029ea8", 1 ) == 1 )
    {
        return false;
    }
    
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

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0xc13
// Size: 0xa5
function function_54c942e3c8dd0485()
{
    while ( true )
    {
        enemies = scripts\mp\mp_agent::getaliveagentsofteam( "axis" );
        
        foreach ( enemy in enemies )
        {
            if ( !enemy istouching( self ) )
            {
                continue;
            }
            
            if ( enemy is_using_flashlight() )
            {
                continue;
            }
            
            if ( enemy can_use_flashlight() )
            {
                enemy enable_flashlight( 1 );
                enemy thread function_1c2287f78a78b0e5( self );
                enemy thread function_928ede0ff50c28b9();
            }
        }
        
        wait 1;
    }
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0xcc0
// Size: 0xbe
function function_c3d4be9fc432cbcd()
{
    if ( istrue( self.var_9d6a9fa7fb835c73 ) )
    {
        return;
    }
    
    if ( !isdefined( self.idle_prop ) )
    {
        return;
    }
    
    self.var_9d6a9fa7fb835c73 = 1;
    
    if ( istrue( self.flashlight ) )
    {
        enable_flashlight( 0 );
    }
    
    play_flashlight_fx( 1, 0 );
    
    while ( isdefined( self.idle_prop ) && self.idle_prop islinked() && !istrue( self.in_melee ) && !istrue( self.in_melee_death ) && !is_dead_or_dying( self ) )
    {
        wait 0.1;
    }
    
    kill_flashlight_fx();
    
    if ( isdefined( self.flashlight_slot ) )
    {
        enable_flashlight( 1 );
    }
    
    self.var_9d6a9fa7fb835c73 = 0;
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0xd86
// Size: 0x41
function function_de97882d0a7e1bef()
{
    self endon( "death" );
    self endon( "enter_combat" );
    
    if ( istrue( self.var_de97882d0a7e1bef ) )
    {
        return;
    }
    
    self.var_de97882d0a7e1bef = 1;
    
    while ( true )
    {
        self waittill( "enable_flashlight_fx" );
        thread function_c3d4be9fc432cbcd();
    }
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 1
// Checksum 0x0, Offset: 0xdcf
// Size: 0x35
function function_1c2287f78a78b0e5( area )
{
    self endon( "death" );
    
    while ( true )
    {
        if ( self istouching( area ) )
        {
            wait 1;
            continue;
        }
        
        break;
    }
    
    enable_flashlight( 0 );
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0xe0c
// Size: 0x27
function function_f697dfeffec8b3c1()
{
    self.fnstealthflashlighton = &flashlight_on;
    self.fnstealthflashlightoff = &flashlight_off;
    scripts\cp\nvg_ai::enable_flashlight( 1 );
}

// Namespace nvg_ai / scripts\cp\nvg_ai
// Params 0
// Checksum 0x0, Offset: 0xe3b
// Size: 0x292
function update_vfx_shadow_limit()
{
    if ( !flag_exist( "infil_complete" ) )
    {
        flag_init( "infil_complete" );
    }
    
    flag_wait( "infil_complete" );
    current_limit = 2;
    
    while ( true )
    {
        cull_dist = getdvarint( @"sm_spotdistcull" );
        ai_array = getaiarray( "axis" );
        var_a2ea3d917e7026b7 = 0;
        
        foreach ( player in level.players )
        {
            /#
                if ( getdvarint( @"hash_20617a1a32773be1" ) )
                {
                    thread draw_circle( player.origin, cull_dist, ( 1, 1, 1 ), 1, 0, 1 );
                }
            #/
            
            foreach ( ai in sortbydistance( ai_array, player.origin ) )
            {
                if ( distancesquared( ai.origin, player.origin ) > cull_dist * cull_dist )
                {
                    break;
                }
                
                if ( istrue( ai.flashlight ) )
                {
                    /#
                        if ( getdvarint( @"hash_20617a1a32773be1" ) )
                        {
                            tag = "<dev string:x22>";
                            
                            if ( ai tagexists( "<dev string:x2c>" ) )
                            {
                                tag = "<dev string:x2c>";
                            }
                            
                            origin = ai gettagorigin( tag );
                            angles = ai gettagangles( tag );
                            thread draw_angles( angles, origin, ( 1, 0, 0 ), 1 );
                            line( origin, origin + anglestoforward( angles ) * 450, ( 1, 0, 0 ), 1, 0, 1 );
                        }
                    #/
                    
                    var_a2ea3d917e7026b7++;
                    
                    if ( var_a2ea3d917e7026b7 >= 4 )
                    {
                        break;
                    }
                }
            }
        }
        
        var_a2ea3d917e7026b7 = clamp( var_a2ea3d917e7026b7, 2, 4 );
        
        if ( var_a2ea3d917e7026b7 != current_limit )
        {
            current_limit = var_a2ea3d917e7026b7;
            setdvar( @"hash_e08232af8b8b695c", current_limit );
            
            /#
                if ( getdvarint( @"hash_20617a1a32773be1" ) )
                {
                    iprintln( "<dev string:x36>" + current_limit );
                }
            #/
        }
        
        waitframe();
    }
    
    if ( current_limit != 2 )
    {
        setdvar( @"hash_e08232af8b8b695c", 2 );
    }
}

