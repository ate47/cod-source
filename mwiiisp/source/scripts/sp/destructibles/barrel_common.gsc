#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\player\gestures;
#using scripts\sp\utility;

#namespace barrel_common;

// Namespace barrel_common / scripts\sp\destructibles\barrel_common
// Params 7
// Checksum 0x0, Offset: 0x14b
// Size: 0xe0
function barrel_setup( subtype, barrel_health, barrel_radius, amp_normal, amp_max, min_range_max_amp, repulsor_radius )
{
    if ( !isdefined( level.phys_barrels ) )
    {
        level.phys_barrels = [];
    }
    
    level.phys_barrels = array_add( level.phys_barrels, self );
    self.onfire = undefined;
    self.subtype = subtype;
    self.isbarrel = 1;
    self setcandamage( 1 );
    self.barrel_health = barrel_health;
    self.phys_barrel_radius = barrel_radius;
    self.phys_amp_normal = amp_normal;
    self.phys_amp_max = amp_max;
    self.min_range_max_amp = min_range_max_amp;
    self.spewtags = [];
    thread barrel_cleanup();
    thread barrel_nav_obstruction();
}

// Namespace barrel_common / scripts\sp\destructibles\barrel_common
// Params 0
// Checksum 0x0, Offset: 0x233
// Size: 0xb9
function barrel_nav_obstruction()
{
    navobstruction = createnavobstaclebybounds( self.origin, ( 12, 12, 50 ), ( 0, 0, 0 ) );
    repulsor_name = undefined;
    
    while ( isdefined( self ) && self.spewtags.size <= 0 )
    {
        wait 0.05;
    }
    
    if ( !isdefined( self ) )
    {
        destroynavobstacle( navobstruction );
        return;
    }
    
    var_90d8a00109786d78 = self.phys_barrel_radius / 4.5;
    repulsor_name = "barrel" + self getentitynumber();
    createnavrepulsor( repulsor_name, -1, self, var_90d8a00109786d78, 1 );
    waittill_either( "barrel_death", "entitydeleted" );
    destroynavobstacle( navobstruction );
}

// Namespace barrel_common / scripts\sp\destructibles\barrel_common
// Params 1
// Checksum 0x0, Offset: 0x2f4
// Size: 0x1a, Type: bool
function is_self_detonating( subtype )
{
    return self.subtype == "red";
}

// Namespace barrel_common / scripts\sp\destructibles\barrel_common
// Params 0
// Checksum 0x0, Offset: 0x317
// Size: 0x2c
function barrel_cleanup()
{
    waittill_either( "barrel_death", "entitydeleted" );
    level.phys_barrels = array_remove( level.phys_barrels, self );
}

// Namespace barrel_common / scripts\sp\destructibles\barrel_common
// Params 1
// Checksum 0x0, Offset: 0x34b
// Size: 0x9e
function get_barrels( subtype )
{
    if ( !isdefined( subtype ) )
    {
        return level.phys_barrels;
    }
    
    barrels = [];
    
    foreach ( barrel in level.phys_barrels )
    {
        if ( isdefined( barrel.subtype ) && barrel.subtype == subtype )
        {
            barrels = array_add( barrels, barrel );
        }
    }
    
    return barrels;
}

// Namespace barrel_common / scripts\sp\destructibles\barrel_common
// Params 1
// Checksum 0x0, Offset: 0x3f1
// Size: 0x3c
function barrel_fusetimer( timer )
{
    self endon( "barrel_death" );
    self notify( "new_barrel_timer" );
    self endon( "new_barrel_timer" );
    wait timer;
    
    while ( isdefined( self.dont_explode ) )
    {
        waitframe();
    }
    
    self notify( "barrel_death" );
}

// Namespace barrel_common / scripts\sp\destructibles\barrel_common
// Params 2
// Checksum 0x0, Offset: 0x435
// Size: 0x10b
function barrel_block_gesture( max_dist, spot )
{
    if ( level.player isthrowinggrenade() || level.player isthrowingbackgrenade() )
    {
        return;
    }
    
    dist = distance2dsquared( level.player.origin, spot );
    
    if ( dist > squared( max_dist ) )
    {
        return;
    }
    
    if ( dist > squared( max_dist * 0.25 ) )
    {
        dot = vectordot( flatten_vector( vectornormalize( spot - level.player.origin ) ), anglestoforward( level.player.angles ) );
        
        if ( dot < 0 )
        {
            return;
        }
    }
    
    if ( !scripts\engine\trace::ray_trace_passed( spot + ( 0, 0, 12 ), level.player geteye(), undefined, scripts\engine\trace::create_world_contents() ) )
    {
        return;
    }
    
    level.player thread barrel_reaction_gesture( spot );
}

