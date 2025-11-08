#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace combat_utility;

// Namespace combat_utility / scripts\anim\combat_utility
// Params 0
// Checksum 0x0, Offset: 0x17a
// Size: 0x2
function shootuntilshootbehaviorchange()
{
    
}

// Namespace combat_utility / scripts\anim\combat_utility
// Params 0
// Checksum 0x0, Offset: 0x184
// Size: 0x2
function initgrenadethrowanims()
{
    
}

// Namespace combat_utility / scripts\anim\combat_utility
// Params 0
// Checksum 0x0, Offset: 0x18e
// Size: 0xbf
function throwgrenadeatplayerasap_combat_utility()
{
    assert( self isbadguy() );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level.players[ i ] function_4c108309dc0d7fd2() == 0 )
        {
            aisetgrenadetimer( level.players[ i ], "lethal", 0 );
        }
    }
    
    function_98deae9464f6c005( 1 );
    
    /#
        enemies = getaiarray( "<dev string:x1c>" );
        
        if ( enemies.size == 0 )
        {
            return;
        }
        
        var_20d57e479df6089c = 0;
        
        for ( i = 0; i < enemies.size ; i++ )
        {
            if ( enemies[ i ].grenadeammo > 0 )
            {
                return;
            }
        }
        
        println( "<dev string:x28>" );
    #/
}

/#

    // Namespace combat_utility / scripts\anim\combat_utility
    // Params 1
    // Checksum 0x0, Offset: 0x255
    // Size: 0xa1, Type: dev
    function function_96d556dea441d1dc( grenadetimer )
    {
        if ( grenadetimer.isplayertimer )
        {
            for ( i = 0; i < level.players.size ; i++ )
            {
                if ( level.players[ i ] == grenadetimer.player )
                {
                    break;
                }
            }
            
            return ( "<dev string:x7c>" + i + 1 + "<dev string:x87>" + grenadetimer.weapon.basename );
        }
        
        return "<dev string:x8c>" + grenadetimer.weapon.basename;
    }

#/

// Namespace combat_utility / scripts\anim\combat_utility
// Params 7
// Checksum 0x0, Offset: 0x2fe
// Size: 0x3b
function trygrenadethrow( throwingat, destination, optionalanimation, armoffset, fastthrow, withbounce, throwinthread )
{
    
}

// Namespace combat_utility / scripts\anim\combat_utility
// Params 0
// Checksum 0x0, Offset: 0x341
// Size: 0x95
function getgrenadedropvelocity()
{
    yaw = randomfloat( 360 );
    pitch = randomfloatrange( 30, 75 );
    amntz = sin( pitch );
    cospitch = cos( pitch );
    amntx = cos( yaw ) * cospitch;
    amnty = sin( yaw ) * cospitch;
    speed = randomfloatrange( 100, 200 );
    velocity = ( amntx, amnty, amntz ) * speed;
    return velocity;
}

// Namespace combat_utility / scripts\anim\combat_utility
// Params 0
// Checksum 0x0, Offset: 0x3df
// Size: 0x42
function dropgrenade()
{
    if ( isdefined( self.nodropgrenade ) )
    {
        return;
    }
    
    grenadeorigin = self gettagorigin( "tag_accessory_right" );
    velocity = getgrenadedropvelocity();
    self magicgrenademanual( grenadeorigin, velocity, 3 );
}

// Namespace combat_utility / scripts\anim\combat_utility
// Params 1
// Checksum 0x0, Offset: 0x429
// Size: 0x46
function getpitchtoshootspot( spot )
{
    if ( !isdefined( spot ) )
    {
        return 0;
    }
    
    vectortoenemy = spot - self getshootatpos();
    vectortoenemy = vectornormalize( vectortoenemy );
    pitchdelta = vectortoangles( vectortoenemy )[ 0 ];
    return angleclamp180( pitchdelta );
}

// Namespace combat_utility / scripts\anim\combat_utility
// Params 0
// Checksum 0x0, Offset: 0x478
// Size: 0x5e
function watchreloading()
{
    self.isreloading = 0;
    self.lastreloadstarttime = -1;
    
    while ( true )
    {
        self waittill( "reload_start" );
        self.isreloading = 1;
        self.lastreloadstarttime = gettime();
        addbattlechatternotify( self, undefined, "reload" );
        waittillreloadfinished();
        self.isreloading = 0;
    }
}

// Namespace combat_utility / scripts\anim\combat_utility
// Params 0
// Checksum 0x0, Offset: 0x4de
// Size: 0x68
function waittillreloadfinished()
{
    thread timednotify( 4, "reloadtimeout" );
    self endon( "reloadtimeout" );
    self endon( "weapon_taken" );
    
    while ( true )
    {
        self waittill( "reload" );
        weap = self getcurrentweapon();
        
        if ( isnullweapon( weap ) )
        {
            break;
        }
        
        if ( self getcurrentweaponclipammo() >= weaponclipsize( weap ) )
        {
            break;
        }
    }
    
    self notify( "reloadtimeout" );
}

// Namespace combat_utility / scripts\anim\combat_utility
// Params 2
// Checksum 0x0, Offset: 0x54e
// Size: 0x1c
function timednotify( time, msg )
{
    self endon( msg );
    wait time;
    self notify( msg );
}

