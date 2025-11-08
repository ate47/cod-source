#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\helicopter_ai;
#using scripts\sp\helicopter_globals;
#using scripts\sp\utility;
#using scripts\vehicle\attack_heli;

#namespace helicopter_globals;

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 0
// Checksum 0x0, Offset: 0x621
// Size: 0x2c
function init_helicopters()
{
    level.helicopter_firelinkfunk = &heli_firelink;
    level.chopperturretonfunc = &chopper_turret_on;
    level.chopperturretofffunc = &chopper_turret_off;
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 0
// Checksum 0x0, Offset: 0x655
// Size: 0xa
function chopper_turret_off()
{
    self notify( "mg_off" );
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 0
// Checksum 0x0, Offset: 0x667
// Size: 0x5d
function chopper_turret_on()
{
    self endon( "death" );
    self endon( "mg_off" );
    var_7d1b1b765f5db6e4 = cos( 55 );
    
    while ( self.health > 0 )
    {
        etarget = scripts\sp\helicopter_globals::getenemytarget( 16000, var_7d1b1b765f5db6e4, 1, 1 );
        
        if ( isdefined( etarget ) )
        {
            thread scripts\sp\helicopter_globals::shootenemytarget_bullets( etarget );
        }
        
        wait 2;
    }
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 1
// Checksum 0x0, Offset: 0x6cc
// Size: 0x27d
function heli_firelink( nextpoint )
{
    target = getent( nextpoint.script_linkto, "script_linkname" );
    var_243154aac115bc0a = !isdefined( target );
    
    if ( !isdefined( target ) )
    {
        target = getstruct( nextpoint.script_linkto, "script_linkname" );
        assertex( isdefined( target ), "No target for script_firelink" );
    }
    
    fire_burst = nextpoint.script_firelink;
    
    if ( var_243154aac115bc0a )
    {
        target = target spawn_tag_origin();
    }
    
    switch ( fire_burst )
    {
        case #"hash_2c6245580ea45116":
            wait 1;
            scripts\sp\helicopter_globals::fire_missile( "hind_zippy", 1, target );
            wait 0.1;
            scripts\sp\helicopter_globals::fire_missile( "hind_zippy", 1, target );
            wait 0.2;
            scripts\sp\helicopter_globals::fire_missile( "hind_zippy", 1, target );
            wait 0.3;
            scripts\sp\helicopter_globals::fire_missile( "hind_zippy", 1, target );
            wait 0.3;
            scripts\sp\helicopter_globals::fire_missile( "hind_zippy", 1, target );
            break;
        case #"hash_4c67bcd319c7e278":
            waits = [ 0.1, 0.2, 0.3 ];
            wait 1;
            target.origin += ( 0, 0, -150 );
            target moveto( target.origin + ( 0, 0, 150 ), 0.6, 0, 0 );
            
            foreach ( waittime in waits )
            {
                if ( !isdefined( self ) )
                {
                    continue;
                }
                
                scripts\sp\helicopter_globals::fire_missile( "apache_zippy", 1, target );
                wait waittime;
            }
            
            break;
        case #"hash_16c9a0e31aadb518":
            scripts\sp\helicopter_globals::fire_missile( "hind_rpg", 5, target, 0.3 );
            break;
        default:
            if ( self.classname == "script_vehicle_littlebird_armed" || self.classname == "script_vehicle_littlebird_md500" )
            {
                scripts\vehicle\attack_heli::heli_fire_missiles( target, 2, 0.25 );
            }
            else
            {
                scripts\sp\helicopter_globals::fire_missile( "hind_zippy", 5, target, 0.3 );
            }
            
            break;
    }
    
    if ( var_243154aac115bc0a )
    {
        target delete();
    }
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 0
// Checksum 0x0, Offset: 0x951
// Size: 0x10c
function globalthink()
{
    if ( !isdefined( self.vehicletype ) )
    {
        return;
    }
    
    ishelicopter = 0;
    
    if ( self.vehicletype == "hind" || self.vehicletype == "hind_blackice" || self.vehicletype == "ny_harbor_hind" )
    {
        ishelicopter = 1;
    }
    
    if ( self.vehicletype == "cobra" || self.vehicletype == "cobra_player" )
    {
        thread attachmissiles( "chopperpilot_hellfire", "cobra_Sidewinder" );
        
        if ( isdefined( self.fullmodel ) )
        {
            self.fullmodel thread attachmissiles( "chopperpilot_hellfire", "cobra_Sidewinder" );
        }
        
        ishelicopter = 1;
    }
    
    if ( !ishelicopter )
    {
        return;
    }
    
    level thread flares_think( self );
    level thread scripts\sp\helicopter_ai::evasive_think( self );
    
    if ( getdvar( @"hash_9f748e2b88d4f7e3" ) == "1" )
    {
        if ( isdefined( self.script_wingman ) )
        {
            level.wingman = self;
            level thread scripts\sp\helicopter_ai::wingman_think( self );
        }
    }
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 1
// Checksum 0x0, Offset: 0xa65
// Size: 0xc2
function flares_think( vehicle )
{
    vehicle endon( "death" );
    notifyoncommand( "flare_button", "+frag" );
    notifyoncommand( "flare_button", "+usereload" );
    notifyoncommand( "flare_button", "+activate" );
    
    while ( vehicle.health > 0 )
    {
        if ( isdefined( vehicle.playercontrolled ) )
        {
            vehicle.pilot waittill( "flare_button" );
        }
        else
        {
            vehicle waittill( "incomming_missile", emissile );
            
            if ( !isdefined( emissile ) )
            {
                continue;
            }
            
            if ( randomint( 3 ) == 0 )
            {
                continue;
            }
            
            wait randomfloatrange( 0.5, 1 );
        }
        
        thread flares_fire( vehicle );
        wait 3;
    }
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 4
// Checksum 0x0, Offset: 0xb2f
// Size: 0xed
function flares_fire_burst( vehicle, fxcount, flarecount, var_8e99a11a6eafd1a )
{
    assert( isdefined( level.flare_fx[ vehicle.vehicletype ] ) );
    assert( fxcount >= flarecount );
    var_7a203c9cb0bc1382 = 1;
    
    for ( i = 0; i < fxcount ; i++ )
    {
        playfx( level.flare_fx[ vehicle.vehicletype ], vehicle gettagorigin( "tag_flare" ) );
        
        if ( isdefined( vehicle.playercontrolled ) )
        {
            level.stats[ "flares_used" ]++;
            vehicle notify( "dropping_flares" );
            
            if ( var_7a203c9cb0bc1382 )
            {
                vehicle playsound( "cobra_flare_fire" );
            }
            
            var_7a203c9cb0bc1382 = !var_7a203c9cb0bc1382;
        }
        
        if ( i <= flarecount - 1 )
        {
            thread flares_redirect_missiles( vehicle, var_8e99a11a6eafd1a );
        }
        
        wait 0.1;
    }
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 1
// Checksum 0x0, Offset: 0xc24
// Size: 0x4b
function flares_fire( vehicle )
{
    vehicle endon( "death" );
    var_8e99a11a6eafd1a = 5;
    
    if ( isdefined( vehicle.flare_duration ) )
    {
        var_8e99a11a6eafd1a = vehicle.flare_duration;
    }
    
    flares_fire_burst( vehicle, 8, 1, var_8e99a11a6eafd1a );
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 0
// Checksum 0x0, Offset: 0xc77
// Size: 0x59
function create_missileattractor_on_player_chopper()
{
    assert( isdefined( self ) );
    assert( isdefined( self.centeraimpoint ) );
    
    if ( isdefined( self.missileattractor ) )
    {
        missile_deleteattractor( self.missileattractor );
    }
    
    self.missileattractor = missile_createattractorent( self.centeraimpoint, 10000, 10000 );
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 2
// Checksum 0x0, Offset: 0xcd8
// Size: 0x1a0
function flares_redirect_missiles( vehicle, var_8e99a11a6eafd1a )
{
    vehicle notify( "flares_out" );
    vehicle endon( "death" );
    vehicle endon( "flares_out" );
    
    if ( !isdefined( var_8e99a11a6eafd1a ) )
    {
        var_8e99a11a6eafd1a = 5;
    }
    
    vec = flares_get_vehicle_velocity( vehicle );
    flare = spawn( "script_origin", vehicle gettagorigin( "tag_flare" ) );
    flare movegravity( vec, var_8e99a11a6eafd1a );
    var_e7f1c1501040bde3 = undefined;
    
    if ( isdefined( vehicle.playercontrolled ) )
    {
        if ( isdefined( vehicle.missileattractor ) )
        {
            missile_deleteattractor( vehicle.missileattractor );
        }
        
        var_e7f1c1501040bde3 = missile_createattractorent( flare, 10000, 10000 );
    }
    
    if ( isdefined( vehicle.incomming_missiles ) )
    {
        for ( i = 0; i < vehicle.incomming_missiles.size ; i++ )
        {
            vehicle.incomming_missiles[ i ] missile_settargetent( flare );
        }
    }
    
    wait var_8e99a11a6eafd1a;
    
    if ( isdefined( vehicle.playercontrolled ) )
    {
        if ( isdefined( var_e7f1c1501040bde3 ) )
        {
            missile_deleteattractor( var_e7f1c1501040bde3 );
        }
        
        vehicle thread create_missileattractor_on_player_chopper();
    }
    
    if ( !isdefined( vehicle.script_targetoffset_z ) )
    {
        vehicle.script_targetoffset_z = 0;
    }
    
    offset = ( 0, 0, vehicle.script_targetoffset_z );
    
    if ( !isdefined( vehicle.incomming_missiles ) )
    {
        return;
    }
    
    for ( i = 0; i < vehicle.incomming_missiles.size ; i++ )
    {
        vehicle.incomming_missiles[ i ] missile_settargetent( vehicle, offset );
    }
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 1
// Checksum 0x0, Offset: 0xe80
// Size: 0x43
function flares_get_vehicle_velocity( vehicle )
{
    org1 = vehicle.origin;
    wait 0.05;
    vec = vehicle.origin - org1;
    return vec * 20;
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 2
// Checksum 0x0, Offset: 0xecc
// Size: 0x50
function missile_deathwait( emissile, emissile_target )
{
    emissile_target endon( "death" );
    emissile waittill( "death" );
    
    if ( !isdefined( emissile_target.incomming_missiles ) )
    {
        return;
    }
    
    emissile_target.incomming_missiles = array_remove( emissile_target.incomming_missiles, emissile );
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 7
// Checksum 0x0, Offset: 0xf24
// Size: 0x370
function getenemytarget( fradius, var_803fde08d46aef72, var_70183020b339e69, dosighttrace, var_390b6d8b1c31fb95, var_1680cd837efb560a, var_a3658e5ee7a7dda1 )
{
    if ( !isdefined( var_70183020b339e69 ) )
    {
        var_70183020b339e69 = 0;
    }
    
    if ( !isdefined( dosighttrace ) )
    {
        dosighttrace = 0;
    }
    
    if ( !isdefined( var_390b6d8b1c31fb95 ) )
    {
        var_390b6d8b1c31fb95 = 1;
    }
    
    if ( !isdefined( var_1680cd837efb560a ) )
    {
        var_1680cd837efb560a = 0;
    }
    
    etargets = [];
    var_fc25f80bd447ed26 = undefined;
    enemyteam = scripts\engine\utility::get_enemy_team( self.script_team );
    possibletargets = [];
    
    if ( var_390b6d8b1c31fb95 )
    {
        foreach ( vehicle in vehicle_getarray() )
        {
            if ( !isdefined( vehicle.script_team ) )
            {
                continue;
            }
            
            if ( vehicle.script_team == enemyteam )
            {
                possibletargets[ possibletargets.size ] = vehicle;
            }
        }
    }
    
    if ( var_70183020b339e69 )
    {
        enemyai = getaiarray( enemyteam );
        
        for ( i = 0; i < enemyai.size ; i++ )
        {
            if ( isdefined( enemyai[ i ].ignored_by_attack_heli ) )
            {
                continue;
            }
            
            possibletargets[ possibletargets.size ] = enemyai[ i ];
        }
        
        if ( enemyteam == "allies" )
        {
            for ( i = 0; i < level.players.size ; i++ )
            {
                possibletargets[ possibletargets.size ] = level.players[ i ];
            }
        }
    }
    
    if ( isdefined( var_a3658e5ee7a7dda1 ) )
    {
        possibletargets = array_exclude( possibletargets, var_a3658e5ee7a7dda1 );
    }
    
    if ( var_1680cd837efb560a )
    {
        possibletargets = array_randomize( possibletargets );
    }
    
    forwardvec = anglestoforward( self.angles );
    
    for ( i = 0; i < possibletargets.size ; i++ )
    {
        if ( issentient( possibletargets[ i ] ) && issentient( self ) && self getthreatbiasgroup() != "" )
        {
            bias = getthreatbias( possibletargets[ i ] getthreatbiasgroup(), self getthreatbiasgroup() );
            
            if ( bias <= -1000000 )
            {
                continue;
            }
        }
        
        if ( isdefined( fradius ) && fradius > 0 )
        {
            if ( distance( self.origin, possibletargets[ i ].origin ) > fradius )
            {
                continue;
            }
        }
        
        if ( isdefined( var_803fde08d46aef72 ) )
        {
            normalvec = vectornormalize( possibletargets[ i ].origin - self.origin );
            var_fc1d9e9e820ad804 = vectordot( forwardvec, normalvec );
            
            if ( var_fc1d9e9e820ad804 <= var_803fde08d46aef72 )
            {
                continue;
            }
        }
        
        if ( dosighttrace )
        {
            sighttracepassed = 0;
            
            if ( isai( possibletargets[ i ] ) )
            {
                var_b882f8c78ca5813b = 48;
            }
            else
            {
                var_b882f8c78ca5813b = 150;
            }
            
            sighttracepassed = sighttracepassed( self.origin, possibletargets[ i ].origin + ( 0, 0, var_b882f8c78ca5813b ), 0, self );
            
            if ( !sighttracepassed )
            {
                continue;
            }
        }
        
        etargets[ etargets.size ] = possibletargets[ i ];
    }
    
    if ( etargets.size == 0 )
    {
        self notify( "gunner_new_target", var_fc25f80bd447ed26 );
        return var_fc25f80bd447ed26;
    }
    
    if ( etargets.size == 1 )
    {
        self notify( "gunner_new_target", etargets[ 0 ] );
        return etargets[ 0 ];
    }
    
    thetarget = getclosest( self.origin, etargets );
    self notify( "gunner_new_target", thetarget );
    return thetarget;
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 1
// Checksum 0x0, Offset: 0x129d
// Size: 0x1b8
function shootenemytarget_bullets( etarget )
{
    self endon( "death" );
    self endon( "mg_off" );
    etarget endon( "death" );
    self endon( "gunner_new_target" );
    
    if ( isdefined( self.playercontrolled ) )
    {
        self endon( "gunner_stop_firing" );
    }
    
    var_2dd2f3c5af25b2aa = ( 0, 0, 0 );
    
    if ( isdefined( etarget.script_targetoffset_z ) )
    {
        var_2dd2f3c5af25b2aa += ( 0, 0, etarget.script_targetoffset_z );
    }
    else if ( issentient( etarget ) )
    {
        var_2dd2f3c5af25b2aa = ( 0, 0, 32 );
    }
    
    self setturrettargetent( etarget, var_2dd2f3c5af25b2aa );
    
    while ( self.health > 0 )
    {
        var_598a708c805940af = randomintrange( 1, 25 );
        
        if ( getdvar( @"hash_c9ab8c9fc46c92cf" ) == "1" )
        {
            iprintln( "randomShots = " + var_598a708c805940af );
        }
        
        for ( i = 0; i < var_598a708c805940af ; i++ )
        {
            if ( isdefined( self.playercontrolled ) )
            {
                if ( isdefined( level.cobraweapon ) && level.cobraweapon.size > 0 )
                {
                    self setvehweapon( level.gunnerweapon );
                }
            }
            
            thread shootenemytarget_bullets_debugline( self, "tag_turret", etarget, var_2dd2f3c5af25b2aa, ( 1, 1, 0 ), 0.05 );
            self fireweapon( "tag_flash" );
            
            if ( isdefined( self.playercontrolled ) )
            {
                self setvehweapon( level.cobraweapon[ self.pilot.currentweapon ].v[ "weapon" ] );
            }
            
            wait 0.05;
        }
        
        wait randomfloatrange( 0.25, 2.5 );
    }
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 6
// Checksum 0x0, Offset: 0x145d
// Size: 0xf6
function shootenemytarget_bullets_debugline( var_55a77f95f61c8b65, var_1f0507f3189c1433, etarget, var_2dd2f3c5af25b2aa, color, timer )
{
    /#
        if ( getdvar( @"hash_c9ab8c9fc46c92cf" ) != "<dev string:x1c>" )
        {
            return;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 0, 0, 0 );
        }
        
        etarget endon( "<dev string:x1e>" );
        self endon( "<dev string:x24>" );
        assert( isdefined( var_1f0507f3189c1433 ) );
        
        if ( !isdefined( var_2dd2f3c5af25b2aa ) )
        {
            var_2dd2f3c5af25b2aa = ( 0, 0, 0 );
        }
        
        if ( isdefined( timer ) )
        {
            timer = gettime() + timer * 1000;
            
            while ( gettime() < timer )
            {
                line( var_55a77f95f61c8b65 gettagorigin( var_1f0507f3189c1433 ), etarget.origin + var_2dd2f3c5af25b2aa, color );
                wait 0.05;
            }
            
            return;
        }
        
        for ( ;; )
        {
            line( var_55a77f95f61c8b65 gettagorigin( var_1f0507f3189c1433 ), etarget.origin + var_2dd2f3c5af25b2aa, color );
            wait 0.05;
        }
    #/
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 4
// Checksum 0x0, Offset: 0x155b
// Size: 0xce
function attachmissiles( weapon1, weapon2, weapon3, weapon4 )
{
    self.hasattachedweapons = 1;
    assert( isdefined( weapon1 ) );
    weapon = [];
    weapon[ 0 ] = weapon1;
    
    if ( isdefined( weapon2 ) )
    {
        weapon[ 1 ] = weapon2;
    }
    
    if ( isdefined( weapon3 ) )
    {
        weapon[ 2 ] = weapon3;
    }
    
    if ( isdefined( weapon4 ) )
    {
        weapon[ 3 ] = weapon4;
    }
    
    for ( i = 0; i < weapon.size ; i++ )
    {
        for ( k = 0; k < level.cobra_weapon_tags[ weapon[ i ] ].size ; k++ )
        {
            self attach( level.cobra_missile_models[ weapon[ i ] ], level.cobra_weapon_tags[ weapon[ i ] ][ k ] );
        }
    }
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 5
// Checksum 0x0, Offset: 0x1631
// Size: 0x64a
function fire_missile( smissiletype, ishots, etarget, fdelay, target_los )
{
    if ( !isdefined( ishots ) )
    {
        ishots = 1;
    }
    
    assert( self.health > 0 );
    weaponname = undefined;
    weaponshoottime = undefined;
    defaultweapon = "cobra_20mm";
    tags = [];
    
    switch ( smissiletype )
    {
        case #"hash_8a9a8bb5dc3486a0":
            weaponname = "cobra_Sidewinder";
            tags[ 0 ] = "le_side_wing_jnt";
            tags[ 1 ] = "ri_side_wing_jnt";
            break;
        case #"hash_b3c93b6b797f0875":
            weaponname = "cobra_seeker";
            tags[ 0 ] = "tag_store_L_1_a";
            tags[ 1 ] = "tag_store_R_1_a";
            tags[ 2 ] = "tag_store_L_2_a";
            tags[ 3 ] = "tag_store_R_2_a";
            break;
        case #"hash_3d94d0154908ee82":
            weaponname = "cobra_FFAR";
            tags[ 0 ] = "tag_store_r_2";
            break;
        case #"hash_328376e06ad436aa":
            weaponname = "cobra_seeker";
            tags[ 0 ] = "tag_store_r_2";
            break;
        case #"hash_839efbe411b43292":
            weaponname = "cobra_FFAR_bog_a_lite";
            tags[ 0 ] = "tag_store_r_2";
            break;
        case #"hash_94fe9ac788124de8":
            weaponname = "cobra_FFAR_airlift";
            tags[ 0 ] = "tag_store_L_wing";
            tags[ 1 ] = "tag_store_R_wing";
            break;
        case #"hash_deec76cccbc43374":
            weaponname = "cobra_FFAR_airlift_nofx";
            tags[ 0 ] = "tag_store_L_wing";
            tags[ 1 ] = "tag_store_R_wing";
            break;
        case #"hash_63dd5f263a6fa359":
            weaponname = "zippy_rockets";
            tags[ 0 ] = "tag_store_L_wing";
            tags[ 1 ] = "tag_store_R_wing";
            break;
        case #"hash_4c67bcd319c7e278":
            weaponname = "zippy_rockets_apache";
            tags[ 0 ] = "tag_flash_2";
            tags[ 1 ] = "tag_flash_3";
            break;
        case #"hash_3a4ef31af3db516f":
            weaponname = "zippy_rockets_apache_nodamage";
            tags[ 0 ] = "tag_flash_2";
            tags[ 1 ] = "tag_flash_3";
            break;
        case #"hash_443e386e3f9045ae":
            weaponname = "zippy_rockets_apache";
            tags[ 0 ] = "tag_store_L_wing";
            tags[ 1 ] = "tag_store_R_wing";
            break;
        case #"hash_5cee564ad78444a6":
            weaponname = "zippy_rockets_apache_cheap";
            tags[ 0 ] = "tag_store_L_wing";
            tags[ 1 ] = "tag_store_R_wing";
            break;
        case #"hash_2dc0d00b9de32bf1":
            weaponname = "hind_turret_penetration";
            tags[ 0 ] = "tag_store_L_wing";
            tags[ 1 ] = "tag_store_R_wing";
            break;
        case #"hash_e49b84d0e03dffd6":
            defaultweapon = "hind_turret";
            weaponname = "hind_FFAR";
            tags[ 0 ] = "tag_missile_left";
            tags[ 1 ] = "tag_missile_right";
            break;
        case #"hash_fdd3bbf6ff0d543f":
            defaultweapon = "hind_turret";
            weaponname = "zippy_rockets";
            tags[ 0 ] = "tag_missile_left";
            tags[ 1 ] = "tag_missile_right";
            break;
        case #"hash_16c9a0e31aadb518":
            defaultweapon = "hind_turret";
            weaponname = "rpg";
            tags[ 0 ] = "tag_missile_left";
            tags[ 1 ] = "tag_missile_right";
            break;
        case #"hash_a0a5554df3c9d800":
            defaultweapon = "hind_turret";
            weaponname = "rpg_cheap";
            tags[ 0 ] = "tag_missile_left";
            tags[ 1 ] = "tag_missile_right";
            break;
        case #"hash_4fc6e6ca2cb98381":
            defaultweapon = "hind_turret";
            weaponname = "hind_FFAR_nodamage";
            tags[ 0 ] = "tag_missile_left";
            tags[ 1 ] = "tag_missile_right";
            break;
        case #"hash_c978062e6445430c":
            defaultweapon = "hind_turret";
            weaponname = "mi28_ffar_village_assault";
            tags[ 0 ] = "tag_store_L_2_a";
            tags[ 1 ] = "tag_store_R_2_a";
            tags[ 2 ] = "tag_store_L_2_b";
            tags[ 3 ] = "tag_store_R_2_b";
            tags[ 4 ] = "tag_store_L_2_c";
            tags[ 5 ] = "tag_store_R_2_c";
            tags[ 6 ] = "tag_store_L_2_d";
            tags[ 7 ] = "tag_store_R_2_d";
            break;
        case #"hash_6bacc9fb0186a1af":
            weaponname = "cobra_FFAR_bog_a_lite";
            tags[ 0 ] = "tag_store_R_2_a";
            tags[ 1 ] = "tag_store_L_2_a";
            break;
        default:
            assertmsg( "Invalid missile type specified." );
            break;
    }
    
    assert( isdefined( weaponname ) );
    assert( tags.size > 0 );
    weaponshoottime = weaponfiretime( weaponname );
    assert( isdefined( weaponshoottime ) );
    
    if ( isdefined( self.nextmissiletag ) )
    {
        nextmissiletag = self.nextmissiletag;
    }
    else
    {
        nextmissiletag = -1;
    }
    
    for ( i = 0; i < ishots ; i++ )
    {
        nextmissiletag++;
        nextmissiletag %= tags.size;
        
        if ( smissiletype == "ffar_mi28_village_assault" )
        {
            if ( isdefined( etarget ) && isdefined( etarget.origin ) )
            {
                magicbullet( weaponname, self gettagorigin( tags[ nextmissiletag ] ), etarget.origin );
                
                if ( isdefined( level._effect[ "ffar_mi28_muzzleflash" ] ) )
                {
                    playfxontag( getfx( "ffar_mi28_muzzleflash" ), self, tags[ nextmissiletag ] );
                }
                
                thread delayed_earthquake( 0.1, 0.5, 0.2, etarget.origin, 1600 );
            }
        }
        else
        {
            self setvehweapon( weaponname );
            
            if ( isdefined( etarget ) )
            {
                emissile = self fireweapon( tags[ nextmissiletag ], etarget );
                
                switch ( smissiletype )
                {
                    case #"hash_3d94d0154908ee82":
                    case #"hash_839efbe411b43292":
                    case #"hash_94fe9ac788124de8":
                        emissile thread missilelosetarget( 0.1 );
                        break;
                    case #"hash_195ee7261f1a1fb5":
                    case #"hash_3a4ef31af3db516f":
                    case #"hash_443e386e3f9045ae":
                    case #"hash_4c67bcd319c7e278":
                    case #"hash_5cee564ad78444a6":
                        if ( !isdefined( target_los ) )
                        {
                            emissile thread missilelosetarget( 0.6 );
                        }
                        else
                        {
                            emissile thread missilelosetarget( target_los );
                        }
                        
                        break;
                    default:
                        break;
                }
            }
            else
            {
                emissile = self fireweapon( tags[ nextmissiletag ] );
            }
            
            self notify( "missile_fired", emissile );
        }
        
        self.nextmissiletag = nextmissiletag;
        
        if ( i < ishots - 1 )
        {
            wait weaponshoottime;
        }
        
        if ( isdefined( fdelay ) )
        {
            wait fdelay;
        }
    }
    
    self setvehweapon( defaultweapon );
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 5
// Checksum 0x0, Offset: 0x1c83
// Size: 0x37
function delayed_earthquake( fdelay, scale, duration, source, fradius )
{
    wait fdelay;
    earthquake( scale, duration, source, fradius );
}

// Namespace helicopter_globals / scripts\sp\helicopter_globals
// Params 1
// Checksum 0x0, Offset: 0x1cc2
// Size: 0x20
function missilelosetarget( fdelay )
{
    self endon( "death" );
    wait fdelay;
    
    if ( isdefined( self ) )
    {
        self missile_cleartarget();
    }
}

