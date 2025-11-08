#using scripts\common\values;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\equipment\ammo_box;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\player;
#using scripts\mp\utility\usability;

#namespace weapon_drop;

// Namespace weapon_drop / scripts\mp\equipment\weapon_drop
// Params 0
// Checksum 0x0, Offset: 0x38a
// Size: 0x1c
function weapondrop_init()
{
    level._effect[ "weapon_drop_impact" ] = loadfx( "vfx/iw9/killstreaks/smk_signal/vfx_carepkg_landing_dust.vfx" );
}

// Namespace weapon_drop / scripts\mp\equipment\weapon_drop
// Params 0
// Checksum 0x0, Offset: 0x3ae
// Size: 0xc, Type: bool
function weapondrop_beginsuper()
{
    thread weapondrop_givedropweapon();
    return true;
}

// Namespace weapon_drop / scripts\mp\equipment\weapon_drop
// Params 0
// Checksum 0x0, Offset: 0x3c3
// Size: 0xdc
function weapondrop_givedropweapon()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    waitframe();
    streakinfo = createstreakinfo( "weapondrop", self );
    streakinfo.deployweaponobj = makeweapon( "deploy_weapondrop_mp" );
    val::set( "giveDropWeapon", "killstreaks", 0 );
    deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy( streakinfo, streakinfo.deployweaponobj, "grenade_fire" );
    val::reset_all( "giveDropWeapon" );
    
    if ( istrue( deployresult ) )
    {
        streakinfo notify( "killstreak_finished_with_deploy_weapon" );
        
        if ( issharedfuncdefined( "supers", "superUseFinished" ) )
        {
            [[ getsharedfunc( "supers", "superUseFinished" ) ]]();
        }
        
        return;
    }
    
    if ( issharedfuncdefined( "supers", "superUseFinished" ) )
    {
        [[ getsharedfunc( "supers", "superUseFinished" ) ]]( 1 );
    }
}

// Namespace weapon_drop / scripts\mp\equipment\weapon_drop
// Params 1
// Checksum 0x0, Offset: 0x4a7
// Size: 0x39, Type: bool
function weapondrop_used( grenade )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    grenade waittill( "explode", pos );
    grenade weapondrop_deploydrone( self, pos );
    return true;
}

// Namespace weapon_drop / scripts\mp\equipment\weapon_drop
// Params 2
// Checksum 0x0, Offset: 0x4e9
// Size: 0xfb
function weapondrop_deploydrone( owner, pos )
{
    drone = owner scripts\cp_mp\killstreaks\helper_drone::deliverydrone_delivertopoint( pos, &weapondrop_dronedelivery );
    
    if ( isdefined( drone ) )
    {
        deliverybox = spawn( "script_model", drone.origin );
        deliverybox setmodel( "military_crate_field_upgrade_01" );
        deliverybox setotherent( owner );
        deliverybox.owner = owner;
        deliverybox.team = owner.team;
        deliverybox linkto( drone, "tag_origin", ( 0, 0, -15 ), ( 0, 0, 0 ) );
        deliverybox enableplayermarks( "killstreak" );
        
        if ( level.teambased )
        {
            deliverybox filteroutplayermarks( owner.team );
        }
        else
        {
            deliverybox filteroutplayermarks( owner );
        }
        
        drone.deliverybox = deliverybox;
        drone thread weapondrop_createdropondeath( deliverybox );
    }
}

// Namespace weapon_drop / scripts\mp\equipment\weapon_drop
// Params 0
// Checksum 0x0, Offset: 0x5ec
// Size: 0x12
function weapondrop_dronedelivery()
{
    self.deliverybox weapondrop_createdrop();
}

// Namespace weapon_drop / scripts\mp\equipment\weapon_drop
// Params 1
// Checksum 0x0, Offset: 0x606
// Size: 0x38
function weapondrop_createdropondeath( deliverybox )
{
    level endon( "game_ended" );
    level endon( "prematch_cleanup" );
    deliverybox endon( "deliveryBox_dropped" );
    deliverybox endon( "death" );
    self waittill( "death" );
    deliverybox thread weapondrop_createdrop();
}

// Namespace weapon_drop / scripts\mp\equipment\weapon_drop
// Params 0
// Checksum 0x0, Offset: 0x646
// Size: 0x89
function weapondrop_createdrop()
{
    if ( istrue( self.hasdropped ) )
    {
        return;
    }
    
    self.hasdropped = 1;
    self notify( "deliveryBox_dropped" );
    self unlink();
    cratephysicson();
    targetlocation = self.origin - ( 0, 0, 1000 );
    killstreak_createdangerzone( targetlocation, 100, 1000, 30, self.owner, self.team, 0 );
    thread watchcrateimpact();
    thread watchcratesettle();
}

