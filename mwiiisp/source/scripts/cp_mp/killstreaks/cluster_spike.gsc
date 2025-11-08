#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\dialog_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace cluster_spike;

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 0
// Checksum 0x0, Offset: 0x56a
// Size: 0xce
function init()
{
    if ( issharedfuncdefined( "cluster_spike", "init" ) )
    {
        [[ getsharedfunc( "cluster_spike", "init" ) ]]();
    }
    
    /#
        setdevdvarifuninitialized( @"hash_ecade10f325e63e6", 0 );
    #/
    
    bundle = level.streakglobals.streakbundles[ "cluster_spike" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    level function_ddb866cc574674c0( bundle );
    level function_1ceb81f4abe9cc5e();
    level function_9d6b4ec9f5809bc5();
    level function_b7fe23eb11f96086();
    level function_b7b736eb11aac7df();
    registerkillstreakdamagedealingweaponsharedfunc( "cluster_spike", bundle.deployweapon, #"medium" );
    registerkillstreakdamagedealingweaponsharedfunc( "cluster_spike", bundle.spawnweapon, #"medium" );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x640
// Size: 0xb5
function function_ddb866cc574674c0( bundle )
{
    level.clusterspikes = [];
    level.var_c255eb9109a38f9f = 0;
    
    foreach ( teamname in level.teamnamelist )
    {
        level.clusterspikes[ teamname ] = [];
    }
    
    var_f16af5a8c61c30ee = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine( "cluster_spike", 1 );
    var_f16af5a8c61c30ee.radius = bundle.var_42cc695c79ff5ddb;
    var_f16af5a8c61c30ee.triggercallback = &function_7fb05833db79cf2d;
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 0
// Checksum 0x0, Offset: 0x6fd
// Size: 0x69
function function_1ceb81f4abe9cc5e()
{
    level.var_ff6ea90ecf04638b = "clusterSpike_placement";
    val::group_register( level.var_ff6ea90ecf04638b, [ "sprint", "supersprint", "offhand_weapons", "melee", "execution_attack", "weapon_pickup", "supers", "cp_munitions_pickup" ] );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 0
// Checksum 0x0, Offset: 0x76e
// Size: 0x2
function function_9d6b4ec9f5809bc5()
{
    
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 0
// Checksum 0x0, Offset: 0x778
// Size: 0x2
function function_b7fe23eb11f96086()
{
    
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 0
// Checksum 0x0, Offset: 0x782
// Size: 0x2
function function_b7b736eb11aac7df()
{
    
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 2
// Checksum 0x0, Offset: 0x78c
// Size: 0x21
function function_bde7fd6853600da4( streakinfo, switchresult )
{
    if ( istrue( switchresult ) )
    {
        thread function_736a390857671cae( streakinfo );
    }
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x7b5
// Size: 0x7f
function function_736a390857671cae( streakinfo )
{
    self endon( "disconnect" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 3" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 4" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 5" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 6" );
    result = waittill_any_return_2( "cancel_deploy", "weapon_switch_started" );
    
    if ( !isdefined( result ) )
    {
        return;
    }
    
    streakinfo notify( "killstreak_finished_with_deploy_weapon" );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x83c
// Size: 0x32
function function_ee88b06e55dd9ca3( streakinfo )
{
    if ( istrue( streakinfo.var_96eb72336f27bc9e ) )
    {
        level callback::callback( "killstreak_finish_use", { #streakinfo:streakinfo } );
    }
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 3
// Checksum 0x0, Offset: 0x876
// Size: 0x7d
function function_baff78978772ecec( streakinfo, weaponobj, projectile )
{
    projectile thread function_ae64d36f507aca45( self, streakinfo, weaponobj );
    
    if ( issharedfuncdefined( "killstreak", "logKillstreakEvent" ) )
    {
        self [[ getsharedfunc( "killstreak", "logKillstreakEvent" ) ]]( streakinfo.airdroptype, self.origin );
    }
    
    streakinfo.var_96eb72336f27bc9e = 1;
    streakinfo notify( "killstreak_finished_with_deploy_weapon" );
    return "success";
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 0
// Checksum 0x0, Offset: 0x8fc
// Size: 0x20
function function_43fcf054875c96c5()
{
    streakinfo = createstreakinfo( "cluster_spike", self );
    return function_4d4dfa5c57455df0( streakinfo );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x925
// Size: 0x1ba, Type: bool
function function_4d4dfa5c57455df0( streakinfo )
{
    bundle = level.streakglobals.streakbundles[ "cluster_spike" ];
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( isdefined( level.var_ff6ea90ecf04638b ) )
    {
        streakinfo.var_fb58a31c756db4cc = level.var_ff6ea90ecf04638b;
    }
    
    deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy( streakinfo, makeweapon( bundle.deployweapon ), "grenade_fire", undefined, &function_bde7fd6853600da4, &function_baff78978772ecec, undefined, &function_ee88b06e55dd9ca3 );
    
    if ( !istrue( deployresult ) )
    {
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            streakinfo notify( "killstreak_finished_with_deploy_weapon" );
            return false;
        }
    }
    
    if ( level.gameended )
    {
        streakinfo notify( "killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    var_52a5be2e2f91d710 = undefined;
    
    if ( issharedfuncdefined( "sound", "playKillstreakDeployDialog" ) )
    {
        [[ getsharedfunc( "sound", "playKillstreakDeployDialog" ) ]]( self, streakinfo.streakname );
        var_52a5be2e2f91d710 = 2;
    }
    
    utility::trycall( level.matchdata_logkillstreakevent, "cluster_spike", self.origin );
    
    if ( issharedfuncdefined( "hud", "teamPlayerCardSplash" ) )
    {
        self thread [[ getsharedfunc( "hud", "teamPlayerCardSplash" ) ]]( "used_" + "cluster_spike", self );
    }
    
    if ( issharedfuncdefined( "cluster_spike", "munitionUsed" ) )
    {
        self [[ getsharedfunc( "cluster_spike", "munitionUsed" ) ]]();
    }
    
    return true;
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 3
// Checksum 0x0, Offset: 0xae8
// Size: 0x272
function function_ae64d36f507aca45( player, streakinfo, weaponobj )
{
    level endon( "game_ended" );
    ownedmines = function_a868fa9dc357d535( player );
    
    if ( isdefined( ownedmines ) )
    {
        foreach ( mine in ownedmines )
        {
            if ( !isdefined( mine ) )
            {
                /#
                    iprintln( "<dev string:x1c>" );
                #/
                
                level.clusterspikes[ self.team ][ "ownerID_" + self getxuid() ] = array_removeundefined( level.clusterspikes[ self.team ][ "ownerID_" + self getxuid() ] );
            }
            
            mine thread clusterspike_explode( "destroy" );
        }
    }
    
    lifetimeoverride = undefined;
    
    if ( issharedfuncdefined( "cluster_spike", "lifetimeOverride" ) )
    {
        lifetimeoverride = [[ getsharedfunc( "cluster_spike", "lifetimeOverride" ) ]]();
    }
    
    bundle = level.streakglobals.streakbundles[ "cluster_spike" ];
    function_cc8b9ef243e90347( self, weaponobj, streakinfo, bundle, player, lifetimeoverride, 1 );
    level endon( "removed_" + self.clusterid );
    self waittill( "missile_stuck" );
    killstreak_dangernotifyplayersinrange( self.owner, self.team, 1200, "cluster_spike", self.origin );
    
    if ( isdefined( level.var_ca4e08767cbdae12 ) )
    {
        canplant = self [[ level.var_ca4e08767cbdae12 ]]();
        
        if ( !canplant )
        {
            if ( issharedfuncdefined( "hud", "showErrorMessage" ) )
            {
                player [[ getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/BLOCKED_REFUND_KILLSTREAK" );
            }
            
            if ( issharedfuncdefined( "killstreak", "awardKillstreakFromStruct" ) )
            {
                player [[ getsharedfunc( "killstreak", "awardKillstreakFromStruct" ) ]]( streakinfo.mpstreaksysteminfo, "other" );
            }
            
            thread function_b53e15638ce719b2( 0 );
            return;
        }
    }
    
    immediaterelease = 1;
    
    /#
        triggertype = self.bundle.var_e56704a1957afc10;
        
        if ( triggertype == 0 )
        {
            immediaterelease = 0;
        }
    #/
    
    thread function_31be5250a8292b48();
    thread function_bdde9fcc527c241b( immediaterelease );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 7
// Checksum 0x0, Offset: 0xd62
// Size: 0x395
function function_cc8b9ef243e90347( clusterspike, weaponobj, streakinfo, bundle, owner, lifetimeoverride, maindevice )
{
    level.var_c255eb9109a38f9f++;
    clusterspike.bundle = bundle;
    clusterspike.owner = owner;
    clusterspike.team = owner.team;
    clusterspike.ownerid = "ownerID_" + owner getxuid();
    clusterspike.clusterid = clusterspike.ownerid + "_" + level.var_c255eb9109a38f9f;
    clusterspike.maindevice = istrue( maindevice );
    clusterspike.weapon_name = weaponobj.basename;
    clusterspike.equipmentref = "cluster_spike";
    clusterspike.weapon_object = weaponobj;
    clusterspike.health = 99999;
    clusterspike.maxhealth = bundle.maxhealth;
    clusterspike.lifetime = bundle.var_7e93f41f2cc274aa;
    clusterspike.killoneshot = bundle.var_f6150443be8e47b7;
    
    if ( issharedfuncdefined( "cluster_spike", "attachXRays" ) )
    {
        clusterspike = [[ getsharedfunc( "cluster_spike", "attachXRays" ) ]]( clusterspike );
    }
    
    if ( isdefined( lifetimeoverride ) )
    {
        clusterspike.lifetime = lifetimeoverride;
    }
    
    clusterspike.streakinfo = streakinfo;
    clusterspike.damagetaken = 0;
    clusterspike setentityowner( owner );
    clusterspike setotherent( owner );
    clusterspike setcandamage( 1 );
    
    if ( issharedfuncdefined( "killstreak", "addToActiveKillstreakList" ) )
    {
        clusterspike [[ getsharedfunc( "killstreak", "addToActiveKillstreakList" ) ]]( streakinfo.streakname, "Killstreak_Ground", owner );
    }
    
    if ( issharedfuncdefined( "emp", "setEMP_Applied_Callback" ) )
    {
        clusterspike [[ getsharedfunc( "emp", "setEMP_Applied_Callback" ) ]]( &function_4d7b7570ddab816d );
    }
    
    if ( issharedfuncdefined( "emp", "setEMP_Cleared_Callback" ) )
    {
        clusterspike [[ getsharedfunc( "emp", "setEMP_Cleared_Callback" ) ]]( &function_1d0735b9c8b14634 );
    }
    
    clusterspike scripts\cp_mp\equipment\haywire::function_172d848d58051fdf( &function_7558c2019a377bd9 );
    clusterspike scripts\cp_mp\emp_debuff::set_start_emp_callback( &function_4d7b7570ddab816d );
    clusterspike scripts\cp_mp\emp_debuff::set_apply_emp_callback( &function_cae5c83763020435 );
    clusterspike scripts\cp_mp\emp_debuff::set_clear_emp_callback( &function_1d0735b9c8b14634 );
    clusterspike function_49197cd063a740ea( &function_9537ab94dab9a1c0 );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread scripts\common\elevators::isentitytouchingdoortrigger( clusterspike );
        }
    }
    
    if ( !isdefined( level.clusterspikes[ clusterspike.team ][ clusterspike.ownerid ] ) )
    {
        level.clusterspikes[ clusterspike.team ][ clusterspike.ownerid ] = [];
    }
    
    level.clusterspikes[ clusterspike.team ][ clusterspike.ownerid ][ level.clusterspikes[ clusterspike.team ][ clusterspike.ownerid ].size ] = clusterspike;
    clusterspike thread function_fd6a27936d8258f4();
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x10ff
// Size: 0x4e
function function_4d7b7570ddab816d( data )
{
    if ( isdefined( self ) && !istrue( self.isexploding ) || getdvarint( @"hash_58254c61de76bffe", 0 ) )
    {
        self.isdisabled = 1;
        self setscriptablepartstate( "empd", "active", 0 );
    }
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x1155
// Size: 0x4d
function function_cae5c83763020435( data )
{
    if ( isdefined( self ) && !istrue( self.isexploding ) || getdvarint( @"hash_58254c61de76bffe", 0 ) )
    {
        data.attacker thread namespace_53fc9ddbb516e6e1::doscoreeventsharedfunc( #"disabled_cluster_spike" );
    }
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x11aa
// Size: 0x3a
function function_1d0735b9c8b14634( data )
{
    if ( isdefined( self ) || !istrue( self.isexploding ) )
    {
        self.isdisabled = undefined;
        self setscriptablepartstate( "empd", "neutral", 0 );
    }
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x11ec
// Size: 0x48
function function_7558c2019a377bd9( data )
{
    if ( istrue( self.isexploding ) )
    {
        return 0;
    }
    
    if ( isdefined( data.attacker ) )
    {
        self setentityowner( data.attacker );
    }
    
    thread clusterspike_explode( "explode" );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 0
// Checksum 0x0, Offset: 0x123c
// Size: 0xf
function function_b89726dbbc1c74f6()
{
    thread clusterspike_explode( "destroy" );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x1253
// Size: 0xdb
function clusterspike_explode( explodestate )
{
    if ( istrue( self.isexploding ) )
    {
        return;
    }
    
    if ( isdefined( level.var_b67b5f9dfe488c2f ) )
    {
        thread [[ level.var_b67b5f9dfe488c2f ]]( self.streakinfo );
    }
    
    if ( isdefined( level.var_ca1a76fbc0ba0bef ) )
    {
        thread [[ level.var_ca1a76fbc0ba0bef ]]( self.streakinfo, self.origin, 0 );
    }
    
    self notify( "explode_cluster_spike" );
    self.isexploding = 1;
    
    if ( isdefined( self.owner ) )
    {
        self setentityowner( self.owner );
    }
    
    self clearscriptabledamageowner();
    self setscriptablepartstate( explodestate, "on", 0 );
    
    if ( isdefined( level.var_f56a88761038798b ) )
    {
        thread [[ level.var_f56a88761038798b ]]( self.streakinfo );
    }
    
    thread function_b53e15638ce719b2( 1 );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x1336
// Size: 0xf0
function function_b53e15638ce719b2( wasdestroyed )
{
    level endon( "game_ended" );
    self.streakinfo.expiredbydeath = istrue( wasdestroyed );
    
    if ( istrue( self.maindevice ) )
    {
        if ( isdefined( self.owner ) )
        {
            if ( !istrue( self.recordedgameendstats ) )
            {
                self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats( self.streakinfo );
            }
        }
    }
    
    if ( isdefined( self.headiconid ) )
    {
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon( self.headiconid );
    }
    
    clusterteam = self.team;
    var_de04c74e0c2b2f65 = self.ownerid;
    level.clusterspikes[ clusterteam ][ var_de04c74e0c2b2f65 ] = array_remove( level.clusterspikes[ clusterteam ][ var_de04c74e0c2b2f65 ], self );
    level notify( "removed_" + self.clusterid );
    wait 1;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 5
// Checksum 0x0, Offset: 0x142e
// Size: 0x14c
function function_723aa6329b751bc7( victim, inflictor, objweapon, meansofdeath, damage )
{
    bundle = level.streakglobals.streakbundles[ "cluster_spike" ];
    
    if ( isdefined( inflictor ) && isdefined( inflictor.damageoverwrite ) )
    {
        return inflictor.damageoverwrite;
    }
    
    if ( !isdefined( bundle ) )
    {
        return damage;
    }
    
    if ( bundle.var_aa7b2f9dc0871919 )
    {
        return damage;
    }
    
    if ( !isdefined( inflictor ) )
    {
        return damage;
    }
    
    if ( meansofdeath != "MOD_EXPLOSIVE" )
    {
        return damage;
    }
    
    if ( !isdefined( objweapon ) )
    {
        return damage;
    }
    
    if ( isnullweapon( objweapon ) )
    {
        return damage;
    }
    
    if ( objweapon.basename != bundle.deployweapon && objweapon.basename != bundle.spawnweapon )
    {
        return damage;
    }
    
    if ( isdefined( victim ) && isplayer( victim ) )
    {
        damagethreshold = victim.maxhealth * 0.5;
        currenthealth = victim.health;
        
        if ( currenthealth >= damagethreshold && damage >= damagethreshold )
        {
            if ( damage >= currenthealth )
            {
                damage = victim.maxhealth - 1;
            }
        }
    }
    
    return damage;
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x1583
// Size: 0x5d
function function_a868fa9dc357d535( owner )
{
    if ( isagent( owner ) )
    {
        return level.clusterspikes[ owner.team ][ "ownerID_" + owner getentitynumber() ];
    }
    
    return level.clusterspikes[ owner.team ][ "ownerID_" + owner getxuid() ];
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 0
// Checksum 0x0, Offset: 0x15e8
// Size: 0x46
function function_31be5250a8292b48()
{
    self endon( "explode_cluster_spike" );
    level endon( "removed_" + self.clusterid );
    level waittill( "game_ended" );
    self.recordedgameendstats = 1;
    self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats( self.streakinfo );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 0
// Checksum 0x0, Offset: 0x1636
// Size: 0x59
function function_76424b83e8eccb98()
{
    self endon( "explode_cluster_spike" );
    level endon( "game_ended" );
    level endon( "removed_" + self.clusterid );
    droneowner = self.owner;
    droneowner waittill_any_3( "disconnect", "joined_team", "joined_spectators" );
    thread clusterspike_explode( "destroy" );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 0
// Checksum 0x0, Offset: 0x1697
// Size: 0x38
function function_61ad64f233f8040a()
{
    self endon( "explode_cluster_spike" );
    level endon( "game_ended" );
    level endon( "removed_" + self.clusterid );
    wait self.lifetime;
    thread clusterspike_explode( "explode" );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 0
// Checksum 0x0, Offset: 0x16d7
// Size: 0xc1
function function_fd6a27936d8258f4()
{
    self endon( "explode_cluster_spike" );
    level endon( "game_ended" );
    clusterteam = self.team;
    var_de04c74e0c2b2f65 = self.ownerid;
    clusterid = self.clusterid;
    thread function_2f8d16ebd367c6e7( clusterid );
    failsafefusetime = self.lifetime + 5;
    result = level waittill_any_timeout_1( failsafefusetime, "removed_" + clusterid );
    
    if ( !isdefined( self ) )
    {
        level.clusterspikes[ clusterteam ][ var_de04c74e0c2b2f65 ] = array_removeundefined( level.clusterspikes[ clusterteam ][ var_de04c74e0c2b2f65 ] );
    }
    else
    {
        function_b53e15638ce719b2( 0 );
    }
    
    level notify( "removed_" + clusterid );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x17a0
// Size: 0x3d
function function_2f8d16ebd367c6e7( clusterid )
{
    self endon( "explode_cluster_spike" );
    level endon( "game_ended" );
    level endon( "removed_" + clusterid );
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        waitframe();
    }
    
    level notify( "removed_" + clusterid );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 0
// Checksum 0x0, Offset: 0x17e5
// Size: 0x33e
function function_fb3d88b9443dd19c()
{
    self endon( "explode_cluster_spike" );
    level endon( "game_ended" );
    level endon( "removed_" + self.clusterid );
    
    while ( true )
    {
        self waittill( "damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( isdefined( level.teambased ) && isplayer( attacker ) && attacker.team == self.team && attacker != self.owner )
        {
            continue;
        }
        
        self.wasdamaged = 1;
        modifieddamage = damage;
        
        if ( issharedfuncdefined( "killstreak", "getModifiedAntiKillstreakDamage" ) )
        {
            modifieddamage = self [[ getsharedfunc( "killstreak", "getModifiedAntiKillstreakDamage" ) ]]( attacker, objweapon, smeansofdeath, damage, self.maxhealth, 1, 1, 1, 1, 1 );
        }
        
        if ( isplayer( attacker ) )
        {
            if ( issharedfuncdefined( "damage", "updateDamageFeedback" ) )
            {
                attacker [[ getsharedfunc( "damage", "updateDamageFeedback" ) ]]( "hitequip" );
            }
        }
        
        if ( issharedfuncdefined( "killstreak", "killstreakHit" ) )
        {
            [[ getsharedfunc( "killstreak", "killstreakHit" ) ]]( attacker, objweapon, self, smeansofdeath, modifieddamage );
        }
        
        if ( isdefined( attacker.owner ) && isplayer( attacker.owner ) )
        {
            if ( issharedfuncdefined( "damage", "updateDamageFeedback" ) )
            {
                attacker.owner [[ getsharedfunc( "damage", "updateDamageFeedback" ) ]]( "hitequip" );
            }
        }
        
        self.damagetaken += modifieddamage;
        self.currenthealth = self.maxhealth - self.damagetaken;
        
        if ( self.currenthealth <= 0 )
        {
            if ( isdefined( objweapon ) && ( objweapon.basename == self.bundle.deployweapon || objweapon.basename == self.bundle.spawnweapon ) )
            {
                minelist = function_a868fa9dc357d535( self.owner );
                var_5ad3fca00533f5b2 = 0.25;
                
                foreach ( mine in minelist )
                {
                    if ( !isdefined( mine ) )
                    {
                        continue;
                    }
                    
                    if ( mine == self )
                    {
                        continue;
                    }
                    
                    if ( istrue( mine.var_5f06e12fc0f29ef4 ) )
                    {
                        var_5ad3fca00533f5b2 += randomfloatrange( 0.25, 0.35 );
                    }
                }
                
                self.var_5f06e12fc0f29ef4 = 1;
                wait var_5ad3fca00533f5b2;
            }
            
            thread clusterspike_explode( "explode" );
        }
    }
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x1b2b
// Size: 0x1bf
function function_31edd36326bada17( var_632c2d9d36540b99 )
{
    self endon( "explode_cluster_spike" );
    level endon( "game_ended" );
    level endon( "removed_" + self.clusterid );
    armstate = "on";
    
    if ( istrue( self.maindevice ) )
    {
        armstate = "on_main";
    }
    
    self setscriptablepartstate( "arm", armstate, 0 );
    self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, 10, undefined, undefined, undefined, undefined, 1 );
    
    /#
        thread function_b6f9b15b3da67aa0();
    #/
    
    thread function_76424b83e8eccb98();
    thread function_61ad64f233f8040a();
    thread function_fb3d88b9443dd19c();
    
    while ( true )
    {
        self waittill( "trigger_grenade", entarr );
        
        if ( istrue( self.isdisabled ) )
        {
            continue;
        }
        
        self setscriptablepartstate( "trigger", "on", 0 );
        
        if ( !istrue( var_632c2d9d36540b99 ) )
        {
            wait 0.35;
        }
        
        foreach ( ent in entarr )
        {
            if ( !isdefined( ent ) || !isdefined( ent.classname ) )
            {
                continue;
            }
            
            if ( ent.classname == "script_vehicle" )
            {
                var_747605e7f0f10e41 = 1;
                
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
                
                if ( !ent _isalive() )
                {
                    continue;
                }
                
                function_94d34a6ffa8cd741();
                break;
            }
        }
    }
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x1cf2
// Size: 0x10d
function function_6360197cfe54c18e( immediaterelease )
{
    clusterowner = self.owner;
    clusterowner endon( "disconnect" );
    level endon( "game_ended" );
    bundle = level.streakglobals.streakbundles[ "cluster_spike" ];
    
    while ( true )
    {
        clusterowner waittill( "grenade_fire", grenade, objweapon, tickpercent, originalowner );
        
        if ( !isdefined( objweapon ) || objweapon.basename != self.bundle.spawnweapon )
        {
            continue;
        }
        
        lifetimeoverride = undefined;
        
        if ( !istrue( immediaterelease ) )
        {
            lifetimeoverride = self.bundle.var_11bd502e73321e11;
        }
        
        function_cc8b9ef243e90347( grenade, objweapon, self.streakinfo, bundle, self.owner, lifetimeoverride );
        grenade thread function_daff421c657d09ca( immediaterelease );
        break;
    }
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x1e07
// Size: 0x3f
function function_daff421c657d09ca( var_f92dd6ce11a58204 )
{
    self endon( "explode_cluster_spike" );
    level endon( "game_ended" );
    level endon( "removed_" + self.clusterid );
    
    if ( istrue( var_f92dd6ce11a58204 ) )
    {
        self waittill( "missile_stuck" );
    }
    
    thread function_31edd36326bada17();
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x1e4e
// Size: 0x59
function function_bdde9fcc527c241b( immediaterelease )
{
    self endon( "explode_cluster_spike" );
    level endon( "game_ended" );
    level endon( "removed_" + self.clusterid );
    thread function_e328684112fe03c5( immediaterelease );
    var_632c2d9d36540b99 = 0;
    
    if ( !istrue( immediaterelease ) )
    {
        var_632c2d9d36540b99 = 1;
    }
    
    self waittill( "released_sub_projectiles" );
    thread function_31edd36326bada17( var_632c2d9d36540b99 );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x1eaf
// Size: 0x19c
function function_e328684112fe03c5( immediaterelease )
{
    self endon( "explode_cluster_spike" );
    level endon( "game_ended" );
    level endon( "removed_" + self.clusterid );
    fusetime = self.bundle.var_7e93f41f2cc274aa + 30;
    
    if ( !istrue( immediaterelease ) )
    {
        self waittill( "trigger_sub_projectiles" );
    }
    else
    {
        wait 0.75;
    }
    
    self setscriptablepartstate( "release", "on", 0 );
    
    for ( i = 0; i < self.bundle.var_c8cf96acb2102d41 ; i++ )
    {
        discnum = "0" + i + 1;
        mineorigin = self gettagorigin( "j_disc_" + discnum );
        launchdir = vectornormalize( mineorigin - self.origin );
        launchstart = mineorigin + launchdir * 2;
        launchgoal = mineorigin + anglestoup( self.angles ) * 200 + launchdir * 300;
        launchvelocity = launchgoal - mineorigin;
        
        if ( isdefined( self ) && isdefined( self.owner ) )
        {
            thread function_6360197cfe54c18e( immediaterelease );
            
            if ( issharedfuncdefined( "weapons", "_launchGrenade" ) )
            {
                self.owner [[ getsharedfunc( "weapons", "_launchGrenade" ) ]]( self.bundle.spawnweapon, launchstart, launchvelocity, fusetime );
            }
        }
        
        wait 0.05;
    }
    
    self notify( "released_sub_projectiles" );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 0
// Checksum 0x0, Offset: 0x2053
// Size: 0xf
function function_94d34a6ffa8cd741()
{
    thread clusterspike_explode( "explode" );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 2
// Checksum 0x0, Offset: 0x206a
// Size: 0x7e
function function_7fb05833db79cf2d( vehicle, mine )
{
    mine endon( "mine_destroyed" );
    mine endon( "death" );
    mine.owner endon( "disconnect" );
    mine notify( "explode_cluster_spike" );
    self.isexploding = 1;
    self setentityowner( self.owner );
    self clearscriptabledamageowner();
    self setscriptablepartstate( "explode", "on", 0 );
    wait 0.2;
    mine thread function_ff273de0f0971ad( vehicle );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x20f0
// Size: 0xff
function function_ff273de0f0971ad( vehicle )
{
    self setentityowner( self.owner );
    self clearscriptabledamageowner();
    self setscriptablepartstate( "explode", "off", 0 );
    thread function_b53e15638ce719b2( 1 );
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle dodamage( self.bundle.var_8bd44ef6b41e8e2, self.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_object );
    ignoredamageid = undefined;
    
    if ( issharedfuncdefined( "game", "non_player_add_ignore_damage_signature" ) )
    {
        ignoredamageid = vehicle [[ getsharedfunc( "game", "non_player_add_ignore_damage_signature" ) ]]( self.owner, self.weapon_object, self, "MOD_EXPLOSIVE" );
    }
    
    waitframe();
    
    if ( issharedfuncdefined( "game", "non_player_remove_ignore_damage_signature" ) )
    {
        if ( isdefined( vehicle ) && isdefined( ignoredamageid ) )
        {
            vehicle [[ getsharedfunc( "game", "non_player_remove_ignore_damage_signature" ) ]]( ignoredamageid );
        }
    }
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x21f7
// Size: 0x4d, Type: bool
function function_60dface26506153e( weaponref )
{
    bundle = level.streakglobals.streakbundles[ "cluster_spike" ];
    return weaponref == bundle.deployweapon || weaponref == bundle.spawnweapon;
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 0
// Checksum 0x0, Offset: 0x224d
// Size: 0xf
function function_9537ab94dab9a1c0()
{
    thread clusterspike_explode( "destroy" );
}

// Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
// Params 1
// Checksum 0x0, Offset: 0x2264
// Size: 0x15
function function_49197cd063a740ea( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

/#

    // Namespace cluster_spike / scripts\cp_mp\killstreaks\cluster_spike
    // Params 0
    // Checksum 0x0, Offset: 0x2281
    // Size: 0x77, Type: dev
    function function_b6f9b15b3da67aa0()
    {
        self endon( "<dev string:x91>" );
        level endon( "<dev string:xa7>" );
        level endon( "<dev string:xb2>" + self.clusterid );
        
        while ( true )
        {
            triggerdebug = getdvarint( @"hash_ecade10f325e63e6", 0 );
            
            if ( !triggerdebug )
            {
                waitframe();
                continue;
            }
            
            break;
        }
        
        setdvar( @"hash_ecade10f325e63e6", 0 );
        self notify( "<dev string:xbb>", [ self.owner ] );
    }

#/
