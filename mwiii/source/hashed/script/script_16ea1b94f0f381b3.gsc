#using scripts\engine\utility;

#namespace namespace_2b1145f62aa835b8;

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 4
// Checksum 0x0, Offset: 0x1289
// Size: 0x37
function scriptmodelplayanimdeltamotionsharedfunc( animname, notifystring, animstarttimeseconds, blendtype )
{
    return utility::callsharedfunc( "anim", "scriptModelPlayAnimDeltaMotion", animname, notifystring, animstarttimeseconds, blendtype );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x12c9
// Size: 0x42
function hasperksharedfunc( perkname )
{
    has_perk = 0;
    
    if ( utility::issharedfuncdefined( "perk", "hasPerk" ) )
    {
        has_perk = self [[ utility::getsharedfunc( "perk", "hasPerk" ) ]]( perkname );
    }
    
    return has_perk;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x1314
// Size: 0x33
function activateperksharedfunc( perkname )
{
    if ( issharedfuncdefined( "perk", "activatePerk" ) )
    {
        self [[ getsharedfunc( "perk", "activatePerk" ) ]]( perkname );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x134f
// Size: 0x3c
function function_690e9e142ebc1c69( fieldupgrade1, fieldupgrade2 )
{
    if ( utility::issharedfuncdefined( "perk", "perkpackage_giveOverrideFieldUpgrades" ) )
    {
        self [[ utility::getsharedfunc( "perk", "perkpackage_giveOverrideFieldUpgrades" ) ]]( fieldupgrade1, fieldupgrade2 );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x1393
// Size: 0x33
function giveperksharedfunc( perkname )
{
    if ( utility::issharedfuncdefined( "perk", "givePerk" ) )
    {
        self [[ utility::getsharedfunc( "perk", "givePerk" ) ]]( perkname );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x13ce
// Size: 0x33
function removeperksharedfunc( perkname )
{
    if ( utility::issharedfuncdefined( "perk", "removePerk" ) )
    {
        self [[ utility::getsharedfunc( "perk", "removePerk" ) ]]( perkname );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 5
// Checksum 0x0, Offset: 0x1409
// Size: 0x57
function showsplashsharedfunc( ref, optionalnumber, playerforplayercard, altdisplayindex, var_ef4849b4cb3ac7e2 )
{
    if ( utility::issharedfuncdefined( "hud", "showSplash" ) )
    {
        self [[ utility::getsharedfunc( "hud", "showSplash" ) ]]( ref, optionalnumber, playerforplayercard, altdisplayindex, var_ef4849b4cb3ac7e2 );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x1468
// Size: 0x45
function showerrormessagesharedfunc( funcname, param1, param2 )
{
    if ( utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
    {
        self [[ utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( funcname, param1, param2 );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x14b5
// Size: 0x37
function isfeaturedisabledsharedfunc( featurename )
{
    if ( utility::issharedfuncdefined( "game", "isFeatureDisabled" ) )
    {
        return [[ utility::getsharedfunc( "game", "isFeatureDisabled" ) ]]( featurename );
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x14f4
// Size: 0x29
function checkforactiveobjicon()
{
    if ( utility::issharedfuncdefined( "game", "checkForActiveObjIcon" ) )
    {
        self [[ utility::getsharedfunc( "game", "checkForActiveObjIcon" ) ]]();
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x1525
// Size: 0x29
function deletequestobjicon()
{
    if ( utility::issharedfuncdefined( "game", "deleteQuestObjIcon" ) )
    {
        self [[ utility::getsharedfunc( "game", "deleteQuestObjIcon" ) ]]();
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 8
// Checksum 0x0, Offset: 0x1556
// Size: 0x73
function spawnpickupsharedfunc( pickupname, dropinfo, count, showtrail, weaponobj, allowautopickup, countlefthand, countalt )
{
    if ( utility::issharedfuncdefined( "game", "spawnPickup" ) )
    {
        [[ utility::getsharedfunc( "game", "spawnPickup" ) ]]( pickupname, dropinfo, count, showtrail, weaponobj, allowautopickup, countlefthand, countalt );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x15d1
// Size: 0x44
function spawnpickupfromlistsharedfunc( var_e31d665c86f80a86, count, origin )
{
    if ( utility::issharedfuncdefined( "game", "spawnPickupFromList" ) )
    {
        [[ utility::getsharedfunc( "game", "spawnPickupFromList" ) ]]( var_e31d665c86f80a86, count, origin );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x161d
// Size: 0x33
function getscriptablefromlootidsharedfunc( lootid )
{
    if ( utility::issharedfuncdefined( "game", "getScriptableFromLootID" ) )
    {
        return [[ utility::getsharedfunc( "game", "getScriptableFromLootID" ) ]]( lootid );
    }
    
    return undefined;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 7
// Checksum 0x0, Offset: 0x1659
// Size: 0x69
function spawnnewitemfromscriptablesharedfunc( scriptablename, itemorigin, itemangles, itemindex, totalitemcount, var_14c85b39207719b8, var_57266f5ca6feebd7 )
{
    if ( utility::issharedfuncdefined( "game", "spawnNewItemFromScriptable" ) )
    {
        return [[ utility::getsharedfunc( "game", "spawnNewItemFromScriptable" ) ]]( scriptablename, itemorigin, itemangles, itemindex, totalitemcount, var_14c85b39207719b8, var_57266f5ca6feebd7 );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 8
// Checksum 0x0, Offset: 0x16ca
// Size: 0x73
function getitemdroporiginandanglessharedfunc( index, baseorigin, baseangles, ignoreent, var_8a600b6102da9f9b, optionaloverridedist, var_6fe2ff802d5192d4, var_3ace5ac9c7d6fa44 )
{
    if ( utility::issharedfuncdefined( "game", "getItemDropOriginAndAngles" ) )
    {
        [[ utility::getsharedfunc( "game", "getItemDropOriginAndAngles" ) ]]( index, baseorigin, baseangles, ignoreent, var_8a600b6102da9f9b, optionaloverridedist, var_6fe2ff802d5192d4, var_3ace5ac9c7d6fa44 );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 6
// Checksum 0x0, Offset: 0x1745
// Size: 0x5f
function function_e2db59d7677bfceb( player, scriptablename, var_43fb3d97abb79854, countoverride, fromkiosk, droppurchased )
{
    if ( utility::issharedfuncdefined( "game", "br_forceGiveCustomPickupItem" ) )
    {
        return [[ utility::getsharedfunc( "game", "br_forceGiveCustomPickupItem" ) ]]( player, scriptablename, var_43fb3d97abb79854, countoverride, fromkiosk, droppurchased );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 4
// Checksum 0x0, Offset: 0x17ac
// Size: 0x4d
function function_98bd9179435d1557( player, plunderspent, purchasetype, itemname )
{
    if ( utility::issharedfuncdefined( "game", "brAnalytics_kiosk_purchaseItem" ) )
    {
        return [[ utility::getsharedfunc( "game", "brAnalytics_kiosk_purchaseItem" ) ]]( player, plunderspent, purchasetype, itemname );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x1801
// Size: 0x45
function function_25fb9a3b7ee98d69( funcname, param1, param2 )
{
    if ( utility::issharedfuncdefined( "game", "runBrGametypeFunc" ) )
    {
        self [[ utility::getsharedfunc( "game", "runBrGametypeFunc" ) ]]( funcname, param1, param2 );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x184e
// Size: 0x32
function iskiosksharedfunc( scriptablename )
{
    if ( utility::issharedfuncdefined( "game", "isKiosk" ) )
    {
        return [[ utility::getsharedfunc( "game", "isKiosk" ) ]]( scriptablename );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x1888
// Size: 0x32
function cantakepickupsharedfunc( pickupent )
{
    if ( utility::issharedfuncdefined( "game", "canTakePickup" ) )
    {
        return [[ utility::getsharedfunc( "game", "canTakePickup" ) ]]( pickupent );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x18c2
// Size: 0x44
function function_e667d74ecc894ceb( player, menuevent, menueventparam )
{
    if ( utility::issharedfuncdefined( "game", "brAnalytics_kiosk_menu_event" ) )
    {
        [[ utility::getsharedfunc( "game", "brAnalytics_kiosk_menu_event" ) ]]( player, menuevent, menueventparam );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x190e
// Size: 0x45
function createquestobjiconsharedfunc( iconref, state, var_38116998df9814d4 )
{
    if ( utility::issharedfuncdefined( "game", "createQuestObjIcon" ) )
    {
        self [[ utility::getsharedfunc( "game", "createQuestObjIcon" ) ]]( iconref, state, var_38116998df9814d4 );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x195b
// Size: 0x33
function showquestobjicontoplayersharedfunc( player )
{
    if ( utility::issharedfuncdefined( "game", "showQuestObjIconToPlayer" ) )
    {
        self [[ utility::getsharedfunc( "game", "showQuestObjIconToPlayer" ) ]]( player );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x1996
// Size: 0x33
function ispubliceventoftypeactivesharedfunc( eventtype )
{
    if ( utility::issharedfuncdefined( "game", "isPublicEventOfTypeActive" ) )
    {
        return [[ utility::getsharedfunc( "game", "isPublicEventOfTypeActive" ) ]]( eventtype );
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x19d2
// Size: 0x33
function hidequestobjiconfromplayersharedfunc( player )
{
    if ( utility::issharedfuncdefined( "game", "hideQuestObjIconFromPlayer" ) )
    {
        self [[ utility::getsharedfunc( "game", "hideQuestObjIconFromPlayer" ) ]]( player );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x1a0d
// Size: 0x32
function isbrpracticemodesharedfunc( player )
{
    if ( utility::issharedfuncdefined( "game", "isBrPracticeMode" ) )
    {
        return [[ utility::getsharedfunc( "game", "isBrPracticeMode" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x1a48
// Size: 0x29
function respawntokendisabledsharedfunc()
{
    if ( utility::issharedfuncdefined( "game", "respawnTokenDisabled" ) )
    {
        return [[ utility::getsharedfunc( "game", "respawnTokenDisabled" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x1a7a
// Size: 0x2a
function hasselfrevivetokensharedfunc()
{
    if ( utility::issharedfuncdefined( "game", "hasSelfReviveToken" ) )
    {
        return self [[ utility::getsharedfunc( "game", "hasSelfReviveToken" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 5
// Checksum 0x0, Offset: 0x1aad
// Size: 0x57
function forcegivekillstreaksharedfunc( killstreakref, dropcurrent, fromkiosk, droppurchased, var_db943473454f6ea6 )
{
    if ( utility::issharedfuncdefined( "game", "forceGiveKillstreak" ) )
    {
        return self [[ utility::getsharedfunc( "game", "forceGiveKillstreak" ) ]]( killstreakref, dropcurrent, fromkiosk, droppurchased, var_db943473454f6ea6 );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x1b0d
// Size: 0x33
function traceselectedmaplocationsharedfunc( location )
{
    if ( utility::issharedfuncdefined( "game", "traceSelectedMapLocation" ) )
    {
        return [[ utility::getsharedfunc( "game", "traceSelectedMapLocation" ) ]]( location );
    }
    
    return undefined;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x1b49
// Size: 0x3b
function getdefaultweaponammosharedfunc( weapon, maxammo )
{
    if ( utility::issharedfuncdefined( "game", "getDefaultWeaponAmmo" ) )
    {
        return [[ utility::getsharedfunc( "game", "getDefaultWeaponAmmo" ) ]]( weapon, maxammo );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x1b8d
// Size: 0x29
function isbackpackinventoryenabledsharedfunc()
{
    if ( utility::issharedfuncdefined( "game", "isBackpackInventoryEnabled" ) )
    {
        return [[ utility::getsharedfunc( "game", "isBackpackInventoryEnabled" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x1bbf
// Size: 0x29
function getgametypesharedfunc()
{
    if ( utility::issharedfuncdefined( "game", "getGameType" ) )
    {
        return [[ utility::getsharedfunc( "game", "getGameType" ) ]]();
    }
    
    return undefined;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x1bf1
// Size: 0x33
function calculatepurchasexpsharedfunc( plunderspent )
{
    if ( utility::issharedfuncdefined( "game", "calculatePurchaseXp" ) )
    {
        return [[ utility::getsharedfunc( "game", "calculatePurchaseXp" ) ]]( plunderspent );
    }
    
    return undefined;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x1c2d
// Size: 0x29
function isanytutorialorbotpracticematchsharedfunc()
{
    if ( utility::issharedfuncdefined( "game", "isAnyTutorialOrBotPracticeMatch" ) )
    {
        return [[ utility::getsharedfunc( "game", "isAnyTutorialOrBotPracticeMatch" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x1c5f
// Size: 0x33
function registeronluieventcallbacksharedfunc( callback )
{
    if ( utility::issharedfuncdefined( "game", "registerOnLuiEventCallback" ) )
    {
        level [[ utility::getsharedfunc( "game", "registerOnLuiEventCallback" ) ]]( callback );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x1c9a
// Size: 0x33
function isloadoutindexdefaultsharedfunc( index )
{
    if ( utility::issharedfuncdefined( "game", "isLoadoutIndexDefault" ) )
    {
        return [[ utility::getsharedfunc( "game", "isLoadoutIndexDefault" ) ]]( index );
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x1cd6
// Size: 0x33
function getclasschoicesharedfunc( menuindex )
{
    if ( utility::issharedfuncdefined( "game", "getClassChoice" ) )
    {
        return [[ utility::getsharedfunc( "game", "getClassChoice" ) ]]( menuindex );
    }
    
    return undefined;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x1d12
// Size: 0x33
function function_3fcb060110170ac9( funcname )
{
    if ( utility::issharedfuncdefined( "game", "isBrGametypeFuncDefined" ) )
    {
        return [[ utility::getsharedfunc( "game", "isBrGametypeFuncDefined" ) ]]( funcname );
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x1d4e
// Size: 0x3d
function function_188f8c265a7ef6ea( spawn_origin, flaretype )
{
    if ( utility::issharedfuncdefined( "game", "utilFlare_shootFlare" ) )
    {
        level thread [[ utility::getsharedfunc( "game", "utilFlare_shootFlare" ) ]]( spawn_origin, flaretype );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x1d93
// Size: 0x45
function isvalidpointinboundssharedfunc( point, checkbadcircleareas, var_498e4e279fb8ed85 )
{
    if ( utility::issharedfuncdefined( "game", "isValidPointInBounds" ) )
    {
        return [[ utility::getsharedfunc( "game", "isValidPointInBounds" ) ]]( point, checkbadcircleareas, var_498e4e279fb8ed85 );
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 4
// Checksum 0x0, Offset: 0x1de1
// Size: 0x4d
function initcirclepoststarttocircleindexsharedfunc( origin, startcircledelay, startcircleindex, startcircleclosetime )
{
    if ( utility::issharedfuncdefined( "game", "initCirclePostStartToCircleIndex" ) )
    {
        [[ utility::getsharedfunc( "game", "initCirclePostStartToCircleIndex" ) ]]( origin, startcircledelay, startcircleindex, startcircleclosetime );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x1e36
// Size: 0x33
function isfeatureenabledsharedfunc( featurename )
{
    if ( utility::issharedfuncdefined( "game", "isFeatureEnabled" ) )
    {
        return [[ utility::getsharedfunc( "game", "isFeatureEnabled" ) ]]( featurename );
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x1e72
// Size: 0x28
function function_baf6855827fe902()
{
    if ( utility::issharedfuncdefined( "game", "spectate_init" ) )
    {
        [[ utility::getsharedfunc( "game", "spectate_init" ) ]]();
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x1ea2
// Size: 0x50
function function_560b2e700ce084a2( v_origin )
{
    if ( utility::issharedfuncdefined( "game", "roundNumberDifficulty" ) )
    {
        return [[ utility::getsharedfunc( "game", "roundNumberDifficulty" ) ]]( v_origin );
    }
    
    assertmsg( "<dev string:x1c>" + level.gametype + "<dev string:x3f>" );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x1efa
// Size: 0x3c
function getteamdatasharedfunc( team, property )
{
    if ( utility::issharedfuncdefined( "game", "getTeamData" ) )
    {
        return [[ utility::getsharedfunc( "game", "getTeamData" ) ]]( team, property );
    }
    
    return [];
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x1f3f
// Size: 0x2e
function registerscoreinfosharedfunc( type, category, value )
{
    return utility::callsharedfunc( "game", "registerScoreInfo", type, category, value );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 5
// Checksum 0x0, Offset: 0x1f76
// Size: 0x40
function trysaylocalsoundsharedfunc( player, soundtype, targetent, delay, location )
{
    return utility::callsharedfunc( "game", "trySayLocalSound", player, soundtype, targetent, delay, location );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x1fbf
// Size: 0x1c
function handlemovingplatformssharedfunc( data )
{
    return utility::callsharedfunc( "game", "handlemovingplatforms", data );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x1fe4
// Size: 0x12
function isteamreviveenabledsharedfunc()
{
    return utility::callsharedfunc( "game", "isTeamReviveEnabled" );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 7
// Checksum 0x0, Offset: 0x1fff
// Size: 0x53
function function_978c422352ec22bc( markerwidgetname, showto, tomark, groupowner, friendlymarker, markonspawn, var_262f4b55aa151de1 )
{
    return utility::callsharedfunc( "game", "targetMarkerGroup_on", markerwidgetname, showto, tomark, groupowner, friendlymarker, markonspawn, var_262f4b55aa151de1 );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x205b
// Size: 0x1c
function function_a24feab7513ef158( targetmarkergroupid )
{
    return utility::callsharedfunc( "game", "targetMarkerGroup_off", targetmarkergroupid );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 6
// Checksum 0x0, Offset: 0x2080
// Size: 0x49
function registersentientsharedfunc( threatbiasgroup, var_5c00772332ce642c, islethal, var_5f6534ad3a0a1fa2, var_719c179eabb70b31, var_8928fdf873929e88 )
{
    return utility::callsharedfunc( "game", "registerSentient", threatbiasgroup, var_5c00772332ce642c, islethal, var_5f6534ad3a0a1fa2, var_719c179eabb70b31, var_8928fdf873929e88 );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x20d2
// Size: 0x25
function registerentforoobsharedfunc( ent, ref )
{
    return utility::callsharedfunc( "game", "registerEntForOOB", ent, ref );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x2100
// Size: 0x25
function clearoobsharedfunc( ent, fromdeath )
{
    return utility::callsharedfunc( "game", "clearOOB", ent, fromdeath );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x212e
// Size: 0x1c
function addspawnviewersharedfunc( entity )
{
    return utility::callsharedfunc( "game", "addSpawnViewer", entity );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x2153
// Size: 0x1c
function removespawnviewersharedfunc( entity )
{
    return utility::callsharedfunc( "game", "removeSpawnViewer", entity );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x2178
// Size: 0x1d
function forcenetfieldhighlod_sharedfunc( set )
{
    utility::callsharedfunc( "game", "ForceNetfieldHighLoD", set );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x219d
// Size: 0x25
function ispointinoutofboundssharedfunc( pointtocheck, teamtocheck )
{
    return utility::callsharedfunc( "game", "isPointInOutOfBounds", pointtocheck, teamtocheck );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x21cb
// Size: 0x12
function function_b1412f0ab907bab7()
{
    return callsharedfunc( "game", "isBRStyleGameType" );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x21e6
// Size: 0x1c
function function_2284137aa92dbd16( duration )
{
    return utility::callsharedfunc( "hostmigration", "waitLongDurationWithPause", duration );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x220b
// Size: 0x25
function waittill_notify_or_timeout_hostmigration_pause( msg, duration )
{
    return utility::callsharedfunc( "hostmigration", "waittillNotifyOrTimeoutPause", msg, duration );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 5
// Checksum 0x0, Offset: 0x2239
// Size: 0x40
function magicbulletsharedfunc( objweapon, start, end, owner, event_ent )
{
    return utility::callsharedfunc( "weapons", "magicBullet", objweapon, start, end, owner, event_ent );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x2282
// Size: 0x1c
function setmissileminimapvisiblesharedfunc( set )
{
    return callsharedfunc( "weapons", "setMissileMinimapVisible", set );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 11
// Checksum 0x0, Offset: 0x22a7
// Size: 0x7b
function function_7a0d2d9d94d820ae( position, duration, scalemax, scalemid, scalemin, radiusmax, radiusmid, radiusmin, ignoreclients, playrumble, var_a03583ed539bdb39 )
{
    return utility::callsharedfunc( "shellshock", "artillery_earthQuake", position, duration, scalemax, scalemid, scalemin, radiusmax, radiusmid, radiusmin, ignoreclients, playrumble, var_a03583ed539bdb39 );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 4
// Checksum 0x0, Offset: 0x232b
// Size: 0x4e
function givesuperpointssharedfunc( points, scoreevent, bypassdisable, pointsmultiplier )
{
    if ( utility::issharedfuncdefined( "supers", "giveSuperPoints" ) )
    {
        self [[ utility::getsharedfunc( "supers", "giveSuperPoints" ) ]]( points, scoreevent, bypassdisable, pointsmultiplier );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x2381
// Size: 0x29
function getsuperpointsneededsharedfunc()
{
    if ( utility::issharedfuncdefined( "supers", "getSuperPointsNeeded" ) )
    {
        self [[ utility::getsharedfunc( "supers", "getSuperPointsNeeded" ) ]]();
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 4
// Checksum 0x0, Offset: 0x23b2
// Size: 0x4e
function givesupersharedfunc( superref, savesuperpoints, immediate, blueprintindex )
{
    if ( utility::issharedfuncdefined( "supers", "giveSuper" ) )
    {
        self [[ utility::getsharedfunc( "supers", "giveSuper" ) ]]( superref, savesuperpoints, immediate, blueprintindex );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x2408
// Size: 0x34
function haskillstreaksharedfunc( killstreakref )
{
    if ( utility::issharedfuncdefined( "player", "hasKillstreak" ) )
    {
        return self [[ utility::getsharedfunc( "player", "hasKillstreak" ) ]]( killstreakref );
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x2445
// Size: 0x2a
function issuperinusesharedfunc()
{
    if ( utility::issharedfuncdefined( "player", "isSuperInUse" ) )
    {
        return self [[ utility::getsharedfunc( "player", "isSuperInUse" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x2478
// Size: 0x29
function getcurrentsuperrefsharedfunc()
{
    if ( utility::issharedfuncdefined( "player", "getCurrentSuperRef" ) )
    {
        return self [[ utility::getsharedfunc( "player", "getCurrentSuperRef" ) ]]();
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x24a9
// Size: 0x2a
function function_eceea793e05658bd()
{
    if ( utility::issharedfuncdefined( "player", "br_ammo_player_is_maxed_out" ) )
    {
        return self [[ utility::getsharedfunc( "player", "br_ammo_player_is_maxed_out" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x24dc
// Size: 0x3c
function takeweaponpickupsharedfunc( pickupent, var_db943473454f6ea6 )
{
    if ( utility::issharedfuncdefined( "player", "takeWeaponPickup" ) )
    {
        self [[ utility::getsharedfunc( "player", "takeWeaponPickup" ) ]]( pickupent, var_db943473454f6ea6 );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 5
// Checksum 0x0, Offset: 0x2520
// Size: 0x57
function forcegivesupersharedfunc( targetsupername, dropcurrent, fromkiosk, droppurchased, var_db943473454f6ea6 )
{
    if ( utility::issharedfuncdefined( "player", "forceGiveSuper" ) )
    {
        self [[ utility::getsharedfunc( "player", "forceGiveSuper" ) ]]( targetsupername, dropcurrent, fromkiosk, droppurchased, var_db943473454f6ea6 );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x257f
// Size: 0x29
function function_836c7d119e02d1d5()
{
    if ( utility::issharedfuncdefined( "player", "br_ammo_player_max_out" ) )
    {
        self [[ utility::getsharedfunc( "player", "br_ammo_player_max_out" ) ]]();
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x25b0
// Size: 0x33
function addrespawntokensharedfunc( skipsplash )
{
    if ( utility::issharedfuncdefined( "player", "addRespawnToken" ) )
    {
        self [[ utility::getsharedfunc( "player", "addRespawnToken" ) ]]( skipsplash );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x25eb
// Size: 0x33
function addselfrevivetokensharedfunc( skipsplash )
{
    if ( utility::issharedfuncdefined( "player", "addSelfReviveToken" ) )
    {
        self [[ utility::getsharedfunc( "player", "addSelfReviveToken" ) ]]( skipsplash );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 8
// Checksum 0x0, Offset: 0x2626
// Size: 0x5d
function updatehitmarker_sharedfunc( markertype, killingblow, headshot, nonplayer, icontype, targetentnum, armorplatecount, var_203066c6662e1f2d )
{
    return utility::callsharedfunc( "hitmarker", "updateHitMarker_SharedFunc", markertype, killingblow, headshot, nonplayer, icontype, targetentnum, armorplatecount, var_203066c6662e1f2d );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x268c
// Size: 0x1c
function updatedamagefeedback_sharedfunc( icontype )
{
    return utility::callsharedfunc( "hitmarker", "updateDamageFeedback_SharedFunc", icontype );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x26b1
// Size: 0x2e
function isjuggernautsharedfunc()
{
    if ( utility::issharedfuncdefined( "player", "isJuggernaut" ) )
    {
        return self [[ utility::getsharedfunc( "player", "isJuggernaut" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 4
// Checksum 0x0, Offset: 0x26e7
// Size: 0x4f
function additemtobackpacksharedfunc( lootid, pickup, dontdropleftover, param4 )
{
    if ( utility::issharedfuncdefined( "player", "addItemToBackpack" ) )
    {
        return self [[ utility::getsharedfunc( "player", "addItemToBackpack" ) ]]( lootid, pickup, dontdropleftover, param4 );
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x273f
// Size: 0x29
function getavailabledmzbackpackindexsharedfunc()
{
    if ( utility::issharedfuncdefined( "player", "getAvailableDMZBackpackIndex" ) )
    {
        return [[ utility::getsharedfunc( "player", "getAvailableDMZBackpackIndex" ) ]]();
    }
    
    return undefined;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 10
// Checksum 0x0, Offset: 0x2771
// Size: 0x88
function doscoreeventsharedfunc( event, objweapon, pointsoverride, xpoverride, victim, var_51bdae03b05bc75e, dontwait, cankillchain, streakinfo, var_827c276da1cdcf23 )
{
    if ( utility::issharedfuncdefined( "player", "doScoreEvent" ) )
    {
        return [[ utility::getsharedfunc( "player", "doScoreEvent" ) ]]( event, objweapon, pointsoverride, xpoverride, victim, var_51bdae03b05bc75e, dontwait, cankillchain, streakinfo, var_827c276da1cdcf23 );
    }
    
    return undefined;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x2802
// Size: 0x3d
function preloadandqueueclasssharedfunc( class, highpriorityload )
{
    if ( utility::issharedfuncdefined( "player", "preloadAndQueueClass" ) )
    {
        return self [[ utility::getsharedfunc( "player", "preloadAndQueueClass" ) ]]( class, highpriorityload );
    }
    
    return undefined;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x2848
// Size: 0x3b
function function_be7af2b74939c9b5( player, dropcurrent )
{
    if ( utility::issharedfuncdefined( "player", "br_giveSelectedClass" ) )
    {
        [[ utility::getsharedfunc( "player", "br_giveSelectedClass" ) ]]( player, dropcurrent );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x288b
// Size: 0x2a
function iseligibleforteamrevivesharedfunc()
{
    if ( utility::issharedfuncdefined( "player", "isEligibleForTeamRevive" ) )
    {
        return self [[ utility::getsharedfunc( "player", "isEligibleForTeamRevive" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x28be
// Size: 0x33
function isrespawningfromtokensharedfunc( player )
{
    if ( utility::issharedfuncdefined( "player", "isRespawningFromToken" ) )
    {
        return [[ utility::getsharedfunc( "player", "isRespawningFromToken" ) ]]( player );
    }
    
    return 0;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 4
// Checksum 0x0, Offset: 0x28fa
// Size: 0x53
function playergulagautowinsharedfunc( sponsor, tokenused, var_5806c4765695a2f4, var_74af5908127b6729 )
{
    if ( utility::issharedfuncdefined( "player", "playerGulagAutoWin" ) )
    {
        self [[ utility::getsharedfunc( "player", "playerGulagAutoWin" ) ]]( "", sponsor, tokenused, var_5806c4765695a2f4, var_74af5908127b6729 );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x2955
// Size: 0x34
function playerprestreamrespawnoriginsharedfunc( spawnpoint )
{
    if ( utility::issharedfuncdefined( "player", "playerPrestreamRespawnOrigin" ) )
    {
        return self [[ utility::getsharedfunc( "player", "playerPrestreamRespawnOrigin" ) ]]( spawnpoint );
    }
    
    return undefined;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x2992
// Size: 0x33
function gulagfadetoblacksharedfunc( fadespectators )
{
    if ( utility::issharedfuncdefined( "player", "gulagFadeToBlack" ) )
    {
        self [[ utility::getsharedfunc( "player", "gulagFadeToBlack" ) ]]( fadespectators );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x29cd
// Size: 0x29
function gulagstreamexitsharedfunc()
{
    if ( utility::issharedfuncdefined( "player", "gulagStreamExit" ) )
    {
        self [[ utility::getsharedfunc( "player", "gulagStreamExit" ) ]]();
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x29fe
// Size: 0x3c
function playerteleportgulagsharedfunc( origin, angles )
{
    if ( utility::issharedfuncdefined( "player", "gulagStreamExit" ) )
    {
        self [[ utility::getsharedfunc( "player", "gulagStreamExit" ) ]]( origin, angles );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x2a42
// Size: 0x33
function playercleanupentondisconnectsharedfunc( ent )
{
    if ( utility::issharedfuncdefined( "player", "gulagStreamExit" ) )
    {
        self [[ utility::getsharedfunc( "player", "gulagStreamExit" ) ]]( ent );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x2a7d
// Size: 0x29
function playerwaittillstreamhintcompletesharedfunc()
{
    if ( utility::issharedfuncdefined( "player", "playerWaittillStreamHintComplete" ) )
    {
        self [[ utility::getsharedfunc( "player", "playerWaittillStreamHintComplete" ) ]]();
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x2aae
// Size: 0x29
function playerclearstreamhintoriginsharedfunc()
{
    if ( utility::issharedfuncdefined( "player", "playerClearStreamHintOrigin" ) )
    {
        self [[ utility::getsharedfunc( "player", "playerClearStreamHintOrigin" ) ]]();
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x2adf
// Size: 0x29
function resetplayermovespeedscalesharedfunc()
{
    if ( utility::issharedfuncdefined( "player", "resetPlayerMoveSpeedScale" ) )
    {
        self [[ utility::getsharedfunc( "player", "resetPlayerMoveSpeedScale" ) ]]();
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x2b10
// Size: 0x29
function gulagfadefromblacksharedfunc()
{
    if ( utility::issharedfuncdefined( "player", "gulagFadeFromBlack" ) )
    {
        self [[ utility::getsharedfunc( "player", "gulagFadeFromBlack" ) ]]();
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x2b41
// Size: 0x3c
function playerplunderkioskpurchasesharedfunc( amount, data )
{
    if ( utility::issharedfuncdefined( "player", "playerPlunderKioskPurchase" ) )
    {
        self [[ utility::getsharedfunc( "player", "playerPlunderKioskPurchase" ) ]]( amount, data );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x2b85
// Size: 0x2e
function fadetoblackforplayersharedfunc( player, fadetoblack, fadetime )
{
    return utility::callsharedfunc( "player", "fadeToBlackForPlayer", player, fadetoblack, fadetime );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 5
// Checksum 0x0, Offset: 0x2bbc
// Size: 0x40
function shellshocksharedfunc( name, category, duration, animationresponse, interruptdelayms )
{
    return utility::callsharedfunc( "player", "shellShock", name, category, duration, animationresponse, interruptdelayms );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x2c05
// Size: 0x1c
function stopshellshocksharedfunc( fromdeath )
{
    return utility::callsharedfunc( "player", "stopShellShock", fromdeath );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x2c2a
// Size: 0x12
function function_c0954ceff138883b()
{
    return utility::callsharedfunc( "player", "setDOF_cruiseFirst" );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x2c45
// Size: 0x2e
function freezecontrolssharedfunc( frozen, force, debug )
{
    return utility::callsharedfunc( "player", "freezeControls", frozen, force, debug );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x2c7c
// Size: 0x1c
function getplayersuperfactionsharedfunc( player )
{
    return utility::callsharedfunc( "player", "getSuperFaction", player );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x2ca1
// Size: 0x12
function isalivesharedfunc()
{
    return utility::callsharedfunc( "player", "_isAlive" );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 4
// Checksum 0x0, Offset: 0x2cbc
// Size: 0x37
function getplayersinradiussharedfunc( origin, radius, desiredteam, excludeent )
{
    return utility::callsharedfunc( "player", "getPlayersInRadius", origin, radius, desiredteam, excludeent );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x2cfc
// Size: 0x25
function freezelookcontrolssharedfunc( frozen, force )
{
    return utility::callsharedfunc( "player", "freezeLookControls", frozen, force );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x2d2a
// Size: 0x3b
function function_90ca6872b70e4c2e( player, reason )
{
    if ( utility::issharedfuncdefined( "dlog", "brAnalytics_inventory_snapshot" ) )
    {
        [[ utility::getsharedfunc( "dlog", "brAnalytics_inventory_snapshot" ) ]]( player, reason );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x2d6d
// Size: 0x44
function function_3cf2d6ddf853bdee( player, plunderspent, loadoutdata )
{
    if ( utility::issharedfuncdefined( "dlog", "brAnalytics_kiosk_purchaseLoadout" ) )
    {
        [[ utility::getsharedfunc( "dlog", "brAnalytics_kiosk_purchaseLoadout" ) ]]( player, plunderspent, loadoutdata );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x2db9
// Size: 0x46
function function_88cafec24778c70c( confirmstring, cancelstring, endstring )
{
    if ( utility::issharedfuncdefined( "killstreak", "waittill_confirm_or_cancel" ) )
    {
        return self [[ utility::getsharedfunc( "killstreak", "waittill_confirm_or_cancel" ) ]]( confirmstring, cancelstring, endstring );
    }
    
    return undefined;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x2e08
// Size: 0x25
function function_f8f5d33ba1c643df( bundle, killstreak )
{
    return utility::callsharedfunc( "killstreak", "killstreak_registerMinimapInfo", bundle, killstreak );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 10
// Checksum 0x0, Offset: 0x2e36
// Size: 0x71
function function_2c47324e96a0854a( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_8dfc256103cce53e, var_191284e2e2837328, premoddamagecallback, postmoddamagecallback, deathcallback )
{
    return utility::callsharedfunc( "killstreak", "killstreak_setupVehicleDamageFunctionality", streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_8dfc256103cce53e, var_191284e2e2837328, premoddamagecallback, postmoddamagecallback, deathcallback );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 11
// Checksum 0x0, Offset: 0x2eb0
// Size: 0x7b
function getmodifiedantikillstreakdamagesharedfunc( attacker, objweapon, meansofdeath, amount, maxhealth, divisorlrg, divisormed, divisorlow, divisormelee, divisortick, explodeoverride )
{
    return utility::callsharedfunc( "killstreak", "getModifiedAntiKillstreakDamage", attacker, objweapon, meansofdeath, amount, maxhealth, divisorlrg, divisormed, divisorlow, divisormelee, divisortick, explodeoverride );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x2f34
// Size: 0x1c
function function_ea1962c946f018b2( currenthealth )
{
    return utility::callsharedfunc( "killstreak", "killstreak_updateDamageState", currenthealth );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 8
// Checksum 0x0, Offset: 0x2f59
// Size: 0x5d
function function_de31b76c1bf488e8( streakinfo, weaponobj, firednotify, weapongivencallback, weaponswitchendedcallback, weaponfiredcallback, weaponcleanupcallback, weapontakencallback )
{
    return callsharedfunc( "killstreak", "streakDeploy_doWeaponFiredDeploy", streakinfo, weaponobj, firednotify, weapongivencallback, weaponswitchendedcallback, weaponfiredcallback, weaponcleanupcallback, weapontakencallback );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x2fbf
// Size: 0x27
function playerkillstreakgetownerlookatignoreentssharedfunc()
{
    if ( issharedfuncdefined( "killstreak", "playerKillstreakGetOwnerLookAtIgnoreEnts" ) )
    {
        return callsharedfunc( "killstreak", "playerKillstreakGetOwnerLookAtIgnoreEnts" );
    }
    
    return undefined;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 5
// Checksum 0x0, Offset: 0x2fef
// Size: 0x40
function function_940b2080e171a9d3( owner, ownerteam, range, streakname, location )
{
    return callsharedfunc( "killstreak", "killstreak_dangerNotifyPlayersInRange", owner, ownerteam, range, streakname, location );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 4
// Checksum 0x0, Offset: 0x3038
// Size: 0x37
function registerkillstreaksharedfunc( streakname, triggeredfunc, availablefunc, directusefunc )
{
    return utility::callsharedfunc( "killstreak", "registerKillstreak", streakname, triggeredfunc, availablefunc, directusefunc );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x3078
// Size: 0x2e
function registerkillstreakdamagedealingweaponsharedfunc( streakname, var_d8a64ed9bcdf7185, damagesize )
{
    return utility::callsharedfunc( "killstreak", "registerKillstreakDamageDealingWeapon", streakname, var_d8a64ed9bcdf7185, damagesize );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x30af
// Size: 0x2e
function registervisibilityomnvarforkillstreaksharedfunc( streakname, omnvarid, omnvarvalue )
{
    return utility::callsharedfunc( "killstreak", "registerVisibilityOmnvarForKillstreak", streakname, omnvarid, omnvarvalue );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x30e6
// Size: 0x25
function createstreakinfosharedfunc( streakname, owner )
{
    return utility::callsharedfunc( "killstreak", "createStreakInfo", streakname, owner );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 10
// Checksum 0x0, Offset: 0x3114
// Size: 0x71
function function_63046c2c6bbd3868( streakinfo, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_f6a32dcc4b19aad9, var_67a06b4ea269058e, var_afe464c242489272, var_818a18147626dfbf, var_c2a00d4f077ebd87 )
{
    return utility::callsharedfunc( "killstreak", "streakDeploy_doWeaponTabletDeploy", streakinfo, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_f6a32dcc4b19aad9, var_67a06b4ea269058e, var_afe464c242489272, var_818a18147626dfbf, var_c2a00d4f077ebd87 );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x318e
// Size: 0x12
function getkillstreakairstrikeheightentsharedfunc()
{
    return utility::callsharedfunc( "killstreak", "getKillstreakAirStrikeHeightEnt" );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 5
// Checksum 0x0, Offset: 0x31a9
// Size: 0x40
function function_d1b8339c6ab7b1fa( streakname, dialog, bypasscooldown, delaytime, charactersuffix )
{
    return utility::callsharedfunc( "killstreak", "playKillstreakOperatorDialog", streakname, dialog, bypasscooldown, delaytime, charactersuffix );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x31f2
// Size: 0x34
function forceusekillstreaksharedfunc( killstreakref )
{
    if ( utility::issharedfuncdefined( "killstreak", "forceUseKillstreak" ) )
    {
        return self [[ utility::getsharedfunc( "killstreak", "forceUseKillstreak" ) ]]( killstreakref );
    }
    
    return undefined;
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x322f
// Size: 0x46
function showkillstreaksplashsharedfunc( splashref, streakval, fromcarepackage )
{
    if ( utility::issharedfuncdefined( "airdrop", "showKillstreakSplash" ) )
    {
        self thread [[ utility::getsharedfunc( "airdrop", "showKillstreakSplash" ) ]]( splashref, streakval, fromcarepackage );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 7
// Checksum 0x0, Offset: 0x327d
// Size: 0x6a
function awardkillstreaksharedfunc( streakname, source, overridelifeid, var_722764086bd2150d, overrideowner, var_546f4a2e8b131d3f, blueprintindex )
{
    if ( utility::issharedfuncdefined( "killstreak", "awardKillstreak" ) )
    {
        self [[ utility::getsharedfunc( "killstreak", "awardKillstreak" ) ]]( streakname, source, overridelifeid, var_722764086bd2150d, overrideowner, var_546f4a2e8b131d3f, blueprintindex );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x32ef
// Size: 0x25
function setvisibiilityomnvarforkillstreaksharedfunc( streakname, omnvarstate )
{
    return utility::callsharedfunc( "killstreak", "setVisibiilityOmnvarForKillstreak", streakname, omnvarstate );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x331d
// Size: 0x1c
function restorekillstreakplayeranglessharedfunc( player )
{
    return utility::callsharedfunc( "killstreak", "restoreKillstreakPlayerAngles", player );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x3342
// Size: 0x1c
function recordkillstreakendstatssharedfunc( streakinfo )
{
    return utility::callsharedfunc( "killstreak", "recordKillstreakEndStats", streakinfo );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x3367
// Size: 0x1c
function function_b23ab1c04cc7fea2( visionsetname )
{
    return utility::callsharedfunc( "killstreak", "killstreak_setMainVision", visionsetname );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x338c
// Size: 0x1c
function function_a271c8ce1dd6c1b1( visionsetinfo )
{
    return utility::callsharedfunc( "killstreak", "killstreak_setSubVision", visionsetinfo );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x33b1
// Size: 0x1c
function function_2470b047f8e10642( count )
{
    return utility::callsharedfunc( "vehicle", "reserveVehicle", count );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x33d6
// Size: 0x1c
function function_49d5647f46bfe073( count )
{
    return utility::callsharedfunc( "vehicle", "clearVehicleReservation", count );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x33fb
// Size: 0x1c
function function_10498f0a8127ad3a( bool )
{
    return utility::callsharedfunc( "vehicle", "vehicle_damage_setCanDamage", bool );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x3420
// Size: 0x25
function function_3c16f3b83d60acbb( ref, minradius )
{
    return utility::callsharedfunc( "vehicle", "vehicle_spawn_setClearanceCheckMinRadius", ref, minradius );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x344e
// Size: 0x2e
function function_b2db3eefeaba048f( data, changed, fromdeath )
{
    return utility::callsharedfunc( "vehicle", "vehicle_damage_clearVisuals", data, changed, fromdeath );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x3485
// Size: 0x12
function function_d7d7db3140b95ce3()
{
    return callsharedfunc( "vehicle", "vehicleCanFly" );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x34a0
// Size: 0x25
function function_1a9f6dcef6e686ab( spawndata, faildata )
{
    return utility::callsharedfunc( "vehicle", "spawnVehicle", spawndata, faildata );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x34ce
// Size: 0x1c
function function_2b2ae7070b2e47d( vehicle )
{
    return utility::callsharedfunc( "vehicle", "deleteVehicle", vehicle );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x34f3
// Size: 0x2e
function function_84cc2da11f01ae43( vehicle, owner, team )
{
    return utility::callsharedfunc( "vehicle", "registerInstance", vehicle, owner, team );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x352a
// Size: 0x1c
function function_239d68eacdce9d10( vehicle )
{
    return utility::callsharedfunc( "vehicle", "deregisterInstance", vehicle );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x354f
// Size: 0x1c
function function_97e107d1361352a9( position )
{
    return utility::callsharedfunc( "event", "predatorMissileImpact", position );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x3574
// Size: 0x1c
function function_1d266a4cf6b48ffa( position )
{
    return utility::callsharedfunc( "event", "largeVehicleExplosion", position );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x3599
// Size: 0x1c
function function_60a28142eebe56eb( damagedata )
{
    return utility::callsharedfunc( "event", "vehicleKilled", damagedata );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x35be
// Size: 0x1c
function function_f03259645f5df6c0( missile )
{
    return utility::callsharedfunc( "event", "missileFired", missile );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 4
// Checksum 0x0, Offset: 0x35e3
// Size: 0x3f
function function_641996b5e113c5c6( entity, applycallback, startcallback, clearcallback )
{
    return utility::callsharedfunc( #"emp", #"hash_a865e3770eb96298", entity, applycallback, startcallback, clearcallback );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x362b
// Size: 0x1c
function function_83cebe0ae5318a7f( entity )
{
    return utility::callsharedfunc( "emp", "emp_debuff_deregister", entity );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x3650
// Size: 0x1c
function function_940c49da06910de0( fromdeath )
{
    return utility::callsharedfunc( "emp", "clear_emp", fromdeath );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x3675
// Size: 0x1c
function function_72b03e277d253250( status )
{
    return utility::callsharedfunc( "emp", "allow_emp", status );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x369a
// Size: 0x12
function function_8e610f938a53a07d()
{
    return utility::callsharedfunc( "emp", "emp_debuff_get_emp_count" );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x36b5
// Size: 0x12
function function_f3890748bda5f813()
{
    return callsharedfunc( "emp", "is_empd" );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x36d0
// Size: 0x25
function function_345d613203ca10d8( scramblelevel, isjammer )
{
    return utility::callsharedfunc( "emp", "play_scramble", scramblelevel, isjammer );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x36fe
// Size: 0x25
function function_ea96a5c13167a126( scramblelevel, isjammer )
{
    return utility::callsharedfunc( "emp", "stop_scramble", scramblelevel, isjammer );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x372c
// Size: 0x2e
function playsoundtoplayersharedfunc( aliasname, player, srcentity )
{
    return utility::callsharedfunc( "sound", "playSoundToPlayer", aliasname, player, srcentity );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 5
// Checksum 0x0, Offset: 0x3763
// Size: 0x40
function spawnfxforclientsharedfunc( fxid, position, player, forward, up )
{
    return utility::callsharedfunc( "fx", "SpawnFXForClient", fxid, position, player, forward, up );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x37ac
// Size: 0x13
function setfxkilldefondeletesharedfunc()
{
    utility::callsharedfunc( "fx", "SetFXKillDefOnDelete" );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x37c7
// Size: 0x25
function function_2611d163b331ae1d( scriptbundle_name, current_round )
{
    return utility::callsharedfunc( "zombie", "health_scaling_get_starting_health", scriptbundle_name, current_round );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x37f5
// Size: 0x12
function function_f1810da227cb50f9()
{
    return utility::callsharedfunc( "zombie", "ammo_mod_cooldown_init" );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x3810
// Size: 0x1c
function function_2e380dedfcfc7972( w_current )
{
    return utility::callsharedfunc( "zombie", "has_ammo_mod", w_current );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x3835
// Size: 0x1c
function function_87b7af080857567f( w_current )
{
    return utility::callsharedfunc( "zombie", "get_ammo_mod_name", w_current );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x385a
// Size: 0x1c
function getplayerweaponraritysharedfunc( weapon )
{
    return utility::callsharedfunc( "zombie", "GetPlayerWeaponRarity", weapon );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x387f
// Size: 0x1c
function function_af5127390d3221e9( weapon )
{
    return utility::callsharedfunc( "zombie", "get_pap_level", weapon );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x38a4
// Size: 0x1c
function function_1ae8c41da6a042c3( dmg_struct )
{
    return utility::callsharedfunc( "zombie", "scale_underbarrel_damage", dmg_struct );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 10
// Checksum 0x0, Offset: 0x38c9
// Size: 0x71
function onhumanoidagentkilledcommon_sharedfunc( einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, dropweapons )
{
    return utility::callsharedfunc( "ai", "onHumanoidAgentKilledCommon_SharedFunc", einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, dropweapons );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 6
// Checksum 0x0, Offset: 0x3943
// Size: 0x49
function spawnnewaitype_sharedfunc( aitype, position, angles, team, characterlistname, gender )
{
    return utility::callsharedfunc( "ai", "spawnNewAIType_SharedFunc", aitype, position, angles, team, characterlistname, gender );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 5
// Checksum 0x0, Offset: 0x3995
// Size: 0x40
function animscripted_sharedfunc( anime, anim_string, org, animangles, anim_flag )
{
    return utility::callsharedfunc( "ai", "Animscripted_SharedFunc", anime, anim_string, org, animangles, anim_flag );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x39de
// Size: 0x1c
function get_aitype_by_subclass_sharedfunc( subclass )
{
    return utility::callsharedfunc( "ai", "get_aitype_by_subclass_SharedFunc", subclass );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x3a03
// Size: 0x12
function get_aitype_default_spawn_team_sharedfunc()
{
    return utility::callsharedfunc( "ai", "get_aitype_default_spawn_team_SharedFunc" );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 11
// Checksum 0x0, Offset: 0x3a1e
// Size: 0x7b
function displaydamagenumber_sharedfunc( eattacker, etargethit, shitloc, smeansofdeath, sweapon, idamage, vpoint, isimmnue, selement, biscritical, var_feef4b237a6beb07 )
{
    return utility::callsharedfunc( "ai", "displayDamageNumber_SharedFunc", eattacker, etargethit, shitloc, smeansofdeath, sweapon, idamage, vpoint, isimmnue, selement, biscritical, var_feef4b237a6beb07 );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x3aa2
// Size: 0x1c
function giveaiweapon_sharedfunc( weapname )
{
    return utility::callsharedfunc( "ai", "giveAIWeapon", weapname );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x3ac7
// Size: 0x12
function getfreeaicount_sharedfunc()
{
    return utility::callsharedfunc( "ai", "GetFreeAICount" );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x3ae2
// Size: 0x12
function function_2f8556207c6fd79f()
{
    return callsharedfunc( "cameras", "GetCameraThirdPerson" );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x3afd
// Size: 0x12
function function_aef9ca498b472945()
{
    return callsharedfunc( "cameras", "GetCameraThirdPersonOrigin" );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 2
// Checksum 0x0, Offset: 0x3b18
// Size: 0x3c
function showpoweruphudsharedfunc( powerupname, lifetime )
{
    if ( utility::issharedfuncdefined( "powerups", "showPowerupHud" ) )
    {
        self [[ utility::getsharedfunc( "powerups", "showPowerupHud" ) ]]( powerupname, lifetime );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x3b5c
// Size: 0x29
function dopowerupscoreeventsharedfunc()
{
    if ( utility::issharedfuncdefined( "powerups", "doPowerupScoreEvent" ) )
    {
        self [[ utility::getsharedfunc( "powerups", "doPowerupScoreEvent" ) ]]();
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 3
// Checksum 0x0, Offset: 0x3b8d
// Size: 0x45
function droppowerupsharedfunc( powerupname, spawnpos, lifetimeoverride )
{
    if ( utility::issharedfuncdefined( "powerups", "dropPowerup" ) )
    {
        return self [[ utility::getsharedfunc( "powerups", "dropPowerup" ) ]]( powerupname, spawnpos, lifetimeoverride );
    }
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 0
// Checksum 0x0, Offset: 0x3bda
// Size: 0x12
function function_fc2ee23e4402d457()
{
    return utility::callsharedfunc( "points", "get_points" );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x3bf5
// Size: 0x1c
function function_993919ed9d35feeb( points )
{
    return utility::callsharedfunc( "points", "set_points", points );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x3c1a
// Size: 0x1c
function function_36a28b99ec0f7fd8( points )
{
    return utility::callsharedfunc( "points", "add_points", points );
}

// Namespace namespace_2b1145f62aa835b8 / namespace_53fc9ddbb516e6e1
// Params 1
// Checksum 0x0, Offset: 0x3c3f
// Size: 0x1c
function function_88137cfcbacc59b2( points )
{
    return utility::callsharedfunc( "points", "take_points", points );
}

