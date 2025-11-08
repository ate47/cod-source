#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\molotov;
#using scripts\sp\equipment\offhands;
#using scripts\sp\nvg\nvg_ai;
#using scripts\sp\trigger;
#using scripts\sp\utility;

#namespace molotov;

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x976
// Size: 0x151
function precache( offhand )
{
    precachemodel( "burntbody_male" );
    precachemodel( "equip_molotov_pool_mp" );
    level.g_effect[ "molotov_explosion" ] = loadfx( "vfx/iw8/core/molotov/vfx_molotov_explosion.vfx" );
    level.g_effect[ "molotov_explosion_child" ] = loadfx( "vfx/iw8/core/molotov/vfx_molotov_explosion_child.vfx" );
    level.g_effect[ "vfx_burn_lrg_high" ] = loadfx( "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_high.vfx" );
    level.g_effect[ "vfx_burn_lrg_low" ] = loadfx( "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_low.vfx" );
    level.g_effect[ "vfx_burn_med_high" ] = loadfx( "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_high.vfx" );
    level.g_effect[ "vfx_burn_med_low" ] = loadfx( "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_low.vfx" );
    level.g_effect[ "vfx_burn_sml_high" ] = loadfx( "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_high.vfx" );
    level.g_effect[ "vfx_burn_sml_low" ] = loadfx( "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_low.vfx" );
    level.g_effect[ "vfx_burn_sml_head_low" ] = loadfx( "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_head_low.vfx" );
    level.molotovdata = spawnstruct();
    level.molotovdata.active = [];
    registeroffhandfirefunc( offhand, &molotovfiremain );
    registersharedfunc( "molotov", "molotov_simulate_impact", &molotov_simulate_impact );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 2
// Checksum 0x0, Offset: 0xacf
// Size: 0x197
function molotovfiremain( grenade, weapon )
{
    if ( isplayer( self ) || isai( self ) )
    {
        owner = self;
    }
    else
    {
        owner_options = getaiarray( "axis" );
        
        if ( owner_options.size > 0 )
        {
            owner = sortandreturnowner( owner_options, grenade );
        }
        else
        {
            owner_options = getaiarray( "allies" );
            
            if ( owner_options.size > 0 )
            {
                owner = sortandreturnowner( owner_options, grenade );
            }
            else
            {
                owner = level.player;
            }
        }
    }
    
    addbattlechatternotify( owner, undefined, "grenade_throw", "molotov" );
    grenade endon( "entitydeleted" );
    
    if ( !isdefined( grenade ) )
    {
        return;
    }
    
    grenade.owner = owner;
    ownerorigin = owner.origin;
    ownerangles = owner.angles;
    grenade waittill( "missile_stuck", stuckto, hitentpart, surfacetype, velocity, position, hitnormal );
    launchangles = getlaunchangles( position, ownerorigin, ownerangles );
    level notify( "molotov_impact", owner, position );
    
    if ( isdefined( owner ) && isdefined( owner.team ) )
    {
        level notify( "bc_inform_weapon", "molotov", owner.team );
    }
    
    owner thread molotov_stuck( grenade, stuckto, launchangles, velocity, 1 );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 2
// Checksum 0x0, Offset: 0xc6e
// Size: 0x26
function sortandreturnowner( arr, grenade )
{
    return sortbydistance( arr, grenade.origin )[ 0 ];
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 3
// Checksum 0x0, Offset: 0xc9d
// Size: 0x8d
function getlaunchangles( origin, ownerorigin, ownerangles )
{
    if ( !isdefined( ownerorigin ) )
    {
        ownerorigin = self.origin;
    }
    
    if ( !isdefined( ownerangles ) )
    {
        ownerangles = self.angles;
    }
    
    dirtomolotov = vectornormalize( origin - ownerorigin );
    ang = vectortoangles( dirtomolotov );
    flatang = ( 0, ownerangles[ 1 ], 0 );
    launchangles = flatang + ( 45, 0, 0 );
    return launchangles;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 5
// Checksum 0x0, Offset: 0xd33
// Size: 0x106
function molotovexplode( origin, normal, velocity, entity, molotovowner )
{
    molotov = spawn( "script_model", origin );
    molotov setmodel( "projectile_molotov_v0" );
    ang = vectortoangles( normal );
    f = anglestoforward( ang );
    r = anglestoright( ang );
    u = anglestoup( ang );
    molotov.angles = axistoangles( r, u, f );
    molotov.owner = molotovowner;
    launchangles = molotovowner scripts\sp\equipment\molotov::getlaunchangles( origin );
    
    if ( isdefined( entity ) && isdefined( entity.classname ) && entity.classname == "worldspawn" )
    {
        entity = undefined;
    }
    
    thread molotov_stuck( molotov, entity, launchangles, velocity );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0xe41
// Size: 0xfb
function pool_damage_scriptables( origin )
{
    scriptableradiuscheck = self.pooldata.triggerradius * 3;
    
    foreach ( ent in self.shareddata.scriptables )
    {
        dist = distance( ent.origin, origin );
        
        if ( dist <= scriptableradiuscheck )
        {
            if ( ent getscriptableparthasstate( "base", "script_ignite" ) )
            {
                ent setscriptablepartstate( "base", "script_ignite", 1 );
                
                /#
                    if ( level.dbgmolodrawhits )
                    {
                        line( origin, ent.origin, ( 1, 0, 0 ), 1, 0, 300 );
                    }
                #/
            }
        }
    }
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 2
// Checksum 0x0, Offset: 0xf44
// Size: 0xff
function pool_damage_vehicles( origin, pool )
{
    radiuscheck = self.pooldata.triggerradius * 5;
    
    foreach ( ent in self.shareddata.vehicles )
    {
        dist = distance( ent.origin, origin );
        
        if ( dist <= radiuscheck )
        {
            /#
                if ( level.dbgmolodrawhits )
                {
                    line( origin, ent.origin, ( 0, 0, 1 ), 1, 0, 300 );
                }
            #/
            
            if ( ent isscriptable() )
            {
                ent thread molotovburnscriptablevehicle( pool );
                continue;
            }
            
            ent thread molotovburnvehicle( pool );
        }
    }
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x104b
// Size: 0xb8
function molotovburnscriptablevehicle( pool )
{
    self endon( "death" );
    wait 1;
    cur_state = self getscriptablepartstate( "body", 1 );
    
    if ( !isdefined( cur_state ) )
    {
        states = [ "flareup", "onfire" ];
        
        foreach ( state in states )
        {
            if ( self getscriptableparthasstate( "body", state ) )
            {
                self setscriptablepartstate( "body", state, 1 );
            }
            
            wait 0.5;
        }
    }
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x110b
// Size: 0x40
function molotovburnvehicle( pool )
{
    self endon( "death" );
    pool endon( "molotov_pool_end" );
    
    while ( true )
    {
        do_damage( 75, self.origin, undefined, undefined, "MOD_FIRE" );
        wait 0.5;
    }
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 2
// Checksum 0x0, Offset: 0x1153
// Size: 0x2e8
function pool_damage_ai( origin, owner )
{
    self.shareddata.ai = array_removeundefined( self.shareddata.ai );
    self.shareddata.ai = array_removedead_or_dying( self.shareddata.ai, 0 );
    
    if ( isdefined( owner ) && isplayer( owner ) )
    {
        level.moloachievementvictims = 0;
    }
    
    foreach ( guy in self.shareddata.ai )
    {
        dist = distance( guy.origin, origin );
        drawtime = 100;
        
        if ( issameteam( guy.team, owner.team ) )
        {
            killradius = self.pooldata.aikillradius * 0.7;
            damageradius = self.pooldata.aidamageradius * 0.5;
        }
        else
        {
            killradius = self.pooldata.aikillradius;
            damageradius = self.pooldata.aidamageradius;
        }
        
        if ( dist <= killradius )
        {
            guy thread achievement_watcher( owner, self );
            molotovburnenemy( guy, 1, origin, owner );
            
            /#
                if ( level.var_fe4aa861c408282f )
                {
                    line( origin, guy.origin, ( 1, 0, 0 ), 1, 0, drawtime );
                    sphere( origin, killradius, ( 1, 0, 0 ), 0, drawtime );
                    sphere( origin, damageradius, ( 0.4, 0.4, 0.4 ), 0, drawtime );
                }
            #/
            
            continue;
        }
        
        if ( dist <= damageradius )
        {
            guy thread achievement_watcher( owner, self );
            molotovburnenemy( guy, 0, origin, owner );
            
            /#
                if ( level.var_fe4aa861c408282f )
                {
                    line( origin, guy.origin, ( 0.8, 0.4, 0.4 ), 1, 0, drawtime );
                    sphere( origin, killradius, ( 0.8, 0.8, 0.8 ), 0, drawtime );
                    sphere( origin, damageradius, ( 1, 0, 0 ), 0, drawtime );
                }
            #/
            
            continue;
        }
        
        /#
            if ( level.var_fe4aa861c408282f )
            {
                sphere( origin, killradius, ( 0.8, 0.8, 0.8 ), 0, drawtime );
                sphere( origin, damageradius, ( 0.4, 0.4, 0.4 ), 0, drawtime );
            }
        #/
    }
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 2
// Checksum 0x0, Offset: 0x1443
// Size: 0x22, Type: bool
function issameteam( ownerteam, victimteam )
{
    return isdefined( ownerteam ) && isdefined( victimteam ) && ownerteam == victimteam;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 4
// Checksum 0x0, Offset: 0x146e
// Size: 0x17f
function molotovburnenemy( enemy, todeath, origin, molotovowner )
{
    if ( istrue( enemy.var_ea62c0816535ee5f ) )
    {
        todeath = 0;
    }
    
    enemy._blackboard.isburning = 1;
    enemy.burningtodeath = todeath;
    enemy.burningdirection = undefined;
    
    if ( todeath )
    {
        if ( istrue( enemy.flashlight ) )
        {
            enemy scripts\sp\nvg\nvg_ai::flashlight_off( 0 );
        }
        
        enemy anim_stopanimscripted();
        enemy do_damage( enemy.health + 9999, origin, molotovowner, molotovowner, "MOD_FIRE", "molotov" );
        currentstate = undefined;
        
        if ( enemy isscriptable() )
        {
            currentstate = enemy getscriptablepartstate( "burn_to_death_by_molotov", 1 );
        }
        
        if ( !isdefined( currentstate ) )
        {
            enemy thread molotov_burn_sfx( todeath );
        }
    }
    else
    {
        enemyright = anglestoright( enemy.angles );
        var_c669c03ee029ef20 = vectornormalize( origin - enemy.origin );
        
        if ( vectordot( enemyright, var_c669c03ee029ef20 ) > 0 )
        {
            enemy.burningdirection = "right";
        }
        else
        {
            enemy.burningdirection = "left";
        }
        
        enemy do_damage( 1, origin, molotovowner, molotovowner, "MOD_FIRE", "molotov" );
        enemy thread molotov_burn_sfx();
    }
    
    level thread remove_blackboard_isburning( enemy );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 2
// Checksum 0x0, Offset: 0x15f5
// Size: 0x7a
function achievement_watcher( owner, branch )
{
    if ( !isai( self ) )
    {
        return;
    }
    
    if ( !isdefined( owner ) || !isplayer( owner ) )
    {
        return;
    }
    
    if ( !istrue( branch.shareddata.thrownoffhand ) )
    {
        return;
    }
    
    level.moloachievementvictims += 1;
    
    if ( level.moloachievementvictims > 3 )
    {
        level thread scripts\sp\utility::giveachievement_wrapper( "ashes" );
    }
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x1677
// Size: 0x1a, Type: bool
function vector_empty( vector )
{
    return vector == ( 0, 0, 0 );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x169a
// Size: 0xf1
function molotov_burn_sfx( todeath )
{
    if ( isdefined( todeath ) )
    {
        duration = 1;
    }
    else
    {
        duration = 0.5;
    }
    
    if ( !isdefined( self.burnsfxenabled ) )
    {
        self.burnsfxenabled = 0;
    }
    
    if ( !isdefined( self.burnsfx ) )
    {
        burnsfx = spawn( "script_origin", self.origin );
        burnsfx linkto( self );
        self.burnsfx = burnsfx;
        wait 0.05;
    }
    else
    {
        burnsfx = self.burnsfx;
    }
    
    if ( isdefined( self ) && self.burnsfxenabled == 0 )
    {
        burnsfx playloopsound( "iw9_weap_molotov_fire_enemy_burn" );
        self.burnsfxenabled = 1;
        wait duration;
        burnsfx playsound( "iw9_weap_molotov_fire_enemy_burn_end" );
        wait 0.15;
        burnsfx stoploopsound( "iw9_weap_molotov_fire_enemy_burn" );
        burnsfx delete();
        
        if ( isdefined( self ) )
        {
            self.burnsfxenabled = 1;
        }
    }
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 2
// Checksum 0x0, Offset: 0x1793
// Size: 0x6f
function molotov_fire_sfx( origin, duration )
{
    wait 0.1;
    soundorg = spawn( "script_origin", origin + ( 0, 0, 15 ) );
    soundorg playloopsound( "iw9_weap_molotov_fire_lp" );
    wait duration;
    thread play_sound_in_space( "iw9_weap_molotov_fire_end", soundorg.origin );
    soundorg sound_fade_and_delete( 1, 1 );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x180a
// Size: 0x62
function molotovviewmodelfiremanager()
{
    var_fd59f476d7d139d1 = makeweapon( "molotov" );
    
    while ( true )
    {
        self waittill( "grenade_pullback", grenadeweapon );
        
        if ( grenadeweapon == var_fd59f476d7d139d1 )
        {
            self setscriptablepartstate( "molotov", "molotov_fx_on" );
            self waittill( "offhand_end" );
            self setscriptablepartstate( "molotov", "molotov_fx_off" );
        }
    }
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x1874
// Size: 0x10
function molotov_init()
{
    molotov_init_cast_data();
    molotov_init_pool_data();
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x188c
// Size: 0x246
function molotov_init_cast_data()
{
    leveldata = level.molotovdata;
    
    if ( !isdefined( leveldata ) )
    {
        leveldata = spawnstruct();
        level.molotovdata = leveldata;
    }
    
    castdata = leveldata.castdata;
    
    if ( !isdefined( castdata ) )
    {
        castdata = spawnstruct();
        leveldata.castdata = castdata;
    }
    
    castdata.distforward = [];
    castdata.distdown = [];
    castdata.distup = [];
    castdata.maxcasts = [];
    castdata.maxfails = [];
    castdata.maxents = [];
    castdata.firstforwarddist = [];
    castdata.firstforwardmindist = [];
    castdata.firstforwardmodanglesfunc = [];
    id = 8;
    castdata.distforward[ id ] = undefined;
    castdata.distdown[ id ] = undefined;
    castdata.distup[ id ] = undefined;
    castdata.maxcasts[ id ] = undefined;
    castdata.maxfails[ id ] = undefined;
    castdata.maxents[ id ] = 1;
    id = 16;
    castdata.distforward[ id ] = 50;
    castdata.distdown[ id ] = 50;
    castdata.distup[ id ] = 25;
    castdata.maxcasts[ id ] = 4;
    castdata.maxfails[ id ] = 3;
    castdata.maxents[ id ] = 1;
    castdata.distforwardwall[ id ] = 25;
    id = 32;
    castdata.distforward[ id ] = 15;
    castdata.distdown[ id ] = 50;
    castdata.distup[ id ] = 25;
    castdata.maxcasts[ id ] = 17;
    castdata.maxfails[ id ] = 3;
    castdata.maxents[ id ] = 3;
    castdata.firstforwarddist[ id ] = 85;
    castdata.firstforwardmindist[ id ] = 8;
    castdata.distforwardwall[ id ] = 8;
    castdata.firstforwarddistwall[ id ] = 44;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x1ada
// Size: 0x1eb
function molotov_init_pool_data()
{
    leveldata = level.molotovdata;
    
    if ( !isdefined( leveldata ) )
    {
        leveldata = spawnstruct();
        level.molotovdata = leveldata;
    }
    
    pooldata = leveldata.pooldata;
    
    if ( !isdefined( pooldata ) )
    {
        pooldata = spawnstruct();
        leveldata.pooldata = pooldata;
    }
    
    pooldata.triggerradius = [];
    pooldata.triggerheight = [];
    pooldata.triggeroffset = [];
    pooldata.startdelayms = [];
    id = 8;
    pooldata.triggerradius[ id ] = 30;
    pooldata.triggerheight[ id ] = 55;
    pooldata.aikillradius[ id ] = 100;
    pooldata.aidamageradius[ id ] = 130;
    pooldata.triggeroffset[ id ] = 15;
    pooldata.startdelayms[ id ] = 0;
    pooldata.dangerzoneradius[ id ] = 350;
    pooldata.dangerzoneheight[ id ] = 128;
    id = 16;
    pooldata.triggerradius[ id ] = 30;
    pooldata.triggerheight[ id ] = 55;
    pooldata.aikillradius[ id ] = 75;
    pooldata.aidamageradius[ id ] = 100;
    pooldata.triggeroffset[ id ] = 15;
    pooldata.startdelayms[ id ] = 100;
    id = 32;
    pooldata.triggerradius[ id ] = 10;
    pooldata.triggerheight[ id ] = 55;
    pooldata.aikillradius[ id ] = 50;
    pooldata.aidamageradius[ id ] = 80;
    pooldata.triggeroffset[ id ] = 15;
    pooldata.startdelayms[ id ] = 100;
    molotov_init_pool_mask();
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x1ccd
// Size: 0x285
function molotov_init_pool_mask()
{
    leveldata = level.molotovdata;
    
    if ( !isdefined( leveldata ) )
    {
        leveldata = spawnstruct();
        level.molotovdata = leveldata;
    }
    
    pooldata = leveldata.pooldata;
    
    if ( !isdefined( pooldata ) )
    {
        pooldata = spawnstruct();
        leveldata.pooldata = pooldata;
    }
    
    var_6f6efec7e89387e8 = [];
    var_6f6efec7e89387e8[ 1 ] = "flareUp";
    var_6f6efec7e89387e8[ 2 ] = "burnLoop";
    var_6f6efec7e89387e8[ 4 ] = "dieDown";
    var_6f6efec7e89387e8[ 8 ] = "coreCenter";
    var_6f6efec7e89387e8[ 16 ] = "core";
    var_6f6efec7e89387e8[ 32 ] = "tendril";
    var_6f6efec7e89387e8[ 64 ] = "";
    var_6f6efec7e89387e8[ 128 ] = "wall";
    var_6f6efec7e89387e8[ 256 ] = "ceil";
    var_6f6efec7e89387e8[ 512 ] = "direct";
    var_6f6efec7e89387e8[ 1024 ] = "";
    scriptableparts = [];
    scriptablestates = [];
    var_e42c4a59211c25aa = ( 1 | 2 | 4 ) ^ ( 1 | 2 | 4 ) & ( 1 | 2 | 4 ) - 1;
    var_a56ffa08fd7c6e21 = ( 8 | 16 | 32 ) ^ ( 8 | 16 | 32 ) & ( 8 | 16 | 32 ) - 1;
    var_880b6bd9b71c4abc = ( 64 | 128 | 256 ) ^ ( 64 | 128 | 256 ) & ( 64 | 128 | 256 ) - 1;
    var_ec021596457d03c5 = ( 512 | 1024 ) ^ ( 512 | 1024 ) & ( 512 | 1024 ) - 1;
    mask = 1 | 2 | 4;
    statebit = var_e42c4a59211c25aa;
    
    while ( ( statebit & ( 1 | 2 | 4 ) ) > 0 )
    {
        scriptableparts[ statebit ] = var_6f6efec7e89387e8[ statebit ];
        typebit = var_a56ffa08fd7c6e21;
        
        while ( ( typebit & ( 8 | 16 | 32 ) ) > 0 )
        {
            orientbit = var_880b6bd9b71c4abc;
            
            while ( ( orientbit & ( 64 | 128 | 256 ) ) > 0 )
            {
                incidencebit = var_ec021596457d03c5;
                
                while ( ( incidencebit & ( 512 | 1024 ) ) > 0 )
                {
                    mask = statebit | typebit | orientbit | incidencebit;
                    scriptablestates[ mask ] = var_6f6efec7e89387e8[ typebit ] + var_6f6efec7e89387e8[ orientbit ] + var_6f6efec7e89387e8[ incidencebit ];
                    mask = typebit | orientbit | incidencebit;
                    scriptablestates[ mask ] = "neutral";
                    incidencebit <<= 1;
                }
                
                orientbit <<= 1;
            }
            
            typebit <<= 1;
        }
        
        statebit <<= 1;
    }
    
    pooldata.scriptableparts = scriptableparts;
    pooldata.scriptablestates = scriptablestates;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 5
// Checksum 0x0, Offset: 0x1f5a
// Size: 0xfe
function molotov_stuck( grenade, stuckto, launchangles, impactvelocity, thrownoffhand )
{
    angles = undefined;
    forward = vectornormalize( impactvelocity );
    up = anglestoup( grenade.angles );
    right = anglestoright( launchangles );
    
    if ( abs( vectordot( forward, up ) ) >= 0.9848 )
    {
        angles = molotov_rebuild_angles_up_right( up, right );
    }
    else
    {
        angles = molotov_rebuild_angles_up_forward( up, forward );
    }
    
    grenade.angles = angles;
    grenade notify( "death" );
    grenade setscriptablepartstate( "effects", "explode", 0 );
    molotov_simulate_impact( grenade, grenade.origin, angles, stuckto, impactvelocity, gettime(), thrownoffhand );
    
    if ( istrue( level.var_721b11eed320a2b5 ) )
    {
        return;
    }
    
    grenade detonate();
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x2060
// Size: 0x8c
function molotovbadplace( impactorigin )
{
    badplace = createnavbadplacebybounds( impactorigin, ( 128, 128, 100 ), ( 0, 0, 0 ) );
    
    /#
        if ( level.dbgmolodrawhits )
        {
            drawtime = int( 6250 );
            orientedbox( impactorigin, ( 128, 128, 100 ), ( 0, 0, 0 ), ( 0, 0, 1 ), 1, drawtime );
        }
    #/
    
    return badplace;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 7
// Checksum 0x0, Offset: 0x20f5
// Size: 0x7e4
function molotov_simulate_impact( grenade, impactorigin, impactangles, impactent, impactvelocity, impacttime, thrownoffhand )
{
    index = level.molotovdata.active.size;
    level.molotovdata.active[ index ] = spawnstruct();
    owner = grenade.owner;
    impactnormal = anglestoup( impactangles );
    caststart = impactorigin + impactnormal * 1;
    castend = caststart + impactnormal * 25;
    contents = molotov_get_cast_contents();
    ignore = getaiarray();
    ignore = array_add( ignore, grenade );
    
    /#
        if ( level.dbgmolodrawhits )
        {
            line( caststart, castend, ( 1, 0, 0 ), 1, 0, 100 );
        }
    #/
    
    castresults = physics_raycast( caststart, castend, contents, ignore, 0, "physicsquery_closest", 1 );
    
    if ( isdefined( castresults ) && castresults.size > 0 )
    {
        castend = castresults[ 0 ][ "position" ] - impactnormal * 1;
    }
    
    borigin = castend;
    burnsource = grenade;
    burnid = molotov_get_next_burning_id();
    coneimpact = 0;
    impactincidence = 512;
    impactdot = vectordot( vectornormalize( impactvelocity ), -1 * impactnormal );
    
    if ( impactdot < 0.96593 )
    {
        coneimpact = 1;
        impactincidence = 1024;
    }
    
    shareddata = molotov_create_shared_data( owner, impacttime, impactincidence, burnsource, burnid, thrownoffhand );
    shareddata.badplace = molotovbadplace( impactorigin );
    shareddata.scriptables = moltovgetscriptables( impactorigin );
    shareddata.vehicles = moltovgetvehicles( impactorigin );
    shareddata.ai = moltovgetai( impactorigin );
    
    /#
        if ( level.var_572fa332ecd66179 )
        {
            id = 8;
            castdata = undefined;
            pooldata = molotov_get_pool_data( id );
            branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, impactorigin, impactangles, impactent );
            shareddata.branches[ shareddata.branches.size ] = branch;
            branch thread molotov_start_branch();
            return;
        }
        else if ( level.var_45cb2e2a7eb65f4 )
        {
            id = 16;
            castdata = undefined;
            pooldata = molotov_get_pool_data( id );
            branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, impactorigin, impactangles, impactent );
            shareddata.branches[ shareddata.branches.size ] = branch;
            branch thread molotov_start_branch();
            return;
        }
        else if ( level.var_b5802d21c9afc19 )
        {
            id = 32;
            castdata = undefined;
            pooldata = molotov_get_pool_data( id );
            branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, impactorigin, impactangles, impactent );
            shareddata.branches[ shareddata.branches.size ] = branch;
            branch thread molotov_start_branch();
            return;
        }
    #/
    
    id = 8;
    castdata = molotov_get_cast_data( id );
    pooldata = molotov_get_pool_data( id );
    branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, impactorigin, impactangles, impactent );
    shareddata.branches[ shareddata.branches.size ] = branch;
    var_6f2b46872df538de = 25;
    var_df64badccf60fd69 = 65;
    var_144e6d19329167bd = 115;
    sidepreventstarttime = gettime() + pooldata.startdelayms;
    id = 16;
    castdata = molotov_get_cast_data( id );
    pooldata = molotov_get_pool_data( id );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = &molotov_branch_create_forward_tendril_cone;
    }
    
    branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, borigin, impactangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    forward = anglestoforward( impactangles );
    right = anglestoright( impactangles );
    up = anglestoup( impactangles );
    castdata = molotov_get_cast_data( id );
    pooldata = molotov_get_pool_data( id );
    bforward = forward * -1;
    bright = right * -1;
    bup = up;
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = undefined;
    }
    
    branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    castdata = molotov_get_cast_data( id );
    pooldata = molotov_get_pool_data( id );
    bforward = rotatepointaroundvector( up, forward, var_df64badccf60fd69 );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = &molotov_branch_create_right_tendril_cone;
    }
    
    branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    castdata = molotov_get_cast_data( id );
    pooldata = molotov_get_pool_data( id );
    bforward = rotatepointaroundvector( up, forward, -1 * var_df64badccf60fd69 );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = &molotov_branch_create_left_tendril_cone;
    }
    
    branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    castdata = molotov_get_cast_data( id );
    pooldata = molotov_get_pool_data( id );
    bforward = rotatepointaroundvector( up, forward, var_144e6d19329167bd );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = undefined;
    }
    
    branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    castdata = molotov_get_cast_data( id );
    pooldata = molotov_get_pool_data( id );
    bforward = rotatepointaroundvector( up, forward, -1 * var_144e6d19329167bd );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = undefined;
    }
    
    branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    shareddata molotov_shared_data_register_cast();
    
    foreach ( branch in shareddata.branches )
    {
        branch thread molotov_start_branch();
    }
    
    shareddata thread molotov_cleanup();
    shareddata.initialized = 1;
    level.molotovdata.active[ index ] = shareddata;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x28e1
// Size: 0x163
function moltovgetscriptables( impactorigin )
{
    damageables[ 0 ] = "scriptable_container_gas_tank_01";
    damageables[ 1 ] = "scriptable_equipment_propane_burner_stove_01_red";
    damageables[ 2 ] = "scriptable_equipment_propane_burner_stove_01_green";
    damageables[ 3 ] = "scriptable_equipment_propane_burner_stove_01_blue";
    damageables[ 4 ] = "scriptable_equipment_propane_burner_stove_01_white";
    damageables[ 5 ] = "scriptable_equipment_propane_burner_stove_01_yellow";
    damageables[ 6 ] = "scriptable_decor_propane_tank_01_en";
    validscriptables = [];
    
    foreach ( ent in damageables )
    {
        scriptables = getscriptablearray( ent, "classname" );
        
        foreach ( ent in scriptables )
        {
            distancesq = distancesquared( ent.origin, impactorigin );
            
            if ( distancesq <= 65536 )
            {
                validscriptables = array_add( validscriptables, ent );
                
                /#
                    if ( level.dbgmolodrawhits )
                    {
                        line( impactorigin, ent.origin, ( 1, 1, 1 ), 0.5, 0, 300 );
                    }
                #/
            }
        }
    }
    
    return validscriptables;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x2a4d
// Size: 0x120
function moltovgetvehicles( impactorigin )
{
    validvehicles = [];
    vehicles = getscriptablearray( "scriptable", "code_classname" );
    vehicles = array_combine( vehicles, getentarray( "script_vehicle", "code_classname" ) );
    
    foreach ( vehicle in vehicles )
    {
        if ( !isdefined( vehicle.model ) || !isstartstr( vehicle.model, "veh8_" ) )
        {
            continue;
        }
        
        distancesq = distancesquared( vehicle.origin, impactorigin );
        
        if ( distancesq <= 65536 )
        {
            validvehicles = array_add( validvehicles, vehicle );
            
            /#
                if ( level.dbgmolodrawhits )
                {
                    line( impactorigin, vehicle.origin, ( 1, 1, 1 ), 0.5, 0, 300 );
                }
            #/
        }
    }
    
    return validvehicles;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x2b76
// Size: 0xe5
function moltovgetai( impactorigin )
{
    ai = getaiarray();
    ai = array_removeundefined( ai );
    ai = array_removedead_or_dying( ai, 0 );
    validai = [];
    
    foreach ( guy in ai )
    {
        distancesq = distancesquared( guy.origin, impactorigin );
        
        if ( distancesq <= 65536 )
        {
            validai = array_add( validai, guy );
            
            /#
                if ( level.dbgmolodrawhits )
                {
                    line( impactorigin, guy.origin, ( 1, 1, 1 ), 0.5, 0, 300 );
                }
            #/
        }
    }
    
    return validai;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x2c64
// Size: 0xf7
function molotov_cleanup()
{
    self.burnsource waittill_notify_or_timeout( "entitydeleted", 6.25 );
    
    while ( true )
    {
        branchesterminated = 1;
        
        foreach ( branch in self.branches )
        {
            if ( !istrue( branch.iscomplete ) )
            {
                branchesterminated = 0;
                break;
            }
            
            if ( !branchesterminated )
            {
                break;
            }
        }
        
        if ( branchesterminated )
        {
            break;
        }
        
        waitframe();
    }
    
    destroynavobstacle( self.badplace );
    
    if ( isdefined( self.burnsource ) )
    {
        self.burnsource delete();
    }
    
    level.molotovdata.active = array_remove( level.molotovdata.active, self );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 6
// Checksum 0x0, Offset: 0x2d63
// Size: 0x165
function molotov_create_shared_data( owner, impacttime, impactincidence, burnsource, burnid, thrownoffhand )
{
    shareddata = spawnstruct();
    shareddata.owner = owner;
    shareddata.team = owner.team;
    shareddata.impacttime = impacttime;
    shareddata.impactincidence = impactincidence;
    shareddata.burnsource = burnsource;
    shareddata.burnid = burnid;
    shareddata.branches = [];
    shareddata.thrownoffhand = thrownoffhand;
    shareddata.entstotal = 0;
    shareddata.caststotal = 0;
    shareddata.caststhisframe = 0;
    shareddata.frametimestamp = gettime();
    shareddata.castcontents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle" ] );
    shareddata.castignore = getaiarray();
    shareddata.castignore = array_add( shareddata.castignore, level.player );
    return shareddata;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x2ed1
// Size: 0x24
function molotov_shared_data_register_cast()
{
    self.caststotal++;
    self.caststhisframe++;
    self.frametimestamp = gettime();
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x2efd
// Size: 0xc
function molotov_shared_data_register_ent()
{
    self.entstotal++;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x2f11
// Size: 0x38, Type: bool
function molotov_shared_data_can_cast_this_frame()
{
    if ( self.frametimestamp < gettime() )
    {
        self.frametimestamp = gettime();
        self.caststhisframe = 0;
    }
    
    return self.caststhisframe < 3;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x2f52
// Size: 0xd4
function molotov_shared_data_is_complete( var_af8745e2185687a8 )
{
    iscomplete = 0;
    
    if ( self.caststotal >= 60 )
    {
        iscomplete = 1;
    }
    else if ( self.entstotal >= 20 )
    {
        iscomplete = 1;
    }
    else if ( istrue( var_af8745e2185687a8 ) )
    {
        var_3ce5d6eb962629fa = 1;
        
        foreach ( branch in self.branches )
        {
            if ( !branch molotov_branch_is_complete( 1, 1 ) )
            {
                var_3ce5d6eb962629fa = 0;
                break;
            }
        }
        
        if ( var_3ce5d6eb962629fa )
        {
            iscomplete = 1;
        }
    }
    
    if ( iscomplete )
    {
        self.iscomplete = 1;
        self.branches = [];
    }
    
    return iscomplete;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 10
// Checksum 0x0, Offset: 0x302f
// Size: 0x12b
function molotov_create_branch( shareddata, castdata, pooldata, parent, startingorigin, startingangles, startingstuckto, startingcasttype, preventstarttime, oncompletedfunc )
{
    branch = spawnstruct();
    branch.shareddata = shareddata;
    branch.castdata = castdata;
    branch.pooldata = pooldata;
    branch.startingorigin = startingorigin;
    branch.startingangles = startingangles;
    branch.startingstuckto = startingstuckto;
    branch.startingcasttype = startingcasttype;
    branch.oncompletedfunc = oncompletedfunc;
    branch.ents = [];
    branch.branches = [];
    branch.hitpositions = [];
    branch.hittypes = [];
    branch.casts = 0;
    branch.castfails = 0;
    branch.preventstarttime = preventstarttime;
    return branch;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x3163
// Size: 0x88d
function molotov_start_branch()
{
    /#
        thread molotov_branch_draw_hits();
    #/
    
    if ( !isdefined( self.preventstarttime ) )
    {
        self.preventstarttime = gettime();
    }
    
    if ( !isdefined( self.startingcasttype ) )
    {
        if ( !self.shareddata molotov_shared_data_is_complete() )
        {
            pool = molotov_branch_create_pool( self.startingorigin, self.startingangles, self.shareddata.impactincidence, self.startingstuckto );
            pool thread molotov_pool_start();
            pool_damage_scriptables( pool.origin );
            pool_damage_vehicles( pool.origin, pool );
            pool_damage_ai( pool.origin, self.shareddata.owner );
            self.iscomplete = 1;
            self.shareddata molotov_shared_data_is_complete( 1 );
            
            /#
                self.hitpositions[ self.hitpositions.size ] = self.startingorigin;
                self.hittypes[ self.hittypes.size ] = 1;
            #/
        }
        
        return;
    }
    
    self.caststart = self.startingorigin;
    self.castend = undefined;
    self.castangles = self.startingangles;
    self.castdir = undefined;
    self.casttype = self.startingcasttype;
    self.startingorigin = undefined;
    self.startingangles = undefined;
    self.startingcasttype = undefined;
    
    while ( true )
    {
        if ( self.shareddata molotov_shared_data_is_complete() )
        {
            break;
        }
        
        if ( molotov_branch_is_complete( undefined, 1 ) )
        {
            break;
        }
        
        if ( !self.shareddata molotov_shared_data_can_cast_this_frame() )
        {
            waitframe();
            continue;
        }
        
        if ( self.casttype == 0 )
        {
            firstforwardmodanglesfunc = self.castdata.firstforwardmodanglesfunc;
            
            if ( isdefined( firstforwardmodanglesfunc ) )
            {
                self.castangles = [[ firstforwardmodanglesfunc ]]( self.castangles );
                self.castdata.firstforwardmodanglesfunc = undefined;
                self.castdata.iswallcast = undefined;
            }
        }
        
        if ( !isdefined( self.iswallcast ) )
        {
            updot = vectordot( anglestoup( self.castangles ), ( 0, 0, 1 ) );
            self.iswallcast = updot > -0.81915 && updot <= 0.5;
            
            if ( isdefined( self.castdata.firstforwarddist ) )
            {
                if ( self.iswallcast && isdefined( self.castdata.firstforwarddistwall ) )
                {
                    self.castdata.firstforwarddist = self.castdata.firstforwarddistwall;
                    self.castdata.firstforwarddistwall = undefined;
                }
                else
                {
                    self.castdata.firstforwarddistwall = undefined;
                }
            }
        }
        
        self.castdir = molotov_get_cast_dir( self.castangles, self.casttype );
        self.castend = self.caststart + self.castdir * molotov_get_cast_dist( self.casttype, self.castdata, self.iswallcast );
        casthit = undefined;
        casthitpos = undefined;
        casthitnorm = undefined;
        casthitent = undefined;
        casthitangles = undefined;
        
        /#
            if ( level.dbgmolodrawhits )
            {
                line( self.caststart, self.castend, ( 1, 1, 1 ), 1, 0, 100 );
            }
        #/
        
        castresults = physics_raycast( self.caststart, self.castend, self.shareddata.castcontents, undefined, 0, "physicsquery_closest", 1 );
        
        if ( isdefined( castresults ) && castresults.size > 0 )
        {
            casthit = 1;
            casthitpos = castresults[ 0 ][ "position" ];
            casthitnorm = castresults[ 0 ][ "normal" ];
            casthitent = castresults[ 0 ][ "entity" ];
        }
        
        switch ( self.casttype )
        {
            case 0:
                if ( istrue( casthit ) )
                {
                    molotov_branch_register_cast( self.casttype, 0, casthitpos );
                    shouldcreatepool = 1;
                    
                    if ( isdefined( self.castdata.firstforwarddist ) )
                    {
                        castvec = casthitpos - self.caststart;
                        castdist = vectordot( castvec, self.castdir );
                        self.castdata.firstforwarddist -= castdist;
                        
                        if ( self.castdata.firstforwarddist > self.castdata.firstforwardmindist )
                        {
                            shouldcreatepool = 0;
                        }
                        else
                        {
                            self.castdata.firstforwarddist = undefined;
                        }
                    }
                    
                    casthitangles = molotov_rebuild_angles_up_right( casthitnorm, anglestoright( self.castangles ) );
                    
                    if ( shouldcreatepool )
                    {
                        ent = molotov_branch_create_pool( casthitpos, casthitangles, self.shareddata.impactincidence, casthitent );
                        ent thread molotov_pool_start();
                        pool_damage_ai( ent.origin, self.shareddata.owner );
                    }
                    
                    self.casttype = 2;
                    self.caststart = casthitpos + casthitnorm * 1;
                    self.castangles = casthitangles;
                    self.iswallcast = undefined;
                }
                else
                {
                    molotov_branch_register_cast( self.casttype, undefined, undefined );
                    
                    if ( isdefined( self.castdata.firstforwarddist ) )
                    {
                        castvec = self.castend - self.caststart;
                        castdist = vectordot( castvec, self.castdir );
                        self.castdata.firstforwarddist -= castdist;
                        
                        if ( self.castdata.firstforwarddist <= self.castdata.firstforwardmindist )
                        {
                            self.castdata.firstforwarddist = undefined;
                        }
                    }
                    
                    self.casttype = 1;
                    self.caststart = self.castend;
                }
                
                break;
            case 1:
                if ( istrue( casthit ) )
                {
                    casthitangles = molotov_rebuild_angles_up_right( casthitnorm, anglestoright( self.castangles ) );
                    ent = molotov_branch_create_pool( casthitpos, casthitangles, self.shareddata.impactincidence, casthitent );
                    ent thread molotov_pool_start();
                    pool_damage_ai( ent.origin, self.shareddata.owner );
                    normdot = vectordot( anglestoup( self.castangles ), casthitnorm );
                    
                    if ( normdot < 0.9848 )
                    {
                        molotov_branch_register_cast( self.casttype, 2, casthitpos );
                        self.casttype = 2;
                        self.caststart = casthitpos + casthitnorm * 1;
                        self.castangles = casthitangles;
                    }
                    else
                    {
                        molotov_branch_register_cast( self.casttype, 1, casthitpos );
                        self.casttype = 0;
                    }
                }
                else
                {
                    molotov_branch_register_cast( self.casttype, undefined, undefined );
                    self.caststart = self.castend;
                }
                
                break;
            case 2:
                if ( istrue( casthit ) )
                {
                    molotov_branch_register_cast( self.casttype, 3, casthitpos );
                    self.casttype = 0;
                    self.caststart = casthitpos + casthitnorm * 1;
                }
                else
                {
                    molotov_branch_register_cast( self.casttype, undefined, undefined );
                    self.casttype = 0;
                }
                
                break;
        }
        
        waittillframeend();
    }
    
    self.iscomplete = 1;
    self.shareddata molotov_shared_data_is_complete( 1 );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 2
// Checksum 0x0, Offset: 0x39f8
// Size: 0x27a
function molotov_branch_is_complete( var_af8745e2185687a8, var_f7d3f0b0605b5824 )
{
    iscomplete = 0;
    var_3ce5d6eb962629fa = undefined;
    
    if ( !istrue( var_f7d3f0b0605b5824 ) )
    {
        iscomplete = self.shareddata molotov_shared_data_is_complete();
    }
    
    if ( !iscomplete )
    {
        if ( isdefined( self.castdata ) && isdefined( self.castdata.maxfails ) && self.castfails >= self.castdata.maxfails )
        {
            iscomplete = 1;
        }
        else if ( isdefined( self.castdata ) && isdefined( self.castdata.maxcasts ) && self.casts >= self.castdata.maxcasts )
        {
            iscomplete = 1;
        }
        else if ( isdefined( self.castdata ) && isdefined( self.castdata.maxents ) && self.ents.size >= self.castdata.maxents )
        {
            iscomplete = 1;
        }
        else if ( istrue( var_af8745e2185687a8 ) && self.branches.size > 0 )
        {
            var_3ce5d6eb962629fa = 1;
            
            foreach ( branch in self.branches )
            {
                if ( !branch molotov_branch_is_complete( var_af8745e2185687a8, var_f7d3f0b0605b5824 ) )
                {
                    var_3ce5d6eb962629fa = 0;
                    break;
                }
            }
            
            if ( var_3ce5d6eb962629fa )
            {
                iscomplete = 1;
            }
        }
    }
    
    if ( iscomplete && !istrue( self.iscomplete ) )
    {
        oncompletedfunc = self.oncompletedfunc;
        self.oncompletedfunc = undefined;
        
        if ( isdefined( oncompletedfunc ) )
        {
            self [[ oncompletedfunc ]]();
        }
        
        println( "<dev string:x1c>" );
        
        if ( istrue( var_3ce5d6eb962629fa ) )
        {
            iscomplete = 0;
            
            foreach ( branch in self.branches )
            {
                if ( !branch molotov_branch_is_complete( 1, var_f7d3f0b0605b5824 ) )
                {
                    var_3ce5d6eb962629fa = 0;
                    break;
                }
            }
            
            if ( var_3ce5d6eb962629fa )
            {
                iscomplete = 1;
            }
        }
    }
    
    if ( iscomplete )
    {
        self.iscomplete = 1;
        self.branches = [];
    }
    
    return iscomplete;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 3
// Checksum 0x0, Offset: 0x3c7b
// Size: 0x179
function molotov_branch_register_cast( casttype, casthittype, hitposition )
{
    self.shareddata molotov_shared_data_register_cast();
    self.casts++;
    
    if ( isdefined( casthittype ) )
    {
        if ( casthittype == 0 || casthittype == 1 || casthittype == 2 )
        {
            self.castfails = 0;
        }
    }
    else if ( casttype == 1 )
    {
        self.castfails++;
    }
    
    /#
        debugmsg = undefined;
        
        if ( isdefined( casthittype ) )
        {
            debugmsg = undefined;
            
            switch ( casthittype )
            {
                case 0:
                    debugmsg = "<dev string:x34>";
                    break;
                case 1:
                    debugmsg = "<dev string:x40>";
                    break;
                case 2:
                    debugmsg = "<dev string:x49>";
                    break;
                case 3:
                    debugmsg = "<dev string:x59>";
                    break;
            }
            
            self.hitpositions[ self.hitpositions.size ] = hitposition;
            self.hittypes[ self.hittypes.size ] = casthittype;
        }
        else
        {
            switch ( casttype )
            {
                case 0:
                    debugmsg = "<dev string:x60>";
                    break;
                case 1:
                    debugmsg = "<dev string:x68>";
                    break;
                case 2:
                    debugmsg = "<dev string:x72>";
                    break;
            }
        }
        
        if ( istrue( level.var_4482770c326f1498 ) )
        {
            if ( isdefined( debugmsg ) )
            {
                println( debugmsg );
            }
        }
    #/
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 9
// Checksum 0x0, Offset: 0x3dfc
// Size: 0x106
function molotov_create_pool( origin, angles, stuckto, owner, burnsource, burnid, starttime, pooldata, poolmask )
{
    ent = spawn( "script_model", origin );
    ent.angles = angles;
    ent.stuckto = stuckto;
    ent.owner = owner;
    ent.burnsource = burnsource;
    ent.burnid = burnid;
    ent.starttime = starttime;
    ent.pooldata = pooldata;
    ent.poolmask = poolmask;
    ent setmodel( "equip_molotov_pool_mp" );
    
    if ( isdefined( owner ) )
    {
        ent setotherent( owner );
        ent setentityowner( owner );
    }
    
    if ( poolshouldlink( stuckto ) )
    {
        ent linkto( stuckto );
    }
    
    return ent;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x3f0b
// Size: 0x2f, Type: bool
function poolshouldlink( stuckto )
{
    if ( !isdefined( stuckto ) )
    {
        return false;
    }
    
    if ( stuckto == level.player )
    {
        return false;
    }
    
    if ( isai( stuckto ) )
    {
        return false;
    }
    
    return true;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 4
// Checksum 0x0, Offset: 0x3f43
// Size: 0x157
function molotov_branch_create_pool( origin, angles, incidence, stuckto )
{
    poolmask = self.pooldata.typeid;
    up = anglestoup( angles );
    dot = vectordot( up, ( 0, 0, 1 ) );
    
    if ( dot <= -0.81915 )
    {
        poolmask |= 256;
    }
    else if ( dot <= 0.5 )
    {
        poolmask |= 128;
    }
    else
    {
        poolmask |= 64;
    }
    
    poolmask |= incidence;
    starttime = self.preventstarttime + self.pooldata.startdelayms;
    ent = molotov_create_pool( origin, angles, stuckto, self.shareddata.owner, self.shareddata.burnsource, self.shareddata.burnid, starttime, self.pooldata, poolmask );
    self.preventstarttime = starttime;
    self.ents[ self.ents.size ] = ent;
    self.shareddata molotov_shared_data_register_ent();
    return ent;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x40a3
// Size: 0x5d
function molotov_pool_start()
{
    if ( istrue( self.started ) )
    {
        return;
    }
    
    self.started = 1;
    self endon( "death" );
    self endon( "molotov_pool_end" );
    
    while ( gettime() < self.starttime )
    {
        waitframe();
    }
    
    self.ended = 0;
    molotov_watch_pool();
    
    if ( isdefined( self ) )
    {
        thread molotov_pool_end();
    }
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x4108
// Size: 0x188
function molotov_watch_pool_explosion_extinguish()
{
    contents = physics_createcontents( [ "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle", "physicscontents_explosionclip" ] );
    
    while ( true )
    {
        level waittill( "explosion_extinguish", position, radius, owner, ignoreents );
        
        if ( distancesquared( position, self.origin ) > radius * radius )
        {
            continue;
        }
        
        if ( !isdefined( ignoreents ) )
        {
            ignoreents = [];
            ignoreents[ ignoreents.size ] = self;
            ignoreents[ ignoreents.size ] = self.burnsource;
        }
        else if ( isarray( ignoreents ) )
        {
            ignoreents[ ignoreents.size ] = self;
            ignoreents[ ignoreents.size ] = self.burnsource;
        }
        else
        {
            ignoreent = ignoreents;
            ignoreents = [];
            ignoreents[ ignoreents.size ] = self;
            ignoreents[ ignoreents.size ] = self.burnsource;
            ignoreents[ ignoreents.size ] = ignoreent;
        }
        
        castoffset = min( 15, self.pooldata.triggerheight );
        caststart = self.origin + anglestoup( self.angles ) * castoffset;
        castresults = physics_raycast( self.origin, position, contents, ignoreents, 0, "physicsquery_closest", 1 );
        
        if ( isdefined( castresults ) && castresults.size > 0 )
        {
            continue;
        }
        
        thread molotov_pool_end();
    }
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x4298
// Size: 0x1e6
function molotov_watch_pool()
{
    if ( isdefined( self.stuckto ) )
    {
        self.stuckto endon( "death" );
    }
    
    childthread molotov_watch_pool_explosion_extinguish();
    
    if ( !istrue( level.dbgmoloburnlooponly ) && !istrue( level.dbgmolodiedownonly ) )
    {
        self.poolmask |= 1;
        
        /#
            if ( istrue( level.dbgmoloflareuponly ) )
            {
                iprintlnbold( "<dev string:x75>" );
            }
        #/
    }
    
    self.trigger = molotov_create_pool_trigger( self.pooldata.triggerradius, self.pooldata.triggerheight, self.pooldata.triggeroffset, self.pooldata.dangerzoneradius, self.pooldata.dangerzoneheight );
    
    /#
        if ( level.dbgmolodrawhits )
        {
            sphere( self.trigger.origin, self.pooldata.triggerradius, ( 1, 0, 0 ), 0, 300 );
        }
    #/
    
    molotov_pool_update_scriptable();
    wait 0.7;
    
    if ( !istrue( level.dbgmoloflareuponly ) && !istrue( level.dbgmolodiedownonly ) )
    {
        self.poolmask |= 2;
        
        /#
            if ( istrue( level.dbgmoloburnlooponly ) )
            {
                iprintlnbold( "<dev string:x84>" );
            }
        #/
    }
    
    molotov_pool_update_scriptable();
    wait 0.3;
    self.poolmask &= ~1;
    
    /#
        if ( istrue( level.dbgmoloflareuponly ) )
        {
            iprintlnbold( "<dev string:x94>" );
        }
    #/
    
    molotov_pool_update_scriptable();
    burnloopduration = randomfloatrange( 6, 6.25 );
    wait burnloopduration;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x4486
// Size: 0x161
function molotov_pool_end( immediate )
{
    self endon( "death" );
    
    if ( istrue( self.ended ) )
    {
        return;
    }
    
    self notify( "molotov_pool_end" );
    self.ended = 1;
    
    if ( isdefined( self.poolmask ) )
    {
        self.poolmask &= ~1;
        self.poolmask &= ~2;
    }
    
    /#
        if ( istrue( level.dbgmoloflareuponly ) )
        {
            iprintlnbold( "<dev string:x94>" );
        }
        else if ( istrue( level.dbgmoloburnlooponly ) )
        {
            iprintlnbold( "<dev string:xa1>" );
        }
    #/
    
    if ( !istrue( level.dbgmoloflareuponly ) && !istrue( level.dbgmoloburnlooponly ) && isdefined( self.poolmask ) )
    {
        self.poolmask |= 4;
        
        /#
            if ( istrue( level.dbgmolodiedownonly ) )
            {
                iprintlnbold( "<dev string:xaf>" );
            }
        #/
    }
    
    molotov_pool_update_scriptable();
    
    if ( !istrue( immediate ) )
    {
        wait 1;
    }
    
    /#
        if ( istrue( level.dbgmolodiedownonly ) )
        {
            iprintlnbold( "<dev string:xbe>" );
        }
    #/
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    self setscriptablepartstate( "decal", "neutral", 0 );
    wait 3.5;
    self delete();
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 5
// Checksum 0x0, Offset: 0x45ef
// Size: 0x187
function molotov_create_pool_trigger( triggerradius, triggerheight, triggeroffset, dangerzoneradius, dangerzoneheight )
{
    origin = self.origin - anglestoup( self.angles ) * triggeroffset;
    trigger = spawn( "trigger_radius_fire", origin, 0, triggerradius, triggerheight );
    trigger.script_multiplier = 10;
    trigger.script_radius = triggerradius;
    trigger.angles = self.angles;
    thread scripts\sp\trigger::trigger_fire( trigger );
    level notify( "molotov_fire_trigger", trigger );
    trigger enablelinkto();
    trigger linkto( self );
    trigger hide();
    struct = spawnstruct();
    struct.trigger = trigger;
    struct.attacker = self.owner;
    struct.inflictor = self.burnsource;
    struct.killcament = self.burnsource;
    struct.burnid = self.burnid;
    struct.playersintrigger = [];
    trigger.struct = struct;
    
    if ( isdefined( dangerzoneradius ) )
    {
        assertex( dangerzoneradius > 0, "Danger zone radius must be greater than zero." );
        assertex( isdefined( dangerzoneheight ), "Danger zone height must be defined if danger zone radius is defined." );
        assertex( dangerzoneheight > 0, "Danger zone height must be greater than zero." );
    }
    
    return trigger;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x477f
// Size: 0xe4
function molotov_pool_update_scriptable()
{
    pooldatalvl = level.molotovdata.pooldata;
    statemask = self.poolmask & ( 1 | 2 | 4 );
    var_e42c4a59211c25aa = ( 1 | 2 | 4 ) ^ ( 1 | 2 | 4 ) & ( 1 | 2 | 4 ) - 1;
    statebit = var_e42c4a59211c25aa;
    
    while ( ( statebit & ( 1 | 2 | 4 ) ) > 0 )
    {
        mask = ~( ( 1 | 2 | 4 ) & ~statebit ) & self.poolmask;
        part = pooldatalvl.scriptableparts[ statebit ];
        state = pooldatalvl.scriptablestates[ mask ];
        self setscriptablepartstate( part, state, 0 );
        statebit <<= 1;
    }
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 9
// Checksum 0x0, Offset: 0x486b
// Size: 0x1d0
function molotov_branch_create_sub_branch( id, starttime, firstforwarddist, firstforwardmindist, firstforwardmodanglesfunc, firstforwarddistwall, maxcasts, maxents, startbranch )
{
    shareddata = self.shareddata;
    castdata = molotov_get_cast_data( id );
    pooldata = molotov_get_pool_data( id );
    
    if ( isdefined( self.castdata ) )
    {
        if ( self.castfails > self.castdata.maxfails )
        {
            return;
        }
        
        if ( self.castfails > castdata.maxfails )
        {
            return;
        }
    }
    
    if ( isdefined( firstforwarddist ) )
    {
        castdata.firstforwarddist = firstforwarddist;
    }
    
    if ( isdefined( firstforwardmindist ) )
    {
        castdata.firstforwardmindist = firstforwardmindist;
    }
    
    if ( isdefined( firstforwardmodanglesfunc ) )
    {
        castdata.firstforwardmodanglesfunc = firstforwardmodanglesfunc;
    }
    
    if ( isdefined( firstforwarddistwall ) )
    {
        castdata.firstforwarddistwall = firstforwarddistwall;
    }
    
    if ( isdefined( maxcasts ) )
    {
        castdata.maxcasts = maxcasts;
    }
    
    if ( isdefined( maxents ) )
    {
        castdata.maxents = maxents;
    }
    
    branch = molotov_create_branch( shareddata, castdata, pooldata, self, self.caststart, self.castangles, undefined, self.casttype, self.preventstarttime );
    branch.castfails = self.castfails;
    self.branches[ self.branches.size ] = branch;
    shareddata.branches[ shareddata.branches.size ] = branch;
    
    if ( istrue( startbranch ) )
    {
        branch thread molotov_start_branch();
    }
    
    return branch;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x4a44
// Size: 0x1f
function molotov_branch_create_forward_tendril_cone()
{
    molotov_branch_create_sub_branch( 32, self.preventstarttime, 35, 8, undefined, 44, undefined, undefined, 1 );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x4a6b
// Size: 0x23
function molotov_branch_create_left_tendril_cone()
{
    molotov_branch_create_sub_branch( 32, self.preventstarttime, 35, 8, &molotov_left_tendril_mod_angles, 44, undefined, undefined, 1 );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x4a96
// Size: 0x23
function molotov_branch_create_right_tendril_cone()
{
    molotov_branch_create_sub_branch( 32, self.preventstarttime, 35, 8, &molotov_right_tendril_mod_angles, 44, undefined, undefined, 1 );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x4ac1
// Size: 0x25
function molotov_branch_create_tendril_radial()
{
    molotov_branch_create_sub_branch( 32, self.preventstarttime, 35, 8, &molotov_tendril_mod_angles_radial, 44, 6, 1, 1 );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 2
// Checksum 0x0, Offset: 0x4aee
// Size: 0x6a
function molotov_rotate_angles_about_up( angles, amount )
{
    forward = anglestoforward( angles );
    up = anglestoup( angles );
    right = undefined;
    forward = rotatepointaroundvector( up, forward, amount );
    right = vectornormalize( vectorcross( forward, up ) );
    up = vectorcross( right, forward );
    return axistoangles( forward, right, up );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x4b61
// Size: 0x27
function molotov_left_tendril_mod_angles( angles )
{
    amount = randomfloatrange( 50, 75 );
    return molotov_rotate_angles_about_up( angles, amount );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x4b91
// Size: 0x2a
function molotov_right_tendril_mod_angles( angles )
{
    amount = -1 * randomfloatrange( 50, 75 );
    return molotov_rotate_angles_about_up( angles, amount );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x4bc4
// Size: 0x27
function molotov_tendril_mod_angles_radial( angles )
{
    amount = randomfloatrange( -60, 60 );
    return molotov_rotate_angles_about_up( angles, amount );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x4bf4
// Size: 0x19c
function molotov_get_cast_data( castid )
{
    if ( !isdefined( level.molotovdata ) || !isdefined( level.molotovdata.castdata ) )
    {
        molotov_init_cast_data();
    }
    
    castdatalvl = level.molotovdata.castdata;
    castdata = spawnstruct();
    castdata.distforward = castdatalvl.distforward[ castid ];
    castdata.distdown = castdatalvl.distdown[ castid ];
    castdata.distup = castdatalvl.distup[ castid ];
    castdata.maxcasts = castdatalvl.maxcasts[ castid ];
    castdata.maxfails = castdatalvl.maxfails[ castid ];
    castdata.maxents = castdatalvl.maxents[ castid ];
    castdata.distforwardwall = castdatalvl.distforwardwall[ castid ];
    
    if ( isdefined( castdatalvl.firstforwarddist[ castid ] ) )
    {
        castdata.firstforwarddist = castdatalvl.firstforwarddist[ castid ];
        castdata.firstforwardmindist = castdatalvl.firstforwardmindist[ castid ];
        castdata.firstforwardmodanglesfunc = castdatalvl.firstforwardmodanglesfunc[ castid ];
        
        if ( isdefined( castdatalvl.firstforwarddistwall[ castid ] ) )
        {
            castdata.firstforwarddistwall = castdatalvl.firstforwarddistwall[ castid ];
        }
    }
    
    return castdata;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x4d99
// Size: 0x13c
function molotov_get_pool_data( typeid )
{
    if ( !isdefined( level.molotovdata ) || !isdefined( level.molotovdata.pooldata ) )
    {
        molotov_init_pool_data();
    }
    
    pooldatalvl = level.molotovdata.pooldata;
    pooldata = spawnstruct();
    pooldata.typeid = typeid;
    pooldata.triggerradius = pooldatalvl.triggerradius[ typeid ];
    pooldata.triggerheight = pooldatalvl.triggerheight[ typeid ];
    pooldata.aikillradius = pooldatalvl.aikillradius[ typeid ];
    pooldata.aidamageradius = pooldatalvl.aidamageradius[ typeid ];
    pooldata.triggeroffset = pooldatalvl.triggeroffset[ typeid ];
    pooldata.startdelayms = pooldatalvl.startdelayms[ typeid ];
    pooldata.dangerzoneradius = pooldatalvl.dangerzoneradius[ typeid ];
    pooldata.dangerzoneheight = pooldatalvl.dangerzoneheight[ typeid ];
    return pooldata;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 2
// Checksum 0x0, Offset: 0x4ede
// Size: 0x59
function molotov_get_cast_dir( angles, casttype )
{
    switch ( casttype )
    {
        case 0:
            return anglestoforward( angles );
        case 1:
            return ( -1 * anglestoup( angles ) );
        case 2:
            return anglestoup( angles );
    }
    
    return undefined;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 3
// Checksum 0x0, Offset: 0x4f40
// Size: 0xae
function molotov_get_cast_dist( casttype, castdata, iswallcast )
{
    switch ( casttype )
    {
        case 0:
            if ( isdefined( castdata.firstforwarddist ) )
            {
                return castdata.firstforwarddist;
            }
            else if ( iswallcast && isdefined( castdata.distforwardwall ) )
            {
                return castdata.distforwardwall;
            }
            else
            {
                return castdata.distforward;
            }
        case 1:
            return castdata.distdown;
        case 2:
            return castdata.distup;
    }
    
    return undefined;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x4ff7
// Size: 0x2c
function molotov_get_cast_contents()
{
    return physics_createcontents( [ "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle" ] );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 2
// Checksum 0x0, Offset: 0x502c
// Size: 0x3b
function molotov_rebuild_angles_up_right( up, right )
{
    forward = vectornormalize( vectorcross( up, right ) );
    right = vectorcross( forward, up );
    return axistoangles( forward, right, up );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 2
// Checksum 0x0, Offset: 0x5070
// Size: 0x3b
function molotov_rebuild_angles_up_forward( up, forward )
{
    right = vectornormalize( vectorcross( forward, up ) );
    forward = vectorcross( up, right );
    return axistoangles( forward, right, up );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x50b4
// Size: 0x7c
function molotov_get_next_burning_id()
{
    if ( !isdefined( level.molotovdata ) )
    {
        level.molotovdata = spawnstruct();
    }
    
    if ( !isdefined( level.molotovdata.burningid ) )
    {
        level.molotovdata.burningid = 0;
    }
    
    id = level.molotovdata.burningid;
    level.molotovdata.burningid++;
    return id;
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x5139
// Size: 0x184
function molotov_watch_fx()
{
    self notify( "molotov_fx_race" );
    self endon( "molotov_fx_race" );
    watchheldoffhandbreak = 0;
    
    while ( true )
    {
        raceresult = spawnstruct();
        
        if ( watchheldoffhandbreak )
        {
            childthread molotov_fx_race_held_offhand_break( raceresult );
        }
        else
        {
            childthread molotov_fx_race_pullback( raceresult );
        }
        
        childthread molotov_fx_race_grenade_fired( raceresult );
        childthread molotov_fx_race_super_started( raceresult );
        childthread molotov_fx_race_death( raceresult );
        childthread molotov_fx_race_taken( raceresult );
        watchheldoffhandbreak = 0;
        self waittill( "molotov_fx_race_start" );
        waittillframeend();
        pullback = istrue( raceresult.pullback );
        fire = istrue( raceresult.fire );
        superstarted = istrue( raceresult.superstarted );
        death = istrue( raceresult.death );
        taken = istrue( raceresult.taken );
        heldoffhandbreak = istrue( raceresult.heldoffhandbreak );
        
        if ( death )
        {
            self notify( "molotov_fx_race_end" );
            thread molotov_end_fx();
            return;
        }
        else if ( taken )
        {
            self notify( "molotov_fx_race_end" );
            thread molotov_end_fx();
            return;
        }
        else if ( superstarted )
        {
            thread molotov_end_fx();
        }
        else if ( heldoffhandbreak )
        {
            thread molotov_end_fx();
        }
        else if ( fire )
        {
            thread molotov_end_fx();
        }
        else if ( pullback )
        {
            thread molotov_begin_fx();
            watchheldoffhandbreak = 1;
        }
        
        self notify( "molotov_fx_race_end" );
    }
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x52c5
// Size: 0x5a
function molotov_fx_race_pullback( raceresult )
{
    self endon( "molotov_fx_race_end" );
    
    while ( true )
    {
        self waittill( "grenade_pullback", objweapon );
        
        if ( objweapon.basename == "molotov_mp" )
        {
            break;
        }
    }
    
    raceresult.pullback = 1;
    self notify( "molotov_fx_race_start" );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x5327
// Size: 0x65
function molotov_fx_race_grenade_fired( raceresult )
{
    self endon( "molotov_fx_race_end" );
    
    while ( true )
    {
        self waittill( "grenade_fire", grenade, objweapon );
        
        if ( objweapon.basename == "molotov_mp" )
        {
            break;
        }
    }
    
    raceresult.fire = 1;
    self notify( "molotov_fx_race_start" );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x5394
// Size: 0x30
function molotov_fx_race_super_started( raceresult )
{
    self endon( "molotov_fx_race_end" );
    self waittill( "super_started" );
    raceresult.superstarted = 1;
    self notify( "molotov_fx_race_start" );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x53cc
// Size: 0x30
function molotov_fx_race_death( raceresult )
{
    self endon( "molotov_fx_race_end" );
    self waittill( "death" );
    raceresult.death = 1;
    self notify( "molotov_fx_race_start" );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x5404
// Size: 0x30
function molotov_fx_race_taken( raceresult )
{
    self endon( "molotov_fx_race_end" );
    self waittill( "molotov_taken" );
    raceresult.taken = 1;
    self notify( "molotov_fx_race_start" );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x543c
// Size: 0x4d
function molotov_fx_race_held_offhand_break( raceresult )
{
    self endon( "molotov_fx_race_end" );
    waitframe();
    weapon = makeweapon( "molotov_mp" );
    
    while ( self getheldoffhand() == weapon )
    {
        waitframe();
    }
    
    raceresult.heldoffhandbreak = 1;
    self notify( "molotov_fx_race_start" );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x5491
// Size: 0x54
function molotov_begin_fx()
{
    self notify( "molotov_begin_fx" );
    self endon( "molotov_begin_fx" );
    self endon( "molotov_end_fx" );
    self setscriptablepartstate( "equipMtovFXWorld", "neutral", 0 );
    self setscriptablepartstate( "equipMtovFXView", "active", 0 );
    wait 0.15;
    self setscriptablepartstate( "equipMtovFXWorld", "active", 0 );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x54ed
// Size: 0x2e
function molotov_end_fx()
{
    self notify( "molotov_end_fx" );
    self setscriptablepartstate( "equipMtovFXWorld", "neutral", 0 );
    self setscriptablepartstate( "equipMtovFXView", "neutral", 0 );
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 0
// Checksum 0x0, Offset: 0x5523
// Size: 0x6b
function delete_all_molotovs()
{
    if ( isdefined( level.molotovdata ) )
    {
        foreach ( struct in level.molotovdata.active )
        {
            thread delete_molotov( struct );
        }
    }
}

// Namespace molotov / scripts\sp\equipment\molotov
// Params 1
// Checksum 0x0, Offset: 0x5596
// Size: 0x7d
function delete_molotov( shareddata )
{
    if ( isdefined( shareddata.deleting ) )
    {
        return;
    }
    
    shareddata.deleting = 1;
    
    while ( !isdefined( shareddata.initialized ) )
    {
        waitframe();
    }
    
    while ( !shareddata molotov_shared_data_is_complete( 1 ) )
    {
        waitframe();
    }
    
    level notify( "explosion_extinguish", shareddata.burnsource.origin, 500 );
    shareddata.burnsource delete();
}

/#

    // Namespace molotov / scripts\sp\equipment\molotov
    // Params 0
    // Checksum 0x0, Offset: 0x561b
    // Size: 0x15e, Type: dev
    function molotov_branch_draw_hits()
    {
        while ( true )
        {
            if ( istrue( self.shareddata.iscomplete ) )
            {
                break;
            }
            
            if ( istrue( self.iscomplete ) )
            {
                break;
            }
            
            if ( istrue( level.dbgmolodrawhits ) )
            {
                ids = getarraykeys( self.hitpositions );
                
                foreach ( id in ids )
                {
                    hitposition = self.hitpositions[ id ];
                    hittype = self.hittypes[ id ];
                    function_5ac76a3e234f3e1a( hitposition, hittype, 0.05 );
                }
            }
            
            wait 0.05;
        }
        
        if ( istrue( level.dbgmolodrawhits ) )
        {
            ids = getarraykeys( self.hitpositions );
            
            foreach ( id in ids )
            {
                hitposition = self.hitpositions[ id ];
                hittype = self.hittypes[ id ];
                function_5ac76a3e234f3e1a( hitposition, hittype, 5 );
            }
        }
    }

    // Namespace molotov / scripts\sp\equipment\molotov
    // Params 3
    // Checksum 0x0, Offset: 0x5781
    // Size: 0xab, Type: dev
    function function_5ac76a3e234f3e1a( hitposition, hittype, duration )
    {
        color = undefined;
        
        switch ( hittype )
        {
            case 0:
                color = ( 1, 1, 0 );
                break;
            case 2:
                color = ( 1, 0, 0 );
                break;
            case 3:
                color = ( 0, 0, 1 );
                break;
            default:
                color = ( 1, 1, 1 );
                break;
        }
    }

#/
