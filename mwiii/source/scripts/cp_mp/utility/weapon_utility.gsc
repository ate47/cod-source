#using scripts\common\utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace weapon_utility;

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 5
// Checksum 0x0, Offset: 0x54e
// Size: 0x6a
function _magicbullet( objweapon, start, end, owner, event_ent )
{
    assertex( !isstring( objweapon ), "<dev string:x1c>" );
    missile = magicbullet( objweapon, start, end, owner, event_ent );
    
    if ( isdefined( missile ) && isdefined( owner ) )
    {
        missile setotherent( owner );
    }
    
    return missile;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x5c1
// Size: 0xa7
function islockonlauncher( objweapon )
{
    islockon = undefined;
    basename = undefined;
    
    if ( isstring( objweapon ) )
    {
        basename = objweapon;
    }
    else
    {
        basename = objweapon.basename;
    }
    
    switch ( basename )
    {
        case #"hash_13a265ac820ea0df":
        case #"hash_3e782fd775b72022":
        case #"hash_5c272c0617caebf0":
        case #"hash_5cbb3a1a84d47f1d":
        case #"hash_6b9700922cc910a9":
        case #"hash_a9e31b8ffd42a67b":
            islockon = 1;
            break;
        default:
            islockon = 0;
            break;
    }
    
    return islockon;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 2
// Checksum 0x0, Offset: 0x671
// Size: 0xf5
function addlockedon( entity, attacker )
{
    if ( !isdefined( entity.islockedon ) )
    {
        entity.islockedon = 0;
        entity.attackerslockedon = [];
    }
    
    if ( entity.islockedon == 0 )
    {
        if ( isdefined( entity.lockedoncallback ) )
        {
            entity thread [[ entity.lockedoncallback ]]();
        }
    }
    
    if ( isdefined( attacker ) )
    {
        assertex( !isdefined( attacker.entlockedonto ), "<dev string:x5f>" );
        attacker.entlockedonto = entity;
        assertex( !isdefined( entity.attackerslockedon[ attacker getentitynumber() ] ), "<dev string:xb1>" );
        entity.attackerslockedon[ attacker getentitynumber() ] = attacker;
        
        if ( isplayer( attacker ) )
        {
            attacker callsharedfunc( "game", "clearSpawnProtection" );
        }
    }
    
    entity.islockedon++;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 2
// Checksum 0x0, Offset: 0x76e
// Size: 0xb6
function removelockedon( entity, attacker )
{
    if ( !isdefined( entity.islockedon ) )
    {
        return;
    }
    
    assert( islockedonto( entity ), "<dev string:x100>" );
    
    if ( entity.islockedon == 1 )
    {
        if ( isdefined( entity.lockedonremovedcallback ) )
        {
            entity thread [[ entity.lockedonremovedcallback ]]();
        }
    }
    
    if ( isdefined( attacker ) )
    {
        if ( isdefined( attacker.entlockedonto ) && attacker.entlockedonto == entity )
        {
            attacker.entlockedonto = undefined;
        }
        
        entity.attackerslockedon[ attacker getentitynumber() ] = undefined;
    }
    
    entity.islockedon--;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 2
// Checksum 0x0, Offset: 0x82c
// Size: 0x20
function setlockedoncallback( entity, lockedoncallback )
{
    entity.lockedoncallback = lockedoncallback;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 2
// Checksum 0x0, Offset: 0x854
// Size: 0x20
function setlockedonremovedcallback( entity, lockedonremovedcallback )
{
    entity.lockedonremovedcallback = lockedonremovedcallback;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x87c
// Size: 0x130
function clearlockedon( entity )
{
    entity notify( "clearLockedOn" );
    
    if ( islockedonto( entity ) )
    {
        if ( isdefined( entity.lockedonremovedcallback ) )
        {
            entity thread [[ entity.lockedonremovedcallback ]]();
        }
        
        foreach ( attacker in entity.attackerslockedon )
        {
            if ( isdefined( attacker ) )
            {
                if ( isdefined( attacker.entlockedonto ) && attacker.entlockedonto == entity )
                {
                    attacker.entlockedonto = undefined;
                }
            }
        }
    }
    
    entity.islockedon = undefined;
    entity.attackerslockedon = undefined;
    entity.lockedoncallback = undefined;
    entity.lockedonremovedcallback = undefined;
    
    if ( hasincoming( entity ) )
    {
        if ( isdefined( entity.incomingremovedcallback ) )
        {
            entity thread [[ entity.incomingremovedcallback ]]();
        }
    }
    
    entity.hasincoming = undefined;
    entity.incomingcallback = undefined;
    entity.incomingremovedcallback = undefined;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x9b4
// Size: 0x33
function clearlockedonondisconnect( player )
{
    if ( isdefined( self.entlockedonto ) )
    {
        removelockedon( self.entlockedonto, self );
    }
    
    self.entlockedonto = undefined;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x9ef
// Size: 0x28, Type: bool
function islockedonto( entity )
{
    return isdefined( entity.islockedon ) && entity.islockedon > 0;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 3
// Checksum 0x0, Offset: 0xa20
// Size: 0x6c, Type: bool
function isinflictorstucktoplayer( inflictor, victim, equipref )
{
    if ( isdefined( inflictor ) )
    {
        if ( isdefined( inflictor.equipmentref ) && isdefined( equipref ) && inflictor.equipmentref != equipref )
        {
            return false;
        }
        
        if ( isdefined( inflictor.stuckto ) && inflictor.stuckto == victim )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0xa95
// Size: 0x15
function function_605b121f1fadd46c( allowed )
{
    self.var_605b121f1fadd46c = allowed;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 0
// Checksum 0x0, Offset: 0xab2
// Size: 0x1b
function ismissilelauncherlockonallowed()
{
    if ( isdefined( self.var_605b121f1fadd46c ) )
    {
        return self.var_605b121f1fadd46c;
    }
    
    return 1;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0xad6
// Size: 0x29, Type: bool
function hasBunkerBustersAttached( entity )
{
    return isdefined( entity.bunkerbustersattached ) && entity.bunkerbustersattached.size > 0;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 2
// Checksum 0x0, Offset: 0xb08
// Size: 0x20
function function_53fd22613ea65204( entity, var_5ec2da3d1d27e716 )
{
    entity.var_5ec2da3d1d27e716 = var_5ec2da3d1d27e716;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 2
// Checksum 0x0, Offset: 0xb30
// Size: 0x20
function function_b55a664e824540d2( entity, var_218d5fb97d94f2c )
{
    entity.var_218d5fb97d94f2c = var_218d5fb97d94f2c;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 2
// Checksum 0x0, Offset: 0xb58
// Size: 0x68
function function_69d45a21a6d4e9f8( entity, ownerteam )
{
    if ( !isdefined( entity.bunkerbustersattached ) )
    {
        entity.bunkerbustersattached = [];
    }
    
    entity.bunkerbustersattached[ entity.bunkerbustersattached.size ] = ownerteam;
    
    if ( isdefined( entity.var_5ec2da3d1d27e716 ) )
    {
        entity thread [[ entity.var_5ec2da3d1d27e716 ]]();
    }
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 2
// Checksum 0x0, Offset: 0xbc8
// Size: 0x113
function function_28e583bfecc38a25( entity, ownerteam )
{
    if ( !isdefined( entity.bunkerbustersattached ) )
    {
        return;
    }
    
    assert( hasBunkerBustersAttached( entity ), "<dev string:x13f>" );
    teams = entity.bunkerbustersattached;
    entity.bunkerbustersattached = [];
    removed = 0;
    
    foreach ( team in teams )
    {
        if ( !removed && team == ownerteam )
        {
            removed = 1;
            continue;
        }
        
        entity.bunkerbustersattached[ entity.bunkerbustersattached.size ] = team;
    }
    
    if ( entity.bunkerbustersattached.size == 0 )
    {
        entity.bunkerbustersattached = undefined;
    }
    
    if ( isdefined( entity.var_218d5fb97d94f2c ) )
    {
        entity thread [[ entity.var_218d5fb97d94f2c ]]();
    }
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0xce3
// Size: 0x62
function addincoming( entity )
{
    if ( !isdefined( entity.hasincoming ) )
    {
        entity.hasincoming = 0;
    }
    
    if ( entity.hasincoming == 0 )
    {
        if ( isdefined( entity.incomingcallback ) )
        {
            entity thread [[ entity.incomingcallback ]]();
        }
    }
    
    entity.hasincoming++;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0xd4d
// Size: 0x6c
function removeincoming( entity )
{
    if ( !isdefined( entity.hasincoming ) )
    {
        return;
    }
    
    assert( hasincoming( entity ), "<dev string:x19c>" );
    
    if ( entity.hasincoming == 1 )
    {
        if ( isdefined( entity.incomingremovedcallback ) )
        {
            entity thread [[ entity.incomingremovedcallback ]]();
        }
    }
    
    entity.hasincoming--;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0xdc1
// Size: 0x109
function giveandfireoffhandreliable( objweapon )
{
    self endon( "death" );
    self endon( "disconnect" );
    heldoffhand = scripts\cp_mp\weapon::getgrenadeinpullback();
    
    if ( isdefined( heldoffhand ) && !isnullweapon( heldoffhand ) )
    {
        return 0;
    }
    
    assert( isweapon( objweapon ), "<dev string:x1df>" );
    
    if ( !isweapon( objweapon ) )
    {
        if ( isstring( objweapon ) )
        {
            objweapon = makeweapon( objweapon );
        }
    }
    
    if ( !isweapon( objweapon ) )
    {
        self notify( "giveAndFireOffhandReliableFailed", objweapon );
        return 0;
    }
    
    self giveandfireoffhand( objweapon );
    
    if ( !self hasweapon( objweapon ) )
    {
        self notify( "giveAndFireOffhandReliableFailed", objweapon );
        return 0;
    }
    
    result = spawnstruct();
    result childthread function_8ea8b6459d144947( self, objweapon );
    result childthread function_158897145d2efb26( self, objweapon );
    result waittill( "race_start" );
    waittillframeend();
    result notify( "race_end" );
    
    if ( istrue( result.success ) )
    {
        self notify( "giveAndFireOffhandReliableSucceeded", objweapon );
        return 1;
    }
    
    if ( istrue( result.failure ) )
    {
        self notify( "giveAndFireOffhandReliableFailed", objweapon );
        return 0;
    }
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 2
// Checksum 0x0, Offset: 0xed2
// Size: 0x38
function function_8ea8b6459d144947( player, objweapon )
{
    self endon( "race_end" );
    player waittillmatch( "offhand_fired", objweapon );
    self.success = 1;
    self notify( "race_start" );
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 2
// Checksum 0x0, Offset: 0xf12
// Size: 0x72
function function_158897145d2efb26( player, objweapon )
{
    self endon( "race_end" );
    timeelapsed = 0;
    
    while ( player hasweapon( objweapon ) && timeelapsed < 5 )
    {
        waitframe();
        timeelapsed += level.framedurationseconds;
    }
    
    if ( player hasweapon( objweapon ) )
    {
        player takeweapon( objweapon );
    }
    
    self.failure = 1;
    self notify( "race_start" );
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 2
// Checksum 0x0, Offset: 0xf8c
// Size: 0x20
function setincomingcallback( entity, incomingcallback )
{
    entity.incomingcallback = incomingcallback;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 2
// Checksum 0x0, Offset: 0xfb4
// Size: 0x20
function setincomingremovedcallback( entity, incomingremovedcallback )
{
    entity.incomingremovedcallback = incomingremovedcallback;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0xfdc
// Size: 0x28, Type: bool
function hasincoming( entity )
{
    return isdefined( entity.hasincoming ) && entity.hasincoming > 0;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 2
// Checksum 0x0, Offset: 0x100d
// Size: 0x51
function watchtargetlockedontobyprojectile( target, projectile )
{
    target endon( "clearLockedOn" );
    addlockedon( target );
    addincoming( target );
    projectile waittill_any_2( "death", "clearTargetLockedOntoByProjectile" );
    
    if ( isdefined( target ) )
    {
        removelockedon( target );
        removeincoming( target );
    }
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x1066
// Size: 0x13
function clearprojectilelockedon( projectile )
{
    projectile notify( "clearTargetLockedOntoByProjectile" );
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 4
// Checksum 0x0, Offset: 0x1081
// Size: 0x2e1
function dropweaponfordeathlaunch( item, weapongroup, damage, angles )
{
    if ( item physics_getnumbodies() == 0 )
    {
        return;
    }
    
    if ( !isdefined( angles ) )
    {
        angles = self.angles;
    }
    
    if ( !isdefined( damage ) )
    {
        damage = 0;
    }
    
    normalizeddamage = math::normalize_value( 0, 200, damage );
    
    if ( isdefined( weapongroup ) && weapongroup == "weapon_melee2" )
    {
        var_4148f5f633bfcf19 = randomfloatrange( 25, 100 );
        var_5de19bfa9bb86f0c = randomfloatrange( 75, 175 );
        var_b8a13f3af0cbe01b = math::factor_value( 450, 800, normalizeddamage );
        var_eac2b0512d0b1c55 = math::factor_value( -7 / 6, -5 / 6, normalizeddamage );
        var_8282854ec42283a2 = math::factor_value( 0.125, 0.183333, normalizeddamage );
    }
    else if ( isdefined( weapongroup ) && weapongroup == "weapon_pistol" )
    {
        var_4148f5f633bfcf19 = randomfloatrange( 100, 200 );
        var_5de19bfa9bb86f0c = randomfloatrange( 150, 250 );
        var_b8a13f3af0cbe01b = math::factor_value( 950, 1300, normalizeddamage );
        var_eac2b0512d0b1c55 = math::factor_value( -7 / 4, -5 / 4, normalizeddamage );
        var_8282854ec42283a2 = math::factor_value( 0.5625, 0.825, normalizeddamage );
    }
    else
    {
        var_4148f5f633bfcf19 = randomfloatrange( 150, 350 );
        var_5de19bfa9bb86f0c = randomfloatrange( 150, 250 );
        var_b8a13f3af0cbe01b = math::factor_value( 950, 1300, normalizeddamage );
        var_eac2b0512d0b1c55 = math::factor_value( -7, -5, normalizeddamage );
        var_8282854ec42283a2 = math::factor_value( 0.75, 1.1, normalizeddamage );
    }
    
    if ( cointoss() )
    {
        var_5de19bfa9bb86f0c *= -1;
    }
    
    if ( !isdefined( item ) )
    {
        println( "<dev string:x218>" );
        return;
    }
    
    itemcenterofmass = item physics_getentitycenterofmass();
    
    if ( isdefined( itemcenterofmass ) )
    {
        itemcenterofmass = itemcenterofmass[ "unscaled" ];
    }
    else
    {
        itemcenterofmass = item.origin;
    }
    
    launchvelocity = ( 0, 0, 0 );
    launchvelocity += anglestoforward( angles ) * var_4148f5f633bfcf19;
    launchvelocity += anglestoright( angles ) * var_5de19bfa9bb86f0c;
    launchvelocity += anglestoup( angles ) * var_b8a13f3af0cbe01b;
    weaponangles = item gettagangles( "tag_flash", 1 );
    
    if ( !isdefined( weaponangles ) )
    {
        weaponangles = item.angles;
    }
    
    if ( cointoss() )
    {
        var_8282854ec42283a2 *= -1;
    }
    
    launchorigin = itemcenterofmass;
    launchorigin += anglestoforward( weaponangles ) * var_eac2b0512d0b1c55;
    launchorigin += anglestoright( weaponangles ) * var_8282854ec42283a2;
    logprint( "PhysicsLaunchServerItem" );
    logprint( "item.classname = " + item.classname );
    logprint( "launchOrigin   = " + launchorigin );
    logprint( "launchVelocity = " + launchvelocity );
    item physicslaunchserveritem( launchorigin, launchvelocity );
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x136a
// Size: 0xf2
function isbulletweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x251>" );
        return 0;
    }
    
    if ( isweapon( weapon ) && isnullweapon( weapon ) )
    {
        return 0;
    }
    
    if ( isstring( weapon ) && weapon == "none" )
    {
        return 0;
    }
    
    if ( isriotshield( weapon ) || isknifeonly( weapon ) )
    {
        return 0;
    }
    
    if ( isdefined( weapon.inventorytype ) && weapon.inventorytype == "model_only" )
    {
        return 0;
    }
    
    switch ( weaponclass( weapon ) )
    {
        case #"hash_690c0d6a821b42e":
        case #"hash_6191aaef9f922f96":
        case #"hash_719417cb1de832b6":
        case #"hash_8cdaf2e4ecfe5b51":
        case #"hash_900cb96c552c5e8e":
        case #"hash_fa24dff6bd60a12d":
            return 1;
        default:
            return 0;
    }
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x1464
// Size: 0xd6, Type: bool
function islauncherweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x293>" );
        return false;
    }
    
    if ( isweapon( weapon ) && isnullweapon( weapon ) )
    {
        return false;
    }
    
    if ( isstring( weapon ) && weapon == "none" )
    {
        return false;
    }
    
    if ( isriotshield( weapon ) || isknifeonly( weapon ) )
    {
        return false;
    }
    
    if ( isdefined( weapon.inventorytype ) && weapon.inventorytype == "model_only" )
    {
        return false;
    }
    
    if ( !isdefined( weapon.basename ) )
    {
        return false;
    }
    
    weaponstrtok = strtok( weapon.basename, "_" );
    
    if ( isdefined( weaponstrtok ) && array_contains( weaponstrtok, "la" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x1543
// Size: 0xe3, Type: bool
function function_38642db3c423bcdc( weapon )
{
    if ( getdvarint( @"hash_86c5f9dae77ee49e", 1 ) == 0 )
    {
        return false;
    }
    
    var_1bae199ae2509f57 = [ "riotshield", "iw9_me_riotshield_mp", "iw9_la_juliet_mp", "iw9_la_gromeo_mp", "iw9_me_sword01_mp", "iw9_me_kamas_mp" ];
    
    if ( isweapon( weapon ) && isnullweapon( weapon ) )
    {
        return false;
    }
    
    if ( isstring( weapon ) && weapon == "none" )
    {
        return false;
    }
    
    theweapontype = weapon.basename;
    
    if ( scripts\cp_mp\weapon::isakimbo( weapon ) )
    {
        return true;
    }
    
    theweapontype = weapon.basename;
    
    for ( i = 0; i < var_1bae199ae2509f57.size ; i++ )
    {
        if ( var_1bae199ae2509f57[ i ] == theweapontype )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x162f
// Size: 0x42, Type: bool
function isriotshield( weapon )
{
    if ( isweapon( weapon ) && isnullweapon( weapon ) )
    {
        return false;
    }
    
    if ( isstring( weapon ) && weapon == "none" )
    {
        return false;
    }
    
    return weapontype( weapon ) == "riotshield";
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x167a
// Size: 0x94, Type: bool
function isknifeonly( weapon )
{
    rootname = scripts\cp_mp\weapon::getweaponrootname( weapon );
    isknife = scripts\cp_mp\weapon::function_b8811a0fc04e4b9d( rootname, #"isknife", 0 );
    var_5e65eddfd622acca = isdefined( weapon ) && isweapon( weapon ) ? weapon.basename : undefined;
    return isknife || rootname == "iw9_me_knife" || rootname == "jup_jp23_me_knife" || rootname == "iw9_knifestab" || isdefined( var_5e65eddfd622acca ) && var_5e65eddfd622acca == "jup_amp_knifestab_mp";
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x1717
// Size: 0x88, Type: bool
function isSharpMeleeWeapon( weapon )
{
    if ( !isdefined( weapon ) || !isdefined( weapon.basename ) )
    {
        return false;
    }
    
    basename = weapon.basename;
    rootname = scripts\cp_mp\weapon::getweaponrootname( weapon );
    var_727d88e47223b87d = scripts\cp_mp\weapon::function_b8811a0fc04e4b9d( rootname, #"issharpmelee", 0 );
    return var_727d88e47223b87d || basename == "iw9_me_knife_mp" || basename == "iw9_knifestab_mp" || basename == "iw9_me_sword01_mp";
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x17a8
// Size: 0x6b
function ischainsword( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x2d7>" );
        return 0;
    }
    
    weapname = undefined;
    
    if ( isweapon( weapon ) )
    {
        if ( isnullweapon( weapon ) )
        {
            return 0;
        }
        
        weapname = weapon.basename;
    }
    else
    {
        if ( weapon == "none" )
        {
            return 0;
        }
        
        weapname = weapon;
    }
    
    return issubstr( weapname, "me_swhiskey" );
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 0
// Checksum 0x0, Offset: 0x181c
// Size: 0x50
function saveweaponstates()
{
    if ( scripts\engine\utility::issharedfuncdefined( "weapons", "saveToggleScopeStates" ) )
    {
        self [[ scripts\engine\utility::getsharedfunc( "weapons", "saveToggleScopeStates" ) ]]();
    }
    
    if ( scripts\engine\utility::issharedfuncdefined( "weapons", "saveAltStates" ) )
    {
        self [[ scripts\engine\utility::getsharedfunc( "weapons", "saveAltStates" ) ]]();
    }
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 2
// Checksum 0x0, Offset: 0x1874
// Size: 0x74
function restoreweaponstates( lastweaponobj, updatetogglescopestate )
{
    if ( self isalternatemode( lastweaponobj ) )
    {
        if ( scripts\engine\utility::issharedfuncdefined( "weapons", "updateSavedAltState" ) )
        {
            lastweaponobj = self [[ scripts\engine\utility::getsharedfunc( "weapons", "updateSavedAltState" ) ]]( lastweaponobj );
        }
    }
    
    if ( updatetogglescopestate && scripts\engine\utility::issharedfuncdefined( "weapons", "updateToggleScopeState" ) )
    {
        self [[ scripts\engine\utility::getsharedfunc( "weapons", "updateToggleScopeState" ) ]]( lastweaponobj );
    }
    
    return lastweaponobj;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 10
// Checksum 0x0, Offset: 0x18f1
// Size: 0x1ca
function function_c9e5c511b923a42f( idamage, attacker, victim, smeansofdeath, shitloc, inflictor, vpoint, lightarmordamage, heavyarmordamage, helmetdamage )
{
    if ( isdefined( level.var_b39eda08d7912835 ) )
    {
        distmsg = "";
        
        if ( isexplosivedamagemod( smeansofdeath ) && isdefined( victim.origin ) )
        {
            dmgorigin = vpoint;
            
            if ( isdefined( inflictor ) && isdefined( inflictor.origin ) )
            {
                dmgorigin = inflictor.origin;
            }
            
            distmsg = " EXPL_DIST: " + int( distance( dmgorigin, victim.origin ) );
        }
        else if ( isdefined( vpoint ) )
        {
            distmsg = " DIST:" + int( distance( attacker.origin, vpoint ) );
        }
        
        armormsg = "";
        
        if ( isdefined( lightarmordamage ) && lightarmordamage > 0 )
        {
            armormsg = " ArmorDmg: " + lightarmordamage;
        }
        else if ( isdefined( heavyarmordamage ) && heavyarmordamage > 0 )
        {
            armormsg = " ArmorDmg: " + heavyarmordamage;
        }
        
        helmetmsg = "";
        
        if ( isdefined( helmetdamage ) && helmetdamage > 0 )
        {
            helmetmsg = " HelmetDmg: " + helmetdamage;
        }
        
        victimtext = ter_op( isai( victim ), "AI-", "Plyr-" );
        iprintln( victimtext + "DMG:" + idamage + " LOC:" + shitloc + " HEALTH: " + victim.health + "/" + victim.maxhealth + distmsg + armormsg + helmetmsg );
    }
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x1ac3
// Size: 0x2f
function function_eeaa22f0cd1ff845( weaponstring )
{
    attachments = getweapondefaultattachments( weaponstring );
    weaponobj = makeweapon( weaponstring, attachments );
    return weaponobj;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 0
// Checksum 0x0, Offset: 0x1afb
// Size: 0x32
function function_8cda2444c7d142df()
{
    if ( isagent( self ) )
    {
        cachevalue = "ai_" + self getentitynumber();
    }
    else
    {
        cachevalue = self.guid;
    }
    
    return cachevalue;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 2
// Checksum 0x0, Offset: 0x1b36
// Size: 0x95
function function_49967318fbd12317( objweapon, var_76b470a332915556 )
{
    if ( !isdefined( level.var_b5224f533f8fffb0 ) )
    {
        level.var_b5224f533f8fffb0 = [];
    }
    
    if ( !array_contains_key( level.var_b5224f533f8fffb0, objweapon.basename ) )
    {
        weaponowners = [];
        level.var_b5224f533f8fffb0[ objweapon.basename ] = weaponowners;
    }
    
    level.var_b5224f533f8fffb0[ objweapon.basename ][ self.guid ] = var_76b470a332915556;
    thread function_820fe7d9e7ec7c65( objweapon );
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x1bd3
// Size: 0x7a
function function_820fe7d9e7ec7c65( objweapon )
{
    note = "removeWeaponParent_" + objweapon.basename;
    self notify( note );
    self endon( note );
    uniqueid = self.guid;
    wait 12;
    level.var_b5224f533f8fffb0[ objweapon.basename ] = array_remove_key( level.var_b5224f533f8fffb0[ objweapon.basename ], uniqueid );
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x1c55
// Size: 0xb4
function function_1e3102980c3a4cc1( objweapon )
{
    weaponname = undefined;
    
    if ( isweapon( objweapon ) )
    {
        weaponname = objweapon.basename;
    }
    else
    {
        assert( isstring( objweapon ) );
        weaponname = objweapon;
    }
    
    if ( !isdefined( weaponname ) )
    {
        return objweapon;
    }
    
    if ( isdefined( level.var_b5224f533f8fffb0 ) && array_contains_key( level.var_b5224f533f8fffb0, weaponname ) )
    {
        /#
            if ( !isdefined( level.var_b5224f533f8fffb0[ weaponname ][ self.guid ] ) )
            {
                assertmsg( "<dev string:x318>" + weaponname + "<dev string:x353>" );
            }
        #/
        
        return level.var_b5224f533f8fffb0[ weaponname ][ self.guid ];
    }
    
    return objweapon;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x1d12
// Size: 0x87, Type: bool
function function_c14e8044664565ad( objweapon )
{
    weaponname = undefined;
    
    if ( isweapon( objweapon ) )
    {
        weaponname = objweapon.basename;
    }
    else if ( isstring( objweapon ) )
    {
        weaponname = objweapon;
    }
    
    if ( !isdefined( weaponname ) )
    {
        return false;
    }
    
    if ( isdefined( level.var_b5224f533f8fffb0 ) && array_contains_key( level.var_b5224f533f8fffb0, weaponname ) )
    {
        if ( !isdefined( level.var_b5224f533f8fffb0[ weaponname ][ self.guid ] ) )
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    
    return false;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x1da2
// Size: 0x51
function function_f0cf737b5d0ccda5( weapon )
{
    weapname = getweaponbasename( weapon );
    result = issubstr( weapname, "sword01" ) || issubstr( weapname, "kamas" ) || issubstr( weapname, "pickaxe" );
    return result;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 3
// Checksum 0x0, Offset: 0x1dfc
// Size: 0x8f
function function_a3fc7ebc9fc3e9a3( eattacker, victim, idflags )
{
    hand = function_88e9e2299bd29fd1( idflags );
    victimentnum = function_d77e6b2580f74622( victim );
    
    if ( isdefined( eattacker.pelletweaponvictimids ) && isdefined( eattacker.pelletweaponvictimids[ hand ] ) && isdefined( eattacker.pelletweaponvictimids[ hand ][ victimentnum ] ) )
    {
        return eattacker.pelletweaponvictimids[ hand ][ victimentnum ].var_7981f7d372990a2b;
    }
    
    return 0;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x1e94
// Size: 0x22
function function_88e9e2299bd29fd1( idflags )
{
    if ( idflags & 2048 )
    {
        return "lHandWeap";
    }
    
    return "rHandWeap";
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x1ebe
// Size: 0x17
function function_d77e6b2580f74622( victim )
{
    return "" + victim getentitynumber();
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 4
// Checksum 0x0, Offset: 0x1ede
// Size: 0x12c
function function_1113fc99a0327d7d( eattacker, victim, idflags, idamage )
{
    hand = function_88e9e2299bd29fd1( idflags );
    victimentnum = function_d77e6b2580f74622( victim );
    
    if ( !isdefined( eattacker.pelletweaponvictimids ) || !isdefined( eattacker.pelletweaponvictimids[ hand ] ) || !isdefined( eattacker.pelletweaponvictimids[ hand ][ victimentnum ] ) )
    {
        return idamage;
    }
    
    var_52f16f4c9cdbf165 = eattacker.pelletweaponvictimids[ hand ][ victimentnum ].var_52f16f4c9cdbf165;
    var_9bb59738d095536e = eattacker.pelletweaponvictimids[ hand ][ victimentnum ].var_9bb59738d095536e;
    
    if ( var_9bb59738d095536e < var_52f16f4c9cdbf165 )
    {
        idamage = clamp( idamage, 0, var_52f16f4c9cdbf165 - eattacker.pelletweaponvictimids[ hand ][ victimentnum ].var_9bb59738d095536e );
        eattacker.pelletweaponvictimids[ hand ][ victimentnum ].var_9bb59738d095536e += idamage;
        return idamage;
    }
    
    return 0;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 4
// Checksum 0x0, Offset: 0x2012
// Size: 0x9b
function function_ad15087050f05b04( eattacker, victim, idflags, idamage )
{
    hand = function_88e9e2299bd29fd1( idflags );
    victimentnum = function_d77e6b2580f74622( victim );
    
    if ( !isdefined( eattacker.pelletweaponvictimids ) || !isdefined( eattacker.pelletweaponvictimids[ hand ] ) || !isdefined( eattacker.pelletweaponvictimids[ hand ][ victimentnum ] ) )
    {
        return;
    }
    
    eattacker.pelletweaponvictimids[ hand ][ victimentnum ].pelletdmgpassed[ 0 ] = idamage;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 4
// Checksum 0x0, Offset: 0x20b5
// Size: 0xb4
function function_9665cbeba4d776f7( eattacker, victim, idflags, amount )
{
    hand = function_88e9e2299bd29fd1( idflags );
    victimentnum = function_d77e6b2580f74622( victim );
    
    if ( !isdefined( eattacker.pelletweaponvictimids ) || !isdefined( eattacker.pelletweaponvictimids[ hand ] ) || !isdefined( eattacker.pelletweaponvictimids[ hand ][ victimentnum ] ) )
    {
        return 0;
    }
    
    eattacker.pelletweaponvictimids[ hand ][ victimentnum ].var_9bb59738d095536e += amount;
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x2171
// Size: 0x2a
function cleanupconcussionstun( time )
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    wait time;
    utility::setplayerunstunned();
    self notify( "concussion_unstunned" );
}

// Namespace weapon_utility / scripts\cp_mp\utility\weapon_utility
// Params 1
// Checksum 0x0, Offset: 0x21a3
// Size: 0x45, Type: bool
function isaxeweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x3d8>" );
        return false;
    }
    
    rootname = getweaponrootname( weapon );
    return rootname == "iw7_axe" || rootname == "jup_jp23_me_spear";
}

