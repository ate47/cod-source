#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\perks\perkfunctions;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\equipment;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;

#namespace butterfly_mine;

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x58f
// Size: 0x18
function autoexec main()
{
    registersharedfunc( "equip_butterfly_mine", "init", &function_843dde4bf96b6965 );
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 0
// Checksum 0x0, Offset: 0x5af
// Size: 0x45
function function_843dde4bf96b6965()
{
    minetriggerdata = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine( "equip_butterfly_mine", 1 );
    minetriggerdata.triggercallback = &function_4751713f978b6416;
    level.var_e705f4189f25418d = getdvarint( @"hash_eb66ecc15316468f", 1 );
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 1
// Checksum 0x0, Offset: 0x5fc
// Size: 0x1a9
function function_539f38f444d5b41a( grenade )
{
    grenade setotherent( self );
    grenade setcandamage( 0 );
    grenade hudoutlinedisable();
    grenade setscriptablepartstate( "visibility", "show", 0 );
    grenade.playerhits = [];
    grenade.givenscore = 0;
    ref = scripts\cp_mp\equipment::function_7f245729fcb6414d( grenade.weapon_name );
    grenade.tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo( ref );
    
    if ( !isdefined( grenade.tableinfo.bundle ) )
    {
        assertmsg( "<dev string:x1c>" );
    }
    
    launchangles = self getgunangles();
    launchtimems = gettime();
    launchvelocity = anglestoforward( launchangles ) * 500 + anglestoup( launchangles ) * 0;
    grenade waittill( "missile_stuck", stuckto );
    grenade setscriptablepartstate( "plant", "active", 0 );
    traveltime = ( gettime() - launchtimems ) / 1000;
    impactvelocity = launchvelocity + ( 0, 0, -800 * traveltime );
    onequipmentplanted( grenade, "equip_butterfly_mine", &function_f1ccd9eaaa39e87c );
    wait grenade.tableinfo.bundle.scatterdelay;
    grenade function_a1a46255fbfac86c( grenade, launchangles, impactvelocity );
    grenade setscriptablepartstate( "launch", "land", 0 );
    wait 0.25;
    grenade setscriptablepartstate( "visibility", "hide", 0 );
    grenade hide();
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 3
// Checksum 0x0, Offset: 0x7ad
// Size: 0x5c
function function_a1a46255fbfac86c( grenade, launchangles, impactvelocity )
{
    grenade.ownedmines = [];
    grenade function_33f76685d61ffb0( grenade.tableinfo.bundle.damageweapons, 3, impactvelocity, 45, 120, 35, 360, 0 );
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 8
// Checksum 0x0, Offset: 0x811
// Size: 0x274
function function_33f76685d61ffb0( minename, nummines, impactvelocity, stepstartradius, var_ec8c077b88a3003e, var_450483a591a06439, fandegrees, var_4d1e3f4a23058445 )
{
    impactangles = undefined;
    forward = vectornormalize( impactvelocity );
    up = anglestoup( self.angles );
    impactangles = function_5f9ffc69b9bd0ab3( up, forward );
    
    for ( mineindex = 0; mineindex < nummines ; mineindex++ )
    {
        minenum = "0" + mineindex;
        launchlocation = self gettagorigin( "j_mine_" + minenum, 1 );
        
        if ( !isdefined( launchlocation ) )
        {
            continue;
        }
        
        launchdirection = vectornormalize( launchlocation - self.origin );
        launchdirection = function_70fd9ddef68b9ae3( launchdirection, launchlocation, 10 );
        verticalangle = randomfloatrange( -1, 1 ) * 5 + var_450483a591a06439;
        angledeviation = randomfloatrange( -1, 1 ) * 15;
        var_441fb78a71e1b458 = 360 - verticalangle - angledeviation;
        targetradius = randomfloatrange( stepstartradius, var_ec8c077b88a3003e );
        launchangles = vectortoangles( launchdirection ) + ( var_441fb78a71e1b458, 0, 0 );
        totalvelocity = sqrt( 800 * targetradius / sin( 2 * verticalangle ) );
        var_b571a1c1c33fc4b = vectornormalize( anglestoforward( launchangles ) );
        velocityvec = totalvelocity * var_b571a1c1c33fc4b;
        
        if ( isdefined( self ) && isdefined( self.owner ) )
        {
            scatteredmine = _launchgrenade( minename, launchlocation, velocityvec, self.tableinfo.bundle.scatterlifetime );
            function_6300c632dc21b15a( scatteredmine, self.owner, self );
            self.ownedmines[ mineindex + var_4d1e3f4a23058445 ] = scatteredmine;
            scatteredmine thread function_ffa6fec05cb3637a( self.tableinfo.bundle );
            
            if ( scripts\engine\utility::issharedfuncdefined( "entity", "trackEntityLimit" ) )
            {
                [[ scripts\engine\utility::getsharedfunc( "entity", "trackEntityLimit" ) ]]( scatteredmine, self.owner, "butterfly_mine" );
                scatteredmine thread function_1575acb1c3533196();
                waitframe();
            }
        }
    }
    
    thread function_ebc941d7484bb7a9();
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 0
// Checksum 0x0, Offset: 0xa8d
// Size: 0x4e
function function_ebc941d7484bb7a9()
{
    level endon( "game_ended" );
    self.owner endon( "disconnect" );
    thread delaythread( 1, &scripts\cp_mp\challenges::function_b0f754c8a379154e, "equip_butterfly_mine", self.owner, undefined, function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"use" ) );
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 3
// Checksum 0x0, Offset: 0xae3
// Size: 0x1d4
function function_70fd9ddef68b9ae3( launchdirection, launchlocation, raycastdistance )
{
    var_7c2f0a987752b57e = launchdirection;
    var_9e1171a935066689 = ( launchdirection[ 0 ], launchdirection[ 1 ], 0 );
    var_9f6125e568a9cc37 = self.origin + ( 0, 0, 1 );
    var_65f2273b33f07faa = self.origin + ( 0, 0, 1 ) + var_9e1171a935066689 * raycastdistance;
    var_68e6f05a4ee24dee = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_characterproxy" ] );
    hitents = physics_raycast( var_9f6125e568a9cc37, var_65f2273b33f07faa, var_68e6f05a4ee24dee, undefined, 0, "physicsquery_all" );
    i = 0;
    var_e1c117e37f2a0513 = var_9e1171a935066689;
    var_f7d4e3b374ebbcfc = 0;
    
    while ( hitents.size > 0 && i < 3 )
    {
        var_9f6125e568a9cc37 = self.origin + ( 0, 0, 1 );
        var_65f2273b33f07faa = self.origin + ( 0, 0, 1 ) + var_e1c117e37f2a0513 * raycastdistance;
        var_6221dd5fd704b1dc = physics_raycast( var_9f6125e568a9cc37, var_65f2273b33f07faa, var_68e6f05a4ee24dee, undefined, 0, "physicsquery_all" );
        
        if ( hitents.size > 0 )
        {
            if ( i == 0 )
            {
                var_e1c117e37f2a0513 = ( var_9e1171a935066689[ 0 ] * -1, var_9e1171a935066689[ 1 ] * -1, 0 );
                var_f7d4e3b374ebbcfc = 1;
            }
            else if ( i == 1 )
            {
                var_e1c117e37f2a0513 = ( var_9e1171a935066689[ 0 ], var_9e1171a935066689[ 1 ] * -1, 0 );
                var_f7d4e3b374ebbcfc = 1;
            }
            else if ( i == 2 )
            {
                var_e1c117e37f2a0513 = ( var_9e1171a935066689[ 0 ] * -1, var_9e1171a935066689[ 1 ], 0 );
                var_f7d4e3b374ebbcfc = 1;
            }
        }
        
        i++;
    }
    
    if ( istrue( var_f7d4e3b374ebbcfc ) )
    {
        return ( var_e1c117e37f2a0513 + ( 0, 0, launchdirection[ 2 ] ) );
    }
    
    return var_7c2f0a987752b57e;
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 4
// Checksum 0x0, Offset: 0xcbf
// Size: 0x375
function function_6300c632dc21b15a( butterflymine, owner, sourcegrenade, lifetimeoverride )
{
    butterflymine.owner = owner;
    butterflymine.team = owner.team;
    butterflymine.ownerid = owner getxuid();
    butterflymine.health = 99999;
    butterflymine.maxhealth = self.tableinfo.bundle.scatterhealth;
    butterflymine.lifetime = self.tableinfo.bundle.scatterlifetime;
    butterflymine.explosionradius = self.tableinfo.bundle.scatterexplosionradius;
    butterflymine.mindmg = self.tableinfo.bundle.var_891e3bfe74f59aa0;
    butterflymine.maxdmg = self.tableinfo.bundle.var_edb2fd8da69874f2;
    butterflymine.equipmentref = "equip_butterfly_mine";
    
    if ( isdefined( lifetimeoverride ) )
    {
        butterflymine.lifetime = lifetimeoverride;
    }
    
    if ( isdefined( sourcegrenade ) )
    {
        butterflymine.sourcegrenade = sourcegrenade;
    }
    
    butterflymine enableplayermarks( "equipment" );
    
    if ( level.teambased )
    {
        butterflymine filteroutplayermarks( butterflymine.owner.team );
    }
    else
    {
        butterflymine filteroutplayermarks( butterflymine.owner );
    }
    
    butterflymine.damagetaken = 0;
    butterflymine scripts\cp_mp\ent_manager::registerspawn( 1, &function_435b53c90ec01143 );
    butterflymine.headiconid = butterflymine scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, 2, undefined, undefined, undefined, undefined, 1 );
    butterflymine setentityowner( owner );
    butterflymine setotherent( owner );
    butterflymine setcandamage( 1 );
    butterflymine.deletefunc = &function_435b53c90ec01143;
    entnum = butterflymine getentitynumber();
    level.mines[ entnum ] = butterflymine;
    butterflymine thread scripts\mp\damage::monitordamage( 1, "hitequip", &function_ca00c87cb0a3d308, &function_31cc0ad55f88e7f3 );
    scripts\cp_mp\emp_debuff::add_emp_ent( butterflymine );
    butterflymine scripts\cp_mp\emp_debuff::set_apply_emp_callback( &function_692167ff37e7ef8 );
    
    if ( issharedfuncdefined( "emp", "setEMP_Started_Callback" ) )
    {
        butterflymine [[ getsharedfunc( "emp", "setEMP_Started_Callback" ) ]]( &function_b86eee224cc33fc );
    }
    
    if ( issharedfuncdefined( "emp", "setEMP_Applied_Callback" ) )
    {
        butterflymine [[ getsharedfunc( "emp", "setEMP_Applied_Callback" ) ]]( &function_692167ff37e7ef8 );
    }
    
    if ( issharedfuncdefined( "emp", "setEMP_Cleared_Callback" ) )
    {
        butterflymine [[ getsharedfunc( "emp", "setEMP_Cleared_Callback" ) ]]( &function_d2c4655c7d6a3331 );
    }
    
    butterflymine.dangerzone = scripts\mp\spawnlogic::addspawndangerzone( butterflymine.origin, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 50, butterflymine.owner.team, undefined, butterflymine.owner, 0, butterflymine, 1 );
    butterflymine thread function_b540d1d357522929();
    butterflymine setscriptablepartstate( "visibility", "show", 0 );
    butterflymine scripts\cp_mp\equipment\haywire::function_172d848d58051fdf( &function_f92200134f4ce696 );
    butterflymine scripts\cp_mp\emp_debuff::set_start_emp_callback( &function_b86eee224cc33fc );
    butterflymine scripts\cp_mp\emp_debuff::set_clear_emp_callback( &function_d2c4655c7d6a3331 );
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 1
// Checksum 0x0, Offset: 0x103c
// Size: 0x1f5
function function_ffa6fec05cb3637a( bundle )
{
    self endon( "death" );
    self endon( "explode" );
    level endon( "game_ended" );
    contents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water" ] );
    wait bundle.var_d96b1862158576e0;
    
    while ( true )
    {
        self setscriptablepartstate( "arm", "active", 0 );
        self waittill( "trigger_grenade", entarr );
        assert( isdefined( entarr ) );
        
        foreach ( ent in entarr )
        {
            if ( ent.classname == "script_vehicle" )
            {
                if ( ent scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_isfriendlytomine( self ) )
                {
                    continue;
                }
                
                if ( !scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_shouldvehicletriggermine( ent, self ) )
                {
                    continue;
                }
                
                scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_minetrigger( ent, self );
                break;
            }
            
            if ( isagent( ent ) || isplayer( ent ) )
            {
                if ( isdefined( ent.vehicle ) )
                {
                    continue;
                }
                
                if ( !isreallyalive( ent ) )
                {
                    continue;
                }
                
                forward = anglestoforward( self.angles );
                up = anglestoup( self.angles );
                castorigin = self.origin + up * 35;
                ignorelist = [ self ];
                castresults = physics_raycast( castorigin, ent.origin, contents, ignorelist, 0, "physicsquery_closest", 1 );
                
                if ( isdefined( castresults ) && castresults.size > 0 )
                {
                    continue;
                }
                
                thread function_fb430131c2697d67( ent );
                break;
            }
        }
    }
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 1
// Checksum 0x0, Offset: 0x1239
// Size: 0x275
function function_fb430131c2697d67( attacker )
{
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    thread function_56ae4ffb25eb1168( 5 );
    
    if ( isai( attacker ) )
    {
        if ( isplayer( attacker ) )
        {
            attackerid = attacker getxuid();
        }
        else
        {
            attackerid = attacker.unique_id;
        }
    }
    else if ( attacker.classname == "script_vehicle" )
    {
        attackerid = attacker.vehiclename;
    }
    else
    {
        attackerid = attacker getxuid();
    }
    
    if ( isplayer( attacker ) )
    {
        if ( attacker scripts\mp\utility\perk::_hasperk( "specialty_delaymine" ) )
        {
            self setscriptablepartstate( "trigger", "active", 0 );
        }
    }
    
    explosivetrigger( attacker, 0 );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.sourcegrenade.playerhits[ attackerid ] ) )
    {
        self.sourcegrenade.playerhits[ attackerid ] += 1;
    }
    else
    {
        self.sourcegrenade.playerhits[ attackerid ] = 1;
    }
    
    statestring = "";
    
    switch ( self.sourcegrenade.playerhits[ attackerid ] )
    {
        case 1:
            statestring = "fromPlayer";
            break;
        case 2:
            statestring = "fromPlayerSecond";
            break;
        case 3:
            statestring = "fromPlayerThird";
            break;
    }
    
    if ( game_utility::function_21322da268e71c19() )
    {
        statestring += "_hc";
    }
    
    if ( isplayer( attacker ) )
    {
        self.sourcegrenade.owner updatedamagefeedback( "hitequip" );
    }
    
    self setscriptablepartstate( "arm", "neutral", 0 );
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        self radiusdamage( self.origin, self.explosionradius, self.maxdmg, self.mindmg, self.owner, "MOD_EXPLOSIVE", "butterfly_mine_mp" );
        self setscriptablepartstate( "explode", "fromPlayerBR", 0 );
    }
    else
    {
        self setscriptablepartstate( "explode", statestring, 0 );
    }
    
    scripts\cp_mp\challenges::function_b0f754c8a379154e( "equip_butterfly_mine", self.sourcegrenade.owner, undefined, function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"hit" ) );
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 2
// Checksum 0x0, Offset: 0x14b6
// Size: 0x1d
function function_4751713f978b6416( vehicle, mine )
{
    mine thread function_fb430131c2697d67( vehicle );
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 1
// Checksum 0x0, Offset: 0x14db
// Size: 0x39
function function_435b53c90ec01143( attacker )
{
    thread function_56ae4ffb25eb1168( 5 );
    self setscriptablepartstate( "arm", "neutral", 0 );
    self setscriptablepartstate( "destroy", "active", 0 );
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 0
// Checksum 0x0, Offset: 0x151c
// Size: 0x37
function function_e7e5214ee3b16fb1()
{
    thread function_56ae4ffb25eb1168( 1, 1 );
    
    if ( isdefined( self ) )
    {
        self setscriptablepartstate( "arm", "neutral", 0 );
        self setscriptablepartstate( "visibility", "hide", 0 );
    }
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 2
// Checksum 0x0, Offset: 0x155b
// Size: 0x149
function function_56ae4ffb25eb1168( deletiondelay, var_6c3c372dfdf70054 )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( "death" );
    self setcandamage( 0 );
    
    if ( isdefined( self.headiconid ) )
    {
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon( self.headiconid );
    }
    
    self.headiconid = undefined;
    
    if ( isdefined( var_6c3c372dfdf70054 ) )
    {
        if ( istrue( var_6c3c372dfdf70054 ) )
        {
            self.exploding = 0;
        }
    }
    else
    {
        self.exploding = 1;
    }
    
    if ( isdefined( self.dangerzone ) )
    {
        scripts\mp\spawnlogic::removespawndangerzone( self.dangerzone );
        self.dangerzone = undefined;
    }
    
    if ( isdefined( self.sourcegrenade ) )
    {
        if ( isdefined( self.sourcegrenade.ownedmines ) )
        {
            self.sourcegrenade.ownedmines = array_remove( self.sourcegrenade.ownedmines, self );
        }
    }
    
    cleanupequipment( self getentitynumber() );
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
        
        if ( !isdefined( self ) )
        {
            return;
        }
    }
    
    scripts\cp_mp\ent_manager::deregisterspawn();
    
    if ( isdefined( self.sourcegrenade ) )
    {
        if ( self.sourcegrenade.ownedmines.size == 0 )
        {
            self.sourcegrenade function_f1ccd9eaaa39e87c();
        }
    }
    
    self delete();
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 0
// Checksum 0x0, Offset: 0x16ac
// Size: 0x72
function function_f1ccd9eaaa39e87c()
{
    if ( isdefined( self.ownedmines ) )
    {
        foreach ( mine in self.ownedmines )
        {
            mine thread function_e7e5214ee3b16fb1();
        }
    }
    
    scripts\cp_mp\ent_manager::deregisterspawn();
    self delete();
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 0
// Checksum 0x0, Offset: 0x1726
// Size: 0x72
function function_81ddc6ea59046dcb()
{
    if ( isdefined( self.ownedmines ) )
    {
        foreach ( mine in self.ownedmines )
        {
            mine thread function_435b53c90ec01143();
        }
    }
    
    scripts\cp_mp\ent_manager::deregisterspawn();
    self delete();
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 1
// Checksum 0x0, Offset: 0x17a0
// Size: 0xde
function function_31cc0ad55f88e7f3( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    meansofdeath = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    
    if ( isbulletdamage( meansofdeath ) )
    {
        if ( isdefined( objweapon ) )
        {
            hits = 1;
            
            if ( damage >= scripts\mp\weapons::minegettwohitthreshold() )
            {
                hits += 1;
            }
            
            if ( scripts\mp\utility\damage::isfmjdamage( objweapon, meansofdeath ) )
            {
                hits *= 2;
            }
            
            damage = hits * 5;
        }
    }
    else if ( function_76df7cd7c6105e46( meansofdeath ) )
    {
        damage = 1;
    }
    
    scripts\mp\weapons::equipmenthit( self.owner, attacker, objweapon, meansofdeath );
    return damage;
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 1
// Checksum 0x0, Offset: 0x1887
// Size: 0x55
function function_76df7cd7c6105e46( meansofdeath )
{
    switch ( meansofdeath )
    {
        case #"hash_66cb246f3e55fbe2":
        case #"hash_b1078ff213fddba6":
        case #"hash_c22b13f81bed11f0":
        case #"hash_d8646db4e6ee3658":
            return 1;
        default:
            return 0;
    }
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 1
// Checksum 0x0, Offset: 0x18e4
// Size: 0xce
function function_ca00c87cb0a3d308( data )
{
    attacker = data.attacker;
    
    if ( isdefined( attacker ) )
    {
        if ( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) )
        {
            attacker notify( "destroyed_equipment" );
            
            if ( !istrue( self.sourcegrenade.givenscore ) )
            {
                attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment( self, data.objweapon );
                self.sourcegrenade.givenscore = 1;
            }
        }
        
        if ( isbulletdamage( data.meansofdeath ) || function_76df7cd7c6105e46( data.meansofdeath ) )
        {
            thread function_92c9dde336b60a46( self.sourcegrenade, self.origin );
        }
    }
    
    thread function_435b53c90ec01143();
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 2
// Checksum 0x0, Offset: 0x19ba
// Size: 0x104
function function_92c9dde336b60a46( sourcegrenade, previousexplosionpoint )
{
    wait 0.35;
    closestmine = self;
    closestdistsqr = 250000;
    minesinrange = 0;
    
    if ( isdefined( sourcegrenade ) && isdefined( sourcegrenade.ownedmines ) )
    {
        foreach ( mine in sourcegrenade.ownedmines )
        {
            if ( !isdefined( mine ) )
            {
                continue;
            }
            
            if ( mine == self )
            {
                continue;
            }
            
            thisdistsqr = distancesquared( mine.origin, previousexplosionpoint );
            
            if ( thisdistsqr < closestdistsqr )
            {
                closestmine = mine;
                closestdistsqr = thisdistsqr;
                minesinrange = 1;
            }
        }
    }
    
    if ( istrue( minesinrange ) )
    {
        closestmine thread function_92c9dde336b60a46( sourcegrenade, closestmine.origin );
        closestmine thread function_435b53c90ec01143();
    }
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 1
// Checksum 0x0, Offset: 0x1ac6
// Size: 0xc4
function function_692167ff37e7ef8( data )
{
    if ( !isdefined( self ) || !isdefined( self.owner ) )
    {
        return;
    }
    
    attacker = data.attacker;
    
    if ( isdefined( attacker ) && istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) ) )
    {
        attacker notify( "destroyed_equipment" );
        
        if ( isdefined( self.sourcegrenade ) && !istrue( self.sourcegrenade.givenscore ) )
        {
            attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment( self, undefined, 1 );
            self.sourcegrenade.givenscore = 1;
        }
    }
    
    if ( isdefined( attacker ) && isplayer( attacker ) )
    {
        attacker updatedamagefeedback( "" );
    }
    
    thread function_435b53c90ec01143();
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 0
// Checksum 0x0, Offset: 0x1b92
// Size: 0x1d
function function_b540d1d357522929()
{
    self endon( "death" );
    function_1ba54174ee9ab40f();
    
    if ( isdefined( self ) )
    {
        thread function_435b53c90ec01143();
    }
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 0
// Checksum 0x0, Offset: 0x1bb7
// Size: 0x3f
function function_1ba54174ee9ab40f()
{
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    level endon( "game_ended" );
    
    while ( true )
    {
        waitframe();
    }
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 0
// Checksum 0x0, Offset: 0x1bfe
// Size: 0x1e
function function_1575acb1c3533196()
{
    self endon( "death" );
    self waittill( "entity_limit_destroy" );
    
    if ( isdefined( self ) )
    {
        thread function_435b53c90ec01143();
    }
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 1
// Checksum 0x0, Offset: 0x1c24
// Size: 0x43
function function_f92200134f4ce696( data )
{
    if ( istrue( self.isexploding ) )
    {
        return 0;
    }
    
    if ( isdefined( data.attacker ) )
    {
        self setentityowner( data.attacker );
    }
    
    thread function_435b53c90ec01143();
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 1
// Checksum 0x0, Offset: 0x1c6f
// Size: 0x3b
function function_b86eee224cc33fc( data )
{
    if ( isdefined( self ) && !istrue( self.isexploding ) )
    {
        self.isdisabled = 1;
        self setscriptablepartstate( "empd", "active", 0 );
    }
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 1
// Checksum 0x0, Offset: 0x1cb2
// Size: 0x3a
function function_d2c4655c7d6a3331( data )
{
    if ( isdefined( self ) || !istrue( self.isexploding ) )
    {
        self.isdisabled = undefined;
        self setscriptablepartstate( "empd", "neutral", 0 );
    }
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 2
// Checksum 0x0, Offset: 0x1cf4
// Size: 0x3c
function function_5f9ffc69b9bd0ab3( up, forward )
{
    right = vectornormalize( vectorcross( forward, up ) );
    forward = vectorcross( up, right );
    return axistoangles( forward, right, up );
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 2
// Checksum 0x0, Offset: 0x1d39
// Size: 0xd9
function function_6fed985972fc7a38( inflictor, attacker )
{
    victim = self;
    
    if ( victim _hasperk( "specialty_tac_resist" ) || victim _hasperk( "specialty_tac_resist_br" ) )
    {
        return;
    }
    
    victim notify( "buttfly_mine_frangible" );
    bundle = inflictor.sourcegrenade.bundle;
    
    if ( isdefined( bundle ) && istrue( bundle.var_5b4fa8f37a5d72d8 ) )
    {
        if ( isdefined( bundle.var_443434c1cae61f7 ) )
        {
            time = getdvarfloat( @"hash_32be7e91632bbd2c", bundle.var_443434c1cae61f7 );
        }
        else
        {
            time = getdvarfloat( @"hash_32be7e91632bbd2c", 3 );
        }
        
        attacker thread scripts\mp\perks\perkfunctions::ammodisabling_run( victim, 0, time );
        victim thread function_62a7d32fe50d51c3( time );
    }
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1e1a
// Size: 0x85
function private function_62a7d32fe50d51c3( timer )
{
    victim = self;
    victim endon( "buttfly_mine_frangible" );
    victim endon( "death_or_disconnect" );
    victim thread function_cf129b3a4e4245d0( timer );
    var_350eace8871c8665 = timer;
    
    if ( level.var_e705f4189f25418d )
    {
        frequency = 1;
        
        while ( isalive( victim ) && timer > 0 )
        {
            self function_2f6b8c6721d18b0b( "vsp_fall" );
            self function_9227c84d3fb311a3( "vsp_fall" );
            wait frequency;
            timer -= frequency;
        }
    }
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1ea7
// Size: 0x74
function private function_cf129b3a4e4245d0( timer )
{
    self endon( "buttfly_mine_frangible" );
    self endon( "death_or_disconnect" );
    
    if ( isusingremote() )
    {
        return;
    }
    
    if ( isalive( self ) )
    {
        self enableplayerbreathsystem( 0 );
        wait 1;
        
        while ( timer > 0 && isalive( self ) )
        {
            self playlocalsound( "plr_breath_pain_init" );
            timer -= 1.7;
            wait 1.7;
        }
        
        wait 0.5;
        self enableplayerbreathsystem( 1 );
    }
}

// Namespace butterfly_mine / scripts\mp\equipment\butterfly_mine
// Params 1
// Checksum 0x0, Offset: 0x1f23
// Size: 0x19c
function function_e1d976fb5e329d97( oldowner )
{
    if ( istrue( self.exploding ) )
    {
        return;
    }
    
    if ( isdefined( self.owner ) )
    {
        if ( isdefined( self.ownedmines ) )
        {
            foreach ( submine in self.ownedmines )
            {
                submine.owner = self.owner;
                submine.team = self.owner.team;
                submine.ownerid = self.owner getxuid();
                submine setentityowner( self.owner );
                submine setotherent( self.owner );
                
                if ( isdefined( submine.dangerzone ) )
                {
                    scripts\mp\spawnlogic::removespawndangerzone( submine.dangerzone );
                    submine.dangerzone = undefined;
                }
                
                submine.dangerzone = scripts\mp\spawnlogic::addspawndangerzone( submine.origin, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 50, submine.owner.team, undefined, submine.owner, 0, submine, 1 );
                
                if ( level.teambased )
                {
                    submine filteroutplayermarks( self.owner.team );
                    continue;
                }
                
                submine filteroutplayermarks( self.owner );
            }
        }
    }
}