// Namespace barrel_common / scripts\sp\destructibles\barrel_common
// Params 1
// Checksum 0x0, Offset: 0x548
// Size: 0xb4
function barrel_reaction_gesture( spot )
{
    self endon( "death" );
    tagorigin = spawn_tag_origin( spot, ( 0, 0, 0 ) );
    thread delete_on_death( tagorigin );
    gesturename = "ges_frag_block";
    gestureplayed = self playgestureviewmodel( gesturename, tagorigin, 1, 0.1 );
    
    if ( gestureplayed )
    {
        childthread scripts\sp\player\gestures::player_gestures_input_disable( gesturename, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1.4, "barrelReactionGesture" );
        
        while ( true )
        {
            self waittill( "gesture_stopped", gesturename );
            
            if ( gesturename == "ges_frag_block" )
            {
                break;
            }
        }
    }
    
    if ( isdefined( tagorigin ) )
    {
        tagorigin delete();
    }
}

// Namespace barrel_common / scripts\sp\destructibles\barrel_common
// Params 2
// Checksum 0x0, Offset: 0x604
// Size: 0x46, Type: bool
function isplayersniperhit( attacker, objweapon )
{
    if ( isdefined( attacker ) && isdefined( objweapon ) && attacker == level.player && objweapon.classname == "sniper" )
    {
        return true;
    }
    
    return false;
}

// Namespace barrel_common / scripts\sp\destructibles\barrel_common
// Params 1
// Checksum 0x0, Offset: 0x653
// Size: 0x1f, Type: bool
function isdirectunderbarrelhit( type )
{
    if ( isdefined( type ) && type == "MOD_IMPACT" )
    {
        return true;
    }
    
    return false;
}

// Namespace barrel_common / scripts\sp\destructibles\barrel_common
// Params 3
// Checksum 0x0, Offset: 0x67b
// Size: 0x69
function isgrenadeinrange( point, type, range )
{
    if ( !isdefined( type ) )
    {
        return 0;
    }
    
    if ( isdefined( type ) && type != "MOD_GRENADE" && type != "MOD_GRENADE_SPLASH" )
    {
        return 0;
    }
    
    if ( !isdefined( point ) )
    {
        return;
    }
    
    dist = distance( self.origin, point );
    
    if ( dist > range )
    {
        return 0;
    }
    
    return 1;
}

// Namespace barrel_common / scripts\sp\destructibles\barrel_common
// Params 2
// Checksum 0x0, Offset: 0x6ed
// Size: 0x49, Type: bool
function isvalidbarreldamage( attacker, type )
{
    if ( isdefined( attacker ) && isai( attacker ) )
    {
        return false;
    }
    
    if ( isdefined( attacker ) && isdefined( attacker.isbarrel ) )
    {
        return false;
    }
    
    if ( ismeleedamage( type ) )
    {
        return false;
    }
    
    return true;
}

// Namespace barrel_common / scripts\sp\destructibles\barrel_common
// Params 3
// Checksum 0x0, Offset: 0x73f
// Size: 0xb7
function barrel_launch( explodeorigin, distancefrombarrel, timer )
{
    self endon( "barrel_death" );
    wait timer;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    throwvec = vectornormalize( self.origin - explodeorigin );
    physamplifier = self.phys_amp_normal;
    
    if ( distancefrombarrel <= self.min_range_max_amp )
    {
        physamplifier = self.phys_amp_max;
    }
    
    distcheck = self.phys_barrel_radius - distancefrombarrel;
    throwamplifier = distcheck / self.phys_barrel_radius;
    throwamplifier *= physamplifier;
    self physicslaunchserver( self.origin, throwvec * throwamplifier );
}

// Namespace barrel_common / scripts\sp\destructibles\barrel_common
// Params 0
// Checksum 0x0, Offset: 0x7fe
// Size: 0x14
function barrel_one_hit_kill()
{
    self waittill( "damage" );
    waitframe();
    waitframe();
    self notify( "barrel_death" );
}

// Namespace barrel_common / scripts\sp\destructibles\barrel_common
// Params 0
// Checksum 0x0, Offset: 0x81a
// Size: 0xa2
function barrel_player()
{
    self endon( "entitydeleted" );
    
    while ( true )
    {
        while ( distancesquared( level.player.origin, self.origin ) > squared( 40 ) )
        {
            wait 0.05;
        }
        
        physorigin = self physics_getentitycenterofmass();
        physorigin = physorigin[ "unscaled" ] + ( 0, 0, 4 );
        self physicslaunchserver( physorigin, vectornormalize( self.origin - level.player.origin ) * 1000 );
        wait 0.05;
    }
}

// Namespace barrel_common / scripts\sp\destructibles\barrel_common
// Params 0
// Checksum 0x0, Offset: 0x8c4
// Size: 0x9e
function barrel_debug()
{
    self endon( "barrel_death" );
    starttime = undefined;
    lasttimer = undefined;
    setdvarifuninitialized( @"barrel_debug", 0 );
    
    for ( ;; )
    {
        if ( !getdvarint( @"barrel_debug" ) )
        {
        }
        else
        {
            /#
                print3d( self gettagorigin( "<dev string:x1c>" ) + ( 0, 0, 10 ), self.barrel_health );
            #/
            
            thread draw_circle( self.origin, 250, ( 1, 0, 0 ), 1, 0, 1 );
        }
        
        wait 0.05;
    }
}

