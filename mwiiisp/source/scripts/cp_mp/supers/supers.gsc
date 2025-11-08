#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;

#namespace supers;

// Namespace supers / scripts\cp_mp\supers\supers
// Params 1
// Checksum 0x0, Offset: 0x1e9
// Size: 0xa2
function function_f0327aead8f016e2( globals )
{
    if ( isdefined( level.gametypebundle ) )
    {
        globals.var_2652b1ba218bbaf5 = istrue( level.gametypebundle.var_2652b1ba218bbaf5 );
        globals.var_a33f6855d9867dbf = istrue( level.gametypebundle.var_a33f6855d9867dbf );
        globals.var_5b66ed80c98f795b = istrue( level.gametypebundle.var_5b66ed80c98f795b );
        return;
    }
    
    globals.var_2652b1ba218bbaf5 = 0;
    globals.var_a33f6855d9867dbf = 0;
    globals.var_5b66ed80c98f795b = 0;
}

// Namespace supers / scripts\cp_mp\supers\supers
// Params 1
// Checksum 0x0, Offset: 0x293
// Size: 0x739
function function_e3234be372f6209d( supertable )
{
    var_5d7589bf09bdf4d8 = getscriptbundle( supertable );
    
    for ( i = 0; i < var_5d7589bf09bdf4d8.super_list.size ; i++ )
    {
        superref = var_5d7589bf09bdf4d8.super_list[ i ].ref;
        superbundlename = var_5d7589bf09bdf4d8.super_list[ i ].bundle;
        
        if ( isdefined( superref ) && superref == "none" )
        {
            continue;
        }
        
        if ( isdefined( superbundlename ) && isdefined( superref ) && superref != "" )
        {
            superbundle = getscriptbundle( "super:" + superbundlename );
            
            if ( isdefined( superbundle ) )
            {
                staticdata = spawnstruct();
                level.superglobals.staticsuperdata[ superref ] = staticdata;
                staticdata.id = i;
                staticdata.ref = superref;
                weaponname = superbundle.offhandweapon;
                staticdata.weapon = weaponname;
                blueprints = getweaponblueprintnames( weaponname );
                
                foreach ( index in blueprints )
                {
                    var_b13ff8bade98bb3f = weaponname + "|" + string( index );
                    level.superblueprints[ var_b13ff8bade98bb3f ] = function_3211981142ec5aee( weaponname, blueprint );
                }
                
                staticdata.bundle = superbundle;
                pointsneeded = undefined;
                usetime = undefined;
                graceperiod = undefined;
                isanymlgmatch = 0;
                
                if ( issharedfuncdefined( "isAnyMLGMatch", "game" ) )
                {
                    isanymlgmatch = self [[ getsharedfunc( "isAnyMLGMatch", "game" ) ]]();
                }
                
                if ( isanymlgmatch )
                {
                    pointsneeded = superbundle.var_d90c4ae14206496f;
                    usetime = superbundle.cwlusetime;
                    graceperiod = superbundle.cwlgraceperiod;
                }
                
                if ( !isdefined( pointsneeded ) )
                {
                    pointsneeded = superbundle.pointsneeded;
                }
                
                if ( !isdefined( usetime ) )
                {
                    usetime = superbundle.usetime;
                }
                
                if ( !isdefined( graceperiod ) )
                {
                    graceperiod = superbundle.graceperiod;
                }
                
                staticdata.pointsneeded = ter_op( isdefined( pointsneeded ), pointsneeded, 0 );
                staticdata.usetime = usetime;
                staticdata.graceperiod = graceperiod;
                staticdata.refundondeath = superbundle.refundondeath;
                staticdata.useweapon = superbundle.useweapon;
                staticdata.useweaponclipammo = ter_op( isdefined( superbundle.useweaponclipammo ), superbundle.useweaponclipammo, 0 );
                staticdata.useweaponstockammo = ter_op( isdefined( superbundle.useweaponstockammo ), superbundle.useweaponstockammo, 0 );
                staticdata.useweapontrackstats = ter_op( isdefined( superbundle.var_a6ad55f6d5e63e36 ), superbundle.var_a6ad55f6d5e63e36, 0 );
                staticdata.movespeed = superbundle.movespeed;
                staticdata.isweapon = superbundle.isweapon;
                staticdata.canuseinlaststand = superbundle.canuseinlaststand;
                staticdata.persistondeath = superbundle.persistondeath;
                staticdata.var_ff2e3a3658646a3f = superbundle.var_ff2e3a3658646a3f;
                staticdata.var_f579d98fe982ce3e = superbundle.var_f579d98fe982ce3e;
                staticdata.var_6af942bb3f913f9f = istrue( superbundle.var_cd006f80436a89fd );
                staticdata.var_d835cd7abd661b88 = superbundle.var_6ccf992f8f601e2e;
                staticdata.weaponammo = superbundle.var_cca155763701359;
                staticdata.var_5c8e66e22b288b33 = superbundle.var_5c8e66e22b288b33;
                staticdata.extraweapons = [];
                
                if ( isdefined( staticdata.useweapon ) && staticdata.useweapon != "" )
                {
                    if ( level.gametype == "dungeons" )
                    {
                        staticdata.useweapon = scripts\cp_mp\weapon::buildweapon_blueprint( scripts\cp_mp\weapon::getweaponrootname( staticdata.useweapon ), "none", "none", 0, undefined, undefined, 1 );
                    }
                    else
                    {
                        staticdata.useweapon = scripts\cp_mp\weapon::buildweapon_blueprint( scripts\cp_mp\weapon::getweaponrootname( staticdata.useweapon ), "none", "none", 0 );
                    }
                }
                
                level.superglobals.supersbyid[ i ] = superref;
                
                if ( !isdefined( staticdata.weapon ) )
                {
                    assertmsg( "super scriptbundle has invalid weapon for super \"" + superref + "\"" );
                    level.superglobals.staticsuperdata[ superref ] = undefined;
                }
                else
                {
                    level.superglobals.supersbyoffhand[ staticdata.weapon ] = staticdata;
                }
                
                if ( !isdefined( staticdata.pointsneeded ) )
                {
                    assertmsg( "super scriptbundle has invalid points needed for super \"" + superref + "\"" );
                    level.superglobals.staticsuperdata[ superref ] = undefined;
                }
                
                if ( isdefined( staticdata.maxactivations ) )
                {
                    if ( staticdata.maxactivations > 0 )
                    {
                        staticdata.activatepenalty = 1 / staticdata.maxactivations;
                    }
                    else
                    {
                        staticdata.activatepenalty = 1;
                    }
                }
                
                if ( isdefined( staticdata.maxactivationsalt ) )
                {
                    if ( staticdata.maxactivationsalt > 0 )
                    {
                        staticdata.activatepenaltyalt = 1 / staticdata.maxactivationsalt;
                    }
                }
                
                if ( isdefined( staticdata.useweapon ) && isweapon( staticdata.useweapon ) )
                {
                    assertex( isdefined( staticdata.useweaponclipammo ), "super scriptbundle \"" + superref + "\" has a useWeapon value set, but no useWeaponClipAmmo set." );
                    assertex( isdefined( staticdata.useweaponstockammo ), "super scriptbundle \"" + superref + "\" has a useWeapon value set, but no useWeaponStockAmmo set." );
                    assertex( isdefined( staticdata.useweapontrackstats ), "super scriptbundle \"" + superref + "\" has a useWeapon value set, but no useWeaponTrackStats set." );
                    level.superglobals.superweapons[ staticdata.useweapon.basename ] = staticdata;
                }
                
                if ( isdefined( staticdata.graceperiod ) )
                {
                    staticdata.graceperiod *= 1000;
                }
                else
                {
                    staticdata.graceperiod = 0;
                }
                
                initializesuper( getxhash( superref ) );
            }
        }
    }
}

