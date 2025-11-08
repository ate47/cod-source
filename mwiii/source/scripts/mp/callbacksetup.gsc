#using scripts\common\callbacks;
#using scripts\common\damage_tuning;
#using scripts\common\telemetry_utils;
#using scripts\common\vehicle;

#namespace callbacksetup;

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 0
// Checksum 0x0, Offset: 0x1ad
// Size: 0x53
function codecallback_startgametype()
{
    if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "1" )
    {
        level waittill( "eternity" );
    }
    
    if ( !isdefined( level.gametypestarted ) || !level.gametypestarted )
    {
        [[ level.callbackstartgametype ]]();
        level.gametypestarted = 1;
    }
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 0
// Checksum 0x0, Offset: 0x208
// Size: 0x41
function codecallback_playeractive()
{
    if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "1" )
    {
        level waittill( "eternity" );
    }
    
    self endon( "disconnect" );
    
    if ( isdefined( level.callbackplayeractive ) )
    {
        [[ level.callbackplayeractive ]]();
    }
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 0
// Checksum 0x0, Offset: 0x251
// Size: 0x40
function codecallback_playerconnect()
{
    if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "1" )
    {
        level waittill( "eternity" );
    }
    
    self endon( "disconnect" );
    [[ level.callbackplayerconnect ]]();
    callback::callback( "player_connect" );
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 1
// Checksum 0x0, Offset: 0x299
// Size: 0xb4
function codecallback_playerdisconnect( reason )
{
    self notify( "disconnect" );
    self notify( "death_or_disconnect" );
    self.isdisconnecting = 1;
    var_f325fe524d4336b = self function_3b6bbfec65cc4ee3();
    
    if ( var_f325fe524d4336b )
    {
        isplayerreloading = self isreloading();
        
        if ( isplayerreloading )
        {
            telemetrydata = spawnstruct();
            telemetrydata.player = self;
            telemetrydata.reloadcanceltime = getsystemtimeinmicroseconds();
            telemetrydata.cancelreason = "DISCONNECT";
            scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_on_reload_cancel", telemetrydata );
        }
    }
    
    [[ level.callbackplayerdisconnect ]]( reason );
    callback::callback( "player_disconnect" );
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 15
// Checksum 0x0, Offset: 0x355
// Size: 0xc4
function codecallback_playerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, var_b0fc59ff15058522, var_be4285b26ed99ab1 )
{
    self endon( "disconnect" );
    
    if ( isdefined( level.weaponmapfunc ) )
    {
        objweapon = [[ level.weaponmapfunc ]]( objweapon, einflictor );
    }
    
    [[ level.callbackplayerdamage ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, var_b0fc59ff15058522, var_be4285b26ed99ab1 );
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 2
// Checksum 0x0, Offset: 0x421
// Size: 0x72
function codecallback_playerfinishweaponchange( objoldweapon, objnewweapon )
{
    self endon( "disconnect" );
    
    if ( isdefined( level.weaponmapfunc ) )
    {
        [[ level.weaponmapfunc ]]( objoldweapon );
        [[ level.weaponmapfunc ]]( objnewweapon );
    }
    
    if ( isdefined( level.callbackfinishweaponchange ) )
    {
        [[ level.callbackfinishweaponchange ]]( objnewweapon, objoldweapon, objnewweapon.isalternate, objoldweapon.isalternate );
    }
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 10
// Checksum 0x0, Offset: 0x49b
// Size: 0x8f
function codecallback_playerimpaled( eattacker, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34, var_d3564b2364cb59e6, var_a4d8eb0a63f60f6b )
{
    self endon( "disconnect" );
    
    if ( isdefined( level.weaponmapfunc ) )
    {
        [[ level.weaponmapfunc ]]( objweapon );
    }
    
    [[ level.callbackplayerimpaled ]]( eattacker, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34, var_d3564b2364cb59e6, var_a4d8eb0a63f60f6b );
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 5
// Checksum 0x0, Offset: 0x532
// Size: 0x5e
function function_352bf03b62b5e7d3( eattacker, objweapon, vdir, magnitude, shitloc )
{
    self endon( "disconnect" );
    
    if ( isdefined( level.weaponmapfunc ) )
    {
        [[ level.weaponmapfunc ]]( objweapon );
    }
    
    [[ level.var_189d24c2bbeed3f5 ]]( eattacker, objweapon, vdir, magnitude, shitloc, 0 );
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 10
// Checksum 0x0, Offset: 0x598
// Size: 0x90
function codecallback_playerkilled( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration )
{
    self endon( "disconnect" );
    
    if ( isdefined( level.weaponmapfunc ) )
    {
        [[ level.weaponmapfunc ]]( objweapon, einflictor );
    }
    
    [[ level.callbackplayerkilled ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration );
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 14
// Checksum 0x0, Offset: 0x630
// Size: 0x1b8
function codecallback_vehicledamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid )
{
    partname = scripts\common\vehicle::function_8ed0ffa3f8be7c75( partname );
    attachtagname = scripts\common\vehicle::function_8ed0ffa3f8be7c75( attachtagname );
    
    if ( isdefined( self.nullownerdamagefunc ) )
    {
        nulldamage = [[ self.nullownerdamagefunc ]]( attacker );
        
        if ( isdefined( nulldamage ) && nulldamage )
        {
            return;
        }
    }
    
    if ( isdefined( level.weaponmapfunc ) )
    {
        objweapon = [[ level.weaponmapfunc ]]( objweapon, inflictor );
    }
    
    if ( isdefined( self.var_e913079a5ffda56d ) )
    {
        damage = getmodifieddamageusingdamagetuning( attacker, objweapon, meansofdeath, damage, self.maxhealth, self.var_e913079a5ffda56d );
    }
    
    if ( isdefined( self.damagecallback ) )
    {
        self [[ self.damagecallback ]]( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid );
        return;
    }
    
    if ( isdefined( level.vehicles ) && isdefined( level.vehicles.damagecallback ) && isdefined( self.vehiclename ) )
    {
        self [[ level.vehicles.damagecallback ]]( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid );
        return;
    }
    
    self vehicle_finishdamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname );
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 9
// Checksum 0x0, Offset: 0x7f0
// Size: 0xed
function codecallback_playerlaststand( einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration )
{
    self endon( "disconnect" );
    
    if ( isdefined( self.perks ) && ( isdefined( self.perks[ "specialty_pistoldeath" ] ) || isdefined( self.perks[ "specialty_survivor" ] ) ) )
    {
        if ( isdefined( level.weaponmapfunc ) )
        {
            [[ level.weaponmapfunc ]]( objweapon, einflictor );
        }
        
        return [[ level.callbackplayerlaststand ]]( einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration );
    }
    
    if ( isdefined( eattacker ) && isdefined( eattacker.team ) )
    {
        level notify( "down_enemy_laststand_" + eattacker.team, eattacker, self );
    }
    
    return 0;
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 1
// Checksum 0x0, Offset: 0x8e5
// Size: 0x25
function codecallback_spawnpointsprecalc( team )
{
    if ( isdefined( level.callbackspawnpointprecalc ) )
    {
        [[ level.callbackspawnpointprecalc ]]( team );
    }
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 3
// Checksum 0x0, Offset: 0x912
// Size: 0x3c
function codecallback_spawnpointscore( player, spawnpoint, team )
{
    if ( isdefined( level.callbackspawnpointscore ) )
    {
        return player [[ level.callbackspawnpointscore ]]( spawnpoint, team );
    }
    
    return 0;
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 3
// Checksum 0x0, Offset: 0x957
// Size: 0x71
function codecallback_spawnpointcritscore( player, spawnpoint, team )
{
    result = "primary";
    
    if ( isdefined( level.callbackspawnpointcritscore ) )
    {
        result = player [[ level.callbackspawnpointcritscore ]]( spawnpoint, team );
    }
    
    if ( result == "primary" )
    {
        return 100;
    }
    else if ( result == "secondary" )
    {
        return 50;
    }
    
    return 0;
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 0
// Checksum 0x0, Offset: 0x9d1
// Size: 0x15
function codecallback_playermigrated()
{
    self endon( "disconnect" );
    [[ level.callbackplayermigrated ]]();
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 0
// Checksum 0x0, Offset: 0x9ee
// Size: 0xe
function codecallback_hostmigration()
{
    [[ level.callbackhostmigration ]]();
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 0
// Checksum 0x0, Offset: 0xa04
// Size: 0x34
function function_99f3c84cf3b7ceb8()
{
    if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "1" )
    {
        level waittill( "eternity" );
    }
    
    self endon( "disconnect" );
    [[ level.var_42d9b617bbca6a42 ]]();
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 1
// Checksum 0x0, Offset: 0xa40
// Size: 0x20
function function_dbf77b841cfb8d59( reason )
{
    self notify( "disconnectmayrejoin" );
    [[ level.var_935c97aa3757676f ]]( reason );
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 2
// Checksum 0x0, Offset: 0xa68
// Size: 0x21
function function_c305fc8bed32b81e( achievementid, progressdata )
{
    [[ level.var_cda3af1f73639c7c ]]( achievementid, progressdata );
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 0
// Checksum 0x0, Offset: 0xa91
// Size: 0x43
function function_493bb22764bc865()
{
    if ( !isdefined( level.autopilot ) )
    {
        return 0;
    }
    
    assert( isdefined( level.autopilot.var_f189ca4555aa689e ) );
    return [[ level.autopilot.var_f189ca4555aa689e ]]();
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 0
// Checksum 0x0, Offset: 0xadd
// Size: 0x18
function function_216b4c739c8bf413()
{
    [[ level.autopilot.var_c214b782db6525f ]]();
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 0
// Checksum 0x0, Offset: 0xafd
// Size: 0x18
function function_c45c947888c3a913()
{
    [[ level.autopilot.var_205cb63b80da5b ]]();
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 0
// Checksum 0x0, Offset: 0xb1d
// Size: 0xe1
function abortlevel()
{
    println( "<dev string:x1c>" );
    level.callbackstartgametype = &callbackvoid;
    level.callbackplayeractive = &callbackvoid;
    level.callbackplayerconnect = &callbackvoid;
    level.callbackplayerdisconnect = &callbackvoid;
    level.callbackplayerdamage = &callbackvoid;
    level.callbackplayerimpaled = &callbackvoid;
    level.var_189d24c2bbeed3f5 = &callbackvoid;
    level.callbackplayerkilled = &callbackvoid;
    level.callbackplayerlaststand = &callbackvoid;
    level.callbackplayermigrated = &callbackvoid;
    level.callbackhostmigration = &callbackvoid;
    level.var_42d9b617bbca6a42 = &callbackvoid;
    level.var_935c97aa3757676f = &callbackvoid;
    setdvar( @"g_gametype", "dm" );
    exitlevel( 0 );
}

// Namespace callbacksetup / scripts\mp\callbacksetup
// Params 0
// Checksum 0x0, Offset: 0xc06
// Size: 0x2
function callbackvoid()
{
    
}

