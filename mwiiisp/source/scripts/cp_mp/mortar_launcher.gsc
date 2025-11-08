#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace mortar_launcher;

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 0
// Checksum 0x0, Offset: 0x47a
// Size: 0xe3
function mortar_launcher_init()
{
    load_fx();
    mortars = getentarray( "player_mortar", "targetname" );
    
    if ( isdefined( mortars ) && mortars.size > 0 )
    {
        setupmortarmodelanimscripts();
        setupmortarplayeranimscripts();
    }
    else
    {
        return;
    }
    
    foreach ( mortar in mortars )
    {
        if ( istrue( level.ismp ) )
        {
            if ( !isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ) || isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ) && isdefined( mortar.script_noteworthy ) && mortar.script_noteworthy != level.localeid )
            {
                mortar delete();
                continue;
            }
        }
        
        mortar thread mortar_test( mortar );
    }
}

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 0
// Checksum 0x0, Offset: 0x565
// Size: 0x50
function load_fx()
{
    level._effect[ "vfx_flare_launch" ] = loadfx( "vfx/iw8/level/embassy/vfx_mortar_fire.vfx" );
    level._effect[ "vfx_mortar_trail" ] = loadfx( "vfx/iw8/level/highway/vfx_mortar_trail.vfx" );
    level._effect[ "vfx_mortar_explosion" ] = loadfx( "vfx/iw8/weap/_explo/mortar/vfx_mortar_explosion_bm.vfx" );
}