// Namespace weapon_drop / scripts\mp\equipment\weapon_drop
// Params 0
// Checksum 0x0, Offset: 0x6d7
// Size: 0x10
function deletecrate()
{
    cratephysicsoff();
    self delete();
}

// Namespace weapon_drop / scripts\mp\equipment\weapon_drop
// Params 0
// Checksum 0x0, Offset: 0x6ef
// Size: 0x78
function cratephysicson()
{
    if ( istrue( self.physicson ) )
    {
        return;
    }
    
    self.physicson = 1;
    self.unresolved_collision_kill = 1;
    self physicslaunchserver( ( 0, 0, 0 ), ( 0, 0, 0 ), 1200 );
    bodyid = self physics_getbodyid( 0 );
    physics_setbodycenterofmassnormal( bodyid, ( 0, 0, -0.75 ) );
    self physics_registerforcollisioncallback();
}

// Namespace weapon_drop / scripts\mp\equipment\weapon_drop
// Params 0
// Checksum 0x0, Offset: 0x76f
// Size: 0x4d
function cratephysicsoff()
{
    if ( !istrue( self.physicson ) )
    {
        return;
    }
    
    self notify( "crate_physics_off" );
    self.physicson = undefined;
    self.unresolved_collision_kill = undefined;
    self physicsstopserver();
    self physics_unregisterforcollisioncallback();
    self stoploopsound( "mp_care_package_drop_lp" );
    killstreak_destroydangerzone();
}

// Namespace weapon_drop / scripts\mp\equipment\weapon_drop
// Params 0
// Checksum 0x0, Offset: 0x7c4
// Size: 0x5c
function watchcratesettle()
{
    self endon( "crate_physics_off" );
    watchcratesettleinternal();
    
    if ( issharedfuncdefined( "entity", "touchingBadTrigger" ) )
    {
        if ( self [[ getsharedfunc( "entity", "touchingBadTrigger" ) ]]() )
        {
            thread deletecrate();
            return;
        }
    }
    
    self.owner thread scripts\mp\equipment\ammo_box::ammobox_settled( self );
    thread cratephysicsoff();
}

// Namespace weapon_drop / scripts\mp\equipment\weapon_drop
// Params 0
// Checksum 0x0, Offset: 0x828
// Size: 0x5b
function watchcratesettleinternal()
{
    wait 1;
    endtime = gettime() + 10000;
    
    while ( gettime() < endtime )
    {
        bodyid = self physics_getbodyid( 0 );
        velocity = physics_getbodylinvel( bodyid );
        
        if ( lengthsquared( velocity ) <= 0.5 )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace weapon_drop / scripts\mp\equipment\weapon_drop
// Params 1
// Checksum 0x0, Offset: 0x88b
// Size: 0x118
function watchcrateimpact( delay )
{
    self endon( "crate_physics_off" );
    self playloopsound( "mp_care_package_drop_lp" );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    var_260ef1536027d0e1 = 0;
    
    while ( true )
    {
        self waittill( "collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        
        if ( isdefined( ent ) && ent scripts\cp_mp\killstreaks\helper_drone::ishelperdrone() )
        {
            ent thread scripts\cp_mp\killstreaks\helper_drone::function_ba1c5496f8fc5f67();
        }
        
        if ( gettime() - var_260ef1536027d0e1 >= 200 )
        {
            var_260ef1536027d0e1 = gettime();
            surface = physics_getsurfacetypefromflags( flag1 );
            surfacetype = getsubstr( surface[ "name" ], 9 );
            
            if ( surfacetype == "user_terrain1" )
            {
                surfacetype = "user_terrain_1";
            }
            
            if ( surfacetype == "user_terrain5" )
            {
                surfacetype = "user_terrain_5";
            }
            
            playcrateimpactfx( position, normal, impulse, surfacetype );
        }
    }
}

// Namespace weapon_drop / scripts\mp\equipment\weapon_drop
// Params 4
// Checksum 0x0, Offset: 0x9ab
// Size: 0x7e
function playcrateimpactfx( position, normal, impulse, surfacetype )
{
    playfx( getfx( "weapon_drop_impact" ), position, normal );
    
    if ( impulse < 150 )
    {
        self playsurfacesound( "mp_care_package_low_impact", surfacetype );
    }
    else if ( impulse < 300 )
    {
        self playsurfacesound( "mp_care_package_med_impact", surfacetype );
    }
    else
    {
        self playsurfacesound( "mp_care_package_high_impact", surfacetype );
    }
    
    self stoploopsound( "mp_care_package_drop_lp" );
}