// Namespace supers / scripts\cp_mp\supers\supers
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x9d4
// Size: 0x3a
function private initializesuper( var_511f1c7eaf0d2df7 )
{
    if ( !isdefined( level.var_db30cf1837ca94fd ) )
    {
        return;
    }
    
    initfunc = level.var_db30cf1837ca94fd[ var_511f1c7eaf0d2df7 ];
    
    if ( !isdefined( initfunc ) )
    {
        return;
    }
    
    level [[ initfunc ]]();
}

// Namespace supers / scripts\cp_mp\supers\supers
// Params 1
// Checksum 0x0, Offset: 0xa16
// Size: 0x7d
function getsuperid( superref )
{
    if ( !isdefined( superref ) || !isdefined( level.superglobals ) || !isdefined( level.superglobals.staticsuperdata ) || !isdefined( level.superglobals.staticsuperdata[ superref ] ) || superref == "none" )
    {
        return 0;
    }
    
    return level.superglobals.staticsuperdata[ superref ].id;
}

// Namespace supers / scripts\cp_mp\supers\supers
// Params 1
// Checksum 0x0, Offset: 0xa9c
// Size: 0x3d
function function_bf9c7e9dd30180e3( superref )
{
    superdata = level.superglobals.staticsuperdata[ superref ];
    
    if ( isdefined( superdata ) )
    {
        return superdata.bundle;
    }
    
    return undefined;
}

// Namespace supers / scripts\cp_mp\supers\supers
// Params 2
// Checksum 0x0, Offset: 0xae2
// Size: 0xec
function buildsuper( weaponname, blueprintindex )
{
    if ( !isdefined( weaponname ) )
    {
        return undefined;
    }
    
    if ( isdefined( blueprintindex ) && blueprintindex > 0 )
    {
        var_b13ff8bade98bb3f = weaponname + "|" + string( blueprintindex );
        var_327f51ee83320be4 = level.superblueprints[ var_b13ff8bade98bb3f ];
        attachments = [];
        var_c9b64ec1c40ac0ef = [];
        arrayindex = 0;
        
        foreach ( blueprintindex in var_327f51ee83320be4 )
        {
            attachments[ arrayindex ] = attachment;
            var_c9b64ec1c40ac0ef[ arrayindex ] = blueprintindex;
            arrayindex++;
        }
        
        weapon = makeweapon( weaponname, attachments, undefined, undefined, blueprintindex, var_c9b64ec1c40ac0ef );
    }
    else
    {
        weapon = makeweapon( weaponname );
    }
    
    return weapon;
}

