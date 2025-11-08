#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\armor;
#using scripts\cp\challenges_cp;
#using scripts\cp\cp_gameskill;
#using scripts\cp\cp_grenade_crate;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_movers;
#using scripts\cp\cp_outline_utility;
#using scripts\cp\cp_relics;
#using scripts\cp\endgame;
#using scripts\cp\equipment\nvg;
#using scripts\cp\inventory\cp_target_marker;
#using scripts\cp\kits;
#using scripts\cp\loadout;
#using scripts\cp\loot_system;
#using scripts\cp\pickups;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\gestures;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\airdrop_escort;
#using scripts\cp_mp\killstreaks\airdrop_multiple;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;

#namespace airdrop_cp;

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0xadd
// Size: 0x2a4
function init()
{
    scripts\engine\utility::registersharedfunc( "airdrop", "airdropMultipleInit", &airdrop_airdropmultipleinit );
    scripts\engine\utility::registersharedfunc( "airdrop", "airdropEscortInit", &function_563387bd27d5b942 );
    scripts\engine\utility::registersharedfunc( "airdrop", "registerScoreInfo", &airdrop_registerscoreinfo );
    scripts\engine\utility::registersharedfunc( "airdrop", "registerActionSet", &airdrop_registeractionset );
    scripts\engine\utility::registersharedfunc( "airdrop", "updateUIProgress", &airdrop_updateuiprogress );
    scripts\engine\utility::registersharedfunc( "airdrop", "allowActionSet", &airdrop_allowactionset );
    scripts\engine\utility::registersharedfunc( "airdrop", "unresolvedCollisionNearestNode", &airdrop_unresolvedcollisionnearestnode );
    scripts\engine\utility::registersharedfunc( "airdrop", "showErrorMessage", &airdrop_showerrormessage );
    scripts\engine\utility::registersharedfunc( "airdrop", "awardKillstreak", &airdrop_awardkillstreak );
    scripts\engine\utility::registersharedfunc( "airdrop", "showKillstreakSplash", &airdrop_showkillstreaksplash );
    scripts\engine\utility::registersharedfunc( "airdrop", "getTargetMarker", &airdrop_gettargetmarker );
    scripts\engine\utility::registersharedfunc( "airdrop", "airdropMultipleDropCrates", &airdrop_airdropmultipledropcrates );
    scripts\engine\utility::registersharedfunc( "airdrop", "registerCrateForCleanup", &airdrop_registercrateforcleanup );
    scripts\engine\utility::registersharedfunc( "airdrop", "makeWeaponFromCrate", &airdrop_makeweaponfromcrate );
    scripts\engine\utility::registersharedfunc( "airdrop", "makeItemFromCrate", &airdrop_makeitemfromcrate );
    scripts\engine\utility::registersharedfunc( "airdrop", "outlineDisable", &airdrop_outlinedisable );
    scripts\engine\utility::registersharedfunc( "airdrop", "br_forceGiveWeapon", &airdrop_br_forcegiveweapon );
    scripts\engine\utility::registersharedfunc( "airdrop", "captureLootCacheCallback", &airdrop_capturelootcachecallback );
    scripts\engine\utility::registersharedfunc( "airdrop", "getGameModeSpecificCrateData", &airdrop_getgamemodespecificcratedata );
    scripts\engine\utility::registersharedfunc( "airdrop", "specialCase_canUseCrate", &airdrop_specialcasecanusecrate );
    scripts\engine\utility::registersharedfunc( "airdrop", "airdropSelectLoadout", &function_3fbfee87ee058fe1 );
    scripts\engine\utility::registersharedfunc( "airdrop", "airdrop_cannotUseLoadoutCrateHint", &airdrop_cannotuseloadoutcratehint );
    level.crate_random_weapons = [ "brloot_weapon_ak47", "brloot_weapon_as50", "brloot_weapon_aug", "brloot_weapon_dp12", "brloot_weapon_famas", "brloot_weapon_g21", "brloot_weapon_hk121", "brloot_weapon_kar98", "brloot_weapon_m14", "brloot_weapon_m4", "brloot_weapon_m870", "brloot_weapon_marlin", "brloot_weapon_mcx", "brloot_weapon_mp5", "brloot_weapon_mp7", "brloot_weapon_p90", "brloot_weapon_pkm", "brloot_weapon_python", "brloot_weapon_p320" ];
    level thread function_20c12aa7546fcaa5();
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0xd89
// Size: 0x7c
function loadout_clearweapons( var_bea1f8064eda3de9 )
{
    if ( istrue( var_bea1f8064eda3de9 ) )
    {
        if ( isdefined( self.primaryweaponobj ) )
        {
            scripts\cp_mp\utility\inventory_utility::_takeweapon( self.primaryweaponobj );
        }
        
        if ( isdefined( self.secondaryweaponobj ) )
        {
            scripts\cp_mp\utility\inventory_utility::_takeweapon( self.secondaryweaponobj );
        }
    }
    else
    {
        self takeallweapons();
    }
    
    self.primaryweapon = undefined;
    self.primaryweaponobj = undefined;
    self.secondaryweapon = undefined;
    self.secondaryweaponobj = undefined;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 2
// Checksum 0x0, Offset: 0xe0d
// Size: 0x72
function loadout_clearplayer( var_bea1f8064eda3de9, var_645209a780738479 )
{
    if ( !istrue( var_645209a780738479 ) )
    {
        scripts\cp\pickups::function_c78e977650c14d64();
        
        if ( isdefined( scripts\cp_mp\equipment::getcurrentequipment( "primary" ) ) )
        {
            scripts\cp\pickups::dropequipmentinslot( "primary" );
        }
        
        if ( isdefined( scripts\cp_mp\equipment::getcurrentequipment( "secondary" ) ) )
        {
            scripts\cp\pickups::dropequipmentinslot( "secondary" );
        }
    }
    
    loadout_clearweapons( 0 );
    scripts\cp_mp\equipment::clearallequipment();
    scripts\cp_mp\gestures::cleargesture();
    scripts\cp_mp\execution::_clearexecution();
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 2
// Checksum 0x0, Offset: 0xe87
// Size: 0x21
function loadout_updateplayeractionslots( struct, class )
{
    self setactionslot( 3, "altmode" );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0xeb0
// Size: 0x1a
function respawnitems_getrespawnitems()
{
    if ( isdefined( self.respawnitems ) )
    {
        return self.respawnitems;
    }
    
    return undefined;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xed3
// Size: 0x1e, Type: bool
function private respawnitems_hasequipmentdata( respawnitems )
{
    if ( !isdefined( respawnitems ) )
    {
        return false;
    }
    
    return isdefined( respawnitems.equipment );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0xefa
// Size: 0x289
function loadout_updateclassfinalweapons( struct )
{
    if ( istrue( struct.loadoutprimaryaddblueprintattachments ) )
    {
        struct.loadoutprimaryobject = scripts\cp_mp\weapon::buildweapon_blueprintwithcustomattachments( struct.loadoutprimary, struct.loadoutprimaryattachments, struct.loadoutprimarycamo, struct.loadoutprimaryreticle, struct.loadoutprimaryvariantid, struct.loadoutprimaryattachmentids, struct.loadoutprimarycosmeticattachment, struct.loadoutprimarystickers, istrue( struct.loadouthasnvg ) );
    }
    else
    {
        struct.loadoutprimaryobject = scripts\cp_mp\weapon::buildweapon( struct.loadoutprimary, struct.loadoutprimaryattachments, struct.loadoutprimarycamo, struct.loadoutprimaryreticle, struct.loadoutprimaryvariantid, struct.loadoutprimaryattachmentids, struct.loadoutprimarycosmeticattachment, struct.loadoutprimarystickers, istrue( struct.loadouthasnvg ), struct.var_193bf3cfb8aeaf0f );
    }
    
    struct.loadoutprimaryfullname = getcompleteweaponname( struct.loadoutprimaryobject );
    
    if ( struct.loadoutsecondary == "none" )
    {
        struct.loadoutsecondaryfullname = "none";
        struct.loadoutsecondaryobject = undefined;
    }
    else
    {
        if ( istrue( struct.loadoutsecondaryaddblueprintattachments ) )
        {
            struct.loadoutsecondaryobject = scripts\cp_mp\weapon::buildweapon_blueprintwithcustomattachments( struct.loadoutsecondary, struct.loadoutsecondaryattachments, struct.loadoutsecondarycamo, struct.loadoutsecondaryreticle, struct.loadoutsecondaryvariantid, struct.loadoutsecondaryattachmentids, struct.loadoutsecondarycosmeticattachment, struct.loadoutsecondarystickers, istrue( struct.loadouthasnvg ) );
        }
        else
        {
            struct.loadoutsecondaryobject = scripts\cp_mp\weapon::buildweapon( struct.loadoutsecondary, struct.loadoutsecondaryattachments, struct.loadoutsecondarycamo, struct.loadoutsecondaryreticle, struct.loadoutsecondaryvariantid, struct.loadoutsecondaryattachmentids, struct.loadoutsecondarycosmeticattachment, struct.loadoutsecondarystickers, istrue( struct.loadouthasnvg ), struct.var_ead3720e647f74a3 );
        }
        
        struct.loadoutsecondaryfullname = getcompleteweaponname( struct.loadoutsecondaryobject );
    }
    
    return struct;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 4
// Checksum 0x0, Offset: 0x118c
// Size: 0x5e
function function_8227ba8be6102414( struct, class, setspawnweap, skipfirstraise )
{
    struct = loadout_updateclassfinalweapons( struct );
    scripts\cp_mp\utility\inventory_utility::_giveweapon( struct.loadoutprimaryobject, undefined, undefined, 0 );
    scripts\cp_mp\utility\inventory_utility::_giveweapon( struct.loadoutsecondaryobject, undefined, undefined, 0 );
    scripts\cp\loadout::function_9743c56a4d2dc135( struct );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 4
// Checksum 0x0, Offset: 0x11f2
// Size: 0x1f6
function loadout_updateplayerweapons( struct, class, setspawnweap, skipfirstraise )
{
    respawnitems = respawnitems_getrespawnitems();
    var_3920d61392aec9d5 = scripts\cp\weapon::function_768c9a047aed19f4( struct.loadoutprimary + "_mp" );
    struct.loadoutprimary = var_3920d61392aec9d5.basename;
    nvgattachment = undefined;
    
    if ( isdefined( struct.loadoutprimaryattachments ) )
    {
        if ( scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4() )
        {
            if ( scripts\cp_mp\weapon::weaponsupportslaserir( struct.loadoutprimary ) )
            {
                nvgattachment = scripts\cp_mp\weapon::getweaponnvgattachment( struct.loadoutprimary );
            }
            
            if ( isdefined( nvgattachment ) )
            {
                struct.loadoutprimaryattachments = array_add( struct.loadoutprimaryattachments, nvgattachment );
            }
        }
        
        var_3920d61392aec9d5 = var_3920d61392aec9d5 scripts\cp\weapon::function_dcb52bcbbcb80b00( struct.loadoutprimaryattachments );
        struct.loadoutprimaryattachments = var_3920d61392aec9d5.attachments;
    }
    
    scripts\cp_mp\utility\inventory_utility::_giveweapon( var_3920d61392aec9d5, undefined, undefined, 0 );
    var_976a64288e459315 = scripts\cp\weapon::function_768c9a047aed19f4( struct.loadoutsecondary + "_mp" );
    struct.loadoutsecondary = var_976a64288e459315.basename;
    nvgattachment = undefined;
    
    if ( isdefined( struct.loadoutsecondaryattachments ) )
    {
        if ( scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4() )
        {
            if ( scripts\cp_mp\weapon::weaponsupportslaserir( struct.loadoutprimary ) )
            {
                nvgattachment = scripts\cp_mp\weapon::getweaponnvgattachment( struct.loadoutsecondary );
            }
            
            if ( isdefined( nvgattachment ) )
            {
                struct.loadoutsecondaryattachments = array_add( struct.loadoutsecondaryattachments, nvgattachment );
            }
        }
        
        var_976a64288e459315 = var_976a64288e459315 scripts\cp\weapon::function_dcb52bcbbcb80b00( struct.loadoutsecondaryattachments );
        struct.loadoutsecondaryattachments = var_976a64288e459315.attachments;
    }
    
    scripts\cp_mp\utility\inventory_utility::_giveweapon( var_976a64288e459315, undefined, undefined, 0 );
    
    if ( !isai( self ) )
    {
        scripts\cp_mp\utility\inventory_utility::_switchtoweapon( var_3920d61392aec9d5 );
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x13f0
// Size: 0xfd
function loadout_updateplayerequipment( struct )
{
    respawnitems = respawnitems_getrespawnitems();
    var_b86cf5cef6838543 = respawnitems_hasequipmentdata( respawnitems );
    self.loadoutequipmentprimary = struct.loadoutequipmentprimary;
    self.loadoutequipmentsecondary = struct.loadoutequipmentsecondary;
    var_e7d8e765ac9243a6 = undefined;
    
    if ( !var_b86cf5cef6838543 )
    {
        var_e7d8e765ac9243a6 = struct.loadoutequipmentprimary;
    }
    else
    {
        var_e7d8e765ac9243a6 = scripts\cp_mp\equipment::function_7f245729fcb6414d( struct.loadoutequipmentprimary );
    }
    
    var_604669419e2560e6 = undefined;
    
    if ( !var_b86cf5cef6838543 )
    {
        var_604669419e2560e6 = struct.loadoutequipmentsecondary;
    }
    else
    {
        var_604669419e2560e6 = scripts\cp_mp\equipment::function_7f245729fcb6414d( struct.loadoutequipmentsecondary );
    }
    
    scripts\cp_mp\equipment::giveequipment( var_e7d8e765ac9243a6, "primary" );
    scripts\cp_mp\equipment::giveequipment( var_604669419e2560e6, "secondary" );
    
    if ( scripts\cp\utility::_hasperk( "specialty_extra_tactical" ) )
    {
        scripts\cp_mp\equipment::incrementequipmentammo( var_604669419e2560e6 );
    }
    
    if ( scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4() )
    {
        thread scripts\cp\equipment\nvg::runnvg();
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 5
// Checksum 0x0, Offset: 0x14f5
// Size: 0x7a
function loadout_updateplayer( globalstruct, struct, class, setspawnweap, skipfirstraise )
{
    function_8227ba8be6102414( struct, class, setspawnweap, skipfirstraise );
    loadout_updateplayerequipment( struct );
    loadout_updateplayeractionslots( struct, class );
    thread scripts\cp\loadout::function_7da7bd24b280d295();
    self.pers[ "lastClass" ] = self.class;
    self.lastclass = self.class;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 6
// Checksum 0x0, Offset: 0x1577
// Size: 0x106
function giveloadout( team, class, class_index, var_bea1f8064eda3de9, skipfirstraise, var_645209a780738479 )
{
    self notify( "giveLoadout_start" );
    self.gettingloadout = 1;
    var_364d691b501cd27f = scripts\cp_mp\armor::function_600f6cf462e983f();
    loadout_clearplayer( var_bea1f8064eda3de9, var_645209a780738479 );
    struct = undefined;
    
    if ( isdefined( self.preloadedclassstruct ) )
    {
        struct = self.preloadedclassstruct;
        self.preloadedclassstruct = undefined;
        self.class_num = class_index;
    }
    else
    {
        struct = scripts\cp\loadout::loadout_getclassstruct();
        
        if ( function_d35dd7ced886e904( class_index ) )
        {
            struct = scripts\cp\loadout::loadout_updateclassdefault( struct, class - 100 );
        }
        else
        {
            struct = scripts\cp\loadout::loadout_updateclasscustom( struct, class );
        }
    }
    
    self.classstruct = struct;
    loadout_updateplayer( struct, struct, class, undefined, skipfirstraise );
    
    if ( !istrue( var_645209a780738479 ) )
    {
        scripts\cp\challenges_cp::function_b036c3abb6389913();
    }
    
    scripts\cp_mp\armor::function_9c6e9a6643b6c9a6( var_364d691b501cd27f );
    self.gettingloadout = 0;
    self notify( "giveLoadout" );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x1685
// Size: 0x16, Type: bool
function function_d35dd7ced886e904( class_index )
{
    if ( class_index >= 100 )
    {
        return true;
    }
    
    return false;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 2
// Checksum 0x0, Offset: 0x16a4
// Size: 0xa2
function swaploadout( newclass, var_645209a780738479 )
{
    self endon( "death_or_disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    self endon( "swapLoadout" );
    self.tag_stowed_back = undefined;
    self.tag_stowed_hip = undefined;
    giveloadout( self.pers[ "team" ], self.pers[ "class" ], newclass, 1, undefined, var_645209a780738479 );
    
    if ( ent_flag_exist( "swapLoadout_pending" ) && ent_flag( "swapLoadout_pending" ) )
    {
        ent_flag_clear( "swapLoadout_pending" );
        ent_flag_set( "swapLoadout_complete" );
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 3
// Checksum 0x0, Offset: 0x174e
// Size: 0x86
function onclasschoicecallback( class_index, var_f01f8e178ff54eda, var_645209a780738479 )
{
    self notify( "loadout_class_selected", class_index );
    
    if ( class_index < 0 )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "class" ] ) || class_index != self.pers[ "class" ] )
    {
        self.pers[ "class" ] = class_index;
        self.class = class_index;
    }
    
    var_cd83a28652a3f837 = 1;
    thread swaploadout( class_index, var_645209a780738479 );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x17dc
// Size: 0x11b
function function_20c12aa7546fcaa5()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    flag_wait( "level_ready_for_script" );
    var_540e67c54116d1a7 = getentarray( "loadout_drop", "targetname" );
    
    if ( var_540e67c54116d1a7.size < 1 )
    {
        return;
    }
    
    initcploadoutcratedata();
    level.var_f3af0989226d9cf0 = [];
    
    foreach ( old_crate in var_540e67c54116d1a7 )
    {
        crate_origin = old_crate.origin;
        crate_angles = old_crate.angles;
        old_crate delete();
        
        if ( scripts\cp\cp_relics::function_7915e88a08f28705() && !scripts\cp\cp_gameskill::function_f8448fd91abb54c8() )
        {
            continue;
        }
        
        if ( getdvarint( @"hash_e8a826507d365217", 0 ) )
        {
            continue;
        }
        
        level.var_f3af0989226d9cf0[ level.var_f3af0989226d9cf0.size ] = scripts\cp_mp\killstreaks\airdrop::createcrate( undefined, "allies", "loadout_drop_cp", crate_origin, crate_angles, undefined, 1, 0 );
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x18ff
// Size: 0x12
function airdrop_cannotuseloadoutcratehint()
{
    scripts\cp\utility::hint_prompt( "cant_use_loadout_crate_again", 1, 2 );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 2
// Checksum 0x0, Offset: 0x1919
// Size: 0x1a3
function function_3fbfee87ee058fe1( crate, var_645209a780738479 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self freezecontrols( 1 );
    self.instantclassswapallowed = 1;
    self setclientomnvar( "ui_options_menu", 2 );
    thread function_91993094d8aade48( "death" );
    thread function_91993094d8aade48( "last_stand_start" );
    thread function_91993094d8aade48( "luinotifyserver" );
    self waittill( "exit_airdrop_loadout", result, class_index );
    
    if ( isdefined( crate ) && iscp() && isdefined( result ) && !( result < 0 ) )
    {
        crate.disabled_use_for[ self getentitynumber() ] = 1;
    }
    
    self.instantclassswapallowed = 0;
    self freezecontrols( 0 );
    self setclientomnvar( "ui_options_menu", 0 );
    
    if ( isdefined( result ) && !( result < 0 ) && isdefined( class_index ) && class_index >= 0 )
    {
        if ( isdefined( crate ) )
        {
            crate scripts\cp_mp\killstreaks\airdrop::loadoutcratepostcapture( self );
        }
        
        onclasschoicecallback( class_index, undefined, var_645209a780738479 );
        return;
    }
    
    if ( isdefined( crate ) && getdvarint( @"hash_618b9c003b5b3883" ) == 0 )
    {
        if ( !isdefined( crate.playerscaptured ) )
        {
            crate.playerscaptured = [];
        }
        
        if ( isdefined( crate ) && isdefined( crate.playerscaptured ) && isdefined( crate.playerscaptured[ self getentitynumber() ] ) )
        {
            if ( crate.playerscaptured[ self getentitynumber() ] == self )
            {
                crate.playerscaptured = array_remove( crate.playerscaptured, self );
            }
        }
    }
    
    return;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x1ac4
// Size: 0x7f
function function_91993094d8aade48( actionnotify )
{
    self endon( "exit_airdrop_loadout" );
    selectedloadout = -1;
    
    while ( true )
    {
        self waittill( actionnotify, param1, param2 );
        
        if ( actionnotify == "luinotifyserver" )
        {
            if ( param1 != "class_select" )
            {
                if ( param1 == "class_menu_closed" )
                {
                    self notify( "exit_airdrop_loadout", selectedloadout );
                    break;
                }
                
                continue;
            }
            
            selectedloadout = 1;
        }
        
        self notify( "exit_airdrop_loadout", selectedloadout, param2 );
        break;
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x1b4b
// Size: 0xa3
function initcpcratedata()
{
    leveldata = scripts\cp_mp\killstreaks\airdrop::getleveldata( "cp" );
    leveldata.capturestring = &"MP/BR_CRATE";
    leveldata.enemymodel = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.headicon = undefined;
    leveldata.headiconoffset = 30;
    leveldata.headicondrawrange = 750;
    leveldata.usepriority = 0;
    leveldata.timeout = undefined;
    leveldata.activatecallback = &cpcrateactivatecallback;
    leveldata.capturecallback = &cpcratecapturecallback;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x1bf6
// Size: 0x29
function getcpcratedatabytype( type )
{
    data = spawnstruct();
    data.type = type;
    return data;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x1c28
// Size: 0x37
function cpcrateactivatecallback( isfirstactivation )
{
    if ( istrue( isfirstactivation ) )
    {
        if ( issharedfuncdefined( "airdrop", "registerCrateForCleanup" ) )
        {
            [[ getsharedfunc( "airdrop", "registerCrateForCleanup" ) ]]( self );
        }
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x1c67
// Size: 0x50
function cpcratecapturecallback( player )
{
    if ( issharedfuncdefined( "airdrop", "makeItemsFromCrate" ) )
    {
        self [[ getsharedfunc( "airdrop", "makeItemsFromCrate" ) ]]( player );
    }
    
    /#
        player iprintln( "<dev string:x1c>" );
    #/
    
    player [[ level.custom_giveloadout ]]( 0 );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x1cbf
// Size: 0xb0
function initcparmsraceemptycrate()
{
    leveldata = scripts\cp_mp\killstreaks\airdrop::getleveldata( "cp_armsrace_crate" );
    leveldata.capturestring = "";
    leveldata.enemymodel = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.headicon = undefined;
    leveldata.usepriority = 0;
    leveldata.timeout = undefined;
    leveldata.friendlyuseonly = 1;
    leveldata.hasnointeraction = 1;
    leveldata.activatecallback = undefined;
    leveldata.capturecallback = undefined;
    leveldata.destroyoncapture = 0;
    leveldata.onecaptureperplayer = 0;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x1d77
// Size: 0xb5
function initcpammoarmorcrate()
{
    leveldata = scripts\cp_mp\killstreaks\airdrop::getleveldata( "cp_resources_crate" );
    leveldata.capturestring = &"MP/BR_CRATE";
    leveldata.enemymodel = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.headicon = "hud_icon_head_killstreak_carepackage";
    leveldata.usepriority = 0;
    leveldata.timeout = undefined;
    leveldata.friendlyuseonly = 1;
    leveldata.activatecallback = &cploadoutcrateactivatecallback;
    leveldata.capturecallback = &cpcpammoarmorcratecapturecallback;
    leveldata.destroyoncapture = 0;
    leveldata.onecaptureperplayer = 1;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x1e34
// Size: 0x24f
function cpcpammoarmorcratecapturecallback( player )
{
    if ( istrue( player.inlaststand ) )
    {
        return;
    }
    
    if ( !isdefined( self.numuses ) )
    {
        self.numuses = 0;
    }
    
    if ( !isdefined( self.playersused ) )
    {
        self.playersused = [];
    }
    
    self.playersused[ self.playersused.size ] = player;
    
    /#
        player iprintln( "<dev string:x1c>" );
    #/
    
    scripts\cp\pickups::giveammo( player );
    scripts\cp\armor::givearmor( player, 100, 1 );
    primary_weapons = player getweaponslistprimaries();
    
    foreach ( weapon in primary_weapons )
    {
        if ( weapontype( weapon ) == "projectile" )
        {
            if ( weapon.basename == "iw8_la_mike32_mp" )
            {
                if ( player.gl_proj_override == "thermite" )
                {
                    continue;
                }
            }
            
            player scripts\cp\utility::function_ad3ce5e1679df13d( weapon );
        }
    }
    
    foreach ( pwr_struct in player.powers )
    {
        if ( pwr_struct.charges < pwr_struct.maxcharges )
        {
            full = 0;
        }
    }
    
    thread scripts\cp\cp_grenade_crate::refill_grenades( player );
    player playlocalsound( "weap_ammo_pickup" );
    self.numuses++;
    
    if ( self.numuses >= level.players.size )
    {
        if ( isdefined( self.outlines ) )
        {
            foreach ( outline in self.outlines )
            {
                if ( issharedfuncdefined( "airdrop", "outlineDisable" ) )
                {
                    [[ getsharedfunc( "airdrop", "outlineDisable" ) ]]( outline, self );
                }
            }
        }
        
        thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x208b
// Size: 0xd1
function initoperationcratedata()
{
    leveldata = scripts\cp_mp\killstreaks\airdrop::getleveldata( "operation_crates" );
    leveldata.capturestring = &"MP/ESC_CACHE_USE_HINT";
    leveldata.enemymodel = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.headicon = "hud_icon_head_killstreak_carepackage";
    leveldata.usepriority = 0;
    leveldata.timeout = undefined;
    leveldata.friendlyuseonly = 1;
    leveldata.activatecallback = &cpoperationcrateactivatecallback;
    leveldata.capturecallback = &cpoperationcratecapturecallback;
    leveldata.destroyoncapture = 0;
    leveldata.onecaptureperplayer = 0;
    leveldata.halfheight = 55;
    leveldata.heliheightoffset = 12000;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x2164
// Size: 0xbb
function initcprooftopcrate()
{
    leveldata = scripts\cp_mp\killstreaks\airdrop::getleveldata( "cp_rooftop_crate" );
    leveldata.capturestring = &"CP_DWN_TWN_OBJECTIVES/TAKE_ROOFTOP_CRATE";
    leveldata.enemymodel = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.headicon = "hud_icon_head_killstreak_carepackage";
    leveldata.usepriority = 0;
    leveldata.timeout = 99999;
    leveldata.friendlyuseonly = 1;
    leveldata.activatecallback = &cploadoutcrateactivatecallback;
    leveldata.capturecallback = &cprooftopcratecapturecallback;
    leveldata.destroyoncapture = 1;
    leveldata.onecaptureperplayer = 0;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x2227
// Size: 0x12b
function initcploadoutcratedata()
{
    leveldata = scripts\cp_mp\killstreaks\airdrop::getleveldata( "loadout_drop_cp" );
    leveldata.capturestring = &"MP/BR_CRATE_LOADOUT";
    leveldata.basemodel = "military_loot_crate_01_cp_loadout";
    leveldata.supportsownercapture = 0;
    leveldata.headicon = "hud_icon_minimap_fieldupgrade_loadout_drop";
    leveldata.headiconoffset = 30;
    leveldata.headicondrawrange = 750;
    leveldata.minimapicon = "hud_icon_minimap_fieldupgrade_loadout_drop";
    leveldata.usepriority = 0;
    leveldata.usefov = 360;
    leveldata.timeout = 10000;
    leveldata.friendlyuseonly = 1;
    leveldata.maxusage = 50;
    leveldata.ownerusetime = 0.5;
    leveldata.otherusetime = 0.5;
    leveldata.activatecallback = &scripts\cp_mp\killstreaks\airdrop::loadoutcrateactivatecallback;
    leveldata.capturecallback = &scripts\cp_mp\killstreaks\airdrop::loadoutcratecapturecallback;
    leveldata.destroyoncapture = 0;
    leveldata.onecaptureperplayer = 0;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x235a
// Size: 0x62
function cpoperationcrateactivatecallback( isfirstactivation )
{
    thread scripts\cp_mp\killstreaks\airdrop::cratephysicsoff();
    
    if ( istrue( isfirstactivation ) )
    {
        if ( issharedfuncdefined( "airdrop", "registerCrateForCleanup" ) )
        {
            [[ getsharedfunc( "airdrop", "registerCrateForCleanup" ) ]]( self );
        }
    }
    
    if ( !isdefined( self.angles ) )
    {
        self.angles = ( 0, 0, 0 );
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x23c4
// Size: 0x18
function cprooftopcratecapturecallback( player )
{
    [[ level.rooftop_crate_usefunc ]]( player );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x23e4
// Size: 0x39a
function cpoperationcratecapturecallback( player )
{
    if ( istrue( player.inlaststand ) )
    {
        return;
    }
    
    if ( !isdefined( self.numuses ) )
    {
        self.numuses = 0;
    }
    
    if ( !isdefined( self.playersused ) )
    {
        self.playersused = [];
    }
    
    self.playersused[ self.playersused.size ] = player;
    
    /#
        player iprintln( "<dev string:x1c>" );
    #/
    
    if ( isdefined( self.customusefunc ) )
    {
        self thread [[ self.customusefunc ]]( player );
        return;
    }
    
    if ( !istrue( level.disable_map_ammo_munitions ) )
    {
        scripts\cp\pickups::giveammo( player );
    }
    
    scripts\cp\armor::givearmor( player, 100, 1 );
    primary_weapons = player getweaponslistprimaries();
    
    foreach ( weapon in primary_weapons )
    {
        if ( weapontype( weapon ) == "projectile" )
        {
            if ( weapon.basename == "iw8_la_mike32_mp" )
            {
                if ( player.gl_proj_override == "thermite" )
                {
                    continue;
                }
            }
            
            player scripts\cp\utility::function_ad3ce5e1679df13d( weapon );
        }
    }
    
    foreach ( pwr_struct in player.powers )
    {
        if ( pwr_struct.charges < pwr_struct.maxcharges )
        {
            full = 0;
        }
    }
    
    thread scripts\cp\cp_grenade_crate::refill_grenades( player );
    player playlocalsound( "weap_ammo_pickup" );
    var_3c5c969ff02785d = [ "precision_airstrike", "juggernaut", "cruise_missile", "cluster_strike" ];
    
    if ( isdefined( self.random_loot_override ) )
    {
        var_3c5c969ff02785d = self.random_loot_override;
    }
    
    var_33ec29f42729af36 = random( var_3c5c969ff02785d );
    var_6e1ec6f2c0ee6b2c = undefined;
    total_slots = player getplayerdata( "cp", "inventorySlots", "totalSlots" );
    
    if ( total_slots < 4 )
    {
        var_6e1ec6f2c0ee6b2c = total_slots;
    }
    else
    {
        var_6e1ec6f2c0ee6b2c = player.dpad_selection_index - 1;
    }
    
    empty_slot = scripts\cp\loot_system::get_empty_munition_slot( player );
    
    if ( isdefined( empty_slot ) )
    {
        var_6e1ec6f2c0ee6b2c = empty_slot;
    }
    else
    {
        player scripts\cp\utility::hint_prompt( "munition_slots_full", 1, 2 );
        return;
    }
    
    if ( var_33ec29f42729af36 == "sentry_turret" )
    {
        player scripts\cp\loot_system::try_give_munition_to_slot( var_33ec29f42729af36, var_6e1ec6f2c0ee6b2c, "sentry_turret" );
    }
    else if ( var_33ec29f42729af36 == "airstrike" )
    {
        player scripts\cp\loot_system::try_give_munition_to_slot( var_33ec29f42729af36, var_6e1ec6f2c0ee6b2c, "precision_airstrike" );
    }
    else
    {
        player scripts\cp\loot_system::try_give_munition_to_slot( var_33ec29f42729af36, var_6e1ec6f2c0ee6b2c );
    }
    
    self.numuses++;
    
    if ( self.numuses >= level.players.size )
    {
        if ( isdefined( self.outlines ) )
        {
            foreach ( outline in self.outlines )
            {
                if ( issharedfuncdefined( "airdrop", "outlineDisable" ) )
                {
                    [[ getsharedfunc( "airdrop", "outlineDisable" ) ]]( outline, self );
                }
            }
        }
        
        thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x2786
// Size: 0x9d
function cploadoutcrateactivatecallback( isfirstactivation )
{
    level notify( "cp_loadoutcrate_activate", self );
    
    if ( istrue( isfirstactivation ) )
    {
        if ( issharedfuncdefined( "airdrop", "registerCrateForCleanup" ) )
        {
            [[ getsharedfunc( "airdrop", "registerCrateForCleanup" ) ]]( self );
        }
    }
    
    var_ccab1b7540f54cda = 0;
    
    if ( isdefined( level.var_989ac7c4fc3d9841 ) )
    {
        var_ccab1b7540f54cda = level.var_989ac7c4fc3d9841;
    }
    
    if ( istrue( var_ccab1b7540f54cda ) )
    {
        hideheadiconfromplayersinmask( self.headiconid );
        removeteamfromheadiconmask( self.headiconid, "allies" );
        thread function_fad514cdb3e05b87( self.headiconid );
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x282b
// Size: 0x7f
function function_fad514cdb3e05b87( headicon )
{
    level endon( "game_ended" );
    
    while ( true )
    {
        self waittill( "disabled_for_player", player );
        
        if ( isplayer( player ) )
        {
            if ( isdefined( headicon ) )
            {
                addclienttoheadiconmask( headicon, player );
            }
            
            if ( getdvarint( @"hash_618b9c003b5b3883" ) == 0 )
            {
                if ( !isdefined( self.playerscaptured ) )
                {
                    self.playerscaptured = [];
                }
                
                self.playerscaptured[ player getentitynumber() ] = player;
            }
        }
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x28b2
// Size: 0x152
function cploadoutcratecapturecallback( player )
{
    if ( scripts\cp\endgame::gamealreadyended() )
    {
        return;
    }
    
    if ( !isdefined( self.numuses ) )
    {
        self.numuses = 0;
    }
    
    self.numuses++;
    
    if ( !isdefined( self.playersused ) )
    {
        self.playersused = [];
    }
    
    if ( !isdefined( array_find( self.playersused, player ) ) )
    {
        self.playersused[ self.playersused.size ] = player;
    }
    
    var_ccab1b7540f54cda = 0;
    
    if ( isdefined( level.var_989ac7c4fc3d9841 ) )
    {
        var_ccab1b7540f54cda = level.var_989ac7c4fc3d9841;
    }
    
    player thread scripts\cp\loadout::function_498b69e3a197b893( self, var_ccab1b7540f54cda, 1 );
    
    if ( istrue( level.var_6dbdf79b784080f9 ) )
    {
        if ( self.numuses >= level.players.size )
        {
            if ( isdefined( self.outlines ) )
            {
                foreach ( outline in self.outlines )
                {
                    if ( issharedfuncdefined( "airdrop", "outlineDisable" ) )
                    {
                        [[ getsharedfunc( "airdrop", "outlineDisable" ) ]]( outline, self );
                    }
                }
            }
            
            thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
        }
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x2a0c
// Size: 0x9
function airdrop_airdropmultipleinit()
{
    scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_init();
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x2a1d
// Size: 0x9
function function_563387bd27d5b942()
{
    scripts\cp_mp\killstreaks\airdrop_escort::function_f383491974a17b9a();
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x2a2e
// Size: 0x2
function airdrop_registerscoreinfo()
{
    
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x2a38
// Size: 0xc9
function airdrop_registeractionset()
{
    var_5e8f3dee82c118cf = getdvarint( @"hash_d15c22f57683add1", 1 );
    
    if ( var_5e8f3dee82c118cf )
    {
        val::group_register( "crateUse", [ "offhand_weapons", "fire", "melee", "weapon_switch", "killstreaks", "supers" ] );
        val::group_register( "juggCrateUse", [ "offhand_weapons", "weapon", "killstreaks", "supers" ] );
        return;
    }
    
    val::group_register( "crateUse", [ "offhand_weapons", "weapon", "killstreaks", "supers" ] );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 2
// Checksum 0x0, Offset: 0x2b09
// Size: 0x30
function airdrop_updateuiprogress( object, bool )
{
    if ( !scripts\cp\utility::is_wave_gametype() && !scripts\cp\utility::is_specops_gametype() )
    {
        updateuiprogress( object, bool );
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 2
// Checksum 0x0, Offset: 0x2b41
// Size: 0x238
function updateuiprogress( object, securing )
{
    if ( !isdefined( level.hostmigrationtimer ) )
    {
        if ( isdefined( object.interactteam ) && object.interactteam == "none" )
        {
            self setclientomnvar( "ui_objective_pinned_text_param", 0 );
            return;
        }
        
        objid = undefined;
        
        if ( isdefined( object.objidnum ) )
        {
            objid = object.objidnum;
        }
        
        progress = 0;
        
        if ( isdefined( object.teamprogress ) && isdefined( object.claimteam ) )
        {
            if ( object.teamprogress[ object.claimteam ] > object.usetime )
            {
                object.teamprogress[ object.claimteam ] = object.usetime;
            }
            
            progress = object.teamprogress[ object.claimteam ] / object.usetime;
        }
        else
        {
            if ( object.curprogress > object.usetime )
            {
                object.curprogress = object.usetime;
            }
            
            progress = object.curprogress / object.usetime;
            
            if ( object.usetime <= 1000 )
            {
                progress = min( progress + 0.05, 1 );
            }
            else
            {
                progress = min( progress + 0.01, 1 );
            }
        }
        
        if ( isdefined( object.id ) )
        {
            idx = 0;
            
            switch ( object.id )
            {
                case #"hash_3fd866e3da61a87":
                    idx = 1;
                    break;
                case #"hash_bf5597954aaed3d7":
                    idx = 2;
                    break;
                case #"hash_dbf719cee2feda22":
                    idx = 3;
                    break;
                case #"hash_82aad0a51185a053":
                    idx = 4;
                    break;
                case #"hash_631f416c3d8360d4":
                    idx = 8;
                    break;
            }
            
            updateuisecuring( progress, securing, idx, object, object.usetime );
        }
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x2d81
// Size: 0x26, Type: bool
function isrevivetrigger()
{
    if ( isdefined( self.id ) && self.id == "laststand_reviver" )
    {
        return true;
    }
    
    return false;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 2
// Checksum 0x0, Offset: 0x2db0
// Size: 0x65, Type: bool
function existinarray( ent, array )
{
    if ( array.size > 0 )
    {
        foreach ( entity in array )
        {
            if ( entity == ent )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 5
// Checksum 0x0, Offset: 0x2e1e
// Size: 0x2f2
function updateuisecuring( progress, securing, idx, object, usetime )
{
    objid = undefined;
    
    if ( securing )
    {
        if ( !isdefined( object.usedby ) )
        {
            object.usedby = [];
        }
        
        if ( !isdefined( self.migrationcapturereset ) )
        {
            object thread migrationcapturereset( self );
        }
        
        if ( !existinarray( self, object.usedby ) )
        {
            object.usedby[ object.usedby.size ] = self;
        }
        
        if ( !isdefined( self.ui_securing ) )
        {
            self setclientomnvar( "ui_securing", idx );
            self.ui_securing = 1;
            
            if ( isdefined( object.trigger ) && object.trigger isrevivetrigger() )
            {
                if ( isdefined( object.trigger.owner ) )
                {
                    object.trigger.owner setclientomnvar( "ui_reviver_id", self getentitynumber() );
                    object.trigger.owner setclientomnvar( "ui_securing", 6 );
                }
            }
        }
    }
    else
    {
        if ( isdefined( object.usedby ) && existinarray( self, object.usedby ) )
        {
            object.usedby = array_remove( object.usedby, self );
        }
        
        self setclientomnvar( "ui_securing", 0 );
        self.ui_securing = undefined;
        
        if ( isdefined( object.trigger ) && object.trigger isrevivetrigger() )
        {
            if ( isdefined( object.trigger.owner ) )
            {
                object.trigger.owner setclientomnvar( "ui_reviver_id", -1 );
                object.trigger.owner setclientomnvar( "ui_securing", 0 );
            }
        }
        
        progress = 0.01;
        
        if ( isdefined( object.objidnum ) )
        {
            objid = object.objidnum;
        }
    }
    
    if ( usetime == 500 )
    {
        progress = min( progress + 0.15, 1 );
    }
    
    if ( progress != 0 )
    {
        self setclientomnvar( "ui_securing_progress", progress );
        
        if ( isdefined( object.trigger ) && object.trigger isrevivetrigger() )
        {
            if ( isdefined( object.trigger.owner ) )
            {
                object.trigger.owner setclientomnvar( "ui_securing_progress", progress );
            }
        }
        
        if ( isdefined( object.objidnum ) )
        {
            scripts\mp\objidpoolmanager::objective_set_progress( object.objidnum, progress );
        }
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x3118
// Size: 0x52
function migrationcapturereset( player )
{
    player.migrationcapturereset = 1;
    level waittill( "host_migration_begin" );
    
    if ( !isdefined( player ) || !isdefined( self ) )
    {
        return;
    }
    
    player setclientomnvar( "ui_securing", 0 );
    player setclientomnvar( "ui_securing_progress", 0 );
    self.migrationcapturereset = undefined;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 2
// Checksum 0x0, Offset: 0x3172
// Size: 0x1c
function airdrop_allowactionset( name, allow )
{
    val::group_set( name, allow );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 3
// Checksum 0x0, Offset: 0x3196
// Size: 0x25
function airdrop_unresolvedcollisionnearestnode( player, var_4258fb168fb20ba6, mover )
{
    childthread scripts\cp\cp_movers::unresolved_collision_nearest_node( player, var_4258fb168fb20ba6 );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x31c3
// Size: 0x13
function airdrop_showerrormessage( string_ref )
{
    scripts\cp\cp_hud_message::showerrormessage( string_ref );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 3
// Checksum 0x0, Offset: 0x31de
// Size: 0x2b
function airdrop_awardkillstreak( streakname, owner, crate )
{
    owner thread scripts\cp\kits::kit_givekillstreak( streakname, 1, 0, 0, 1 );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 3
// Checksum 0x0, Offset: 0x3211
// Size: 0x25
function airdrop_showkillstreaksplash( splashref, streakval, fromcarepackage )
{
    scripts\cp\cp_hud_message::showkillstreaksplash( splashref, streakval, fromcarepackage );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x323e
// Size: 0x12
function airdrop_gettargetmarker( streakinfo )
{
    return scripts\cp\inventory\cp_target_marker::gettargetmarker( streakinfo );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 5
// Checksum 0x0, Offset: 0x3259
// Size: 0x39
function airdrop_airdropmultipledropcrates( owner, team, position, angles, destination )
{
    scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates( owner, team, position, angles, destination, 1 );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x329a
// Size: 0xb
function airdrop_registercrateforcleanup( crate )
{
    
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x32ad
// Size: 0x2
function airdrop_makeweaponfromcrate()
{
    
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x32b7
// Size: 0x2
function airdrop_makeitemfromcrate()
{
    
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 2
// Checksum 0x0, Offset: 0x32c1
// Size: 0x1c
function airdrop_outlinedisable( id, var_420a996e67989dc4 )
{
    scripts\cp\cp_outline_utility::outlinedisable( id, var_420a996e67989dc4 );
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 3
// Checksum 0x0, Offset: 0x32e5
// Size: 0x1b
function airdrop_br_forcegiveweapon( weaponname, player, completeweapon )
{
    
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x3308
// Size: 0x2
function airdrop_capturelootcachecallback()
{
    
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x3312
// Size: 0x4c
function airdrop_getgamemodespecificcratedata()
{
    initcpcratedata();
    initcploadoutcratedata();
    initoperationcratedata();
    initcparmsraceemptycrate();
    initcpammoarmorcrate();
    initcprooftopcrate();
    initkillstreakcratedata();
    
    if ( isdefined( level.var_ddab5ba81879746c ) )
    {
        [[ level.var_ddab5ba81879746c ]]();
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x3366
// Size: 0x2d, Type: bool
function airdrop_specialcasecanusecrate()
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    if ( isdefined( level.nuclear_core_carrier ) && level.nuclear_core_carrier == self )
    {
        return false;
    }
    
    return true;
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 1
// Checksum 0x0, Offset: 0x339c
// Size: 0x81
function makeitemsfromcrate( player )
{
    cratedata = self.data;
    
    if ( cratedata.type == "weapon" )
    {
        numweapons = randomintrange( 2, 4 );
        numextras = 6 - numweapons;
        return;
    }
    
    if ( cratedata.type == "attachment" )
    {
        numweapons = randomintrange( 1, 2 );
        numextras = 6 - numweapons;
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 5
// Checksum 0x0, Offset: 0x3425
// Size: 0x2b
function createdropweapon( completeweaponname, pos, ori, firstspawn, var_5b8a430b9f994496 )
{
    
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x3458
// Size: 0xce
function managedroppedents()
{
    if ( !isdefined( level.droppedweapons ) )
    {
        level.droppedweapons = [];
    }
    
    if ( level.droppedweapons.size > 63 )
    {
        temparray = [];
        
        for ( i = 0; i < level.droppedweapons.size ; i++ )
        {
            if ( i < 16 )
            {
                if ( isdefined( level.droppedweapons[ i ] ) )
                {
                    if ( isdefined( level.droppedweapons[ i ].pickupent ) )
                    {
                        level.droppedweapons[ i ].pickupent delete();
                    }
                    
                    level.droppedweapons[ i ] delete();
                }
                
                continue;
            }
            
            temparray[ temparray.size ] = level.droppedweapons[ i ];
        }
        
        level.droppedweapons = temparray;
    }
}

// Namespace airdrop_cp / scripts\cp\killstreaks\airdrop_cp
// Params 0
// Checksum 0x0, Offset: 0x352e
// Size: 0x2a8
function initkillstreakcratedata()
{
    level.cratedata.ksweights = [];
    level.cratedata.kscapturestrings = [];
    level.cratedata.ksrerollstrings = [];
    activatecallback = &killstreakcrateactivatecallback;
    capturecallback = &killstreakcratecapturecallback;
    leveldata = getleveldata( "killstreak" );
    leveldata.activatecallback = activatecallback;
    leveldata.capturecallback = capturecallback;
    
    if ( scripts\cp_mp\utility\game_utility::function_2d79a7a3b91c4c3e() )
    {
        leveldata.capturestring = &"MP/BR_CRATE_LOADOUT";
    }
    
    leveldata = getleveldata( "killstreak_no_owner" );
    leveldata.activatecallback = activatecallback;
    leveldata.capturecallback = capturecallback;
    leveldata.supportsownercapture = 0;
    bundle = level.streakglobals.streakbundles[ "airdrop" ];
    bundle.var_819ed648a31d2d61 = 0;
    
    if ( !isdefined( bundle ) || !istrue( bundle.var_819ed648a31d2d61 ) )
    {
        addkillstreakcratedata( "assault_drone", undefined, undefined, 300 );
        addkillstreakcratedata( "uav", undefined, undefined, 300 );
        addkillstreakcratedata( "cluster_spike", undefined, undefined, 300 );
        addkillstreakcratedata( "switchblade_drone", undefined, undefined, 300 );
        addkillstreakcratedata( "cruise_predator", undefined, undefined, 150 );
        addkillstreakcratedata( "toma_strike", undefined, undefined, 150 );
        addkillstreakcratedata( "precision_airstrike", undefined, undefined, 150 );
        addkillstreakcratedata( "sentry", undefined, undefined, 150 );
        addkillstreakcratedata( "lrad", undefined, undefined, 150 );
        addkillstreakcratedata( "hover_jet", undefined, undefined, 100 );
        addkillstreakcratedata( "loitering_munition", undefined, undefined, 100 );
        addkillstreakcratedata( "ims", undefined, undefined, 100 );
        addkillstreakcratedata( "auto_drone", undefined, undefined, 50 );
        addkillstreakcratedata( "chopper_gunner", undefined, undefined, 50 );
        addkillstreakcratedata( "juggernaut", undefined, undefined, 10 );
        return;
    }
    
    foreach ( crateentry in bundle.crateentries )
    {
        if ( isdefined( crateentry.name ) && isdefined( crateentry.weight ) )
        {
            addkillstreakcratedata( crateentry.name, undefined, undefined, crateentry.weight );
        }
    }
}

