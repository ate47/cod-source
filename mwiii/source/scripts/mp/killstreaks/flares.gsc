#using scripts\common\utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;

#namespace flares;

// Namespace flares / scripts\mp\killstreaks\flares
// Params 1
// Checksum 0x0, Offset: 0x21c
// Size: 0x27
function flares_monitor( flarecount )
{
    self.flaresreservecount = flarecount;
    self.flareslive = [];
    thread ks_laserguidedmissile_handleincoming();
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 2
// Checksum 0x0, Offset: 0x24b
// Size: 0x5d
function flares_playfx( fxoverride, fxtagoverride )
{
    flarestag = "tag_origin";
    
    if ( !isdefined( fxoverride ) )
    {
        fxoverride = "vehicle_flares";
    }
    
    if ( isdefined( fxtagoverride ) )
    {
        flarestag = fxtagoverride;
    }
    
    playsoundatpos( self gettagorigin( flarestag ), "ks_apache_flares" );
    playfxontag( level._effect[ fxoverride ], self, flarestag );
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 0
// Checksum 0x0, Offset: 0x2b0
// Size: 0x88
function flares_deploy()
{
    flare = spawn( "script_origin", self.origin + ( 0, 0, -256 ) );
    flare.angles = self.angles;
    flare movegravity( ( 0, 0, -1 ), 5 );
    self.flareslive[ self.flareslive.size ] = flare;
    flare thread flares_deleteaftertime( 5, 2, self );
    return flare;
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 3
// Checksum 0x0, Offset: 0x341
// Size: 0x71
function flares_deleteaftertime( delaydelete, var_66f0721fc5bc2eb5, vehicle )
{
    assertex( !isdefined( var_66f0721fc5bc2eb5 ) || var_66f0721fc5bc2eb5 < delaydelete, "<dev string:x1c>" );
    
    if ( isdefined( var_66f0721fc5bc2eb5 ) && isdefined( vehicle ) )
    {
        delaydelete -= var_66f0721fc5bc2eb5;
        wait var_66f0721fc5bc2eb5;
        
        if ( isdefined( vehicle ) )
        {
            vehicle.flareslive = array_remove( vehicle.flareslive, self );
        }
    }
    
    wait delaydelete;
    self delete();
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 1
// Checksum 0x0, Offset: 0x3ba
// Size: 0x16
function flares_getnumleft( vehicle )
{
    return vehicle.flaresreservecount;
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 1
// Checksum 0x0, Offset: 0x3d9
// Size: 0x32, Type: bool
function flares_areavailable( vehicle )
{
    flares_cleanflareslivearray( vehicle );
    return vehicle.flaresreservecount > 0 || vehicle.flareslive.size > 0;
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 1
// Checksum 0x0, Offset: 0x414
// Size: 0x4b
function flares_getflarereserve( vehicle )
{
    assertex( vehicle.flaresreservecount > 0, "<dev string:x74>" );
    flares_reducereserves( vehicle );
    vehicle thread flares_playfx();
    flare = vehicle flares_deploy();
    return flare;
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 1
// Checksum 0x0, Offset: 0x468
// Size: 0x28
function flares_cleanflareslivearray( vehicle )
{
    vehicle.flareslive = array_removeundefined( vehicle.flareslive );
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 1
// Checksum 0x0, Offset: 0x498
// Size: 0x4f
function flares_getflarelive( vehicle )
{
    flares_cleanflareslivearray( vehicle );
    flare = undefined;
    
    if ( vehicle.flareslive.size > 0 )
    {
        flare = vehicle.flareslive[ vehicle.flareslive.size - 1 ];
    }
    
    return flare;
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 0
// Checksum 0x0, Offset: 0x4f0
// Size: 0xdd
function ks_laserguidedmissile_handleincoming()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self endon( "helicopter_done" );
    
    while ( flares_areavailable( self ) )
    {
        level waittill( "laserGuidedMissiles_incoming", player, missiles, target );
        
        if ( !isdefined( target ) || target != self )
        {
            continue;
        }
        
        if ( !isarray( missiles ) )
        {
            missiles = [ missiles ];
        }
        
        foreach ( missile in missiles )
        {
            if ( isvalidmissile( missile ) )
            {
                level thread ks_laserguidedmissile_monitorproximity( missile, player, player.team, target );
            }
        }
    }
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 4
// Checksum 0x0, Offset: 0x5d5
// Size: 0xc2
function ks_laserguidedmissile_monitorproximity( missile, player, team, target )
{
    target endon( "death" );
    missile endon( "death" );
    missile endon( "missile_targetChanged" );
    
    while ( flares_areavailable( target ) )
    {
        if ( !isdefined( target ) || !isvalidmissile( missile ) )
        {
            break;
        }
        
        center = target getpointinbounds( 0, 0, 0 );
        
        if ( distancesquared( missile.origin, center ) < 4000000 )
        {
            flare = flares_getflarelive( target );
            
            if ( !isdefined( flare ) )
            {
                flare = flares_getflarereserve( target );
            }
            
            clearprojectilelockedon( missile );
            missile missile_settargetent( flare );
            missile notify( "missile_pairedWithFlare" );
            break;
        }
        
        waitframe();
    }
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 1
// Checksum 0x0, Offset: 0x69f
// Size: 0x9c
function flares_handleincomingsam( functionoverride )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self endon( "helicopter_done" );
    
    for ( ;; )
    {
        level waittill( "sam_fired", player, missilegroup, locktarget );
        
        if ( !isdefined( locktarget ) || locktarget != self )
        {
            continue;
        }
        
        if ( isdefined( functionoverride ) )
        {
            level thread [[ functionoverride ]]( player, player.team, locktarget, missilegroup );
            continue;
        }
        
        level thread flares_watchsamproximity( player, player.team, locktarget, missilegroup );
    }
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 4
// Checksum 0x0, Offset: 0x743
// Size: 0x127
function flares_watchsamproximity( player, missileteam, missiletarget, missilegroup )
{
    level endon( "game_ended" );
    missiletarget endon( "death" );
    
    while ( true )
    {
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = [];
        
        for ( i = 0; i < missilegroup.size ; i++ )
        {
            if ( isdefined( missilegroup[ i ] ) )
            {
                curdist[ i ] = distance( missilegroup[ i ].origin, center );
            }
        }
        
        for ( i = 0; i < curdist.size ; i++ )
        {
            if ( isdefined( curdist[ i ] ) )
            {
                if ( curdist[ i ] < 4000 && missiletarget.flaresreservecount > 0 )
                {
                    flares_reducereserves( missiletarget );
                    missiletarget thread flares_playfx();
                    newtarget = missiletarget flares_deploy();
                    
                    for ( j = 0; j < missilegroup.size ; j++ )
                    {
                        if ( isdefined( missilegroup[ j ] ) )
                        {
                            clearprojectilelockedon( missilegroup[ j ] );
                            missilegroup[ j ] missile_settargetent( newtarget );
                            missilegroup[ j ] notify( "missile_pairedWithFlare" );
                        }
                    }
                    
                    return;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 2
// Checksum 0x0, Offset: 0x872
// Size: 0xbb
function flares_handleincomingstinger( functionoverride, fxlocoverride )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self endon( "helicopter_done" );
    
    if ( !isdefined( self.flareslive ) )
    {
        self.flareslive = [];
    }
    
    for ( ;; )
    {
        level waittill( "stinger_fired", player, missile, locktarget );
        
        if ( !isdefined( locktarget ) || locktarget != self )
        {
            continue;
        }
        
        if ( isdefined( functionoverride ) )
        {
            missile thread [[ functionoverride ]]( player, player.team, locktarget, fxlocoverride );
            continue;
        }
        
        missile thread flares_watchstingerproximity( player, player.team, locktarget, fxlocoverride );
    }
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 4
// Checksum 0x0, Offset: 0x935
// Size: 0xbf
function flares_watchstingerproximity( player, missileteam, missiletarget, fxtagoverride )
{
    self endon( "death" );
    
    while ( true )
    {
        if ( !isdefined( missiletarget ) )
        {
            break;
        }
        
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = distance( self.origin, center );
        
        if ( curdist < 4000 && missiletarget.flaresreservecount > 0 )
        {
            flares_reducereserves( missiletarget );
            missiletarget thread flares_playfx( undefined, fxtagoverride );
            newtarget = missiletarget flares_deploy();
            clearprojectilelockedon( self );
            self missile_settargetent( newtarget );
            self notify( "missile_pairedWithFlare" );
            return;
        }
        
        waitframe();
    }
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 1
// Checksum 0x0, Offset: 0x9fc
// Size: 0x47
function flares_reducereserves( flaresholder )
{
    flaresholder.flaresreservecount--;
    
    if ( isdefined( flaresholder.owner ) )
    {
        flaresholder.owner setclientomnvar( "ui_killstreak_flares", flaresholder.flaresreservecount );
    }
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 4
// Checksum 0x0, Offset: 0xa4b
// Size: 0x60
function ks_setup_manual_flares( num_flares, button_action, var_b1b8f942e50d3620, var_1ec886f1b7540ead )
{
    self.flaresreservecount = num_flares;
    self.flareslive = [];
    
    if ( isdefined( var_b1b8f942e50d3620 ) )
    {
        self.owner setclientomnvar( var_b1b8f942e50d3620, num_flares );
    }
    
    thread ks_manualflares_watchuse( button_action, var_b1b8f942e50d3620 );
    thread ks_manualflares_handleincoming( var_1ec886f1b7540ead );
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 2
// Checksum 0x0, Offset: 0xab3
// Size: 0xe1
function ks_manualflares_watchuse( button_action, omnvar_name )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self endon( "helicopter_done" );
    
    if ( !isai( self.owner ) )
    {
        self.owner notifyonplayercommand( "manual_flare_popped", button_action );
    }
    
    while ( flares_getnumleft( self ) )
    {
        self.owner waittill( "manual_flare_popped" );
        flare = flares_getflarereserve( self );
        
        if ( isdefined( flare ) && isdefined( self.owner ) && !isai( self.owner ) )
        {
            self.owner playlocalsound( "ks_ac130_flares" );
            
            if ( isdefined( omnvar_name ) )
            {
                self.owner setclientomnvar( omnvar_name, flares_getnumleft( self ) );
            }
        }
    }
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 1
// Checksum 0x0, Offset: 0xb9c
// Size: 0x154
function ks_manualflares_handleincoming( omnvar_name )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self endon( "helicopter_done" );
    
    while ( flares_areavailable( self ) )
    {
        self waittill( "targeted_by_incoming_missile", missiles );
        
        if ( !isdefined( missiles ) )
        {
            continue;
        }
        
        self.owner thread ks_watch_death_stop_sound( self, "missile_incoming" );
        
        if ( isdefined( omnvar_name ) )
        {
            var_53b34aadf7b8e731 = vectornormalize( missiles[ 0 ].origin - self.origin );
            var_f2fd2ff92f5325ba = vectornormalize( anglestoright( self.angles ) );
            vec_dot = vectordot( var_53b34aadf7b8e731, var_f2fd2ff92f5325ba );
            dir_index = 1;
            
            if ( vec_dot > 0 )
            {
                dir_index = 2;
            }
            else if ( vec_dot < 0 )
            {
                dir_index = 3;
            }
            
            self.owner setclientomnvar( omnvar_name, dir_index );
        }
        
        foreach ( missile in missiles )
        {
            if ( isvalidmissile( missile ) )
            {
                thread ks_manualflares_monitorproximity( missile );
            }
        }
    }
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 1
// Checksum 0x0, Offset: 0xcf8
// Size: 0xa9
function ks_manualflares_monitorproximity( missile )
{
    self endon( "death" );
    missile endon( "death" );
    
    while ( true )
    {
        if ( !isdefined( self ) || !isvalidmissile( missile ) )
        {
            break;
        }
        
        center = self getpointinbounds( 0, 0, 0 );
        
        if ( distancesquared( missile.origin, center ) < 4000000 )
        {
            flare = flares_getflarelive( self );
            
            if ( isdefined( flare ) )
            {
                clearprojectilelockedon( missile );
                missile missile_settargetent( flare );
                missile notify( "missile_pairedWithFlare" );
                self.owner stoplocalsound( "missile_incoming" );
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace flares / scripts\mp\killstreaks\flares
// Params 2
// Checksum 0x0, Offset: 0xda9
// Size: 0x2a
function ks_watch_death_stop_sound( vehicle, sound )
{
    self endon( "disconnect" );
    vehicle waittill( "death" );
    self stoplocalsound( sound );
}

