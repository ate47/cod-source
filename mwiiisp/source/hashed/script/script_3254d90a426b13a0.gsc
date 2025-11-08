#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;

#namespace namespace_89fba8554565f939;

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 0
// Checksum 0x0, Offset: 0x436
// Size: 0x77
function function_764239e6a246c46a()
{
    funcarray = [];
    funcarray[ "init" ] = &visibilitymode_init;
    funcarray[ "shouldRun" ] = &visibilitymode_shouldrun;
    funcarray[ "enableForClient" ] = &visibilitymode_enable;
    funcarray[ "disable" ] = &visibilitymode_disable;
    funcarray[ "checkForDataUpdates" ] = &function_5d19d3f8062e4bee;
    funcarray[ "getADSWeaponDist" ] = &function_553772f1f998aa41;
    funcarray[ "getTargetArray" ] = &visibilitymode_gettargetarray;
    funcarray[ "optionalADSFuncs" ] = &function_6bcbb2f848cd60ef;
    return funcarray;
}

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 0
// Checksum 0x0, Offset: 0x4b6
// Size: 0x1c
function visibilitymode_init()
{
    flag_wait( "load_finished" );
    scripts\engine\sp\utility::hudoutline_add_channel( "highContrastMode", -10 );
}

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 0
// Checksum 0x0, Offset: 0x4da
// Size: 0x4, Type: bool
function visibilitymode_shouldrun()
{
    return true;
}

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 0
// Checksum 0x0, Offset: 0x4e7
// Size: 0x3b
function function_f0094b64651988aa()
{
    while ( !isdefined( level.player.values ) || level.player val::get( "freezecontrols" ) )
    {
        wait 0.1;
    }
}

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 3
// Checksum 0x0, Offset: 0x52a
// Size: 0x44
function visibilitymode_enable( client, assetname, prioritygroup )
{
    soldiernum = self getentitynumber();
    self.var_5d5996d4b95f80f0 = prioritygroup;
    scripts\engine\sp\utility::hudoutline_enable_new( assetname, "highContrastMode" );
    return soldiernum;
}

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 1
// Checksum 0x0, Offset: 0x577
// Size: 0x17
function visibilitymode_disable( id )
{
    scripts\engine\sp\utility::hudoutline_disable( "highContrastMode" );
}

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 0
// Checksum 0x0, Offset: 0x596
// Size: 0x29
function function_553772f1f998aa41()
{
    weapon = self getcurrentweapon();
    
    if ( weaponclass( weapon ) == "sniper" )
    {
        return 3500;
    }
    
    return 1500;
}

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 1
// Checksum 0x0, Offset: 0x5c8
// Size: 0xc1
function visibilitymode_gettargetarray( client )
{
    aiarray = getaiarray();
    fakearray = getfakeaiarray();
    drones = [];
    allmodels = getentarray( "script_model", "code_classname" );
    
    for ( i = 0; i < allmodels.size ; i++ )
    {
        if ( isdefined( allmodels[ i ].team ) && isdefined( allmodels[ i ].type ) && allmodels[ i ].type == "human" )
        {
            drones[ drones.size ] = allmodels[ i ];
        }
    }
    
    all = array_combine( aiarray, fakearray, drones );
    return all;
}

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 0
// Checksum 0x0, Offset: 0x692
// Size: 0xec
function function_5d19d3f8062e4bee()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        wait 1;
        
        if ( !isdefined( level.player ) )
        {
            continue;
        }
        
        datavalue = level.player getlocalplayerprofiledata( "highVisibilityMode" );
        outlinevalue = level.player getlocalplayerprofiledata( "highVisibilityModeOutline" );
        
        if ( isdefined( datavalue ) )
        {
            if ( isdefined( level.player.visibilitymodeval ) && isdefined( level.player.var_5615f87228f360c8 ) )
            {
                if ( datavalue != level.player.visibilitymodeval || outlinevalue != level.player.var_5615f87228f360c8 )
                {
                    level.player scripts\common\visibility_mode::visibilitymode_unpackvalue( datavalue, outlinevalue );
                }
                
                continue;
            }
            
            level.player scripts\common\visibility_mode::visibilitymode_unpackvalue( datavalue, outlinevalue );
        }
    }
}

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 0
// Checksum 0x0, Offset: 0x786
// Size: 0x103
function function_b0ca2ca41e304f16()
{
    enabled = level.player getlocalplayerprofiledata( "highVisibilityMode" ) > 0;
    packedvalue = enabled;
    
    if ( enabled )
    {
        darkbackground = level.player getlocalplayerprofiledata( "highVisibilityModeDarkBackground" );
        packedvalue += 2 * darkbackground;
        enemycolor = level.player getlocalplayerprofiledata( "highVisibilityModeEnemyColor" );
        packedvalue += 4 * enemycolor;
        npccolor = level.player getlocalplayerprofiledata( "highVisibilityModeNpcColor" );
        packedvalue += 16 * npccolor;
        playercolor = level.player getlocalplayerprofiledata( "highVisibilityModePlayerColor" );
        packedvalue += 64 * playercolor;
        vismode = level.player getlocalplayerprofiledata( "highVisibilityMode" ) - 1;
        packedvalue += 256 * vismode;
        
        if ( packedvalue < 0 )
        {
            packedvalue *= -1;
        }
    }
    
    return packedvalue;
}

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 0
// Checksum 0x0, Offset: 0x892
// Size: 0x166
function function_6bcbb2f848cd60ef()
{
    self endon( "disconnect" );
    self.visibilitymodeads = 0;
    self.var_44446bd6d8fd6ed0 = 0;
    self notifyonplayercommand( "vis_melee_pressed", "+melee" );
    self notifyonplayercommand( "vis_melee_pressed", "+melee_zoom" );
    self notifyonplayercommand( "vis_melee_pressed", "+melee_sprint" );
    self notifyonplayercommand( "vis_use_pressed", "+usereload" );
    self notifyonplayercommand( "vis_use_pressed", "+reload" );
    self notifyonplayercommand( "vis_use_pressed", "+activate" );
    self notifyonplayercommand( "vis_use_pressed", "+usereload" );
    self notifyonplayercommand( "vis_sprint_pressed", "+breath_sprint" );
    self notifyonplayercommand( "vis_sprint_pressed", "+melee_breath" );
    
    while ( scripts\common\visibility_mode::function_5f46cf1503a0541a() )
    {
        wait 0.1;
        
        if ( !isalive( self ) )
        {
            continue;
        }
        
        if ( !scripts\common\visibility_mode::function_787341d4cc18bba() )
        {
            continue;
        }
        
        playerads = self playerads();
        
        if ( playerads == 1 )
        {
            if ( self.visibilitymodeads == 0 )
            {
                self.visibilitymodeads = 1;
                thread function_dc7453c8550c512c();
                thread function_eec104c84dc70618( "vis_melee_pressed" );
                thread function_eec104c84dc70618( "vis_use_pressed" );
                thread function_eec104c84dc70618( "vis_sprint_pressed" );
            }
            
            continue;
        }
        
        if ( playerads < 1 )
        {
            self.visibilitymodeads = 0;
            self.var_44446bd6d8fd6ed0 = 0;
            self notify( "visibilityMode_stopads" );
        }
    }
}

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xa00
// Size: 0x65
function private function_eec104c84dc70618( type )
{
    self endon( "death_or_disconnect" );
    self endon( "visibilityMode_stopads" );
    
    if ( type == "vis_melee_pressed" )
    {
        self waittill( "vis_melee_pressed" );
        childthread function_5c04dcd5e95fbb53();
        return;
    }
    
    if ( type == "vis_use_pressed" )
    {
        self waittill( "vis_use_pressed" );
        childthread function_1f6b32e8c25bc863();
        return;
    }
    
    if ( type == "vis_sprint_pressed" )
    {
        self waittill( "vis_sprint_pressed" );
    }
}

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xa6d
// Size: 0x5e
function private function_5c04dcd5e95fbb53()
{
    clientallies = scripts\common\visibility_mode::function_e3c04f03881b4dc7();
    clientallies = sortbydistance( clientallies, self.origin );
    
    for ( i = 0; i < clientallies.size ; i++ )
    {
        if ( soundexists( "generic_throw_enemy_1" ) )
        {
            clientallies[ i ] playsound( "generic_throw_enemy_1" );
            wait 0.1;
        }
    }
}

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xad3
// Size: 0x250
function private function_1f6b32e8c25bc863()
{
    all_scriptables = getscriptablearray();
    
    if ( isdefined( all_scriptables ) )
    {
        all_scriptables = sortbydistance( all_scriptables, self.origin );
        
        for ( i = 0; i < all_scriptables.size ; i++ )
        {
            if ( distancesquared( all_scriptables[ i ].origin, self.origin ) > 22500 )
            {
                continue;
            }
            
            if ( all_scriptables[ i ] getscriptableisusableonanypart() )
            {
                if ( all_scriptables[ i ] scriptableisdoor() )
                {
                    if ( all_scriptables[ i ] scriptabledoorisclosed() )
                    {
                        all_scriptables[ i ] playsound( "door_locked" );
                    }
                    else
                    {
                        all_scriptables[ i ] playsound( "door_locked_bashed" );
                    }
                }
                else
                {
                    all_scriptables[ i ] playsound( "bunkerbuster_bounce" );
                }
                
                wait 0.25;
            }
        }
    }
    
    var_bf8f84ac20a265e7 = getentarrayinradius( "script_model", "code_classname", self.origin, 150 );
    
    if ( isdefined( var_bf8f84ac20a265e7 ) )
    {
        var_bf8f84ac20a265e7 = sortbydistance( var_bf8f84ac20a265e7, self.origin );
        
        for ( i = 0; i < var_bf8f84ac20a265e7.size ; i++ )
        {
            if ( var_bf8f84ac20a265e7[ i ] isusable() )
            {
                var_bf8f84ac20a265e7[ i ] playsound( "bunkerbuster_bounce" );
                wait 0.25;
            }
        }
    }
    
    var_e047507c690c0ca8 = getentarrayinradius( "script_origin", "code_classname", self.origin, 150 );
    
    if ( isdefined( var_e047507c690c0ca8 ) )
    {
        var_e047507c690c0ca8 = sortbydistance( var_e047507c690c0ca8, self.origin );
        
        for ( i = 0; i < var_e047507c690c0ca8.size ; i++ )
        {
            if ( var_e047507c690c0ca8[ i ] isusable() )
            {
                var_e047507c690c0ca8[ i ] playsound( "bunkerbuster_bounce" );
                wait 0.25;
            }
        }
    }
    
    all_loot = getlootscriptablearrayinradius( undefined, undefined, self.origin, 150 );
    
    if ( isdefined( all_loot ) )
    {
        all_loot = sortbydistance( all_loot, self.origin );
        
        for ( i = 0; i < all_loot.size ; i++ )
        {
            level thread function_61145e6fc9e0c9c5( all_loot[ i ] );
            wait 0.25;
        }
    }
    
    nearby_weapons = getweaponarrayinradius( self.origin, 150, 1 );
    
    if ( isdefined( nearby_weapons ) )
    {
        nearby_weapons = sortbydistance( nearby_weapons, self.origin );
        
        for ( i = 0; i < nearby_weapons.size ; i++ )
        {
            weaponpickupsound = nearby_weapons[ i ] function_feabbad27268cf50();
            nearby_weapons[ i ] playsound( weaponpickupsound );
            wait 0.25;
        }
    }
}

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xd2b
// Size: 0x55
function private function_61145e6fc9e0c9c5( item )
{
    tag_origin = spawn( "script_model", item.origin );
    tag_origin setmodel( "tag_origin" );
    tag_origin playsound( "detpack_pickup" );
    wait lookupsoundlength( "detpack_pickup" );
    tag_origin delete();
}

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 0
// Checksum 0x0, Offset: 0xd88
// Size: 0x101
function function_feabbad27268cf50()
{
    name = getweaponbasename( self );
    name_str = strtok( name, "_" );
    
    for ( i = 0; i < name_str.size ; i++ )
    {
        if ( name_str[ i ] == "ar" )
        {
            return "weap_pickup_ar_npc";
        }
        
        if ( name_str[ i ] == "br" )
        {
            return "weap_pickup_br_npc";
        }
        
        if ( name_str[ i ] == "dm" )
        {
            return "weap_pickup_dm_npc";
        }
        
        if ( name_str[ i ] == "lmg" )
        {
            return "weap_pickup_lmg_npc";
        }
        
        if ( name_str[ i ] == "smg" )
        {
            return "weap_pickup_smg_npc";
        }
        
        if ( name_str[ i ] == "pi" )
        {
            return "weap_pickup_pistol_npc";
        }
        
        if ( name_str[ i ] == "sh" )
        {
            return "weap_pickup_shotgun_npc";
        }
        
        if ( name_str[ i ] == "la" )
        {
            return "weap_pickup_launcher_npc";
        }
        
        if ( name_str[ i ] == "sn" )
        {
            return "weap_pickup_sniper_npc";
        }
    }
    
    return "weap_pickup";
}

// Namespace namespace_89fba8554565f939 / namespace_c9004e665a1c17b4
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xe92
// Size: 0xec
function private function_dc7453c8550c512c()
{
    self endon( "death_or_disconnect" );
    self endon( "visibilityMode_stopads" );
    
    if ( self.var_44446bd6d8fd6ed0 == 0 )
    {
        self.var_44446bd6d8fd6ed0 = 1;
    }
    else
    {
        return;
    }
    
    maxdist = self [[ level.visibilitymode.funcs[ "getADSWeaponDist" ] ]]();
    maxdistsq = squared( maxdist );
    clientenemies = scripts\common\visibility_mode::function_90ce2459298d263();
    clientenemies = sortbydistance( clientenemies, self.origin );
    
    for ( i = 0; i < clientenemies.size ; i++ )
    {
        if ( clientenemies[ i ] lastknowntime( self ) == 0 )
        {
            continue;
        }
        
        if ( distancesquared( clientenemies[ i ].origin, self.origin ) < maxdistsq )
        {
            if ( soundexists( "heli_missile_lock" ) )
            {
                clientenemies[ i ] playsound( "heli_missile_lock" );
            }
        }
    }
}