#using_animtree( "script_model" );

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 0
// Checksum 0x0, Offset: 0x5bd
// Size: 0x6d
function setupmortarplayeranimscripts()
{
    level.scr_animtree[ "player_mortar" ] = #animtree;
    level.scr_anim[ "player_mortar" ][ "player_mortar_fire" ] = %emb_vm_mortar_player;
    level.scr_eventanim[ "player_mortar" ][ "player_mortar_fire" ] = %"player_mortar_fire";
    level.scr_viewmodelanim[ "player_mortar" ][ "player_mortar_fire" ] = "emb_vm_mortar_player";
}

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 0
// Checksum 0x0, Offset: 0x632
// Size: 0x63
function setupmortarmodelanimscripts()
{
    level.scr_animtree[ "mortar" ] = #animtree;
    level.scr_model[ "mortar" ] = "misc_wm_mortar";
    level.scr_anim[ "mortar" ][ "player_mortar_fire" ] = %emb_vm_mortar_mortar;
    level.scr_viewmodelanim[ "mortar" ][ "player_mortar_fire" ] = "emb_vm_mortar_mortar";
}

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 4
// Checksum 0x0, Offset: 0x69d
// Size: 0xc0
function create_player_rig( player, animname, rig_model, blockview )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player.animname = animname;
    player function_b88c89bb7cd1ab8e( player.origin );
    player_rig = spawn( "script_arms", player.origin, 0, 0, player );
    player_rig.player = player;
    player.player_rig = player_rig;
    player.player_rig hide();
    player.player_rig.animname = animname;
    player.player_rig useanimtree( #animtree );
}

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 7
// Checksum 0x0, Offset: 0x765
// Size: 0xba
function put_player_into_rig( rig, blendtime, right, left, top, bottom, player )
{
    player val::set( "put_player_into_rig", "ads", 0 );
    player val::set( "put_player_into_rig", "prone", 0 );
    player val::set( "put_player_into_rig", "crouch", 0 );
    player val::set( "put_player_into_rig", "weapon_switch", 0 );
    
    if ( blendtime > 0 )
    {
        player playerlinktoblend( rig, "tag_player", blendtime, 0, 0 );
        wait blendtime;
    }
    
    player playerlinktodelta( rig, "tag_player", 1, right, left, top, bottom, 1 );
}

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 1
// Checksum 0x0, Offset: 0x827
// Size: 0x3d
function take_player_out_of_rig( player )
{
    player val::reset_all( "mortar" );
    player val::reset_all( "put_player_into_rig" );
    player unlink();
    player.player_rig delete();
}

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 2
// Checksum 0x0, Offset: 0x86c
// Size: 0x70
function mortar_launch_player_effect( player, mortar )
{
    if ( !istrue( level.ismp ) )
    {
        mortar playsound( "weap_mortar_load" );
    }
    
    wait 2.2;
    player playrumbleonentity( "damage_bullet" );
    earthquake( 0.24, 1, mortar.origin, 256 );
    mortar hidepart( mortar.shell, "misc_wm_mortar" );
}

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 5
// Checksum 0x0, Offset: 0x8e4
// Size: 0x220
function movemortar( model, start, end, time, height )
{
    setdvarifuninitialized( @"hash_7a0d2f4714304d2b", "0 " );
    
    if ( getdvarint( @"hash_7a0d2f4714304d2b" ) )
    {
        model.origin = start;
        gravity = getdvarint( @"bg_gravity" );
        dist = distance( start, end );
        delta = end - start;
        drop = 0.5 * gravity * squared( time ) * -1;
        vel = ( delta[ 0 ] / time, delta[ 1 ] / time, ( delta[ 2 ] - drop ) / time );
        model movegravity( vel, time );
        endtime = gettime() + time * 1000;
        
        while ( gettime() < endtime )
        {
            model anglemortar();
            waitframe();
        }
        
        return;
    }
    
    apex = 1200;
    
    if ( isdefined( height ) )
    {
        apex = height;
    }
    
    framefrac = 1 / time / 0.05;
    frac = 0;
    
    while ( frac < 1 )
    {
        model.origin = math::get_point_on_parabola( start, end, apex, frac );
        model anglemortar();
        
        /#
            if ( istrue( level.mortar_debug ) )
            {
                thread draw_line_for_time( model.origin, model.origin + ( 0, 0, 128 ), 1, 1, 1, 0.05 );
            }
        #/
        
        frac += framefrac;
        wait 0.05;
    }
    
    model.origin = end;
    
    /#
        if ( istrue( level.mortar_debug ) )
        {
            thread draw_line_for_time( model.origin, model.origin + ( 0, 0, 128 ), 1, 1, 1, 5 );
        }
    #/
}

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 0
// Checksum 0x0, Offset: 0xb0c
// Size: 0x5f
function anglemortar()
{
    if ( !isdefined( self.prevorigin ) )
    {
        self.prevorigin = self.origin;
        self.roll = 0;
        return;
    }
    
    self.angles = vectortoangles( self.origin - self.prevorigin );
    self.prevorigin = self.origin;
}

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 1
// Checksum 0x0, Offset: 0xb73
// Size: 0x190
function mortar_test( mortar )
{
    if ( !istrue( level.ismp ) )
    {
        mortar.interact = mortarlauncher_createhintobject( mortar.origin + ( 0, 0, 40 ), "HINT_BUTTON", undefined, &"CP_DWN_TWN_OBJECTIVES/ROOF_DEFEND", undefined, undefined, "show", 50, 160, 32, 120 );
    }
    else
    {
        mortar.interact = mortarlauncher_createhintobject( mortar.origin + ( 0, 0, 40 ), "HINT_BUTTON", undefined, &"MP_INGAME_ONLY/USE_MORTAR", undefined, undefined, "show", 256, 160, 128, 160 );
    }
    
    mortar.flash = "j_shaft_top";
    mortar.shell = "j_mortar_shell";
    mortar hidepart( mortar.shell, "misc_wm_mortar" );
    mortar.animname = "mortar";
    mortar useanimtree( #animtree );
    mortar.og_angles = mortar.angles;
    
    while ( true )
    {
        mortar.interact makeusable();
        mortar.interact waittill( "trigger", player );
        player val::set( "mortar_test", "usability", 0 );
        mortar.interact makeunusable();
        player_launch_mortar( player, mortar );
        wait 5;
        mortar rotateto( mortar.og_angles, 0.1 );
        wait 1;
    }
}

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 2
// Checksum 0x0, Offset: 0xd0b
// Size: 0x1d9
function player_launch_mortar( player, mortar )
{
    self endon( "death_or_disconnect" );
    player setorigin( mortar.origin );
    player setplayerangles( mortar.angles );
    player create_player_rig( player, "player_mortar" );
    player.player_rig.angles = mortar.angles;
    put_player_into_rig( player.player_rig, 0.5, 0, 0, 0, 0, player );
    player val::set( "mortar", "weapon", 0 );
    result = player mortar_targetting( mortar );
    
    if ( isdefined( result ) )
    {
        player playerlinktodelta( player.player_rig, "tag_player", 1, 0, 0, 0, 0, 1 );
        angles = vectortoangles( result - mortar.origin );
        mortar.angles = ( 0, angles[ 1 ], 0 );
        mortar showpart( mortar.shell, "misc_wm_mortar" );
        player.player_rig show();
        mortar delaythread( 2.25, &launch_mortar, result, player );
        thread mortar_launch_player_effect( player, mortar );
        mortar thread scripts\common\anim::anim_single( [ mortar, player.player_rig ], "player_mortar_fire" );
        player.player_rig waittillmatch( "single anim", "end" );
        mortar notify( "mortar_fired" );
    }
    
    player val::reset_all( "mortar_test" );
    mortar hidepart( mortar.shell, "misc_wm_mortar" );
    take_player_out_of_rig( player );
    
    if ( isdefined( mortar.previs_model ) )
    {
        mortar.previs_model delete();
    }
}

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 1
// Checksum 0x0, Offset: 0xeec
// Size: 0x24f
function mortar_targetting( mortar )
{
    self endon( "death_or_disconnect" );
    thread mortar_ondeathcleanup( mortar );
    pos = undefined;
    self playerlinktodelta( self.player_rig, "tag_player", 0, 45, 45, 60, 60, 1 );
    
    if ( isdefined( mortar.previs_model ) )
    {
        mortar.previs_model setscriptablepartstate( "target", "active" );
    }
    
    while ( true )
    {
        if ( self stancebuttonpressed() || self attackbuttonpressed() )
        {
            if ( self attackbuttonpressed() )
            {
                while ( self attackbuttonpressed() )
                {
                    wait 0.05;
                }
                
                return pos;
            }
            
            while ( self stancebuttonpressed() )
            {
                wait 0.05;
            }
            
            return undefined;
        }
        
        trace = scripts\engine\trace::ray_trace( self geteye() + ( 0, 0, 128 ), self geteye() + anglestoforward( self getplayerangles() ) * 16000 );
        pos = getgroundposition( trace[ "position" ], 8, 0, 1500 );
        angles = vectortoangles( pos - mortar.origin );
        mortar.angles = ( 0, angles[ 1 ], 0 );
        
        if ( !isdefined( mortar.previs_model ) )
        {
            mortar.previs_model = spawn( "script_model", pos );
            mortar.previs_model setmodel( "mortar_target" );
            mortar.previs_model.angles = ( -90, 0, 0 );
            mortar.previs_model setscriptablepartstate( "target", "active" );
            
            foreach ( player in level.players )
            {
                mortar.previs_model hidefromplayer( player );
            }
            
            mortar.previs_model showtoplayer( self );
        }
        
        mortar.previs_model moveto( pos + ( 0, 0, 10 ), 0.1 );
        wait 0.05;
    }
}

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 1
// Checksum 0x0, Offset: 0x1143
// Size: 0x3a
function mortar_ondeathcleanup( mortar )
{
    mortar endon( "mortar_fired" );
    self waittill( "death_or_disconnect" );
    
    if ( isdefined( mortar.previs_model ) )
    {
        mortar.previs_model delete();
    }
}

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 2
// Checksum 0x0, Offset: 0x1185
// Size: 0x2b1
function launch_mortar( endpos, player )
{
    start = self gettagorigin( "j_shaft_top" );
    end = getgroundposition( self.origin + anglestoforward( self.angles ) * 8000, 8, 1000 );
    
    if ( isdefined( endpos ) )
    {
        end = endpos;
    }
    
    mortar = spawn_tag_origin( self gettagorigin( "j_shaft_top" ), ( 0, 0, 0 ) );
    mortar setmodel( "equipment_mortar_shell_improvised_01_mp" );
    playfx( getfx( "vfx_flare_launch" ), self.origin + ( 0, 0, 3 ) + anglestoforward( self.angles ) * 8, anglestoforward( self.angles ) );
    
    if ( !istrue( level.ismp ) )
    {
        playsoundatpos( self gettagorigin( "j_shaft_top" ), "weap_mortar_flare_launch" );
    }
    else
    {
        playsoundatpos( self gettagorigin( "j_shaft_top" ), "weap_mortar_flare_launch" );
    }
    
    mortar show();
    time = 5;
    thread movemortar( mortar, start, end, time, 1200 );
    wait 0.1;
    playfxontag( getfx( "vfx_mortar_trail" ), mortar, "tag_origin" );
    
    if ( !istrue( level.ismp ) )
    {
        mortar playloopsound( "weap_mortar_fly_lp" );
    }
    else
    {
        mortar playloopsound( "weap_mortar_fly_lp" );
    }
    
    wait time - 1.7;
    
    if ( !istrue( level.ismp ) )
    {
        mortar playsound( "weap_mortar_incoming" );
    }
    
    wait 1.7;
    stopfxontag( getfx( "vfx_mortar_trail" ), mortar, "tag_origin" );
    mortar stoploopsound();
    playfx( getfx( "vfx_mortar_explosion" ), end );
    earthquake( 0.25, 3, end, 2048 );
    
    if ( !istrue( level.ismp ) )
    {
        playrumbleonposition( "cp_chopper_rumble", end );
    }
    else
    {
        playrumbleonposition( "grenade_rumble", end );
        playsoundatpos( end, "weap_mortar_expl_trans" );
    }
    
    magicgrenademanual( "mortar_mp", end + ( 0, 0, 5 ), ( 0, 0, 0 ), 0.05 );
    
    if ( !istrue( level.ismp ) )
    {
        radiusdamage( end + ( 0, 0, 5 ), 512, 250, 250, player, "MOD_EXPLOSIVE", "c4_mp" );
    }
    else
    {
        radiusdamage( end + ( 0, 0, 5 ), 512, 1000, 250, player, "MOD_EXPLOSIVE", "c4_mp" );
    }
    
    mortar delete();
}

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 0
// Checksum 0x0, Offset: 0x143e
// Size: 0x1b
function kill_mortar_target()
{
    self.previs_model setscriptablepartstate( "target", "neutral" );
}

// Namespace mortar_launcher / scripts\cp_mp\mortar_launcher
// Params 12
// Checksum 0x0, Offset: 0x1461
// Size: 0x1b6
function mortarlauncher_createhintobject( org, type, icon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov, useent )
{
    hintobj = undefined;
    
    if ( isdefined( useent ) )
    {
        hintobj = useent;
    }
    else
    {
        hintobj = spawn( "script_model", org );
    }
    
    hintobj makeusable();
    
    if ( isdefined( useent ) && isdefined( org ) )
    {
        assertex( isstring( org ), "When creating a hint object with a passed in ent, you need to set org to a tag on that model" );
        hintobj sethinttag( org );
    }
    
    if ( isdefined( type ) )
    {
        hintobj setcursorhint( type );
    }
    else
    {
        hintobj setcursorhint( "HINT_NOICON" );
    }
    
    if ( isdefined( icon ) )
    {
        hintobj sethinticon( icon );
    }
    
    if ( isdefined( hintstring ) )
    {
        hintobj sethintstring( hintstring );
    }
    
    if ( isdefined( priority ) )
    {
        hintobj setusepriority( priority );
    }
    else
    {
        hintobj setusepriority( 0 );
    }
    
    if ( isdefined( duration ) )
    {
        hintobj setuseholdduration( duration );
    }
    else
    {
        hintobj setuseholdduration( "duration_short" );
    }
    
    if ( isdefined( onobstruction ) )
    {
        hintobj sethintonobstruction( onobstruction );
    }
    else
    {
        hintobj sethintonobstruction( "hide" );
    }
    
    if ( isdefined( hintdist ) )
    {
        hintobj sethintdisplayrange( hintdist );
    }
    else
    {
        hintobj sethintdisplayrange( 200 );
    }
    
    if ( isdefined( hintfov ) )
    {
        hintobj sethintdisplayfov( hintfov );
    }
    else
    {
        hintobj sethintdisplayfov( 160 );
    }
    
    if ( isdefined( usedist ) )
    {
        hintobj setuserange( usedist );
    }
    else
    {
        hintobj setuserange( 50 );
    }
    
    if ( isdefined( usefov ) )
    {
        hintobj setusefov( usefov );
    }
    else
    {
        hintobj setusefov( 120 );
    }
    
    if ( !isdefined( useent ) )
    {
        return hintobj;
    }
}