// Namespace combat_utility / scripts\anim\combat_utility
// Params 0
// Checksum 0x0, Offset: 0x572
// Size: 0x178
function monitorflash()
{
    self endon( "death" );
    
    if ( !isdefined( level.neverstopmonitoringflash ) )
    {
        self endon( "stop_monitoring_flash" );
    }
    
    while ( true )
    {
        amount_distance = undefined;
        origin = undefined;
        amount_angle = undefined;
        attacker = undefined;
        attackerteam = undefined;
        self waittill( "flashbang", origin, amount_distance, amount_angle, attacker, attackerteam, duration );
        
        if ( isdefined( self.flashbangimmunity ) && self.flashbangimmunity )
        {
            continue;
        }
        
        if ( isdefined( self.script_immunetoflash ) && self.script_immunetoflash != 0 )
        {
            continue;
        }
        
        if ( isdefined( self.team ) && isdefined( attackerteam ) && self.team == attackerteam )
        {
            amount_distance = 3 * ( amount_distance - 0.75 );
            
            if ( amount_distance < 0 )
            {
                continue;
            }
            
            if ( isdefined( self.teamflashbangimmunity ) )
            {
                continue;
            }
        }
        
        if ( scripts\common\utility::function_ec40425fb125f6cf( "flashbang", attackerteam ) )
        {
            continue;
        }
        
        var_fbc487faa5bf1ff = 0.2;
        
        if ( amount_distance > 1 - var_fbc487faa5bf1ff )
        {
            amount_distance = 1;
        }
        else
        {
            amount_distance /= 1 - var_fbc487faa5bf1ff;
        }
        
        if ( !isdefined( duration ) )
        {
            duration = 4.5;
        }
        
        duration *= amount_distance;
        
        if ( duration < 0.25 )
        {
            continue;
        }
        
        self.flashingteam = attackerteam;
        flashbangstart( duration );
        self notify( "doFlashBanged", origin, attacker );
    }
}

// Namespace combat_utility / scripts\anim\combat_utility
// Params 1
// Checksum 0x0, Offset: 0x6f2
// Size: 0xed
function flashbangstart( duration )
{
    assert( isdefined( self ) );
    assert( isdefined( duration ) );
    
    if ( isdefined( self.flashbangimmunity ) && self.flashbangimmunity )
    {
        return;
    }
    
    if ( isdefined( self.syncedmeleetarget ) )
    {
        return;
    }
    
    if ( self isinscriptedstate() || scripts\asm\asm_bb::bb_isanimscripted() )
    {
        return;
    }
    
    if ( !self.allowpain || !self.allowpain_internal )
    {
        return;
    }
    
    newflashendtime = gettime() + int( duration * 1000 );
    
    if ( isdefined( self.flashendtime ) )
    {
        self.flashendtime = int( max( self.flashendtime, newflashendtime ) );
    }
    else
    {
        self.flashendtime = newflashendtime;
        
        if ( isdefined( self.asm ) )
        {
            scripts\asm\asm::asm_setstate( "pain_flashed_transition" );
        }
    }
    
    self notify( "flashed" );
}

// Namespace combat_utility / scripts\anim\combat_utility
// Params 0
// Checksum 0x0, Offset: 0x7e7
// Size: 0x7
function fasteranimspeed()
{
    return 1.5;
}

/#

    // Namespace combat_utility / scripts\anim\combat_utility
    // Params 0
    // Checksum 0x0, Offset: 0x7f7
    // Size: 0x18d, Type: dev
    function showgrenadetimers()
    {
        setdvarifuninitialized( @"hash_b4fd9ea4f6486d24", "<dev string:x93>" );
        huds = undefined;
        playerhuds = undefined;
        
        while ( true )
        {
            if ( getdvarint( @"hash_b4fd9ea4f6486d24" ) == 0 )
            {
                function_c0d677eae75ed3ea( huds );
                function_c0d677eae75ed3ea( playerhuds );
                huds = undefined;
                playerhuds = undefined;
                wait 0.2;
                continue;
            }
            
            if ( !isdefined( huds ) )
            {
                [ huds, playerhuds ] = function_96de23075e92ba2();
            }
            
            foreach ( key, hud in huds )
            {
                hud.value = anim.meleechargetimers[ key ] - gettime();
                
                if ( hud.value < 0 )
                {
                    continue;
                }
                
                hud setvalue( hud.value );
            }
            
            foreach ( key, hud in playerhuds )
            {
                hud.value = anim.meleechargeplayertimers[ key ] - gettime();
                
                if ( hud.value < 0 )
                {
                    continue;
                }
                
                hud setvalue( hud.value );
            }
            
            wait 0.05;
        }
    }

    // Namespace combat_utility / scripts\anim\combat_utility
    // Params 0
    // Checksum 0x0, Offset: 0x98c
    // Size: 0x182, Type: dev
    function function_96de23075e92ba2()
    {
        huds = [];
        count = 0;
        
        foreach ( key, item in anim.meleechargetimers )
        {
            hud = newhudelem();
            hud.x = 80;
            hud.y = 20 + count * 15;
            hud.label = "<dev string:x98>" + key + "<dev string:xa7>";
            hud setvalue( 0 );
            hud.value = 0;
            huds[ key ] = hud;
            count++;
        }
        
        count++;
        playerhuds = [];
        
        foreach ( key, item in anim.meleechargeplayertimers )
        {
            hud = newhudelem();
            hud.x = 80;
            hud.y = 20 + count * 15;
            hud.label = "<dev string:xad>" + key + "<dev string:xa7>";
            hud setvalue( 0 );
            hud.value = 0;
            playerhuds[ key ] = hud;
            count++;
        }
        
        return [ huds, playerhuds ];
    }

    // Namespace combat_utility / scripts\anim\combat_utility
    // Params 1
    // Checksum 0x0, Offset: 0xb16
    // Size: 0x5f, Type: dev
    function function_c0d677eae75ed3ea( huds )
    {
        if ( !isdefined( huds ) )
        {
            return;
        }
        
        foreach ( hud in huds )
        {
            hud destroy();
        }
    }

#/
