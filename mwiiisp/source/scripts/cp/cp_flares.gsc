#using scripts\common\utility;
#using scripts\engine\utility;

#namespace cp_flares;

// Namespace cp_flares / scripts\cp\cp_flares
// Params 1
// Checksum 0x0, Offset: 0x274
// Size: 0x27
function flares_monitor( flarecount )
{
    self.flaresreservecount = flarecount;
    self.flareslive = [];
    thread ks_laserguidedmissile_handleincoming();
}

// Namespace cp_flares / scripts\cp\cp_flares
// Params 2
// Checksum 0x0, Offset: 0x2a3
// Size: 0x89
function flares_playfx( fxoverride, fxtagoverride )
{
    flarestag = "tag_origin";
    
    if ( isdefined( fxtagoverride ) )
    {
        flarestag = fxtagoverride;
    }
    
    if ( istrue( level.var_49bcbced231ce223 ) )
    {
        playsoundatpos( self gettagorigin( flarestag ), "ks_apache_flares" );
        playfxontag( level._effect[ "vehicle_flares" ], self, flarestag );
        return;
    }
    
    playsoundatpos( self gettagorigin( flarestag ), "ks_ac130_flares" );
    playfxontag( getfx( "gunship_flares" ), self, flarestag );
}

// Namespace cp_flares / scripts\cp\cp_flares
// Params 0
// Checksum 0x0, Offset: 0x334
// Size: 0x5b
function flares_deploy()
{
    flare = spawn( "script_origin", self.origin );
    self.flareslive[ self.flareslive.size ] = flare;
    flare thread flares_deleteaftertime( 5, 3, self );
    playsoundatpos( flare.origin, "ks_ac130_flares" );
    return flare;
}

// Namespace cp_flares / scripts\cp\cp_flares
// Params 3
// Checksum 0x0, Offset: 0x398
// Size: 0x71
function flares_deleteaftertime( delaydelete, var_66f0721fc5bc2eb5, vehicle )
{
    assertex( !isdefined( var_66f0721fc5bc2eb5 ) || var_66f0721fc5bc2eb5 < delaydelete, "flares_deleteAfterTime() delayDelete should never be greater than delayStopTracking." );
    
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

// Namespace cp_flares / scripts\cp\cp_flares
// Params 1
// Checksum 0x0, Offset: 0x411
// Size: 0x16
function flares_getnumleft( vehicle )
{
    return vehicle.flaresreservecount;
}

// Namespace cp_flares / scripts\cp\cp_flares
// Params 1
// Checksum 0x0, Offset: 0x430
// Size: 0x32, Type: bool
function flares_areavailable( vehicle )
{
    flares_cleanflareslivearray( vehicle );
    return vehicle.flaresreservecount > 0 || vehicle.flareslive.size > 0;
}

// Namespace cp_flares / scripts\cp\cp_flares
// Params 1
// Checksum 0x0, Offset: 0x46b
// Size: 0x4a
function flares_getflarereserve( vehicle )
{
    assertex( vehicle.flaresreservecount > 0, "flares_getFlareReserve() called on vehicle without any flares in reserve." );
    flares_reducereserves( vehicle );
    vehicle thread flares_playfx();
    flare = vehicle flares_deploy();
    return flare;
}

// Namespace cp_flares / scripts\cp\cp_flares
// Params 1
// Checksum 0x0, Offset: 0x4be
// Size: 0x28
function flares_cleanflareslivearray( vehicle )
{
    vehicle.flareslive = array_removeundefined( vehicle.flareslive );
}

// Namespace cp_flares / scripts\cp\cp_flares
// Params 1
// Checksum 0x0, Offset: 0x4ee
// Size: 0x4e
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

// Namespace cp_flares / scripts\cp\cp_flares
// Params 0
// Checksum 0x0, Offset: 0x545
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

// Namespace cp_flares / scripts\cp\cp_flares
// Params 4
// Checksum 0x0, Offset: 0x62a
// Size: 0xba
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
            
            missile missile_settargetent( flare );
            missile notify( "missile_pairedWithFlare" );
            break;
        }
        
        waitframe();
    }
}

// Namespace cp_flares / scripts\cp\cp_flares
// Params 1
// Checksum 0x0, Offset: 0x6ec
// Size: 0x9d
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

