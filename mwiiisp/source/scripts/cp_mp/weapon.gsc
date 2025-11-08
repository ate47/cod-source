#using scripts\common\utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\cp_mp\weapons_dev;
#using scripts\engine\utility;

#namespace weapon;

// Namespace weapon / scripts\cp_mp\weapon
// Params 9
// Checksum 0x0, Offset: 0x1301
// Size: 0x284
function buildweapon_blueprintwithcustomattachments( rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg )
{
    weaponassetname = weaponassetnamemap( rootname, variantid );
    attachmenttoidmap = [];
    blockedslots = [];
    blockedtypes = [];
    
    if ( isdefined( attachments ) )
    {
        assertex( !isdefined( attachmentids ) || attachments.size == attachmentids.size, "buildWeapon_variantWithCustomAttachments() passed attachmentIDs array not of the same size as the passed attachments array." );
        
        foreach ( idx, attachment in attachments )
        {
            var_1fce8439ed13e7b3 = getattachmentbasetypesblocked( weaponassetname, attachment );
            slotsblocked = getattachmentslotsblocked( weaponassetname, attachment );
            
            foreach ( blockedslot in slotsblocked )
            {
                blockedslots[ blockedslot ] = 1;
            }
            
            foreach ( basetypeblocked in var_1fce8439ed13e7b3 )
            {
                blockedtypes[ basetypeblocked ] = 1;
            }
            
            aid = 0;
            
            if ( isdefined( attachmentids ) && isdefined( attachmentids[ idx ] ) )
            {
                aid = attachmentids[ idx ];
            }
            
            attachmenttoidmap[ attachment ] = aid;
        }
    }
    
    variantattachments = weaponattachcustomtoidmap( rootname, variantid );
    
    if ( isdefined( variantattachments ) )
    {
        foreach ( attachment, id in variantattachments )
        {
            if ( blockedslots.size > 0 )
            {
                slot = getattachmentslot( weaponassetname, attachment );
                
                if ( isdefined( blockedslots[ slot ] ) )
                {
                    continue;
                }
            }
            
            if ( blockedtypes.size > 0 )
            {
                type = getattachmentbasetype( weaponassetname, attachment );
                
                if ( isdefined( blockedtypes[ type ] ) )
                {
                    continue;
                }
            }
            
            attachmenttoidmap[ attachment ] = id;
        }
    }
    
    return buildweapon_attachmentidmap( rootname, attachmenttoidmap, camo, reticle, variantid, cosmeticattachment, stickers, hasnvg );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 7
// Checksum 0x0, Offset: 0x158e
// Size: 0xd3
function buildweapon_blueprint( rootname, camo, reticle, variantid, cosmeticattachment, stickers, hasnvg )
{
    attachmenttoidmap = weaponattachcustomtoidmap( rootname, variantid );
    
    if ( !isdefined( attachmenttoidmap ) )
    {
        attachmenttoidmap = [];
    }
    
    if ( istrue( level.var_320be3d1af4ef493 ) && attachmenttoidmap.size > 0 )
    {
        foreach ( attachment, id in attachmenttoidmap )
        {
            if ( issubstr( attachment, "laser" ) )
            {
                attachmenttoidmap[ attachment ] = undefined;
            }
        }
    }
    
    return buildweapon_attachmentidmap( rootname, attachmenttoidmap, camo, reticle, variantid, cosmeticattachment, stickers, hasnvg );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 8
// Checksum 0x0, Offset: 0x166a
// Size: 0xbe
function buildweapon_attachmentidmap( rootname, attachmenttoidmap, camo, reticle, variantid, cosmeticattachment, stickers, hasnvg )
{
    attachments = [];
    attachmentids = [];
    
    foreach ( id in attachmenttoidmap )
    {
        attachments[ attachments.size ] = attachment;
        attachmentids[ attachmentids.size ] = id;
    }
    
    return buildweapon( rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 10
// Checksum 0x0, Offset: 0x1731
// Size: 0x408
function buildweapon( rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg, attachmenttuning )
{
    isrankedmode = level.leagueplaymatch;
    
    if ( !istrue( iskillstreakplayerweapon( rootname ) ) )
    {
        rootname = getweaponrootname( rootname );
    }
    
    if ( isminigunweapon( rootname ) )
    {
        minigunweaponobj = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845( rootname );
        return minigunweaponobj;
    }
    
    if ( isdefined( attachments ) )
    {
        assertex( isarray( attachments ), "buildWeapon() passed invalid attachment array." );
    }
    else
    {
        attachments = [];
    }
    
    if ( !isdefined( camo ) )
    {
        camo = "none";
    }
    
    if ( isdefined( variantid ) && variantid <= 0 )
    {
        variantid = undefined;
    }
    
    weaponassetname = weaponassetnamemap( rootname, variantid );
    attachmenttoidmap = buildweaponattachmentidmap( attachments, attachmentids );
    weaponobj = makeweapon( weaponassetname, [], undefined, camo, variantid );
    var_de230719cecf1c95 = buildweaponattachmenttoidmap( rootname, attachmenttoidmap, variantid, weaponassetname, attachments );
    
    if ( isdefined( cosmeticattachment ) && cosmeticattachment != "none" )
    {
        var_de230719cecf1c95[ cosmeticattachment ] = 0;
    }
    
    var_de230719cecf1c95 = filterinvalidattachmentsfromidmap( var_de230719cecf1c95, weaponassetname, weaponobj );
    
    foreach ( attachment, attachmentid in var_de230719cecf1c95 )
    {
        if ( isdefined( attachmenttuning ) && isdefined( attachmenttuning[ attachment ] ) )
        {
            weaponobj = weaponobj withattachment( attachment, attachmentid, attachmenttuning[ attachment ] );
            continue;
        }
        
        var_379ca50ca75be2a9 = 0;
        weaponassetname = weaponassetnamemap( rootname, variantid );
        attachvariants = function_55db7a4374ed4b1b( weaponassetname, attachment );
        
        foreach ( id in attachvariants )
        {
            if ( attachmentid == id )
            {
                var_379ca50ca75be2a9 = 1;
                break;
            }
        }
        
        if ( var_379ca50ca75be2a9 )
        {
            weaponobj = weaponobj withattachment( attachment, attachmentid );
            continue;
        }
        
        weaponobj = weaponobj withattachment( attachment );
    }
    
    if ( istrue( hasnvg ) )
    {
        if ( weaponsupportslaserir( weaponassetname ) && function_8a96b90526c40df6( weaponobj, attachments ) )
        {
            nvgattachment = getweaponnvgattachment( weaponobj );
            
            if ( nvgattachment != "invalid" && !isdefined( attachmenttoidmap[ nvgattachment ] ) )
            {
                weaponobj = weaponobj withattachment( nvgattachment );
            }
        }
    }
    
    if ( isdefined( variantid ) && ( !isdefined( isrankedmode ) || !istrue( isrankedmode ) || level.gametype == "br" ) )
    {
        weaponobj = weaponobj function_7e483d6e6b4b5688( variantid );
    }
    
    if ( isdefined( level.var_436bef26c1525d89 ) && isdefined( weaponobj ) )
    {
        weaponobj = self [[ level.var_436bef26c1525d89 ]]( weaponobj );
    }
    
    if ( isdefined( stickers ) )
    {
        for ( i = 0; i < stickers.size ; i++ )
        {
            stickername = stickers[ i ];
            
            if ( stickername == "none" )
            {
                continue;
            }
            
            if ( "i/" != getsubstr( stickername, 0, 2 ) )
            {
                stickername = "i/" + stickers[ i ];
            }
            
            weaponobj = weaponobj setsticker( i, stickername );
        }
    }
    
    if ( isdefined( weaponobj.scope ) && !isstartstr( weaponobj.scope, "ironsdefault" ) )
    {
        reticleindex = getreticleindex( reticle );
        
        if ( isdefined( reticleindex ) )
        {
            weaponobj = weaponobj withreticle( reticleindex );
        }
    }
    
    /#
        if ( isdefined( reticle ) && reticle != "<dev string:x1c>" )
        {
            assertex( isdefined( weaponobj.scope ), "<dev string:x21>" );
            assertex( !isstartstr( weaponobj.scope, "<dev string:x6a>" ), "<dev string:x77>" );
        }
    #/
    
    return weaponobj;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 5
// Checksum 0x0, Offset: 0x1b42
// Size: 0x345
function buildweaponattachmenttoidmap( rootname, attachmenttoidmap, variantid, weaponassetname, attachments )
{
    if ( !isdefined( attachmenttoidmap ) )
    {
        attachmenttoidmap = [];
    }
    
    attachmenttoidmap = array_remove_key( attachmenttoidmap, "none" );
    attachmenttoidmap = array_remove_key( attachmenttoidmap, "" );
    attachmentdefaulttoidmap = weaponattachdefaulttoidmap( rootname, variantid, attachments );
    
    if ( !isdefined( attachmentdefaulttoidmap ) )
    {
        attachmentdefaulttoidmap = [];
    }
    
    weaponassetname = getweaponassetname( rootname );
    basedefaultattachments = getweaponattachmentdefaultattachments( weaponassetname, attachments );
    var_234557a232185389 = [];
    var_55559af28dcac702 = [];
    
    if ( isdefined( variantid ) && variantid > 0 )
    {
        foreach ( blueprintattachments, id in attachmentdefaulttoidmap )
        {
            foreach ( baseweaponattach in basedefaultattachments )
            {
                if ( blueprintattachments == baseweaponattach )
                {
                    var_234557a232185389[ blueprintattachments ] = id;
                }
            }
            
            if ( getattachmentslot( weaponassetname, blueprintattachments ) == "other" )
            {
                if ( issubstr( blueprintattachments, "akimbo" ) )
                {
                    continue;
                }
                
                var_234557a232185389[ blueprintattachments ] = id;
            }
        }
    }
    
    if ( var_234557a232185389.size > 0 )
    {
        foreach ( defaultattach in basedefaultattachments )
        {
            var_55559af28dcac702[ defaultattach ] = 0;
        }
        
        var_234557a232185389 = combinedefaultandcustomattachmentidmaps( var_55559af28dcac702, var_234557a232185389 );
    }
    
    var_71daf4388d8cc783 = [];
    
    if ( var_234557a232185389.size > 0 )
    {
        var_71daf4388d8cc783 = combinedefaultandcustomattachmentidmaps( var_234557a232185389, attachmenttoidmap );
    }
    else if ( isdefined( attachmentdefaulttoidmap ) )
    {
        var_71daf4388d8cc783 = combinedefaultandcustomattachmentidmaps( attachmentdefaulttoidmap, attachmenttoidmap );
    }
    
    attachmentsextra = [];
    level.extraattachments = [];
    
    foreach ( attachmentid in var_71daf4388d8cc783 )
    {
        extra = attachmentmap_toextra( attachment );
        
        if ( isdefined( extra ) )
        {
            foreach ( extraattach in extra )
            {
                extravariantid = 0;
                
                if ( isdefined( variantid ) )
                {
                    extravariantid = attachmentmap_extratovariantid( extraattach, rootname, variantid, attachmentid );
                }
                else if ( attachmentid != 0 )
                {
                    extravariantid = attachmentid;
                }
                
                attachmentsextra[ extraattach ] = extravariantid;
                level.extraattachments[ level.extraattachments.size ] = extraattach;
            }
        }
    }
    
    if ( attachmentsextra.size > 0 )
    {
        var_71daf4388d8cc783 = array_combine_unique_keys( var_71daf4388d8cc783, attachmentsextra );
    }
    
    if ( var_71daf4388d8cc783.size > 0 )
    {
        var_71daf4388d8cc783 = filterattachmenttoidmap( var_71daf4388d8cc783, rootname, weaponassetname, attachmenttoidmap, attachments );
    }
    
    assertex( var_71daf4388d8cc783.size <= 14, "buildWeapon() ended up with over 14 attachments after mods and defaults were added." );
    return var_71daf4388d8cc783;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 5
// Checksum 0x0, Offset: 0x1e90
// Size: 0x3c4
function filterattachmenttoidmap( attachmenttoidmap, weaponname, weaponassetname, customattachmentarray, attachments )
{
    filtered = [];
    attachments = [];
    
    if ( isdefined( level.weaponmapdata[ weaponname ] ) && isdefined( level.weaponmapdata[ weaponname ].var_d43f9c4f6b647ba4 ) )
    {
        attachmenttoidmap = function_73948793bdd465e3( attachmenttoidmap, weaponassetname );
    }
    
    attachmenttoidmap = function_89579d7ba0194e4a( attachmenttoidmap, weaponassetname );
    slotschecked = 1;
    var_7cb73d334cb60b70 = attachmenttoidmap;
    var_12537f9ef0bc941e = customattachmentarray;
    var_f564d1d37df78cbd = getweaponattachmentdefaultattachments( weaponassetname, attachments );
    
    foreach ( customatt, id in var_12537f9ef0bc941e )
    {
        foreach ( defatt in var_f564d1d37df78cbd )
        {
            if ( customatt == defatt )
            {
                var_12537f9ef0bc941e = array_remove_key( var_12537f9ef0bc941e, customatt );
            }
        }
    }
    
    foreach ( customatt, id1 in var_12537f9ef0bc941e )
    {
        foreach ( combinedatt, id2 in attachmenttoidmap )
        {
            if ( customatt == combinedatt )
            {
                continue;
            }
            
            conflictstring = attachmentsconflict( combinedatt, customatt, weaponname, slotschecked );
            
            if ( conflictstring == customatt )
            {
                var_7cb73d334cb60b70 = array_remove_key( var_7cb73d334cb60b70, combinedatt );
            }
        }
    }
    
    attachmenttoidmap = var_7cb73d334cb60b70;
    attachmentkey = getfirstarraykey( attachmenttoidmap );
    assertex( isdefined( attachmentkey ), "attachmentToIdMap has no elements, possible error while reading table" );
    attachments[ 0 ] = attachmentkey;
    
    for ( attachmentindex = 0; attachmentindex < attachments.size ; attachmentindex++ )
    {
        attachment = attachments[ attachmentindex ];
        
        if ( attachment != "none" )
        {
            add = 1;
            
            for ( filteredindex = 0; filteredindex < filtered.size ; filteredindex++ )
            {
                filtereditem = filtered[ filteredindex ];
                
                if ( filtereditem == "" )
                {
                    continue;
                }
                
                if ( attachment == filtereditem )
                {
                    add = 0;
                    break;
                }
                
                conflictstring = attachmentsconflict( attachment, filtereditem, weaponname, slotschecked );
                
                if ( conflictstring == attachment )
                {
                    filtered[ filteredindex ] = "";
                    continue;
                }
                
                if ( conflictstring != "" )
                {
                    filtered[ filteredindex ] = "";
                    add = 0;
                    conflictresults = [];
                    conflictresults = strtok( conflictstring, " " );
                    
                    for ( conflictidx = 0; conflictidx < conflictresults.size ; conflictidx++ )
                    {
                        attachments[ attachments.size ] = conflictresults[ conflictidx ];
                    }
                    
                    break;
                }
            }
            
            if ( add )
            {
                filteredsize = filtered.size;
                filtered[ filteredsize ] = attachment;
            }
        }
        
        if ( attachmentindex == attachments.size - 1 )
        {
            attachmentkey = getnextarraykey( attachmenttoidmap, attachmentkey );
            
            if ( isdefined( attachmentkey ) )
            {
                attachments[ attachments.size ] = attachmentkey;
            }
        }
    }
    
    attachmenttoidmapupdated = [];
    
    for ( attachmentindex = 0; attachmentindex < filtered.size ; attachmentindex++ )
    {
        attachment = filtered[ attachmentindex ];
        
        if ( attachment != "" )
        {
            attachmentid = ter_op( isdefined( attachmenttoidmap[ attachment ] ), attachmenttoidmap[ attachment ], 0 );
            attachmenttoidmapupdated[ attachment ] = attachmentid;
        }
    }
    
    return attachmenttoidmapupdated;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 3
// Checksum 0x0, Offset: 0x225d
// Size: 0x25a
function function_89579d7ba0194e4a( attachmenttoidmap, weaponname, weaponassetname )
{
    filtered = [];
    attachments = [];
    attachmentkey = getfirstarraykey( attachmenttoidmap );
    assertex( isdefined( attachmentkey ), "attachmentToIdMap has no elements, possible error while reading table" );
    attachments[ 0 ] = attachmentkey;
    defaultattachmentsarray = [];
    
    if ( isdefined( weaponname ) )
    {
        defaultattachmentsarray = getweapondefaultattachments( weaponname );
    }
    
    for ( attachmentindex = 0; attachmentindex < attachments.size ; attachmentindex++ )
    {
        attachment = attachments[ attachmentindex ];
        
        if ( attachment != "none" )
        {
            add = 1;
            
            for ( filteredindex = 0; filteredindex < filtered.size ; filteredindex++ )
            {
                filtereditem = filtered[ filteredindex ];
                
                if ( filtereditem == "" )
                {
                    continue;
                }
                
                if ( attachment == filtereditem )
                {
                    add = 0;
                    break;
                }
                
                conflictstring = function_b9f9c92ef7f1922b( attachment, filtereditem, weaponname );
                
                if ( conflictstring == attachment )
                {
                    if ( isdefined( level.extraattachments ) && array_contains( level.extraattachments, conflictstring ) )
                    {
                        if ( array_contains( defaultattachmentsarray, filtereditem ) )
                        {
                            conflictstring = filtereditem;
                        }
                        else
                        {
                            filtered[ filteredindex ] = "";
                        }
                    }
                    else
                    {
                        filtered[ filteredindex ] = "";
                    }
                    
                    continue;
                }
                
                if ( conflictstring != "" )
                {
                    filtered[ filteredindex ] = "";
                    add = 0;
                    conflictresults = [];
                    conflictresults = strtok( conflictstring, " " );
                    
                    for ( conflictidx = 0; conflictidx < conflictresults.size ; conflictidx++ )
                    {
                        attachments[ attachments.size ] = conflictresults[ conflictidx ];
                    }
                    
                    break;
                }
            }
            
            if ( add )
            {
                filteredsize = filtered.size;
                filtered[ filteredsize ] = attachment;
            }
        }
        
        if ( attachmentindex == attachments.size - 1 )
        {
            attachmentkey = getnextarraykey( attachmenttoidmap, attachmentkey );
            
            if ( isdefined( attachmentkey ) )
            {
                attachments[ attachments.size ] = attachmentkey;
            }
        }
    }
    
    level.extraattachments = undefined;
    attachmenttoidmapupdated = [];
    
    for ( attachmentindex = 0; attachmentindex < filtered.size ; attachmentindex++ )
    {
        attachment = filtered[ attachmentindex ];
        
        if ( attachment != "" )
        {
            attachmentid = ter_op( isdefined( attachmenttoidmap[ attachment ] ), attachmenttoidmap[ attachment ], 0 );
            attachmenttoidmapupdated[ attachment ] = attachmentid;
        }
    }
    
    return attachmenttoidmapupdated;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x24c0
// Size: 0x484
function function_73948793bdd465e3( attachmenttoidmap, weaponassetname )
{
    attachmentkey = getfirstarraykey( attachmenttoidmap );
    assertex( isdefined( attachmentkey ), "attachmentToIdMap has no elements, possible error while reading table" );
    attachments[ 0 ] = attachmentkey;
    var_13f5ce59fee67e25 = "";
    priorityattach = "";
    var_b93f2890063ccf4e = 0;
    basenamefound = 0;
    var_7002135dc405cb0 = [];
    var_d5d1e39edb18d983 = 0;
    
    for ( attachmentindex = 0; attachmentindex < attachments.size ; attachmentindex++ )
    {
        attachment = attachments[ attachmentindex ];
        tempbasename = getattachmentbasename( weaponassetname, attachments[ attachmentindex ] );
        
        if ( tempbasename != "" )
        {
            basenamefound = 1;
        }
        
        if ( attachmentindex == attachments.size - 1 )
        {
            attachmentkey = getnextarraykey( attachmenttoidmap, attachmentkey );
            
            if ( isdefined( attachmentkey ) )
            {
                attachments[ attachments.size ] = attachmentkey;
            }
        }
    }
    
    if ( !basenamefound )
    {
        return attachmenttoidmap;
    }
    
    foreach ( id, a in attachments )
    {
        for ( counter = attachments.size; counter > id + 1 ; counter-- )
        {
            conflictstring = attachmentsconflict( a, attachments[ counter - 1 ], weaponassetname );
            
            if ( conflictstring == attachments[ counter - 1 ] )
            {
                conflictstringslot = getattachmentslot( weaponassetname, conflictstring );
                aslot = getattachmentslot( weaponassetname, a );
                
                if ( conflictstringslot == aslot )
                {
                    attachments[ id ] = conflictstring;
                    break;
                }
                else
                {
                    var_13f5ce59fee67e25 = a;
                    priorityattach = conflictstring;
                    var_d5d1e39edb18d983 = 1;
                }
            }
            else if ( conflictstring == a )
            {
                var_13f5ce59fee67e25 = attachments[ counter - 1 ];
                priorityattach = conflictstring;
                var_d5d1e39edb18d983 = 1;
            }
            
            if ( var_d5d1e39edb18d983 )
            {
                attachbasename = getattachmentbasename( weaponassetname, var_13f5ce59fee67e25 );
                oldattachslot = getattachmentslot( weaponassetname, var_13f5ce59fee67e25 );
                
                if ( attachbasename != "" )
                {
                    var_feaa04125d5c7ab2 = function_fa689aee146fbcf9( weaponassetname, attachbasename );
                    
                    foreach ( var_8f99d80bac78db05 in var_feaa04125d5c7ab2 )
                    {
                        var_7f067bf518e3b85f = attachmentsconflict( var_8f99d80bac78db05, priorityattach, weaponassetname );
                        
                        if ( var_7f067bf518e3b85f == priorityattach )
                        {
                            continue;
                        }
                        
                        if ( var_7f067bf518e3b85f == var_13f5ce59fee67e25 )
                        {
                            continue;
                        }
                        
                        newattachslot = getattachmentslot( weaponassetname, var_8f99d80bac78db05 );
                        
                        if ( oldattachslot == newattachslot )
                        {
                            foreach ( a2 in attachments )
                            {
                                if ( a2 == var_13f5ce59fee67e25 )
                                {
                                    var_b93f2890063ccf4e = id2;
                                }
                            }
                            
                            attachments[ var_b93f2890063ccf4e ] = var_8f99d80bac78db05;
                            var_7002135dc405cb0[ var_7002135dc405cb0.size ] = var_8f99d80bac78db05;
                            var_d5d1e39edb18d983 = 0;
                            break;
                        }
                        
                        var_d5d1e39edb18d983 = 0;
                    }
                }
            }
        }
    }
    
    attachmenttoidmapupdated = [];
    
    for ( attachmentindex = 0; attachmentindex < attachments.size ; attachmentindex++ )
    {
        var_74903b21bc06dfd7 = 0;
        attachment = attachments[ attachmentindex ];
        
        if ( attachment != "" )
        {
            foreach ( a, id in attachmenttoidmap )
            {
                foreach ( atwo in var_7002135dc405cb0 )
                {
                    if ( attachment == atwo )
                    {
                        attachmenttoidmapslot = getattachmentslot( weaponassetname, a );
                        var_df4becef128f8f21 = getattachmentslot( weaponassetname, atwo );
                        
                        if ( attachmenttoidmapslot == var_df4becef128f8f21 )
                        {
                            if ( id > 0 )
                            {
                                attachvariants = function_55db7a4374ed4b1b( weaponassetname, attachment );
                                
                                if ( attachvariants.size > 0 )
                                {
                                    attachmenttoidmapupdated[ attachment ] = id;
                                    var_74903b21bc06dfd7 = 1;
                                    break;
                                }
                                
                                break;
                            }
                        }
                    }
                }
            }
            
            if ( !var_74903b21bc06dfd7 )
            {
                attachmentid = ter_op( isdefined( attachmenttoidmap[ attachment ] ), attachmenttoidmap[ attachment ], 0 );
                attachmenttoidmapupdated[ attachment ] = attachmentid;
            }
        }
    }
    
    return attachmenttoidmapupdated;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 4
// Checksum 0x0, Offset: 0x294d
// Size: 0x18d
function attachmentsconflict( attachment1, attachment2, weapon, slotschecked )
{
    assertex( isdefined( weapon ), "attachmentsConflict() passed undefined weapon" );
    assertex( isdefined( attachment1 ) && isdefined( attachment1 ), "attachmentsConflict() passed undefined attachment" );
    
    if ( attachmentiscosmetic( attachment1 ) && attachmentiscosmetic( attachment2 ) )
    {
        return attachment1;
    }
    
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = getcompleteweaponname( weapon );
    }
    else
    {
        weaponname = weapon;
    }
    
    if ( iskillstreakweapon( weapon ) )
    {
        weaponasset = weapon;
    }
    else
    {
        rootname = getweaponrootname( weapon );
        weaponasset = weaponassetnamemap( rootname );
    }
    
    if ( !istrue( slotschecked ) )
    {
        attachment1slot = getattachmentslot( weaponasset, attachment1 );
        attachment2slot = getattachmentslot( weaponasset, attachment2 );
        
        if ( attachment1slot == attachment2slot && attachment1slot != "other" )
        {
            attach1priority = getattachmentslotpriority( weaponasset, attachment1 );
            attach2priority = getattachmentslotpriority( weaponasset, attachment2 );
            
            if ( attach1priority >= attach2priority )
            {
                return attachment1;
            }
            else
            {
                return attachment2;
            }
        }
    }
    
    var_27ccfb6c99bba30d = _attachmentblocks( weaponasset, attachment1, attachment2 );
    var_b7b0b0d582725413 = _attachmentblocks( weaponasset, attachment2, attachment1 );
    
    if ( var_27ccfb6c99bba30d && var_b7b0b0d582725413 )
    {
        return attachment1;
    }
    else if ( var_27ccfb6c99bba30d )
    {
        return attachment1;
    }
    else if ( var_b7b0b0d582725413 )
    {
        return attachment2;
    }
    
    return "";
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 4
// Checksum 0x0, Offset: 0x2ae3
// Size: 0x134
function function_b9f9c92ef7f1922b( attachment1, attachment2, weapon, var_85cf583664cf2b09 )
{
    assertex( isdefined( weapon ), "attachmentsConflict() passed undefined weapon" );
    assertex( isdefined( attachment1 ) && isdefined( attachment1 ), "attachmentsConflict() passed undefined attachment" );
    
    if ( attachmentiscosmetic( attachment1 ) && attachmentiscosmetic( attachment2 ) )
    {
        return attachment1;
    }
    
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = getcompleteweaponname( weapon );
    }
    else
    {
        weaponname = weapon;
    }
    
    if ( iskillstreakweapon( weapon ) )
    {
        weaponasset = weapon;
    }
    else
    {
        rootname = getweaponrootname( weapon );
        weaponasset = weaponassetnamemap( rootname );
    }
    
    attachment1slot = getattachmentslot( weaponasset, attachment1 );
    attachment2slot = getattachmentslot( weaponasset, attachment2 );
    
    if ( attachment1slot == attachment2slot && attachment1slot != "other" )
    {
        attach1priority = getattachmentslotpriority( weaponasset, attachment1 );
        attach2priority = getattachmentslotpriority( weaponasset, attachment2 );
        
        if ( attach1priority >= attach2priority )
        {
            return attachment1;
        }
        else
        {
            return attachment2;
        }
    }
    
    return "";
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2c20
// Size: 0x190, Type: bool
function private _attachmentblocks( weaponasset, attachment1, attachment2 )
{
    var_1fce8439ed13e7b3 = getattachmentbasetypesblocked( weaponasset, attachment1 );
    var_b28653df677fb727 = getattachmentbasetype( weaponasset, attachment2 );
    attachmentsblocked = getattachmentsblocked( weaponasset, attachment1 );
    
    foreach ( basetype in var_1fce8439ed13e7b3 )
    {
        if ( basetype == var_b28653df677fb727 )
        {
            return true;
        }
    }
    
    attachment1slot = getattachmentslot( weaponasset, attachment1 );
    attachment2slot = getattachmentslot( weaponasset, attachment2 );
    
    if ( attachment1slot == attachment2slot && attachment1slot != "other" )
    {
        return true;
    }
    
    slotsblocked = getattachmentslotsblocked( weaponasset, attachment1 );
    
    foreach ( slot in slotsblocked )
    {
        if ( slot == attachment2slot )
        {
            return true;
        }
    }
    
    foreach ( attachment in attachmentsblocked )
    {
        if ( attachment == attachment2 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x2db9
// Size: 0x16
function isattachmentironsdefault( attachment )
{
    return issubstr( attachment, "ironsdefault_" );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x2dd8
// Size: 0x25, Type: bool
function function_de04e13ab01e1a10( attachment )
{
    return issubstr( attachment, "ubshtgn" ) || issubstr( attachment, "ub_sh" );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x2e06
// Size: 0x3f
function attachmentmap_tocategory( attachmentname )
{
    assertex( isdefined( level.var_f83e21209be1b993 ), "attachmentMap_toCategory() called without first calling buildAttachmentMaps()" );
    
    if ( isdefined( level.var_f83e21209be1b993[ attachmentname ] ) )
    {
        return level.var_f83e21209be1b993[ attachmentname ];
    }
    
    return undefined;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x2e4e
// Size: 0xdd
function attachmentmap_toextra( attachmentname )
{
    assertex( isdefined( level.var_50611d6541b815a3 ), "attachmentMap_toExtra() called without first calling buildAttachmentMaps()" );
    
    if ( isdefined( level.var_50611d6541b815a3[ attachmentname ] ) )
    {
        extraattachments = [];
        extraattachmentlist = level.var_50611d6541b815a3[ attachmentname ];
        
        foreach ( entry in extraattachmentlist )
        {
            if ( !isdefined( entry.attachmentextra ) || entry.attachmentextra == "" )
            {
                continue;
            }
            
            extraattachments[ entry.attachmentextra ] = entry.attachmentextra;
        }
        
        return extraattachments;
    }
    
    return undefined;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x2f33
// Size: 0x2d
function attachmentperkmap( weapon, attachmentname )
{
    attachperks = function_4f344ec5b7c45a3f( weapon, attachmentname );
    
    if ( isdefined( attachperks ) )
    {
        return attachperks;
    }
    
    return undefined;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 0
// Checksum 0x0, Offset: 0x2f69
// Size: 0x2d5
function buildattachmentmaps()
{
    assertex( !isdefined( level.var_50611d6541b815a3 ), "buildAttachmentMaps() called when base to extra map already existed." );
    assertex( !isdefined( level.weaponattachments ), "buildAttachmentMaps() called when weapon attachment list already existed." );
    assertex( !isdefined( level.weaponattachmentsmap ), "buildAttachmentMaps() called when weapon attachment map list already existed." );
    assertex( isdefined( level.weaponmapdata ), "buildWeaponMap() should be called before buildAttachmentMaps()" );
    level.var_50611d6541b815a3 = [];
    level.weaponattachments = [];
    function_c471a035d22df5eb();
    slotarray = [];
    
    foreach ( slot in level.attachmentslotarray )
    {
        if ( slot == "visual" )
        {
            continue;
        }
        
        slotarray[ slotarray.size ] = slot;
    }
    
    foreach ( weaponnamekey in level.weaponmapdata )
    {
        if ( isdefined( weaponnamekey.assetname ) && isdefined( weaponnamekey.group ) )
        {
            foreach ( slot in slotarray )
            {
                var_63a235c3e361a6c3 = function_75b035199842693d( weaponnamekey.assetname, slot, 1 );
                
                if ( isdefined( var_63a235c3e361a6c3 ) )
                {
                    foreach ( attachment in var_63a235c3e361a6c3 )
                    {
                        attachmentdataname = function_d3831c58b9d05ac2( weaponnamekey.assetname, attachment );
                        
                        if ( isdefined( attachmentdataname ) )
                        {
                            lootid = getscriptbundlefieldvalue( attachmentdataname, #"lootid" );
                            category = getscriptbundlefieldvalue( attachmentdataname, #"category" );
                            var_903ba58b5abb6cc2 = getscriptbundlefieldvalue( attachmentdataname, #"hash_febd8701371cdffe" );
                            
                            if ( isdefined( lootid ) )
                            {
                                if ( isdefined( level.weaponattachments[ attachment ] ) )
                                {
                                    continue;
                                }
                                
                                if ( isdefined( var_903ba58b5abb6cc2 ) && var_903ba58b5abb6cc2.size > 0 )
                                {
                                    if ( !isdefined( level.var_50611d6541b815a3[ attachment ] ) )
                                    {
                                        level.var_50611d6541b815a3[ attachment ] = var_903ba58b5abb6cc2;
                                    }
                                }
                                
                                if ( isdefined( category ) && category != "NONE" && !isdefined( level.weaponattachments[ attachment ] ) )
                                {
                                    level.weaponattachments[ attachment ] = lootid;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x3246
// Size: 0x183
function weaponattachremoveextraattachments( attachments )
{
    assertex( isdefined( level.var_50611d6541b815a3 ), "weaponAttachRemoveExtraAttachments() called without first calling buildWeaponMap()." );
    extraattachmentlist = [];
    
    foreach ( attachment in attachments )
    {
        var_f08eec5e41ed914f = attachmentmap_toextra( attachment );
        
        if ( isdefined( var_f08eec5e41ed914f ) )
        {
            extraattachmentlist[ extraattachmentlist.size ] = var_f08eec5e41ed914f;
        }
    }
    
    attachmentsfiltered = [];
    
    foreach ( attachment in attachments )
    {
        isextraattachment = 0;
        
        foreach ( extraattachments in extraattachmentlist )
        {
            foreach ( extraattach in extraattachments )
            {
                if ( attachment == extraattach )
                {
                    isextraattachment = 1;
                    break;
                }
            }
        }
        
        if ( !isextraattachment )
        {
            attachmentsfiltered[ attachmentsfiltered.size ] = attachment;
        }
    }
    
    return attachmentsfiltered;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x33d2
// Size: 0x35
function getattachmentlootid( weaponname, attachref )
{
    if ( isdefined( level.weaponattachments[ attachref ] ) )
    {
        return level.weaponattachments[ attachref ];
    }
    
    return scripts\cp_mp\utility\loot::getlootidfromref( attachref );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 0
// Checksum 0x0, Offset: 0x3410
// Size: 0x9f
function buildweaponrootlist()
{
    rootweapons = [];
    
    foreach ( data in level.weaponmapdata )
    {
        if ( isdefined( data.group ) )
        {
            if ( !issubstr( data.group, "weapon_" ) )
            {
                continue;
            }
            
            if ( data.group == "weapon_other" )
            {
                continue;
            }
            
            rootweapons[ rootweapons.size ] = weapon;
        }
    }
    
    return rootweapons;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x34b8
// Size: 0xf9
function weaponattachcustomtoidmap( weaponroot, variantid )
{
    assertex( isdefined( level.weaponmapdata ), "weaponAttachCustomToIDMap() called without first calling buildWeaponMap()." );
    assertex( isdefined( variantid ), "weaponAttachCustomToIDMap() called without a variantID. Only blueprint weapons have custom attachments." );
    
    if ( isdefined( variantid ) && variantid >= 0 )
    {
        weaponvariantkey = weaponroot + "|" + variantid;
        
        if ( getdvar( @"iw9_blueprints", "1" ) == "1" )
        {
            if ( isdefined( level.weaponlootmapdata[ weaponvariantkey ] ) && isdefined( level.weaponlootmapdata[ weaponvariantkey ].attachdefaulttoidmap ) )
            {
                return level.weaponlootmapdata[ weaponvariantkey ].attachdefaulttoidmap;
            }
        }
        else if ( isdefined( level.weaponlootmapdata[ weaponvariantkey ] ) && isdefined( level.weaponlootmapdata[ weaponvariantkey ].attachcustomtoidmap ) )
        {
            return level.weaponlootmapdata[ weaponvariantkey ].attachcustomtoidmap;
        }
    }
    
    return undefined;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 3
// Checksum 0x0, Offset: 0x35ba
// Size: 0xa6
function weaponattachdefaulttoidmap( weaponroot, variantid, attachments )
{
    assertex( isdefined( level.weaponmapdata ), "weaponAttachDefaultToIDMap() called without first calling buildWeaponMap()." );
    
    if ( isdefined( variantid ) )
    {
        weaponvariantkey = weaponroot + "|" + variantid;
        
        if ( isdefined( level.weaponlootmapdata[ weaponvariantkey ] ) && isdefined( level.weaponlootmapdata[ weaponvariantkey ].attachdefaulttoidmap ) )
        {
            return level.weaponlootmapdata[ weaponvariantkey ].attachdefaulttoidmap;
        }
    }
    
    attachdefaulttoidmap = getbaseweaponattachdefaulttoidmap( weaponroot, attachments );
    
    if ( isdefined( attachdefaulttoidmap ) )
    {
        return attachdefaulttoidmap;
    }
    
    return undefined;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x3669
// Size: 0xc7
function weaponassetnamemap( weaponroot, variantid )
{
    if ( iskillstreakweapon( weaponroot ) )
    {
        return weaponroot;
    }
    
    if ( isdefined( variantid ) )
    {
        var_b40b03d6bdc699b3 = weaponroot + "|" + variantid;
        
        if ( isdefined( level.weaponlootmapdata[ var_b40b03d6bdc699b3 ] ) && isdefined( level.weaponlootmapdata[ var_b40b03d6bdc699b3 ].assetoverridename ) )
        {
            return level.weaponlootmapdata[ var_b40b03d6bdc699b3 ].assetoverridename;
        }
    }
    
    if ( isdefined( level.weaponmapdata[ weaponroot ] ) && isdefined( level.weaponmapdata[ weaponroot ].assetname ) )
    {
        return level.weaponmapdata[ weaponroot ].assetname;
    }
    
    assertmsg( "weaponAssetNameMap() could not find an asset name for weapon " + weaponroot );
    return weaponroot;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x3739
// Size: 0x63
function weapongroupmap( weaponroot )
{
    assertex( isdefined( level.weaponmapdata ), "weaponGroupMap() called without first calling buildWeaponMap()." );
    
    if ( isdefined( level.weaponmapdata[ weaponroot ] ) && isdefined( level.weaponmapdata[ weaponroot ].group ) )
    {
        return level.weaponmapdata[ weaponroot ].group;
    }
    
    return undefined;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x37a5
// Size: 0x2f, Type: bool
function function_89497fa763d431c0( weaponroot )
{
    assertex( isdefined( level.weaponmapdata ), "weaponNumberMap() called without first calling buildWeaponMap()." );
    return isdefined( level.weaponmapdata[ weaponroot ] );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 4
// Checksum 0x0, Offset: 0x37dd
// Size: 0x66
function attachmentmap_extratovariantid( attachment, weaponroot, weaponvariantid, attachmentid )
{
    assertex( isdefined( weaponvariantid ), "" );
    var_b40b03d6bdc699b3 = weaponroot + "|" + weaponvariantid;
    
    if ( isdefined( level.weaponlootmapdata[ var_b40b03d6bdc699b3 ] ) && isdefined( attachmentid ) && attachmentid > 0 )
    {
        return attachmentid;
    }
    
    return 0;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 0
// Checksum 0x0, Offset: 0x384c
// Size: 0x6d6
function buildweaponmap()
{
    assertex( !isdefined( level.weaponmapdata ), "buildWeaponMap() called when map already existed." );
    level.weaponmapdata = [];
    level.weapongroupdata = [];
    level.weaponlootmapdata = [];
    weaponsscriptbundle = scripts\cp_mp\weapon::function_a221d76594ef4e8b();
    
    if ( isdefined( weaponsscriptbundle ) )
    {
        foreach ( weaponname in weaponsscriptbundle )
        {
            weaponscriptbundle = scripts\cp_mp\weapon::function_8477d8595e0364a7( weaponname, [ #"ref", #"group", #"displayorder", #"asset", #"name", #"perk", #"speedscale", #"hash_1469d2b702a6d5f8", #"lootid", #"botpersonality", #"isactivearmory" ] );
            weapon = weaponscriptbundle.ref;
            weapon_asset = weaponscriptbundle.asset;
            
            if ( weapon != "" && weaponexists( weapon_asset ) && !isnullweapon( makeweaponfromstring( weapon_asset ) ) )
            {
                level.weaponmapdata[ weapon ] = spawnstruct();
                group = weaponscriptbundle.group;
                
                if ( isdefined( group ) && group != "" )
                {
                    level.weaponmapdata[ weapon ].group = group;
                    uidisplayorder = default_to( weaponscriptbundle.displayorder, 0 );
                    
                    if ( isdefined( uidisplayorder ) && uidisplayorder > -1 )
                    {
                        if ( !isdefined( level.weapongroupdata[ group ] ) )
                        {
                            level.weapongroupdata[ group ] = [];
                        }
                        
                        level.weapongroupdata[ group ][ level.weapongroupdata[ group ].size ] = weapon;
                    }
                    else
                    {
                        level.weaponmapdata[ weapon ].uihidden = 1;
                    }
                }
                
                assetname = weaponscriptbundle.asset;
                
                if ( isdefined( assetname ) && assetname != "" )
                {
                    level.weaponmapdata[ weapon ].assetname = assetname;
                }
                
                locname = weaponscriptbundle.name;
                
                if ( isdefined( locname ) && locname != &"" )
                {
                    level.weaponmapdata[ weapon ].locname = locname;
                }
                
                perk = weaponscriptbundle.perk;
                
                if ( isdefined( perk ) && perk != "" )
                {
                    level.weaponmapdata[ weapon ].perk = perk;
                }
                
                level.weaponmapdata[ weapon ].weaponlootid = weaponscriptbundle.lootid;
                movespeed = weaponscriptbundle.speedscale;
                
                if ( isdefined( movespeed ) )
                {
                    level.weaponmapdata[ weapon ].speed = movespeed;
                    assertex( isdefined( movespeed ) && movespeed > 0 && movespeed <= 1, "buildWeaponMap() found invalid movespeed for weapon: " + weapon );
                }
                
                var_d43f9c4f6b647ba4 = weaponscriptbundle.var_d43f9c4f6b647ba4;
                
                if ( isdefined( var_d43f9c4f6b647ba4 ) )
                {
                    level.weaponmapdata[ weapon ].var_d43f9c4f6b647ba4 = var_d43f9c4f6b647ba4;
                }
                
                botpersonalities = weaponscriptbundle.botpersonality;
                
                if ( isdefined( botpersonalities ) )
                {
                    level.weaponmapdata[ weapon ].botpersonalities = strtok( botpersonalities, "|" );
                }
                
                activearmoryenabled = weaponscriptbundle.isactivearmory;
                
                if ( isdefined( activearmoryenabled ) )
                {
                    level.weaponmapdata[ weapon ].activearmoryenabled = activearmoryenabled;
                }
                
                if ( isequipmentaddon( weapon ) )
                {
                    level.weaponmapdata[ weapon ].isequipmentaddon = 1;
                }
                
                if ( isdefined( level.weaponmapdata[ weapon ].group ) && ( !isdefined( level.weaponmapdata[ weapon ].uihidden ) || isdefined( level.gametype ) && level.gametype == "br" ) || isdefined( level.weaponmapdata[ weapon ] ) && istrue( level.weaponmapdata[ weapon ].isequipmentaddon ) )
                {
                    svariantid = 0;
                    weaponvariantkey = weapon + "|" + svariantid;
                    level.weaponlootmapdata[ weaponvariantkey ] = spawnstruct();
                    level.weaponlootmapdata[ weaponvariantkey ].variantid = svariantid;
                    level.weaponlootmapdata[ weaponvariantkey ].lootid = weaponscriptbundle.lootid;
                    attachdefaulttoidmap = getbaseweaponattachdefaulttoidmap( weapon );
                    
                    if ( isdefined( attachdefaulttoidmap ) )
                    {
                        level.weaponlootmapdata[ weaponvariantkey ].attachdefaulttoidmap = attachdefaulttoidmap;
                    }
                    
                    weaponblueprints = getweaponblueprintnames( level.weaponmapdata[ weapon ].assetname );
                    
                    if ( isdefined( weaponblueprints ) )
                    {
                        foreach ( weaponvariant, weaponvariantid in weaponblueprints )
                        {
                            weaponvariantkey = weapon + "|" + weaponvariantid;
                            level.weaponlootmapdata[ weaponvariantkey ] = spawnstruct();
                            level.weaponlootmapdata[ weaponvariantkey ].variantid = weaponvariantid;
                            blueprintbundle = function_332b73d2eca8c367( level.weaponmapdata[ weapon ].assetname, weaponvariant );
                            level.weaponlootmapdata[ weaponvariantkey ].lootid = blueprintbundle.lootid;
                            level.weaponlootmapdata[ weaponvariantkey ].weaponcooldown = blueprintbundle.var_2da3d71eb40ea685;
                            attachdefaulttoidmap = function_3211981142ec5aee( level.weaponmapdata[ weapon ].assetname, weaponvariant );
                            
                            if ( isdefined( attachdefaulttoidmap ) )
                            {
                                level.weaponlootmapdata[ weaponvariantkey ].attachdefaulttoidmap = attachdefaulttoidmap;
                            }
                        }
                    }
                }
            }
        }
    }
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 0
// Checksum 0x0, Offset: 0x3f2a
// Size: 0x282
function function_ee4a536a155313b7()
{
    assertex( !isdefined( level.weaponmappedcamos ), "buildProgressionCamosMap() called when map already existed." );
    level.weaponmappedcamos = [];
    camolistbundle = getscriptbundle( hashcat( %"hash_752ed0204d7db62c", level.gamemodebundle.weaponcamolist ) );
    
    foreach ( camoname in camolistbundle.camo_list )
    {
        if ( !isdefined( camoname.camodata ) )
        {
            continue;
        }
        
        category = getscriptbundlefieldvalue( hashcat( %"hash_1345cc24140e89b8", camoname.camodata ), #"camocategory" );
        
        if ( isdefined( category ) && category == "camo_category_completion" )
        {
            camoref = getscriptbundlefieldvalue( hashcat( %"hash_1345cc24140e89b8", camoname.camodata ), #"ref" );
            weaponref = getscriptbundlefieldvalue( hashcat( %"hash_1345cc24140e89b8", camoname.camodata ), #"weaponref" );
            lootid = getscriptbundlefieldvalue( hashcat( %"hash_1345cc24140e89b8", camoname.camodata ), #"lootid" );
            
            if ( isdefined( weaponref ) )
            {
                if ( !isdefined( level.weaponmappedcamos[ weaponref ] ) )
                {
                    level.weaponmappedcamos[ weaponref ] = [];
                }
                
                level.weaponmappedcamos[ weaponref ][ camoref ] = lootid;
            }
            
            continue;
        }
        
        if ( isdefined( category ) && category == "camo_category_events" )
        {
            camoref = getscriptbundlefieldvalue( hashcat( %"hash_1345cc24140e89b8", camoname.camodata ), #"ref" );
            weaponclass = getscriptbundlefieldvalue( hashcat( %"hash_1345cc24140e89b8", camoname.camodata ), #"weaponclass" );
            lootid = getscriptbundlefieldvalue( hashcat( %"hash_1345cc24140e89b8", camoname.camodata ), #"lootid" );
            
            if ( isdefined( weaponclass ) )
            {
                if ( !isdefined( level.weaponmappedcamos[ weaponclass ] ) )
                {
                    level.weaponmappedcamos[ weaponclass ] = [];
                }
                
                level.weaponmappedcamos[ weaponclass ][ camoref ] = lootid;
            }
        }
    }
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x41b4
// Size: 0x61
function getweaponvarianttablename( weaponrootname )
{
    if ( string_starts_with( weaponrootname, "jup_" ) || string_starts_with( weaponrootname, "iw8_" ) || string_starts_with( weaponrootname, "iw9_" ) || string_starts_with( weaponrootname, "t10_" ) )
    {
        weaponrootname = getsubstr( weaponrootname, 4 );
    }
    
    return "mp/gunsmith/" + weaponrootname + "_variants.csv";
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x421e
// Size: 0x7f
function getweaponattachmentdefaultattachments( weaponassetname, attachments )
{
    if ( isdefined( attachments ) )
    {
        sortedattachments = alphabetize( attachments );
        
        for ( attachmentindex = 0; attachmentindex < sortedattachments.size ; attachmentindex++ )
        {
            attachment = sortedattachments[ attachmentindex ];
            
            if ( attachment != "none" && ( attachmentindex == 0 || attachment != sortedattachments[ attachmentindex - 1 ] ) )
            {
                weaponassetname = weaponassetname + "+" + attachment;
            }
        }
    }
    
    return getweapondefaultattachments( weaponassetname );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x42a6
// Size: 0xa5
function getbaseweaponattachdefaulttoidmap( weapon, attachments )
{
    assetname = getweaponassetname( weapon );
    
    if ( !isdefined( assetname ) )
    {
        assetname = weapon;
    }
    
    defaultattachments = getweaponattachmentdefaultattachments( assetname, attachments );
    
    if ( isdefined( defaultattachments ) && defaultattachments.size > 0 )
    {
        defaulttoidmap = [];
        
        foreach ( defaultattachment in defaultattachments )
        {
            defaulttoidmap[ defaultattachment ] = 0;
        }
        
        return defaulttoidmap;
    }
    
    return undefined;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x4354
// Size: 0xb4
function parseattachdefaulttoidmap( attachmentdefaults )
{
    if ( attachmentdefaults != "" )
    {
        defaultkvps = strtok( attachmentdefaults, " " );
        defaulttoidmap = [];
        
        foreach ( kvp in defaultkvps )
        {
            pair = strtok( kvp, "|" );
            
            if ( pair.size == 2 )
            {
                defaulttoidmap[ pair[ 0 ] ] = int( pair[ 1 ] );
                continue;
            }
            
            defaulttoidmap[ pair[ 0 ] ] = 0;
        }
        
        return defaulttoidmap;
    }
    
    return undefined;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x4411
// Size: 0x4b
function getweaponassetname( rootname )
{
    if ( isdefined( level.weaponmapdata[ rootname ] ) && isdefined( level.weaponmapdata[ rootname ].assetname ) )
    {
        return level.weaponmapdata[ rootname ].assetname;
    }
    
    return undefined;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x4465
// Size: 0x2d7
function getweaponrootname( weapon )
{
    if ( !isdefined( level.weaponrootcache ) )
    {
        level.weaponrootcache = [];
    }
    
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        assert( isstring( weapon ) );
        weaponname = weapon;
    }
    
    cachedvalue = level.weaponrootcache[ weaponname ];
    
    if ( isdefined( cachedvalue ) )
    {
        return cachedvalue;
    }
    
    if ( !isdefined( weaponname ) )
    {
        weaponname = "";
    }
    
    if ( weaponname == "iw9_lm_dblmg_jup_sp_v1" || weaponname == "iw9_lm_dblmg_jup_mp" | weaponname == "iw9_lm_dblmg_jup" )
    {
        return "iw9_lm_dblmg_jup";
    }
    
    originalname = weaponname;
    
    if ( originalname == "jup_pi_raygun_mp" || originalname == "jup_pi_raygun" )
    {
        weaponname = "jup_pi_raygun";
    }
    else
    {
        tokens = strtok( weaponname, "_" );
        index = 0;
        
        if ( tokens[ 0 ] == "alt" )
        {
            index++;
        }
        
        if ( tokens[ index ] == "iw8" || tokens[ index ] == "iw9" || tokens[ index ] == "t10" || tokens[ index ] == "jup" )
        {
            classtokens = [ "ar", "sm", "lm", "sh", "sn", "dm", "pi", "la", "me", "br" ];
            
            if ( tokens[ index ] == "jup" && isdefined( tokens[ index + 2 ] ) && array_contains( classtokens, tokens[ index + 2 ] ) )
            {
                weaponname = tokens[ index ] + "_" + tokens[ index + 1 ] + "_" + tokens[ index + 2 ] + "_" + tokens[ index + 3 ];
            }
            else if ( isdefined( tokens[ index + 1 ] ) && array_contains( classtokens, tokens[ index + 1 ] ) )
            {
                var_883157764b005ca1 = tokens.size >= index + 2 && tokens[ index + 2 ] == "zombie";
                
                if ( tokens.size >= index + 4 && tokens[ index ] == "t10" || var_883157764b005ca1 )
                {
                    weaponname = tokens[ index ] + "_" + tokens[ index + 1 ] + "_" + tokens[ index + 2 ] + "_" + tokens[ index + 3 ];
                }
                else
                {
                    weaponname = tokens[ index ] + "_" + tokens[ index + 1 ] + "_" + tokens[ index + 2 ];
                }
            }
            else
            {
                weaponname = tokens[ index ] + "_" + tokens[ index + 1 ];
            }
        }
    }
    
    if ( level.weaponrootcache.size < 100 )
    {
        level.weaponrootcache[ originalname ] = weaponname;
    }
    
    return weaponname;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x4745
// Size: 0x137
function getweaponclasstoken( weaponname )
{
    assert( isstring( weaponname ) );
    weaponclasstokens[ 0 ] = strtok( weaponname, "_" )[ 1 ];
    weaponclasstokens[ 1 ] = strtok( weaponname, "_" )[ 2 ];
    
    foreach ( potentialtoken in weaponclasstokens )
    {
        if ( !isdefined( potentialtoken ) )
        {
            continue;
        }
        
        switch ( potentialtoken )
        {
            case #"hash_fa0ed9f6bd4f4e9a":
            case #"hash_fa18d2f6bd57925a":
            case #"hash_fa24ddf6bd609e07":
            case #"hash_fa27b9f6bd62a3f2":
            case #"hash_fa27bdf6bd62aa3e":
            case #"hash_fa37b6f6bd6f6b2c":
            case #"hash_fa4dbdf6bd80bf52":
            case #"hash_fa50b4f6bd82efbe":
            case #"hash_fa50b6f6bd82f2e4":
            case #"hash_fa50b9f6bd82f79d":
                return potentialtoken;
            case #"hash_fa21c4f6bd5e3815":
                return "ar";
        }
    }
    
    assertmsg( "getWeaponClassToken: Could not parse a valid weapon class token from weapon: " + weaponname );
    return undefined;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x4885
// Size: 0x1d, Type: bool
function attachmentiscosmetic( attachment )
{
    return isdefined( attachment ) && string_starts_with( attachment, "cos_" );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x48ab
// Size: 0x1a
function issilencerattach( weapon, attachment )
{
    return issilencedattachment( weapon, attachment );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x48ce
// Size: 0xa9
function combinedefaultandcustomattachmentidmaps( attachmentdefaulttoidmap, attachmenttoidmap )
{
    combined = [];
    
    foreach ( key, value in attachmentdefaulttoidmap )
    {
        if ( array_contains_key( attachmenttoidmap, key ) )
        {
            continue;
        }
        
        combined[ key ] = value;
    }
    
    foreach ( key, value in attachmenttoidmap )
    {
        combined[ key ] = value;
    }
    
    return combined;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 3
// Checksum 0x0, Offset: 0x4980
// Size: 0x1d6
function filterinvalidattachmentsfromidmap( var_f44f790efdadeea0, weaponassetname, weaponobj )
{
    var_3aa0e5fbca9e041c = [];
    
    foreach ( attachment, attachmentid in var_f44f790efdadeea0 )
    {
        if ( weaponobj canuseattachment( attachment ) )
        {
            var_3aa0e5fbca9e041c[ attachment ] = attachmentid;
            continue;
        }
        
        /#
            thread invalidattachmentwarning( attachment, weaponassetname );
            println( "<dev string:xc5>" + weaponassetname + "<dev string:xe0>" );
            attachmentslots = [ "<dev string:xe3>", "<dev string:xec>", "<dev string:xf7>", "<dev string:x101>", "<dev string:x10a>", "<dev string:x113>", "<dev string:x11a>", "<dev string:x123>", "<dev string:x12b>", "<dev string:x131>", "<dev string:x137>", "<dev string:x143>", "<dev string:x14c>", "<dev string:x153>" ];
            
            foreach ( attachmentslot in attachmentslots )
            {
                println( "<dev string:x159>" + attachmentslot );
                attachmentsavailable = function_75b035199842693d( weaponassetname, attachmentslot );
                
                foreach ( attachment in attachmentsavailable )
                {
                    println( "<dev string:x15b>" + attachment );
                }
            }
        #/
    }
    
    return var_3aa0e5fbca9e041c;
}

/#

    // Namespace weapon / scripts\cp_mp\weapon
    // Params 2
    // Checksum 0x0, Offset: 0x4b5f
    // Size: 0x7c, Type: dev
    function invalidattachmentwarning( attachment, weaponassetname )
    {
        message = "<dev string:x15e>" + attachment + "<dev string:x173>" + weaponassetname;
        
        if ( isdefined( self ) && isplayer( self ) )
        {
            if ( getdvarint( @"scr_playtest", 0 ) == 1 )
            {
                iprintlnbold( message );
            }
            else
            {
                iprintlnbold( message );
            }
        }
        
        println( "<dev string:x178>" + message );
        assertmsg( message );
    }

#/

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x4be3
// Size: 0xba, Type: bool
function weaponsupportslaserir( weaponbasename )
{
    switch ( weaponbasename )
    {
        case #"hash_ad9dd8204eeeec9":
        case #"hash_105072c3c4229775":
        case #"hash_1ee4b4461a10e3f1":
        case #"hash_7b2c4b25882fbf2f":
        case #"hash_ca6072c8c1ca083f":
        case #"hash_decd8473cdd1b5a9":
        case #"hash_fcd329558a1aa65a":
            return false;
    }
    
    if ( iskillstreakweapon( weaponbasename ) )
    {
        return false;
    }
    
    class = weaponclass( weaponbasename );
    return class == "rifle" || class == "mg" || class == "sniper" || class == "smg" || class == "spread";
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x4ca6
// Size: 0x75
function iskillstreakplayerweapon( weapon )
{
    killstreakplayerweapon = 0;
    weapname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weapname = weapon.basename;
    }
    else
    {
        weapname = getweaponassetname( weapon );
        
        if ( !isdefined( weapname ) )
        {
            weapname = weapon;
        }
    }
    
    if ( issubstr( weapname, "_mp" ) )
    {
        if ( iskillstreakweapon( weapname ) && isminigunweapon( weapname ) )
        {
            killstreakplayerweapon = 1;
        }
    }
    
    return killstreakplayerweapon;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x4d24
// Size: 0x9b
function issuperuseweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "Weapon.gsc - isSuperUseWeapon was passed an undefined weapon name" );
        return 0;
    }
    
    if ( !isstring( weapon ) )
    {
        weapon = weapon.basename;
    }
    
    if ( function_602a4626cabc6981( weapon ) )
    {
        return 1;
    }
    
    if ( !isdefined( level.superglobals ) || !isdefined( level.superglobals.superweapons ) || !isdefined( level.superglobals.superweapons[ weapon ] ) )
    {
        return undefined;
    }
    
    return isdefined( level.superglobals.superweapons[ weapon ] );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x4dc8
// Size: 0x93, Type: bool
function issupergestureweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "Weapon.gsc - isSuperGestureWeapon was passed an undefined weapon name" );
        return false;
    }
    
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        weaponname = getweaponassetname( weapon );
        
        if ( !isdefined( weaponname ) )
        {
            weaponname = weapon;
        }
    }
    
    switch ( weaponname )
    {
        case #"hash_4cdc20240e59faaf":
        case #"hash_ca1eabc559246db2":
        case #"hash_cfc84b38b4da467b":
        case #"hash_f4312df166bd9791":
            return true;
    }
    
    return false;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x4e64
// Size: 0x68
function function_602a4626cabc6981( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "Weapon.gsc - isInSuperUseWhitelist was passed an undefined weapon name" );
        return 0;
    }
    
    if ( !isstring( weapon ) )
    {
        weapon = weapon.basename;
    }
    
    switch ( weapon )
    {
        case #"hash_b742b20d3ace6197":
        case #"hash_db7c88dcdb203deb":
            return 1;
        default:
            return 0;
    }
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x4ed4
// Size: 0x71, Type: bool
function function_3de73a849ecea0d( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "Weapon.gsc - isOxygenMaskWeapon was passed an undefined weapon name" );
        return false;
    }
    
    weapname = undefined;
    
    if ( isweapon( weapon ) )
    {
        if ( isnullweapon( weapon ) )
        {
            return false;
        }
        
        weapname = weapon.basename;
    }
    else
    {
        if ( weapon == "none" )
        {
            return false;
        }
        
        weapname = weapon;
    }
    
    return weapname == "iw9_oxygenmask" || weapname == "iw9_oxygenmask_mp";
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x4f4e
// Size: 0x9d, Type: bool
function isminigunweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "Weapon.gsc - isMinigunWeapon cwas passed an undefined weapon name" );
        return false;
    }
    
    weapname = undefined;
    
    if ( isweapon( weapon ) )
    {
        if ( isnullweapon( weapon ) )
        {
            return false;
        }
        
        weapname = weapon.basename;
    }
    else
    {
        if ( weapon == "none" )
        {
            return false;
        }
        
        weapname = weapon;
    }
    
    return weapname == "iw9_minigunksjugg_mp" || weapname == "iw9_minigunksjugg_reload_mp" || weapname == "iw8_lm_dblmg_mp" || weapname == "iw9_lm_dblmg_mp" || weapname == "iw9_lm_dblmg2_cp" || weapname == "iw9_lm_dblmg_jup_mp";
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x4ff4
// Size: 0x77, Type: bool
function iskillstreakweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "Weapon.gsc - isKillstreakWeapon was passed an undefined weapon name" );
        return false;
    }
    
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        weaponname = getweaponassetname( weapon );
        
        if ( !isdefined( weaponname ) )
        {
            weaponname = weapon;
        }
    }
    
    if ( isdefined( level.killstreakweaponmap ) && isdefined( level.killstreakweaponmap[ weaponname ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x5074
// Size: 0x37
function registerkillstreakweaponmap( streakname, var_d8a64ed9bcdf7185 )
{
    if ( !isdefined( level.killstreakweaponmap ) )
    {
        level.killstreakweaponmap = [];
    }
    
    level.killstreakweaponmap[ var_d8a64ed9bcdf7185 ] = streakname;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 0
// Checksum 0x0, Offset: 0x50b3
// Size: 0x448
function initkillstreakweaponmap()
{
    if ( !isdefined( level.killstreakweaponmap ) )
    {
        level.killstreakweaponmap = [];
    }
    
    level.killstreakweaponmap[ "tacops_beacon_mp" ] = "marker";
    level.killstreakweaponmap[ "radar_drone_proj_mp" ] = "radar_drone_recon";
    level.killstreakweaponmap[ "gunship_105mm_mp" ] = "gunship";
    level.killstreakweaponmap[ "manual_turret_mp" ] = "manual_turret";
    level.killstreakweaponmap[ "nuke_mp" ] = "nuke";
    level.killstreakweaponmap[ "artillery_mp" ] = "precision_airstrike";
    level.killstreakweaponmap[ "iw9_spotter_scope_mp" ] = "precision_airstrike";
    level.killstreakweaponmap[ "deploy_airdrop_mp" ] = "airdrop";
    level.killstreakweaponmap[ "deploy_airdrop_sticky_mp" ] = "airdrop";
    level.killstreakweaponmap[ "nuke_multi_mp" ] = "nuke_multi";
    level.killstreakweaponmap[ "cruise_proj_mp" ] = "cruise_predator";
    level.killstreakweaponmap[ "pac_sentry_turret_mp" ] = "pac_sentry";
    level.killstreakweaponmap[ "toma_proj_mp" ] = "toma_strike";
    level.killstreakweaponmap[ "iw9_laser_large_ir_mp" ] = "toma_strike";
    level.killstreakweaponmap[ "chopper_gunner_turret_mp" ] = "chopper_gunner";
    level.killstreakweaponmap[ "chopper_gunner_proj_mp" ] = "chopper_gunner";
    level.killstreakweaponmap[ "chopper_gunner_turret_cp" ] = "chopper_gunner";
    level.killstreakweaponmap[ "chopper_gunner_proj_cp" ] = "chopper_gunner";
    level.killstreakweaponmap[ "gunship_25mm_mp" ] = "gunship";
    level.killstreakweaponmap[ "gunship_40mm_mp" ] = "gunship";
    level.killstreakweaponmap[ "gunship_hellfire_mp" ] = "gunship";
    level.killstreakweaponmap[ "fuelstrike_proj_mp" ] = "fuel_airstrike";
    level.killstreakweaponmap[ "chopper_support_turret_mp" ] = "chopper_support";
    level.killstreakweaponmap[ "chopper_support_turret_br" ] = "chopper_support";
    level.killstreakweaponmap[ "deploy_sentry_mp" ] = "sentry_gun";
    level.killstreakweaponmap[ "sentry_turret_mp" ] = "sentry_gun";
    level.killstreakweaponmap[ "hover_jet_turret_mp" ] = "hover_jet";
    level.killstreakweaponmap[ "hover_jet_proj_mp" ] = "hover_jet";
    level.killstreakweaponmap[ "hover_jet_bomb_mp" ] = "hover_jet";
    level.killstreakweaponmap[ "iw9_minigunksjugg_mp" ] = "juggernaut";
    level.killstreakweaponmap[ "iw9_minigunksjugg_reload_mp" ] = "juggernaut";
    level.killstreakweaponmap[ "deploy_juggernaut_mp" ] = "juggernaut";
    level.killstreakweaponmap[ "assault_drone_mp" ] = "assault_drone";
    level.killstreakweaponmap[ "assault_drone_danger_mp" ] = "assault_drone";
    level.killstreakweaponmap[ "auto_drone_proj_mp" ] = "auto_drone";
    level.killstreakweaponmap[ "airdrop_escort_turret_mp" ] = "airdrop_escort";
    level.killstreakweaponmap[ "super_laser_charge_mp" ] = "super_laser_charge";
    level.killstreakweaponmap[ "electric_discharge_mp" ] = "super_electric_discharge";
    level.killstreakweaponmap[ "high_jump_mp" ] = "super_high_jump";
    level.killstreakweaponmap[ "airdrop_escort_turret_ballistics_mp" ] = "airdrop_escort";
    level.killstreakweaponmap[ "chopper_gunner_turret_ballistics_mp" ] = "chopper_gunner";
    level.killstreakweaponmap[ "hover_jet_turret_ballistics_mp" ] = "hover_jet";
    level.killstreakweaponmap[ "switchblade_drone_mp" ] = "switchblade_drone";
    level.killstreakweaponmap[ "lrad_mp" ] = "lrad";
    level.killstreakweaponmap[ "deploy_remote_turret_mp" ] = "remote_turret";
    level.killstreakweaponmap[ "remote_turret_mp" ] = "remote_turret";
    level.killstreakweaponmap[ "loitering_munition_proj_mp" ] = "loitering_munition";
    level.killstreakweaponmap[ "deploy_missileturret_jup_mp" ] = "missile_turret";
    level.killstreakweaponmap[ "missile_turret_proj_jup_mp" ] = "missile_turret";
    level.killstreakweaponmap[ "drone_swarm_drone_mp" ] = "drone_swarm";
    level.killstreakweaponmap[ "toma_proj_jup_mp" ] = "toma_strike";
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x5503
// Size: 0xa4, Type: bool
function function_1a9394eb58e66a9b( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "Weapon.gsc - isFakeKillstreakWeapon was passed an undefined weapon name" );
        return false;
    }
    
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        weaponname = getweaponassetname( weapon );
        
        if ( !isdefined( weaponname ) )
        {
            weaponname = weapon;
        }
    }
    
    if ( isdefined( level.killstreakweaponmap ) && isdefined( level.killstreakweaponmap[ weaponname ] ) )
    {
        switch ( weaponname )
        {
            case #"hash_10480ca9423043c7":
            case #"hash_4cdc20240e59faaf":
            case #"hash_9acbd2b1e30a8e0e":
                return true;
        }
    }
    
    return false;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x55b0
// Size: 0xb8, Type: bool
function function_aea26b825f926e9c( weapon, attachmentname )
{
    if ( attachmentname == "none" )
    {
        return true;
    }
    
    if ( !isdefined( weapon ) || isstring( weapon ) && ( weapon == "none" || weapon == "" ) )
    {
        return false;
    }
    
    rootname = getweaponrootname( weapon );
    weaponasset = weaponassetnamemap( rootname );
    weaponattachments = function_91d352b50d9a0630( weaponasset );
    attachmentslot = getattachmentslot( weaponasset, attachmentname );
    attachmentarray = weaponattachments[ attachmentslot ];
    
    if ( isdefined( attachmentarray ) && array_contains( attachmentarray, attachmentname ) )
    {
        return true;
    }
    
    return false;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x5671
// Size: 0x64
function function_6e7bc1b23afa0ea8( weapon, playerdatavalue )
{
    if ( scripts\cp_mp\weapon::function_aea26b825f926e9c( weapon, playerdatavalue ) )
    {
        return playerdatavalue;
    }
    
    println( "<dev string:x182>" + playerdatavalue );
    rootname = getweaponrootname( weapon );
    weaponasset = weaponassetnamemap( rootname );
    return getattachmentfromslotandindex( weaponasset, "receiver", 0 );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x56dd
// Size: 0x8e
function buildweaponattachmentidmap( attachments, attachmentids )
{
    attachmenttoidmap = [];
    
    foreach ( idx, var_8bccf360992ddd62 in attachments )
    {
        if ( isdefined( attachmentids ) && idx < attachmentids.size )
        {
            if ( isdefined( attachmentids[ var_8bccf360992ddd62 ] ) )
            {
                attachmenttoidmap[ var_8bccf360992ddd62 ] = attachmentids[ var_8bccf360992ddd62 ];
            }
            else
            {
                attachmenttoidmap[ var_8bccf360992ddd62 ] = attachmentids[ idx ];
            }
            
            continue;
        }
        
        attachmenttoidmap[ var_8bccf360992ddd62 ] = 0;
    }
    
    return attachmenttoidmap;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x5774
// Size: 0x84
function getweaponnvgattachment( weaponobj )
{
    var_7efcef2ab37c2c45 = [ "laserir_box", "laserir_cyl", "laserir_pstl" ];
    
    foreach ( attachment in var_7efcef2ab37c2c45 )
    {
        if ( weaponobj canuseattachment( attachment ) )
        {
            return attachment;
        }
    }
    
    return "invalid";
}

/#

    // Namespace weapon / scripts\cp_mp\weapon
    // Params 10
    // Checksum 0x0, Offset: 0x5801
    // Size: 0x118, Type: dev
    function function_13aeabbe4210eadc( itemname, rarity, lootid, baseweapon, attachments, fullweaponname, titlestring, descstring, icon, pickupsound )
    {
        str = "<dev string:x1ae>";
        str += "<dev string:x1b3>" + itemname;
        str += "<dev string:x1b3>" + "<dev string:x1b6>";
        str += "<dev string:x1b3>" + rarity;
        str += "<dev string:x1b3>";
        str += "<dev string:x1b3>" + lootid;
        str += "<dev string:x1b3>";
        str += "<dev string:x1b3>";
        str += "<dev string:x1b3>" + baseweapon;
        str += "<dev string:x1b3>";
        str += "<dev string:x1b3>" + attachments;
        str += "<dev string:x1b3>" + fullweaponname;
        str += "<dev string:x1b3>" + function_e4891bb7bec886f9( titlestring );
        str += "<dev string:x1b3>" + function_e4891bb7bec886f9( descstring );
        str += "<dev string:x1b3>" + icon;
        str += "<dev string:x1b3>" + pickupsound;
        return str;
    }

#/

// Namespace weapon / scripts\cp_mp\weapon
// Params 0
// Checksum 0x0, Offset: 0x5921
// Size: 0x7b
function function_623af97ae297f796()
{
    attachmentlist = [];
    numrows = tablelookupgetnumrows( "mp/attachmenttable.csv" );
    
    for ( index = 0; index < numrows ; index++ )
    {
        attachmentname = tablelookupbyrow( "mp/attachmenttable.csv", index, 4 );
        
        if ( attachmentname == "" )
        {
            continue;
        }
        
        assertex( !isdefined( attachmentlist[ attachmentname ] ), "Duplicate attachment reference name found in attachmentTable.csv: " + attachmentname );
        attachmentlist[ attachmentname ] = attachmentname;
    }
    
    return attachmentlist;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x59a5
// Size: 0x41
function getreticleindex( reticleref )
{
    if ( !isdefined( reticleref ) )
    {
        return undefined;
    }
    
    reticleid = int( tablelookup( "mp/reticleTable.csv", 1, reticleref, 5 ) );
    
    if ( !isdefined( reticleid ) || reticleid == 0 )
    {
        return undefined;
    }
    
    return reticleid;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 0
// Checksum 0x0, Offset: 0x59ef
// Size: 0x41
function getweapontable()
{
    if ( !isdefined( level.weapontable ) )
    {
        if ( isdefined( level.gamemodebundle ) )
        {
            level.weapontable = level.gamemodebundle.var_ddaed03ebcc9ccf9;
        }
    }
    
    return level.weapontable;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 0
// Checksum 0x0, Offset: 0x5a39
// Size: 0x107
function function_a221d76594ef4e8b()
{
    if ( isdefined( level.weaponlistbundle ) )
    {
        return level.weaponlistbundle;
    }
    
    gamemodebundle = getgamemodescriptbundle();
    
    if ( isdefined( gamemodebundle ) && isdefined( gamemodebundle.weaponlist ) )
    {
        weaponlistbundle = getscriptbundle( hashcat( %"hash_7eccb7f3e167e22b", gamemodebundle.weaponlist ) );
        
        if ( isdefined( weaponlistbundle ) && isdefined( weaponlistbundle.weapons ) )
        {
            level.weaponlistbundle = [];
            
            foreach ( struct in weaponlistbundle.weapons )
            {
                if ( isdefined( struct ) && isdefined( struct.weapondata ) )
                {
                    level.weaponlistbundle[ index ] = struct.weapondata;
                }
            }
            
            return level.weaponlistbundle;
        }
    }
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x5b48
// Size: 0x117
function function_c7901c1f857aa1a0( weapon )
{
    println( "<dev string:x1bd>" + getcompleteweaponname( weapon ) );
    variantindex = getweaponvariantindex( getcompleteweaponname( weapon ) );
    
    if ( !isdefined( variantindex ) )
    {
        itemname = getweaponbasename( weapon );
        weapon_lootid = scripts\cp_mp\weapon::getweaponlootid( weapon );
        println( "<dev string:x1d7>" + itemname );
        
        if ( weapon_lootid > 0 )
        {
            println( "<dev string:x1e6>" + weapon_lootid + "<dev string:x1f3>" );
        }
        
        return [ itemname, weapon_lootid ];
    }
    
    println( "<dev string:x1f5>" + variantindex );
    weaponscriptbundle = function_33ce6e3c89e6975f( getweaponbasename( weapon ), variantindex );
    weapon_lootid = weaponscriptbundle.lootid;
    blueprintname = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3( weaponscriptbundle.lootid );
    println( "<dev string:x203>" + blueprintname );
    println( "<dev string:x1e6>" + weapon_lootid + "<dev string:x1f3>" );
    return [ blueprintname, weapon_lootid ];
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x5c68
// Size: 0x28
function function_8477d8595e0364a7( weapon, keys )
{
    return getscriptbundlefieldvalues( hashcat( %"hash_31705bf9ed477170", weapon ), keys );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x5c99
// Size: 0x28
function function_a622d54bb517923a( attachment, keys )
{
    return getscriptbundlefieldvalues( hashcat( %"hash_3c2c9813bb16552f", attachment ), keys );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 3
// Checksum 0x0, Offset: 0x5cca
// Size: 0x43
function function_b8811a0fc04e4b9d( weapon, key, def )
{
    value = getscriptbundlefieldvalue( hashcat( %"hash_31705bf9ed477170", weapon ), key );
    
    if ( !isdefined( value ) )
    {
        return def;
    }
    
    return value;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x5d16
// Size: 0x82
function function_91d352b50d9a0630( weapon )
{
    slotarray = function_c471a035d22df5eb();
    allattachments = [];
    
    foreach ( slot in slotarray )
    {
        var_63a235c3e361a6c3 = function_75b035199842693d( weapon, slot );
        allattachments[ slot ] = var_63a235c3e361a6c3;
    }
    
    return allattachments;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 0
// Checksum 0x0, Offset: 0x5da1
// Size: 0x174
function function_c471a035d22df5eb()
{
    if ( !isdefined( level.attachmentslotarray ) )
    {
        level.attachmentslotarray = [];
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "frontpiece";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "backpiece";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "magazine";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "override";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "muzzle";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "reargrip";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "trigger";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "extra";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "scope";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "underbarrel";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "modifier";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "visual";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "other";
    }
    
    return level.attachmentslotarray;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x5f1e
// Size: 0x5d
function function_5419ac7173288fc1( weapon )
{
    weaponname = weapon.basename;
    
    if ( !isdefined( weaponname ) )
    {
        return 0;
    }
    
    currentweapon = 0;
    
    switch ( weaponname )
    {
        case #"hash_33c7f389fa9d6dd5":
        case #"hash_c94fd51fe359fdfe":
            currentweapon = 1;
            break;
    }
    
    return currentweapon;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x5f84
// Size: 0x5d
function isdeploytablet( weapon )
{
    weaponname = weapon.basename;
    
    if ( !isdefined( weaponname ) )
    {
        return 0;
    }
    
    currentweapon = 0;
    
    switch ( weaponname )
    {
        case #"hash_288bc6291d670eaa":
        case #"hash_b43c2e4c05fafc4b":
            currentweapon = 1;
            break;
    }
    
    return currentweapon;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x5fea
// Size: 0x2f, Type: bool
function function_aa8b0f148ca930aa( weapon )
{
    weaponname = weapon.basename;
    
    if ( !isdefined( weaponname ) )
    {
        return false;
    }
    
    return weaponname == "super_remote_map_mp";
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x6022
// Size: 0x67
function function_79d6e6c22245687a( rootname, variantid )
{
    weaponvariantkey = rootname + "|" + variantid;
    
    if ( isdefined( level.weaponlootmapdata[ weaponvariantkey ] ) && isdefined( level.weaponlootmapdata[ weaponvariantkey ].lootid ) )
    {
        return level.weaponlootmapdata[ weaponvariantkey ].lootid;
    }
    
    return 0;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x6092
// Size: 0x6f
function function_115404a4dbd59830( rootname, variantid )
{
    if ( !isdefined( variantid ) )
    {
        variantid = 0;
    }
    
    weaponvariantkey = rootname + "|" + variantid;
    
    if ( isdefined( level.weaponlootmapdata[ weaponvariantkey ] ) && isdefined( level.weaponlootmapdata[ weaponvariantkey ].weaponcooldown ) )
    {
        return level.weaponlootmapdata[ weaponvariantkey ].weaponcooldown;
    }
    
    return 0;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x610a
// Size: 0x4d
function getweaponlootid( weapon )
{
    variantid = 0;
    rootname = scripts\cp_mp\weapon::getweaponrootname( weapon );
    
    if ( isdefined( weapon.variantid ) )
    {
        variantid = weapon.variantid;
    }
    
    return function_79d6e6c22245687a( rootname, variantid );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x6160
// Size: 0x30
function function_b0d37b9be0027733( customweaponname )
{
    rootname = scripts\cp_mp\weapon::getweaponrootname( customweaponname );
    ref = rootname;
    return scripts\cp_mp\utility\loot::getlootidfromref( ref );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x6199
// Size: 0xa6
function function_98bac17512f9c622( weapon )
{
    weaponlootid = 0;
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        assert( isstring( weapon ) );
        weaponname = weapon;
    }
    
    if ( isdefined( weaponname ) )
    {
        weaponrootname = scripts\cp_mp\weapon::getweaponrootname( weaponname );
        
        if ( isdefined( level.weaponmapdata[ weaponrootname ] ) && isdefined( level.weaponmapdata[ weaponrootname ].weaponlootid ) )
        {
            weaponlootid = level.weaponmapdata[ weaponrootname ].weaponlootid;
        }
    }
    
    return weaponlootid;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x6248
// Size: 0xe0
function function_89a83ae9a4c4142a( weapon )
{
    if ( getdvarint( @"hash_8f727124cb64ae24", 1 ) == 1 )
    {
        weaponlootid = function_98bac17512f9c622( weapon );
        
        if ( weaponlootid != 0 )
        {
            return weaponlootid;
        }
    }
    
    if ( !isdefined( level.specialweaponlist ) )
    {
        level.specialweaponlist = [];
    }
    
    weaponname = function_c2bc8497963042d5( weapon );
    
    if ( !isdefined( weaponname ) )
    {
        return 0;
    }
    
    if ( isdefined( level.specialweaponlist[ weaponname ] ) )
    {
        return level.specialweaponlist[ weaponname ];
    }
    
    id = tablelookup( "loot/special_weapon_ids.csv", 1, weaponname, 0 );
    
    if ( !isdefined( id ) || id == "0" || id == "" )
    {
        return 0;
    }
    
    id = int( id );
    
    if ( isdefined( id ) )
    {
        level.specialweaponlist[ weaponname ] = id;
        return id;
    }
    
    return getweaponlootid( weapon );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x6331
// Size: 0xb2
function function_c2bc8497963042d5( weapon )
{
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        assert( isstring( weapon ) );
        weaponname = weapon;
    }
    
    switch ( weaponname )
    {
        case #"hash_b1091bccb52690e0":
        case #"hash_e1e4906cafc3af9d":
            weaponname = "iw9_tur_mrap_mp";
            break;
        case #"hash_20305144649233ed":
        case #"hash_8d7aa4b158a0e9a9":
            weaponname = "iw9_mg_patrol_boat_front_mp";
            break;
        case #"hash_62a9688b69906271":
        case #"hash_708fb6e22f87a3a4":
            weaponname = "iw9_tur_cougar_mp";
            break;
    }
    
    return weaponname;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 0
// Checksum 0x0, Offset: 0x63ec
// Size: 0x3c
function getgrenadeinpullback()
{
    offhandweapon = self getheldoffhand();
    
    if ( isdefined( self.gestureweapon ) && offhandweapon == makeweaponfromstring( self.gestureweapon ) )
    {
        offhandweapon = nullweapon();
    }
    
    return offhandweapon;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x6431
// Size: 0x1d, Type: bool
function isweaponequipment( weapon )
{
    return istrue( weapon.inventorytype == "offhand" );
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x6457
// Size: 0x19, Type: bool
function isequipmentaddon( weapon )
{
    if ( weapon == "iw9_knifestab" )
    {
        return true;
    }
    
    return false;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x6479
// Size: 0x32
function getweaponbotpersonalities( weapon )
{
    rootname = scripts\cp_mp\weapon::getweaponrootname( weapon );
    return level.weaponmapdata[ rootname ].botpersonalities;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x64b4
// Size: 0x75, Type: bool
function function_8a96b90526c40df6( weapon, attachments )
{
    foreach ( attachment in attachments )
    {
        if ( issubstr( attachment, "laser" ) || issubstr( attachment, "flashlight" ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x6532
// Size: 0x28, Type: bool
function isspreadweapon( objweapon )
{
    return isdefined( objweapon ) && isdefined( weaponclass( objweapon ) ) && weaponclass( objweapon ) == "spread";
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 1
// Checksum 0x0, Offset: 0x6563
// Size: 0x78
function iswonderweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x217>" );
        return 0;
    }
    
    var_768d659419360f70 = weapon.var_9d7facbe889e667c;
    
    if ( !isdefined( var_768d659419360f70 ) )
    {
        return 0;
    }
    
    metadata = level.weaponmetadata[ var_768d659419360f70 ];
    
    if ( isdefined( metadata ) && isdefined( metadata.iswonderweapon ) )
    {
        return metadata.iswonderweapon;
    }
    
    return 0;
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 0
// Checksum 0x0, Offset: 0x65e4
// Size: 0x21
function function_5238382582ce39fa()
{
    buildweaponmap();
    buildattachmentmaps();
    function_ee4a536a155313b7();
    
    /#
        scripts\cp_mp\weapons_dev::function_b8a2a2faf79dc08e();
    #/
}

// Namespace weapon / scripts\cp_mp\weapon
// Params 2
// Checksum 0x0, Offset: 0x660d
// Size: 0x13f, Type: bool
function fixupplayerweapons( player, weapon )
{
    currentplayerweapons = player getweaponslistprimaries();
    dirtyprimary = 1;
    dirtysecondary = 1;
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = getcompleteweaponname( weapon );
    }
    else
    {
        weaponname = weapon;
    }
    
    foreach ( currentweapon in currentplayerweapons )
    {
        if ( isdefined( player.primaryweaponobj ) && player.primaryweaponobj == currentweapon )
        {
            dirtyprimary = 0;
            continue;
        }
        
        if ( isdefined( player.secondaryweaponobj ) && player.secondaryweaponobj == currentweapon )
        {
            dirtysecondary = 0;
        }
    }
    
    if ( dirtyprimary )
    {
        player.primaryweapon = weaponname;
        player.primaryweaponobj = makeweaponfromstring( weaponname );
    }
    else if ( dirtysecondary )
    {
        player.secondaryweapon = weaponname;
        player.secondaryweaponobj = makeweaponfromstring( weaponname );
    }
    
    return dirtyprimary || dirtysecondary;
}

