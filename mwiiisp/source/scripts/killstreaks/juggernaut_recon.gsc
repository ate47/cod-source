#using script_13865ca76df87ea;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\juggernaut;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#using scripts\mp\objidpoolmanager;

#namespace juggernaut_recon;

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x4f6
// Size: 0x18
function autoexec main()
{
    registerkillstreakinitfunction( getxhash( "juggernaut_recon" ), &init );
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 0
// Checksum 0x0, Offset: 0x516
// Size: 0x94
function init()
{
    if ( issharedfuncdefined( "killstreak", "registerKillstreak" ) )
    {
        [[ getsharedfunc( "killstreak", "registerKillstreak" ) ]]( "juggernaut_recon", &function_2e34ff8caa82d72d );
    }
    
    if ( issharedfuncdefined( "juggernaut_recon", "init" ) )
    {
        [[ getsharedfunc( "juggernaut_recon", "init" ) ]]();
    }
    
    if ( issharedfuncdefined( "juggernaut_recon", "registerActionSet" ) )
    {
        [[ getsharedfunc( "juggernaut_recon", "registerActionSet" ) ]]();
    }
    
    level.var_e084c71df9ac20f1 = spawnstruct();
    thread function_f49ef51573779a58();
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 0
// Checksum 0x0, Offset: 0x5b2
// Size: 0x16
function function_f49ef51573779a58()
{
    wait 0.1;
    function_6cbad31a27208d32();
    function_11f8f0876fc973de();
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 0
// Checksum 0x0, Offset: 0x5d0
// Size: 0x86
function function_6cbad31a27208d32()
{
    globals = level.var_e084c71df9ac20f1;
    bundle = level.streakglobals.streakbundles[ "juggernaut_recon" ];
    config = scripts\cp_mp\killstreaks\juggernaut::function_23f0145756ed19cb( bundle );
    
    /#
        function_9611765a6973a30a( @"hash_c46033a2195754fb", config, 1 );
        function_9611765a6973a30a( @"hash_669557a21f746dbf", config, 0 );
    #/
    
    if ( isdefined( config ) )
    {
        globals.config = config;
    }
}

/#

    // Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
    // Params 3
    // Checksum 0x0, Offset: 0x65e
    // Size: 0xbb, Type: dev
    function function_9611765a6973a30a( dvar, config, isprimary )
    {
        overridestring = getdvar( dvar, "<dev string:x1c>" );
        
        if ( overridestring.size == 0 )
        {
            return;
        }
        
        substrings = strtok( overridestring, "<dev string:x1d>" );
        weaponname = substrings[ 0 ];
        
        if ( isprimary )
        {
            config.classstruct.loadoutprimary = weaponname;
        }
        else
        {
            config.classstruct.loadoutsecondary = weaponname;
        }
        
        weaponblueprint = undefined;
        
        if ( substrings.size > 1 )
        {
            weaponblueprint = substrings[ 1 ];
        }
        
        function_51b8a3cf6102ba3( weaponname, weaponblueprint, config, isprimary );
    }

#/

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 0
// Checksum 0x0, Offset: 0x721
// Size: 0xea
function function_138468dd32aae3fe()
{
    leveldata = undefined;
    
    if ( issharedfuncdefined( "juggernaut_recon", "levelData" ) )
    {
        leveldata = [[ getsharedfunc( "juggernaut_recon", "levelData" ) ]]( "juggernaut_recon" );
    }
    
    if ( isdefined( leveldata ) )
    {
        leveldata.capturecallback = &function_c13dca1515447b28;
        leveldata.destroycallback = &function_bbd5edacfcb74661;
        leveldata.activatecallback = &function_546bfb8d4d00c31;
        leveldata.minimapicon = "jup_ui_map_icon_jugg_recon_drop";
        leveldata.headicon = "jup_ui_map_icon_jugg_recon_drop";
        
        if ( scripts\cp_mp\utility\game_utility::function_2d79a7a3b91c4c3e() )
        {
            leveldata.capturestring = &"MP/BR_CRATE_LOADOUT";
        }
        else
        {
            leveldata.capturestring = &"KILLSTREAKS_HINTS/JUGG_RECON_CRATE_PICKUP";
        }
        
        if ( !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
        {
            leveldata.basemodel = self.var_3c9615208f1c09b8.cratemodel;
        }
    }
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 0
// Checksum 0x0, Offset: 0x813
// Size: 0x21
function function_11f8f0876fc973de()
{
    game[ "dialog" ][ "juggernaut_recon" + "_use" ] = "killstreak_remote_operator" + "_request_response";
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 2
// Checksum 0x0, Offset: 0x83c
// Size: 0x40
function function_b960491329678b4( activateimmediate, var_ca56839b2e00edce )
{
    streakinfo = createstreakinfo( "juggernaut_recon", self );
    streakinfo.var_ca56839b2e00edce = var_ca56839b2e00edce;
    function_2e34ff8caa82d72d( streakinfo, activateimmediate );
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 2
// Checksum 0x0, Offset: 0x884
// Size: 0x179, Type: bool
function function_2e34ff8caa82d72d( streakinfo, activateimmediate )
{
    if ( scripts\engine\utility::issharedfuncdefined( "juggernaut_recon", "canTriggerJuggernaut" ) )
    {
        if ( !self [[ scripts\engine\utility::getsharedfunc( "juggernaut_recon", "canTriggerJuggernaut" ) ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    bundle = level.streakglobals.streakbundles[ "juggernaut_recon" ];
    self.var_3c9615208f1c09b8 = function_d5974b5f58f14716( bundle, streakinfo.mpstreaksysteminfo.blueprintindex );
    function_138468dd32aae3fe();
    instantdeploy = 0;
    
    /#
        instantdeploy = getdvarint( @"hash_8324943f346018cf", 0 );
    #/
    
    if ( instantdeploy || istrue( activateimmediate ) )
    {
        thread function_8bac95417054dcbf( streakinfo );
    }
    else
    {
        scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
        deployweaponobj = self.var_3c9615208f1c09b8.deployweapon;
        
        if ( isdefined( level.var_27f78817b59dfe32 ) )
        {
            streakinfo.var_fb58a31c756db4cc = level.var_27f78817b59dfe32;
        }
        
        deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy( streakinfo, deployweaponobj, "grenade_fire", undefined, undefined, &markerthrown );
        
        if ( !istrue( deployresult ) )
        {
            scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
            return false;
        }
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 3
// Checksum 0x0, Offset: 0xa06
// Size: 0xa0
function markerthrown( streakinfo, weaponobj, projectile )
{
    if ( issharedfuncdefined( "vehicle", "incrementFauxVehicleCount" ) )
    {
        [[ getsharedfunc( "vehicle", "incrementFauxVehicleCount" ) ]]();
    }
    
    projectile.owner = self;
    
    if ( issharedfuncdefined( "killstreak", "logKillstreakEvent" ) )
    {
        self [[ getsharedfunc( "killstreak", "logKillstreakEvent" ) ]]( streakinfo.streakname, self.origin );
    }
    
    projectile thread function_20037b6d61f6913a( streakinfo );
    streakinfo notify( "killstreak_finished_with_deploy_weapon" );
    return "success";
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 1
// Checksum 0x0, Offset: 0xaaf
// Size: 0x1d1
function function_20037b6d61f6913a( streakinfo )
{
    level endon( "game_ended" );
    ownerangles = self.owner.angles;
    owner = self.owner;
    streakinfo.airdroptype = streakinfo.streakname;
    self waittill( "explode", position );
    
    if ( !isdefined( owner ) )
    {
        if ( issharedfuncdefined( "vehicle", "decrementFauxVehicleCount" ) )
        {
            [[ getsharedfunc( "vehicle", "decrementFauxVehicleCount" ) ]]();
        }
        
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
        return;
    }
    
    if ( issharedfuncdefined( "vehicle", "decrementFauxVehicleCount" ) )
    {
        [[ getsharedfunc( "vehicle", "decrementFauxVehicleCount" ) ]]();
    }
    
    if ( issharedfuncdefined( "juggernaut_recon", "dropCrateFromScriptedHeli" ) && !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        streakinfo.vehicleisreserved = 1;
        data = streakinfo;
        scenenode = [[ getsharedfunc( "juggernaut_recon", "dropCrateFromScriptedHeli" ) ]]( owner, owner.team, "juggernaut_recon", position, ownerangles, position, data, streakinfo );
        owner thread scripts\cp_mp\killstreaks\airdrop::airdrop_playdeploydialog( streakinfo );
        
        if ( !isdefined( scenenode ) )
        {
            if ( issharedfuncdefined( "hud", "showErrorMessage" ) )
            {
                owner [[ getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/VEHICLE_REFUND_KILLSTREAK" );
            }
            
            if ( issharedfuncdefined( "killstreak", "awardKillstreakFromStruct" ) )
            {
                owner [[ getsharedfunc( "killstreak", "awardKillstreakFromStruct" ) ]]( streakinfo.mpstreaksysteminfo, "other" );
            }
        }
        
        return;
    }
    
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        isfromgrenade = 1;
        owner thread scripts\cp_mp\killstreaks\airdrop::spawnjuggernautcrateatposition( position, isfromgrenade );
    }
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 1
// Checksum 0x0, Offset: 0xc88
// Size: 0x22
function function_546bfb8d4d00c31( firstactivation )
{
    if ( istrue( firstactivation ) )
    {
        self setscriptablepartstate( "smoke_cover", "active", 0 );
    }
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 1
// Checksum 0x0, Offset: 0xcb2
// Size: 0xad
function function_c13dca1515447b28( player )
{
    streakinfo = self.data;
    
    if ( istrue( player.isjuggernaut ) )
    {
        if ( issharedfuncdefined( "airdrop", "awardKillstreak" ) )
        {
            self.streakinfo = streakinfo;
            player [[ getsharedfunc( "airdrop", "awardKillstreak" ) ]]( streakinfo.streakname, player, self );
        }
        
        if ( issharedfuncdefined( "airdrop", "showKillstreakSplash" ) )
        {
            player [[ getsharedfunc( "airdrop", "showKillstreakSplash" ) ]]( streakinfo.streakname, undefined, 1 );
        }
        
        return;
    }
    
    player function_8bac95417054dcbf( streakinfo );
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 1
// Checksum 0x0, Offset: 0xd67
// Size: 0x37
function function_bbd5edacfcb74661( immediate )
{
    streakinfo = self.data;
    level callback::callback( "killstreak_finish_use", { #streakinfo:streakinfo } );
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 1
// Checksum 0x0, Offset: 0xda6
// Size: 0x197
function function_8bac95417054dcbf( streakinfo )
{
    /#
        if ( getdvarint( @"hash_e84595a290967e65", 0 ) == 1 )
        {
            function_6cbad31a27208d32();
        }
    #/
    
    globals = level.var_e084c71df9ac20f1;
    result = 0;
    
    if ( issharedfuncdefined( "juggernaut_recon", "makeJuggernaut" ) )
    {
        result = self [[ getsharedfunc( "juggernaut_recon", "makeJuggernaut" ) ]]( self.var_3c9615208f1c09b8, streakinfo );
    }
    
    if ( !result )
    {
        return 0;
    }
    
    self.isjuggernautrecon = 1;
    
    if ( self isnightvisionon() )
    {
        self nightvisionviewoff( 1 );
        self notify( "night_vision_off" );
    }
    
    if ( issharedfuncdefined( "juggernaut_recon", "playOperatorUseLine" ) )
    {
        level thread [[ getsharedfunc( "juggernaut_recon", "playOperatorUseLine" ) ]]( self );
    }
    
    if ( issharedfuncdefined( "hud", "teamPlayerCardSplash" ) )
    {
        level thread [[ getsharedfunc( "hud", "teamPlayerCardSplash" ) ]]( "used_juggernaut_recon", self );
    }
    
    function_68e45178659d4dfd();
    
    if ( isdefined( self.operatorcustomization.gender ) && self.operatorcustomization.gender == "female" )
    {
        self function_555e2d32e2756625( "gasmask_female" );
    }
    else
    {
        self function_555e2d32e2756625( "gasmask_male" );
    }
    
    if ( !istrue( streakinfo.var_ca56839b2e00edce ) )
    {
        self setsoundsubmix( "mp_juggernaut", 0.5 );
    }
    
    thread function_e3caef85dfedc944();
    thread function_ad3e24a2d0896537( streakinfo );
    thread function_a8ed613077c9e07( streakinfo );
    thread function_ca2a1fd81a921292( streakinfo );
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 0
// Checksum 0x0, Offset: 0xf45
// Size: 0x12d
function function_e3caef85dfedc944()
{
    self endon( "death" );
    self endon( "destroyed" );
    self endon( "juggernaut_end" );
    level endon( "game_ended" );
    wait 0.5;
    bundle = level.streakglobals.streakbundles[ "juggernaut_recon" ];
    var_2ff0b7294cde30f8 = int( bundle.var_5ac52738ec92f8e * 1000 );
    radarradius = int( bundle.var_e57c83329f2687af );
    
    if ( islargemap() )
    {
        radarradius = int( bundle.var_93d485915fce13b4 );
    }
    
    if ( issharedfuncdefined( "player", "doScoreEvent" ) )
    {
        childthread function_44d4db462cec2873( bundle, radarradius, bundle.var_5ac52738ec92f8e );
    }
    
    while ( true )
    {
        if ( function_7d7531f974260d91() )
        {
            self notify( "juggernaut_recon_ping_start" );
            
            if ( level.teambased )
            {
                triggerportableradarpingteam( self.origin, self.team, radarradius, var_2ff0b7294cde30f8 );
            }
            else
            {
                triggerportableradarping( self.origin, self, radarradius, var_2ff0b7294cde30f8 );
            }
        }
        
        wait bundle.var_8d17f7f2d3c1ebb7;
        self notify( "juggernaut_recon_ping_end" );
    }
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 0
// Checksum 0x0, Offset: 0x107a
// Size: 0x1e, Type: bool
function function_7d7531f974260d91()
{
    if ( istrue( self.var_85dc59c6a906819f ) )
    {
        return false;
    }
    
    if ( scripts\cp_mp\emp_debuff::is_empd() )
    {
        return false;
    }
    
    return true;
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 3
// Checksum 0x0, Offset: 0x10a1
// Size: 0x178
function function_44d4db462cec2873( bundle, radarradius, var_2ff0b7294cde30f8 )
{
    while ( true )
    {
        self waittill( "juggernaut_recon_ping_start" );
        pingcenter = self.origin;
        checkinterval = var_2ff0b7294cde30f8 / bundle.var_9bf9f003feb68ed8;
        characterschecked = [];
        
        for ( i = 1; i <= bundle.var_9bf9f003feb68ed8 ; i++ )
        {
            wait checkinterval;
            var_ad00034aa6fc55c9 = i / bundle.var_9bf9f003feb68ed8 * radarradius;
            
            if ( issharedfuncdefined( "game", "getEnemyTeams" ) )
            {
                enemyteams = [[ getsharedfunc( "game", "getEnemyTeams" ) ]]( self.team );
                var_782a999b1a24e0d8 = getplayersandaiarrayinradius( pingcenter, var_ad00034aa6fc55c9, enemyteams );
            }
            else
            {
                var_782a999b1a24e0d8 = getplayersandaiarrayinradius( pingcenter, var_ad00034aa6fc55c9 );
            }
            
            foreach ( newcharacter in var_782a999b1a24e0d8 )
            {
                if ( !array_contains( characterschecked, newcharacter ) )
                {
                    characterschecked = array_add( characterschecked, newcharacter );
                    
                    if ( newcharacter function_7e3a77b73394cde7() )
                    {
                        continue;
                    }
                    
                    newcharacter childthread function_b3ac6739913f71ab( self );
                }
            }
        }
        
        self waittill( "juggernaut_recon_ping_end" );
    }
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 0
// Checksum 0x0, Offset: 0x1221
// Size: 0x53, Type: bool
function function_7e3a77b73394cde7()
{
    if ( scripts\engine\utility::issharedfuncdefined( "perk", "hasPerk" ) && self [[ getsharedfunc( "perk", "hasPerk" ) ]]( "specialty_ghost" ) && istrue( self.canghost ) )
    {
        return true;
    }
    
    if ( istrue( self.var_8d9c40fe23269431 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 1
// Checksum 0x0, Offset: 0x127d
// Size: 0x9c
function function_b3ac6739913f71ab( juggernautplayer )
{
    juggernautplayer endon( "juggernaut_recon_ping_end" );
    self waittill( "death", attacker );
    
    if ( isdefined( attacker ) && isplayer( attacker ) && attacker != juggernautplayer )
    {
        isfriendly = 0;
        
        if ( issharedfuncdefined( "player", "isFriendly" ) )
        {
            isfriendly = [[ getsharedfunc( "player", "isFriendly" ) ]]( juggernautplayer.team, attacker );
        }
        
        if ( isfriendly )
        {
            juggernautplayer thread [[ getsharedfunc( "player", "doScoreEvent" ) ]]( #"jugg_recon_ping_assist" );
        }
    }
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 1
// Checksum 0x0, Offset: 0x1321
// Size: 0x34
function function_ad3e24a2d0896537( streakinfo )
{
    self endon( "disconnect" );
    self endon( "juggernaut_end" );
    level waittill( "game_ended" );
    
    if ( isdefined( self ) && isdefined( streakinfo ) )
    {
        scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats( streakinfo );
    }
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 1
// Checksum 0x0, Offset: 0x135d
// Size: 0xab
function function_a8ed613077c9e07( streakinfo )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    juggcontext = self.juggcontext;
    self waittill( "juggernaut_end" );
    
    if ( isdefined( self.operatorcustomization ) )
    {
        if ( isdefined( self.operatorcustomization.gender ) && self.operatorcustomization.gender == "female" )
        {
            self function_555e2d32e2756625( "female" );
        }
        else
        {
            self function_555e2d32e2756625( "" );
        }
    }
    
    self clearsoundsubmix( "mp_juggernaut", 0.5 );
    function_d6e3424025c35356( streakinfo, juggcontext );
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 2
// Checksum 0x0, Offset: 0x1410
// Size: 0x52
function function_d6e3424025c35356( streakinfo, juggcontext )
{
    if ( !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        level callback::callback( "killstreak_finish_use", { #streakinfo:streakinfo } );
        streakinfo.expiredbydeath = 1;
        scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats( streakinfo );
    }
    
    function_2bb8ec2d315b7cb1( juggcontext );
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 1
// Checksum 0x0, Offset: 0x146a
// Size: 0x3d
function function_ca2a1fd81a921292( streakinfo )
{
    self endon( "juggernaut_end" );
    level endon( "game_ended" );
    juggcontext = self.juggcontext;
    self waittill( "disconnect" );
    function_2bb8ec2d315b7cb1( juggcontext );
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 1
// Checksum 0x0, Offset: 0x14af
// Size: 0x166
function function_68e45178659d4dfd( var_cbcc20cc563590c7 )
{
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        if ( !isdefined( var_cbcc20cc563590c7 ) )
        {
            var_cbcc20cc563590c7 = "playerObjective";
        }
        
        self setscriptablepartstate( var_cbcc20cc563590c7, "juggernaut", 0 );
        return;
    }
    
    requestfunc = undefined;
    
    if ( scripts\engine\utility::issharedfuncdefined( "game", "requestObjectiveID" ) )
    {
        requestfunc = scripts\engine\utility::getsharedfunc( "game", "requestObjectiveID" );
    }
    
    if ( isdefined( requestfunc ) )
    {
        objid = [[ requestfunc ]]( 99 );
        self.juggcontext.juggobjid = objid;
        scripts\mp\objidpoolmanager::objective_add_objective( objid, "active", self.origin, "jup_hud_icon_minimap_killstreak_juggernaut_recon", "icon_medium" );
        scripts\mp\objidpoolmanager::objective_set_play_intro( objid, 0 );
        scripts\mp\objidpoolmanager::objective_set_play_outro( objid, 0 );
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || isbot( player ) || player == self )
            {
                continue;
            }
            
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( objid, player );
        }
        
        scripts\mp\objidpoolmanager::update_objective_onentity( objid, self );
        scripts\mp\objidpoolmanager::update_objective_setbackground( objid, 1 );
        
        if ( level.teambased )
        {
            scripts\mp\objidpoolmanager::update_objective_ownerteam( objid, self.team );
            return;
        }
        
        scripts\mp\objidpoolmanager::update_objective_ownerclient( objid, self );
    }
}

// Namespace juggernaut_recon / scripts\killstreaks\juggernaut_recon
// Params 2
// Checksum 0x0, Offset: 0x161d
// Size: 0x70
function function_2bb8ec2d315b7cb1( juggcontext, var_cbcc20cc563590c7 )
{
    if ( isdefined( self ) && scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        if ( !isdefined( var_cbcc20cc563590c7 ) )
        {
            var_cbcc20cc563590c7 = "playerObjective";
        }
        
        self setscriptablepartstate( var_cbcc20cc563590c7, "off", 0 );
        return;
    }
    
    if ( scripts\engine\utility::issharedfuncdefined( "game", "returnObjectiveID" ) )
    {
        [[ scripts\engine\utility::getsharedfunc( "game", "returnObjectiveID" ) ]]( juggcontext.juggobjid );
    }
}

