#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\asm\asm;
#using scripts\common\anim;
#using scripts\engine\utility;

#namespace namespace_15a6b98dc3353454;

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 2
// Checksum 0x0, Offset: 0x359
// Size: 0x1da, Type: bool
function evaluatesyncedmeleebyxanim( meleexanim, var_63cac41d4942d388 )
{
    target = self.meleetarget;
    targetangles = target.angles;
    metotarget = target.origin - self.origin;
    metotargetyaw = vectortoyaw( metotarget );
    var_5e7f52c1693e8f30 = 30;
    yawdelta = angleclamp180( metotargetyaw - self.angles[ 1 ] );
    
    if ( abs( yawdelta ) > var_5e7f52c1693e8f30 )
    {
        return false;
    }
    
    if ( var_63cac41d4942d388 )
    {
        targetangles = target.angles - ( 0, yawdelta * 0.5, 0 );
        startpos = getstartorigin( target.origin, targetangles, meleexanim );
    }
    else
    {
        targetangles = target.angles - ( 0, yawdelta, 0 );
        startpos = getstartorigin( target.origin, targetangles, meleexanim );
    }
    
    startpostome = self.origin - startpos;
    var_e0e7d3c1e330d5d4 = vectornormalize( target.origin - startpos );
    dot = vectordot( var_e0e7d3c1e330d5d4, startpostome );
    
    if ( dot > 12 || dot < -12 )
    {
        return false;
    }
    
    if ( var_63cac41d4942d388 )
    {
        self.var_290be0985580a7a0 = self.angles[ 1 ] + yawdelta * 0.5;
        target.var_290be0985580a7a0 = targetangles[ 1 ];
    }
    else
    {
        self.var_290be0985580a7a0 = getstartangles( target.origin, targetangles, meleexanim )[ 1 ];
        target.var_290be0985580a7a0 = targetangles[ 1 ];
    }
    
    target.var_3a185a212fdfebca = 1;
    return true;
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 2
// Checksum 0x0, Offset: 0x53c
// Size: 0x1be, Type: bool
function function_732d599999bac851( meleexanim, zombiemeleexanim )
{
    soldieranimlength = getanimlength( meleexanim );
    zombieanimlength = getanimlength( zombiemeleexanim );
    zombiesynctime = getnotetracktimes( zombiemeleexanim, "sync" );
    fracsynctime = zombiesynctime[ 0 ] * zombieanimlength / soldieranimlength;
    soldiermovedelta = getmovedelta( meleexanim );
    soldieranimendpos = self localtoworldcoords( soldiermovedelta );
    zombieanimstartposang = scripts\common\anim::function_d2e8597ff01310ed( meleexanim, "tag_sync", 0, self.origin, self.angles );
    var_8fcc6747b3d1ffc3 = scripts\common\anim::function_d2e8597ff01310ed( meleexanim, "tag_sync", fracsynctime, self.origin, self.angles );
    zombiemovedelta = getmovedelta( zombiemeleexanim );
    endpos = coordtransform( soldiermovedelta, zombieanimstartposang[ "origin" ], zombieanimstartposang[ "angles" ] );
    target = self.meleetarget;
    dist = distance( target.origin, var_8fcc6747b3d1ffc3[ "origin" ] );
    
    if ( dist > 60 )
    {
        return false;
    }
    
    if ( !ispointonnavmesh( soldieranimendpos ) || !ispointonnavmesh( var_8fcc6747b3d1ffc3[ "origin" ] ) )
    {
        return false;
    }
    
    navtraceresult = navtrace( zombieanimstartposang[ "origin" ], self.origin, target, 0 );
    
    if ( navtraceresult )
    {
        return false;
    }
    
    navtraceresult = navtrace( self.origin, soldieranimendpos, self, 0 );
    
    if ( navtraceresult )
    {
        return false;
    }
    
    target.var_3a185a212fdfebca = 1;
    return true;
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 4
// Checksum 0x0, Offset: 0x703
// Size: 0x371
function evaluatesyncedmelee( asmname, statename, tostatename, params )
{
    if ( isdefined( level.var_134c418fea89d2ad ) )
    {
        return [[ level.var_134c418fea89d2ad ]]( self, asmname, statename, tostatename, params );
    }
    
    assert( self.in_melee );
    assert( isdefined( self.meleetarget ) );
    target = self.meleetarget;
    
    if ( isplayer( target ) )
    {
        return 0;
    }
    
    if ( istrue( self.dontsyncmelee ) || istrue( target.dontsyncmelee ) )
    {
        return 0;
    }
    
    if ( !isdefined( target.weapon ) )
    {
        return 0;
    }
    
    if ( !target asmhasstate( target.asmname, tostatename + "_victim" ) )
    {
        return 0;
    }
    
    if ( target.type != "zombie" )
    {
        if ( weaponclass( self.weapon ) == "pistol" || weaponclass( target.weapon ) == "pistol" )
        {
            return 0;
        }
    }
    
    if ( getdvarint( @"hash_4fa81bfc988a90e6", 0 ) == 1 )
    {
        if ( target.type == "zombie" )
        {
            target.meleealwayswin = 1;
        }
    }
    
    if ( !isdefined( self.var_74666f91f95a6ef8 ) || !isdefined( target.var_74666f91f95a6ef8 ) )
    {
        melee_decide_winner();
    }
    
    bwinner = params[ 0 ];
    
    if ( self.var_74666f91f95a6ef8 != bwinner )
    {
        return 0;
    }
    
    var_63cac41d4942d388 = params[ 1 ];
    syncdir = melee_calcsyncdirection();
    variations = [ "a" ];
    
    if ( target.type == "zombie" || syncdir == "8" )
    {
        variations = [ "a", "b", "c" ];
        numvars = 3;
        var_8a8ae42021841e0c = randomint( numvars );
        var_8a8ae720218424a5 = randomint( numvars );
        temp = variations[ var_8a8ae42021841e0c ];
        variations[ var_8a8ae42021841e0c ] = variations[ var_8a8ae720218424a5 ];
        variations[ var_8a8ae720218424a5 ] = temp;
    }
    
    numvars = variations.size;
    
    for ( ivar = 0; ivar < numvars ; ivar++ )
    {
        aliasname = syncdir + variations[ ivar ];
        meleeanim = asm_lookupanimfromalias( tostatename, aliasname );
        meleexanim = asm_getxanim( tostatename, meleeanim );
        
        if ( target.type == "zombie" )
        {
            zombietostatename = tostatename + "_victim";
            zombiemeleeanim = target asm_lookupanimfromalias( zombietostatename, aliasname );
            zombiemeleexanim = target asm_getxanim( zombietostatename, zombiemeleeanim );
            
            if ( function_732d599999bac851( meleexanim, zombiemeleexanim ) )
            {
                self.meleeanimalias = aliasname;
                target.meleeanimalias = aliasname;
                target.syncedmeleepartner = self;
                return 1;
            }
            
            continue;
        }
        
        if ( evaluatesyncedmeleebyxanim( meleexanim, var_63cac41d4942d388 ) )
        {
            self.meleeanimalias = aliasname;
            target.meleeanimalias = aliasname;
            target.syncedmeleepartner = self;
            return 1;
        }
    }
    
    return 0;
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 2
// Checksum 0x0, Offset: 0xa7d
// Size: 0xd7
function melee_setmeleetimer( unittype, factor )
{
    if ( !isdefined( anim ) )
    {
        return;
    }
    
    if ( !isdefined( anim.meleechargeintervals ) )
    {
        return;
    }
    
    if ( !isdefined( unittype ) )
    {
        return;
    }
    
    if ( !isdefined( factor ) )
    {
        factor = 1;
    }
    
    if ( isplayer( self.meleetarget ) && isdefined( anim.meleechargeplayerintervals[ self.unittype ] ) )
    {
        anim.meleechargeplayertimers[ self.unittype ] = gettime() + anim.meleechargeplayerintervals[ self.unittype ] * factor;
        return;
    }
    
    if ( isdefined( anim.meleechargeintervals[ self.unittype ] ) )
    {
        anim.meleechargetimers[ self.unittype ] = gettime() + anim.meleechargeintervals[ self.unittype ] * factor;
    }
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 0
// Checksum 0x0, Offset: 0xb5c
// Size: 0xc6
function melee_calcsyncdirection()
{
    assert( self.in_melee );
    target = self.meleetarget;
    assert( isdefined( target ) );
    targettome = self.origin - target.origin;
    var_f38131fb9a95561a = vectortoyaw( targettome );
    anglediff = angleclamp180( var_f38131fb9a95561a - target.angles[ 1 ] );
    
    if ( -45 < anglediff && anglediff < 45 )
    {
        return "8";
    }
    else if ( anglediff > 135 || anglediff < -135 )
    {
        return "2";
    }
    else if ( anglediff > 45 )
    {
        return "4";
    }
    
    return "6";
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 1
// Checksum 0x0, Offset: 0xc2b
// Size: 0x48
function melee_waitfordroppedweapon( statename )
{
    self endon( statename + "_finished" );
    self waittill( "weapon_dropped", droppedweapon );
    
    if ( isdefined( droppedweapon ) )
    {
        assert( self.in_melee );
        self.var_aca4dbbe78d6d478 = droppedweapon;
    }
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 2
// Checksum 0x0, Offset: 0xc7b
// Size: 0xb6
function melee_synced_setup( statename, battacker )
{
    self.meleestatename = statename;
    self.bmeleeinprogress = 1;
    self.meleeweapon = self.weapon;
    self.meleeweaponslot = scripts\anim\utility::getcurrentweaponslotname();
    self.var_a54042b7b10263be = 1;
    
    if ( battacker )
    {
        melee_setmeleetimer( self.unittype );
        self.syncedmeleetarget = self.meleetarget;
    }
    else
    {
        self.syncedmeleetarget = self.meleepartner;
    }
    
    if ( self.unittype == "c6" )
    {
        self.hackable = 0;
        self.ignoreme = 1;
    }
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 0
// Checksum 0x0, Offset: 0xd39
// Size: 0x8a
function melee_unlink()
{
    self unlink();
    
    if ( isdefined( self.meleepartner ) && isalive( self.meleepartner ) )
    {
        self.meleepartner animmode( "zonly_physics" );
        self.meleepartner orientmode( "face angle", self.meleepartner.angles[ 1 ] );
    }
    
    self animmode( "zonly_physics" );
    self orientmode( "face angle", self.angles[ 1 ] );
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 3
// Checksum 0x0, Offset: 0xdcb
// Size: 0x3e
function chooseanim_syncmelee( asmname, statename, params )
{
    assert( isdefined( self.meleeanimalias ) );
    return asm_lookupanimfromalias( statename, self.meleeanimalias );
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 0
// Checksum 0x0, Offset: 0xe12
// Size: 0x155
function melee_decide_winner()
{
    assert( self.in_melee );
    assert( isdefined( self.meleetarget ) );
    target = self.meleetarget;
    assert( target.in_melee );
    
    if ( self.meleealwayswin )
    {
        assert( !isdefined( target.magic_bullet_shield ) );
        self.var_74666f91f95a6ef8 = 1;
        target.var_74666f91f95a6ef8 = 0;
        return;
    }
    else if ( target.meleealwayswin )
    {
        assert( !isdefined( self.magic_bullet_shield ) );
        self.var_74666f91f95a6ef8 = 0;
        target.var_74666f91f95a6ef8 = 1;
        return;
    }
    
    if ( isdefined( self.magic_bullet_shield ) )
    {
        assert( !isdefined( target.magic_bullet_shield ) );
        self.var_74666f91f95a6ef8 = 1;
        target.var_74666f91f95a6ef8 = 0;
        return;
    }
    
    if ( isdefined( target.magic_bullet_shield ) )
    {
        self.var_74666f91f95a6ef8 = 0;
        target.var_74666f91f95a6ef8 = 1;
        return;
    }
    
    self.var_74666f91f95a6ef8 = scripts\engine\utility::cointoss();
    target.var_74666f91f95a6ef8 = !self.var_74666f91f95a6ef8;
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 3
// Checksum 0x0, Offset: 0xf6f
// Size: 0x3a
function melee_instantkill( asmname, statename, params )
{
    self kill( self.origin + anglestoforward( self.angles ) );
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 3
// Checksum 0x0, Offset: 0xfb1
// Size: 0x274
function playmeleeanim_synced( asmname, statename, params )
{
    assert( self.in_melee );
    assert( isdefined( self.meleetarget ) );
    self.bmeleestarted = 1;
    target = self.meleetarget;
    meleeanim = asm_getanim( asmname, statename );
    meleexanim = asm_getxanim( statename, meleeanim );
    asm_fireephemeralevent( "melee_attack", "begin" );
    melee_synced_setup( statename, 1 );
    stoptimes = getnotetracktimes( meleexanim, "melee_stop" );
    
    if ( stoptimes.size > 0 )
    {
        self.var_6a4a5c698277c54d = 1;
    }
    
    interacttimes = getnotetracktimes( meleexanim, "melee_interact" );
    
    if ( interacttimes.size > 0 )
    {
        self.var_541e0eb7644f137f = 1;
    }
    
    if ( self.type != "zombie" )
    {
        thread melee_waitfordroppedweapon( statename );
    }
    
    if ( isdefined( target getinteractionid() ) )
    {
        target leaveinteraction();
    }
    
    target asm_setstate( statename + "_victim" );
    
    if ( target.type == "zombie" )
    {
        self.var_c5959a333d8edf27 = 1;
    }
    
    self animmode( "zonly_physics" );
    
    if ( isdefined( self.var_290be0985580a7a0 ) )
    {
        self orientmode( "face angle", self.var_290be0985580a7a0 );
    }
    
    self aisetanim( statename, meleeanim );
    asm_playfacialanim( asmname, statename, meleexanim );
    thread playmeleeanim_synced_waitforpartnerexit( asmname, statename );
    self endon( statename + "_finished" );
    lastnotetrack = asm_donotetracks( asmname, statename, &melee_handlenotetracks );
    
    if ( ( lastnotetrack == "melee_death" || !self.var_74666f91f95a6ef8 ) && !self.var_d8a098b0872bb2cb )
    {
        self.a.nodeath = 0;
        
        if ( isdefined( self.meleetarget ) && self.meleetarget.in_melee )
        {
            self.meleetarget.var_42c47bf5f8a7fdf6 = 1;
        }
        
        if ( target.type == "zombie" )
        {
            self kill( self.origin + anglestoforward( self.angles ) );
            return;
        }
        
        self kill();
    }
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 3
// Checksum 0x0, Offset: 0x122d
// Size: 0x7f
function playmeleeanim_synced_survive( asmname, statename, params )
{
    assert( !self.in_melee );
    surviveanim = asm_getanim( asmname, statename );
    survivexanim = asm_getxanim( statename, surviveanim );
    self aisetanim( statename, surviveanim );
    asm_playfacialanim( asmname, statename, survivexanim );
    self.meleeanimalias = undefined;
    asm_donotetracks( asmname, statename, &melee_handlenotetracks );
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 3
// Checksum 0x0, Offset: 0x12b4
// Size: 0xf0
function playmeleeanim_synced_cleanup( asmname, statename, params )
{
    assert( self.in_melee );
    
    if ( self.in_melee )
    {
        if ( isdefined( self.syncedmeleepartner ) )
        {
            self.syncedmeleepartner notify( "melee_exit" );
            self.syncedmeleepartner = undefined;
        }
        else if ( isdefined( self.meleepartner ) )
        {
            self.meleepartner notify( "melee_exit" );
        }
    }
    
    self.var_c5959a333d8edf27 = 0;
    
    if ( isalive( self ) && self.in_melee && self.type != "zombie" )
    {
        melee_droppedweaponrestore();
    }
    
    self unlink();
    
    if ( self.unittype == "c6" )
    {
        self.hackable = 1;
        self.ignoreme = 0;
    }
    
    self function_bdcb37a9431e654( 0 );
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 3
// Checksum 0x0, Offset: 0x13ac
// Size: 0x1fc
function playmeleeanim_synced_victim( asmname, statename, params )
{
    self endon( statename + "_finished" );
    assert( self.in_melee );
    self.bmeleestarted = 1;
    self animmode( "nogravity" );
    
    if ( isdefined( self.var_290be0985580a7a0 ) )
    {
        self orientmode( "face angle", self.var_290be0985580a7a0 );
    }
    else
    {
        self orientmode( "face current" );
    }
    
    melee_synced_setup( statename, 0 );
    
    if ( self.type != "zombie" )
    {
        thread melee_waitfordroppedweapon( statename );
    }
    
    victimanim = asm_getanim( asmname, statename );
    victimxanim = asm_getxanim( statename, victimanim );
    self aisetanim( statename, victimanim );
    asm_playfacialanim( asmname, statename, victimxanim );
    stoptimes = getnotetracktimes( victimxanim, "melee_stop" );
    
    if ( stoptimes.size > 0 )
    {
        self.var_6a4a5c698277c54d = 1;
    }
    
    interacttimes = getnotetracktimes( victimxanim, "melee_interact" );
    
    if ( interacttimes.size > 0 )
    {
        self.var_541e0eb7644f137f = 1;
    }
    
    interactendtimes = getnotetracktimes( victimxanim, "drop" );
    
    if ( interactendtimes.size > 0 )
    {
        self.var_b3c40d9762123312 = 1;
    }
    
    thread playmeleeanim_synced_waitforpartnerexit( asmname, statename );
    lastnotetrack = asm_donotetracks( asmname, statename, &melee_handlenotetracks );
    
    if ( ( lastnotetrack == "melee_death" || !self.var_74666f91f95a6ef8 ) && !self.var_d8a098b0872bb2cb )
    {
        self.a.nodeath = 0;
        
        if ( isdefined( self.meleepartner ) && self.meleepartner.in_melee )
        {
            self.meleepartner.var_42c47bf5f8a7fdf6 = 1;
        }
        
        self kill();
    }
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 2
// Checksum 0x0, Offset: 0x15b0
// Size: 0x29
function waitforpartnerdelete( statename, partner )
{
    if ( !isdefined( partner ) )
    {
        return;
    }
    
    partner waittill( "entitydeleted" );
    self notify( "melee_exit" );
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 2
// Checksum 0x0, Offset: 0x15e1
// Size: 0x1b3
function playmeleeanim_synced_waitforpartnerexit( asmname, statename )
{
    self endon( statename + "_finished" );
    
    if ( isdefined( self.syncedmeleepartner ) )
    {
        childthread waitforpartnerdelete( statename, self.syncedmeleepartner );
    }
    else
    {
        childthread waitforpartnerdelete( statename, self.meleepartner );
    }
    
    self waittill( "melee_exit" );
    self unlink();
    var_f20f49840827acf1 = asm_eventfired( asmname, "melee_interact" );
    
    if ( self.var_541e0eb7644f137f && !var_f20f49840827acf1 )
    {
        self.var_d8a098b0872bb2cb = 1;
    }
    else if ( var_f20f49840827acf1 && !asm_eventfired( asmname, "melee_death" ) )
    {
        if ( self.var_b3c40d9762123312 )
        {
            self.var_d8a098b0872bb2cb = !asm_eventfired( asmname, "drop" );
        }
        else
        {
            self.var_d8a098b0872bb2cb = 0;
        }
    }
    
    if ( !self.var_74666f91f95a6ef8 )
    {
        if ( self.var_d8a098b0872bb2cb )
        {
            if ( asm_eventfired( asmname, "death_ragdoll_delayed" ) )
            {
                melee_instantkill();
            }
            else
            {
                self.var_4ecd594ae357f55b = 1;
                self.var_9ea242cb88e6301e = 0;
            }
        }
        else if ( asm_eventfired( asmname, "melee_no_recovery" ) )
        {
            self.var_9aedaf1da799bd67 = 1;
        }
        else if ( asm_eventfired( asmname, "melee_stop" ) )
        {
            self kill();
        }
        else if ( self.var_6a4a5c698277c54d )
        {
            self.var_4ecd594ae357f55b = 1;
        }
        else
        {
            self.var_9aedaf1da799bd67 = 1;
        }
        
        return;
    }
    
    if ( asm_eventfired( asmname, "fire" ) )
    {
        self.var_9aedaf1da799bd67 = 1;
        return;
    }
    
    if ( !self.var_42c47bf5f8a7fdf6 )
    {
        self.var_4ecd594ae357f55b = 1;
    }
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 2
// Checksum 0x0, Offset: 0x179c
// Size: 0x1da
function function_4f145058cbb5099e( final_alias, append_code )
{
    append = "";
    
    switch ( append_code )
    {
        case #"hash_a13dd2b8b51545eb":
            append = "_cloth";
            
            if ( istrue( self.armored ) )
            {
                append = "_gear";
            }
            
            break;
        case #"hash_4f7f2f56f62275dc":
            append = "_dirt";
            my_surface = self.lastgroundtype;
            
            if ( isdefined( my_surface ) )
            {
                switch ( my_surface )
                {
                    case #"hash_cacc49f5cefe9c2":
                    case #"hash_fb5a4fd62140d3d":
                    case #"hash_1b9205edae40e596":
                    case #"hash_1d3c8b96a9c71b54":
                    case #"hash_3931479c445fb9b9":
                    case #"hash_4d63389017f81514":
                    case #"hash_4f863c6e34468e29":
                    case #"hash_51929a2eb8e4f743":
                    case #"hash_519950fd846289c6":
                    case #"hash_57b9e7028fd773ba":
                    case #"hash_590687995d01030e":
                    case #"hash_5dab8ddea3468324":
                    case #"hash_67e845c97d1f9eda":
                    case #"hash_7fe735e403d9fe08":
                    case #"hash_84a41da455643bc9":
                    case #"hash_886109ae17c9aa73":
                    case #"hash_8c9d4c67dcde81f2":
                    case #"hash_8dede5336d28890d":
                    case #"hash_8f53c9965f23a6cd":
                    case #"hash_91afe7576024a903":
                    case #"hash_d70d4c17673f4162":
                    case #"hash_df0e712b7aee0b97":
                    case #"hash_f4d3c7f04f8ef31d":
                    case #"hash_f5afef0d74babaca":
                    case #"hash_f9100fc94321f813":
                        append = "_wood";
                        break;
                }
            }
            
            break;
    }
    
    final_alias += append;
    
    if ( soundexists( final_alias ) )
    {
        self playsound( final_alias );
    }
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 1
// Checksum 0x0, Offset: 0x197e
// Size: 0x29b
function melee_handlenotetracks( note )
{
    prefix = getsubstr( note, 0, 3 );
    used_prefix = 0;
    
    switch ( prefix )
    {
        case #"hash_8966586c51e34031":
            used_prefix = 1;
            alias = getsubstr( note, 3 );
            self playsound( alias );
            break;
        case #"hash_6d20b46c4370528e":
            used_prefix = 1;
            truncatednotetrack = getsubstr( note, 3 );
            params = strtok( truncatednotetrack, "," );
            
            if ( params.size >= 2 )
            {
                function_4f145058cbb5099e( params[ 0 ], params[ 1 ] );
            }
            
            break;
    }
    
    if ( used_prefix )
    {
        return;
    }
    
    switch ( note )
    {
        case #"hash_49d2de8a43d395fa":
            if ( !self.var_4ecd594ae357f55b )
            {
                if ( isdefined( self.meleetarget ) )
                {
                    if ( isalive( self.meleetarget ) )
                    {
                        self linktoblendtotag( self.meleetarget, "tag_sync", 1, 1 );
                    }
                }
                else if ( self.var_3a185a212fdfebca && isdefined( self.syncedmeleepartner ) )
                {
                    if ( isalive( self.syncedmeleepartner ) )
                    {
                        self linktoblendtotag( self.syncedmeleepartner, "tag_sync", 1, 1 );
                    }
                }
            }
            
            break;
        case #"hash_a74d3b6faa5ac811":
            if ( self.var_a54042b7b10263be )
            {
                melee_unlink();
            }
            else
            {
                self unlink();
            }
            
            break;
        case #"hash_9b60ee8bd4984ddf":
            scripts\anim\shared::dropallaiweapons();
            
            if ( isdefined( level.var_14fad57c290ee19a ) && isdefined( level.var_170ca38d1fed8147 ) )
            {
                self.alreadydroppedweapon = 1;
                weapon = self [[ level.var_14fad57c290ee19a ]]();
                [[ level.var_170ca38d1fed8147 ]]( weapon, self.origin );
            }
            
            break;
        case #"hash_b11f0ef79e138572":
            break;
        case #"hash_9a4dd9ac49e5d8ae":
            return note;
        case #"hash_fd45bbe21f535106":
            self attach( "weapon_vm_me_soscar_knife", "TAG_INHAND", 1 );
            break;
        case #"hash_78af604e22ccf1d4":
            self detach( "weapon_vm_me_soscar_knife", "TAG_INHAND", 1 );
            break;
        case #"hash_23b3ca8a2f927c01":
            self playsound( "melee_knife_hit_body" );
            playfxontag( level._effect[ "melee_knife_ai" ], self, "TAG_KNIFE_FX" );
            break;
        case #"hash_9ccf1d54a8f2ba84":
            break;
    }
}

// Namespace namespace_15a6b98dc3353454 / namespace_5b839d77e9fabdb7
// Params 0
// Checksum 0x0, Offset: 0x1c21
// Size: 0x95
function melee_droppedweaponrestore()
{
    assert( isdefined( self ) );
    assert( self.in_melee );
    
    if ( !isnullweapon( self.weapon ) && !isnullweapon( self.lastweapon ) )
    {
        return;
    }
    
    if ( isundefinedweapon( self.meleeweapon ) )
    {
        return;
    }
    
    scripts\anim\shared::forceuseweapon( self.meleeweapon, self.meleeweaponslot );
    
    if ( isdefined( self.var_aca4dbbe78d6d478 ) )
    {
        self.var_aca4dbbe78d6d478 delete();
        self.var_aca4dbbe78d6d478 = undefined;
    }
}