// Namespace cp_flares / scripts\cp\cp_flares
// Params 4
// Checksum 0x0, Offset: 0x791
// Size: 0x120
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

// Namespace cp_flares / scripts\cp\cp_flares
// Params 2
// Checksum 0x0, Offset: 0x8b9
// Size: 0xa5
function flares_handleincomingstinger( functionoverride, fxlocoverride )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self endon( "helicopter_done" );
    
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

// Namespace cp_flares / scripts\cp\cp_flares
// Params 4
// Checksum 0x0, Offset: 0x966
// Size: 0x161
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
            missiletarget thread flares_playfx( fxtagoverride );
            newtarget = undefined;
            
            if ( scripts\engine\utility::issharedfuncdefined( "flares", "deploy" ) )
            {
                newtarget = missiletarget [[ scripts\engine\utility::getsharedfunc( "flares", "deploy" ) ]]();
            }
            
            self.var_afcd53cfa79abccf = 1;
            self missile_settargetent( newtarget );
            self notify( "missile_pairedWithFlare" );
            missiletarget.var_2c72dd1407c28de0 = 1;
            level notify( "flares", player, missiletarget );
            
            while ( true )
            {
                if ( !isdefined( newtarget ) )
                {
                    missiletarget.var_2c72dd1407c28de0 = undefined;
                    return;
                }
                
                curdist = distance( self.origin, newtarget.origin );
                
                if ( curdist < 100 )
                {
                    missiletarget thread function_be1f5581f4e837b0();
                    self.owner = missiletarget;
                    self detonate();
                    return;
                }
                
                waitframe();
            }
        }
        else
        {
            missiletarget.var_2c72dd1407c28de0 = undefined;
        }
        
        waitframe();
    }
}

// Namespace cp_flares / scripts\cp\cp_flares
// Params 0
// Checksum 0x0, Offset: 0xacf
// Size: 0x16
function function_be1f5581f4e837b0()
{
    self endon( "death" );
    wait 1;
    self.var_2c72dd1407c28de0 = undefined;
}

// Namespace cp_flares / scripts\cp\cp_flares
// Params 1
// Checksum 0x0, Offset: 0xaed
// Size: 0x5b
function flares_reducereserves( flaresholder )
{
    flaresholder.flaresreservecount--;
    
    if ( isdefined( flaresholder.owner ) && isplayer( flaresholder.owner ) )
    {
        flaresholder.owner setclientomnvar( "ui_killstreak_flares", flaresholder.flaresreservecount );
    }
}

// Namespace cp_flares / scripts\cp\cp_flares
// Params 4
// Checksum 0x0, Offset: 0xb50
// Size: 0x72
function ks_setup_manual_flares( num_flares, button_action, var_b1b8f942e50d3620, var_1ec886f1b7540ead )
{
    self.flaresreservecount = num_flares;
    self.flareslive = [];
    
    if ( isdefined( var_b1b8f942e50d3620 ) && isplayer( self.owner ) )
    {
        self.owner setclientomnvar( var_b1b8f942e50d3620, num_flares );
    }
    
    thread ks_manualflares_watchuse( button_action, var_b1b8f942e50d3620 );
    thread ks_manualflares_handleincoming( var_1ec886f1b7540ead );
}

// Namespace cp_flares / scripts\cp\cp_flares
// Params 2
// Checksum 0x0, Offset: 0xbca
// Size: 0xe0
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

// Namespace cp_flares / scripts\cp\cp_flares
// Params 1
// Checksum 0x0, Offset: 0xcb2
// Size: 0x175
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
        
        if ( isdefined( self.owner ) && isplayer( self.owner ) )
        {
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

// Namespace cp_flares / scripts\cp\cp_flares
// Params 1
// Checksum 0x0, Offset: 0xe2f
// Size: 0xc0
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
                missile missile_settargetent( flare );
                missile notify( "missile_pairedWithFlare" );
                
                if ( isdefined( self.owner ) && isplayer( self.owner ) )
                {
                    self.owner stoplocalsound( "missile_incoming" );
                }
                
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace cp_flares / scripts\cp\cp_flares
// Params 2
// Checksum 0x0, Offset: 0xef7
// Size: 0x2a
function ks_watch_death_stop_sound( vehicle, sound )
{
    self endon( "disconnect" );
    vehicle waittill( "death" );
    self stoplocalsound( sound );
}

