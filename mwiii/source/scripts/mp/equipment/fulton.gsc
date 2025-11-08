#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\supers;
#using scripts\mp\utility\teams;

#namespace fulton;

// Namespace fulton / scripts\mp\equipment\fulton
// Params 0
// Checksum 0x0, Offset: 0x5ab
// Size: 0xc2
function fulton_init()
{
    fulton_initrepository();
    
    if ( !scripts\cp_mp\utility\game_utility::IsMagellanMode() )
    {
        game[ "dialog" ][ "plunder_extract_fail_fulton" ] = "pxff_grav_plnd";
    }
    else
    {
        game[ "dialog" ][ "plunder_extract_fail_fulton" ] = "plunder_plunder_extract_fail_fulton";
    }
    
    level._effect[ "vfx_fulton_explode" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_money_fulton_destr.vfx" );
    
    /#
        setdevdvarifuninitialized( @"hash_480475a0dec18661", 1 );
        setdevdvarifuninitialized( @"hash_491b43c08b40fe8c", 1 );
        setdevdvarifuninitialized( @"hash_6bcaa107055e7a7f", 0.75 );
        setdevdvarifuninitialized( @"hash_f28eeaada0889d3a", 250 );
        setdevdvarifuninitialized( @"hash_de5cf9b63e5508db", 1500 );
        setdevdvarifuninitialized( @"hash_3fed2bee9823c2be", 20 );
    #/
}

#using_animtree( "script_model" );

// Namespace fulton / scripts\mp\equipment\fulton
// Params 0
// Checksum 0x0, Offset: 0x675
// Size: 0x83
function fulton_initanims()
{
    level.scr_animtree[ "fulton" ] = #animtree;
    level.scr_anim[ "fulton" ][ "fulton_open" ] = level.br_anim[ "wm_skyhook_ground_open" ];
    level.scr_anim[ "fulton" ][ "fulton_open_idle" ] = level.br_anim[ "wm_skyhook_ground_idle_open" ];
    level.scr_anim[ "fulton" ][ "fulton_takeoff" ] = level.br_anim[ "wm_skyhook_ground_takeoff" ];
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 0
// Checksum 0x0, Offset: 0x700
// Size: 0x1ac
function fulton_initrepository()
{
    leveldataforrepository = plunder_getleveldataforrepository( "equip_mp_fulton", 1 );
    leveldataforrepository.type = 0;
    leveldataforrepository.usetime = getdvarfloat( @"hash_6bcaa107055e7a7f", 0.75 );
    leveldataforrepository.useeventtype = 2;
    leveldataforrepository.useeventamount = getdvarint( @"hash_f28eeaada0889d3a", 250 );
    leveldataforrepository.teamuseonly = 1;
    leveldataforrepository.teamanchoredwidget = 1;
    leveldataforrepository.usefailcapacitymsg = "MP/CANNOT_DEPOSIT_CASH_BALLOON_FULL";
    leveldataforrepository.usefailextractingmsg = "MP/CANNOT_DEPOSIT_CASH_BALLOON_LEAVING";
    leveldataforrepository.scriptableusepart = "fulton_use_cache";
    leveldataforrepository.scriptableusestate = "usable";
    leveldataforrepository.scriptablenousestate = "unusable";
    leveldataforrepository.extractcountdown = getdvarint( @"hash_3fed2bee9823c2be", 20 );
    leveldataforrepository.extractcountdownmsg = "MP/CASH_BALLOON_LEAVING_IN_N";
    leveldataforrepository.capacity = getdvarint( @"hash_de5cf9b63e5508db", 1500 );
    leveldataforrepository.countdownendcallback = &fulton_repositorycountdownendcallback;
    leveldataforrepository.extractcallback = &fulton_repositoryextractcallback;
    leveldataforrepository.atcapacitycallback = &fulton_repositoryatcapacitycallback;
    leveldataforrepository.extractionmethod = "fulton";
    leveldataforrepository.dropplunder = getdvarint( @"hash_491b43c08b40fe8c", 1 ) > 0;
    leveldataforrepository.cantakedamage = getdvarint( @"hash_480475a0dec18661", 1 ) > 0;
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 1
// Checksum 0x0, Offset: 0x8b4
// Size: 0xeb
function fulton_create( grenade )
{
    fulton = spawn( "script_model", grenade.origin );
    fulton setautoboxcalculationusingdobj( 1 );
    var_cb09fafea872c96d = "military_skyhook_far_mp";
    
    if ( istrue( level.var_5a2620a56cf4bb ) )
    {
        var_cb09fafea872c96d = "military_skyhook_far_plunder";
    }
    
    fulton setmodel( var_cb09fafea872c96d );
    fulton.angles = grenade.angles;
    fulton.owner = self;
    fulton.team = self.team;
    
    if ( isdefined( grenade.moving_platform ) )
    {
        fulton.moving_platform = grenade.moving_platform;
    }
    
    fulton.animname = "fulton";
    fulton scripts\common\anim::setanimtree();
    self.fulton = fulton;
    fulton thread fulton_planted();
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 1
// Checksum 0x0, Offset: 0x9a7
// Size: 0x9d
function fulton_destroy( damagedata )
{
    leveldataforrepository = plunder_getleveldataforrepository( "equip_mp_fulton" );
    thread scripts\mp\gametypes\br::teamsplashbr( "br_fulton_balloon_shot_down", self.owner, self.team, undefined, "splash_list_br_plunder_iw9_mp" );
    scripts\mp\gametypes\br_plunder::entityplunderlosealldeposited( leveldataforrepository.dropplunder );
    playfx( getfx( "vfx_fulton_explode" ), self.origin, anglestoforward( self.angles ) );
    playsoundatpos( self.origin, "br_fulton_extract_exp" );
    thread fulton_deletenextframe();
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 0
// Checksum 0x0, Offset: 0xa4c
// Size: 0xa6
function fulton_deletenextframe()
{
    self notify( "death" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner.fulton = undefined;
    }
    
    self hide();
    scripts\mp\damage::monitordamageend();
    self setscriptablepartstate( "fulton_use_cache", "unusable", 0 );
    self setscriptablepartstate( "fulton_use_extract", "unusable", 0 );
    self setscriptablepartstate( "effects", "neutral", 0 );
    plunder_deregisterrepositoryinstance( self );
    self stopanimscripted();
    
    if ( isdefined( self.scenenode ) )
    {
        self.scenenode delete();
    }
    
    waitframe();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 1
// Checksum 0x0, Offset: 0xafa
// Size: 0x151
function fulton_used( grenade )
{
    self endon( "death_or_disconnect" );
    
    if ( !istrue( level.br_plunder_enabled ) )
    {
        return;
    }
    
    grenade waittill( "missile_stuck", stuckto );
    
    if ( isdefined( stuckto ) )
    {
        if ( getdvarint( @"hash_269506ff08a558cd", 1 ) == 1 )
        {
            fulton_check_for_moving_platform( grenade, stuckto );
        }
        
        if ( !isdefined( grenade.moving_platform ) )
        {
            self playlocalsound( "br_pickup_deny" );
            scripts\mp\hud_message::showerrormessage( "MP/CASH_BALLOON_CANNOT_PLACE" );
            
            if ( isdefined( self.super ) )
            {
                fulton_refundsuper();
            }
            
            grenade delete();
            return;
        }
    }
    
    if ( !fulton_cancreate( grenade ) )
    {
        self playlocalsound( "br_pickup_deny" );
        scripts\mp\hud_message::showerrormessage( "MP/CASH_BALLOON_BLOCKED" );
        
        if ( isdefined( self.super ) )
        {
            fulton_refundsuper();
        }
        
        grenade delete();
        return;
    }
    else if ( 1 && isdefined( self.fulton ) )
    {
        self playlocalsound( "br_pickup_deny" );
        scripts\mp\hud_message::showerrormessage( "MP/CASH_BALLOON_TOO_MANY" );
        
        if ( isdefined( self.super ) )
        {
            fulton_refundsuper();
        }
        
        grenade delete();
        return;
    }
    
    if ( isdefined( self.super ) )
    {
        scripts\mp\supers::superusefinished( undefined, undefined, undefined, 1 );
    }
    
    thread fulton_create( grenade );
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 2
// Checksum 0x0, Offset: 0xc53
// Size: 0x9a
function fulton_check_for_moving_platform( grenade, stuckto )
{
    if ( isdefined( stuckto.linked_brush ) )
    {
        if ( isdefined( stuckto.linked_brush.targetname ) )
        {
            if ( stuckto.linked_brush.targetname == "train_wz" )
            {
                grenade.moving_platform = stuckto;
            }
        }
        
        return;
    }
    
    if ( isdefined( stuckto.targetname ) && stuckto.targetname == "train_wz" )
    {
        grenade.moving_platform = stuckto;
    }
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 0
// Checksum 0x0, Offset: 0xcf5
// Size: 0x15a
function fulton_planted()
{
    self endon( "death" );
    self endon( "start_extract" );
    playsoundatpos( self.origin, "iw9_extraction_balloon_drop" );
    thread scripts\mp\gametypes\br::teamsplashbr( "br_fulton_device_placed", self.owner, self.team, undefined, "splash_list_br_plunder_iw9_mp" );
    players = scripts\mp\utility\teams::getfriendlyplayers( self.team );
    plunder_registerrepositoryinstance( self, "equip_mp_fulton" );
    thread scripts\mp\gametypes\br_plunder::plunder_repositorywatchcountdown( self, players );
    plunder_updateanchoredwidgetforplayers( self, players );
    scenenode = spawn( "script_model", self.origin );
    scenenode setmodel( "tag_origin" );
    scenenode.angles = self.angles * ( 0, 1, 0 );
    scenenode.fulton = self;
    self.scenenode = scenenode;
    
    if ( isdefined( self.moving_platform ) )
    {
        self linkto( self.moving_platform );
        scenenode linkto( self.moving_platform );
    }
    
    fulton_open();
    leveldataforrepository = plunder_getleveldataforrepository( "equip_mp_fulton", 1 );
    
    if ( leveldataforrepository.cantakedamage )
    {
        thread scripts\mp\damage::monitordamage( 300, "", &fulton_handlefataldamage, &fulton_handledamage );
    }
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 0
// Checksum 0x0, Offset: 0xe57
// Size: 0x3a
function fulton_open()
{
    self setscriptablepartstate( "effects", "fillUp", 0 );
    self.scenenode scripts\common\anim::anim_single_solo( self, "fulton_open" );
    childthread function_f71b5e7dfcfa8820();
    childthread fulton_openidle();
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 0
// Checksum 0x0, Offset: 0xe99
// Size: 0x20
function fulton_openidle()
{
    while ( true )
    {
        self.scenenode scripts\common\anim::anim_single_solo( self, "fulton_open_idle" );
    }
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 0
// Checksum 0x0, Offset: 0xec1
// Size: 0x3f
function function_f71b5e7dfcfa8820()
{
    self endon( "death" );
    var_72b2451562363925 = "iw9_extraction_balloon_idle_lp";
    play_loop_sound_on_entity( var_72b2451562363925, ( 0, 0, 72 ) );
    self waittill( "fulton_takeoff" );
    stop_loop_sound_on_entity( var_72b2451562363925 );
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 1
// Checksum 0x0, Offset: 0xf08
// Size: 0xe6
function fulton_handledamage( damagedata )
{
    damage = damagedata.damage;
    
    if ( !istrue( scripts\cp_mp\utility\player_utility::playersareenemies( damagedata.attacker, self.owner ) ) )
    {
        damage = 0;
    }
    else
    {
        damage = scripts\mp\damage::handleshotgundamage( damagedata.objweapon, damagedata.meansofdeath, damagedata.damage );
        hitstokill = undefined;
        
        if ( damagedata.meansofdeath == "MOD_MELEE" )
        {
            damage = int( ceil( self.maxhealth / 6 ) );
        }
        else if ( isexplosivedamagemod( damagedata.meansofdeath ) )
        {
            if ( damagedata.damage >= 50 )
            {
                damage = int( ceil( self.maxhealth / 1 ) );
            }
        }
    }
    
    return damage;
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 1
// Checksum 0x0, Offset: 0xff7
// Size: 0x14
function fulton_handlefataldamage( damagedata )
{
    thread fulton_destroy( damagedata );
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 3
// Checksum 0x0, Offset: 0x1013
// Size: 0x48
function fulton_repositoryusecallback( entity, player, amount )
{
    leveldataforrepository = plunder_getleveldataforrepository( "equip_mp_fulton" );
    player thread playerplunderevent( amount, leveldataforrepository.useeventtype, entity );
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 2
// Checksum 0x0, Offset: 0x1063
// Size: 0x3f
function fulton_repositorycountdownendcallback( entity, fromtimeout )
{
    if ( isdefined( entity.owner ) )
    {
        entity.owner.fulton = undefined;
    }
    
    plunder_repositoryextract( entity );
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 1
// Checksum 0x0, Offset: 0x10aa
// Size: 0x9b
function fulton_repositoryextractcallback( entity )
{
    entity endon( "death" );
    leveldataforrepository = plunder_getleveldataforrepository( "equip_mp_fulton" );
    data = undefined;
    entity scripts\mp\damage::monitordamageend();
    data = scripts\mp\gametypes\br_plunder::entityplunderbankalldeposited();
    thread scripts\mp\gametypes\br::teamsplashbr( "br_fulton_balloon_successfully_away", self.owner, self.team, undefined, "splash_list_br_plunder_iw9_mp" );
    self notify( "fulton_takeoff" );
    self playsoundonmovingent( "iw9_extraction_balloon_takeoff" );
    self.scenenode scripts\common\anim::anim_single_solo( self, "fulton_takeoff" );
    thread fulton_deletenextframe();
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 1
// Checksum 0x0, Offset: 0x114d
// Size: 0x34
function fulton_repositoryatcapacitycallback( entity )
{
    thread scripts\mp\gametypes\br::teamsplashbr( "br_fulton_balloon_full", entity.owner, entity.team, undefined, "splash_list_br_plunder_iw9_mp" );
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 1
// Checksum 0x0, Offset: 0x1189
// Size: 0xb8, Type: bool
function fulton_cancreate( grenade )
{
    if ( scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf() )
    {
        return true;
    }
    
    var_57f6e7d1be00d5f9 = 25;
    planeflyheight = scripts\cp_mp\parachute::getc130height();
    start = grenade.origin + ( 0, 0, var_57f6e7d1be00d5f9 + 1 );
    end = ( grenade.origin[ 0 ], grenade.origin[ 1 ], planeflyheight );
    contents = create_contents( 0, 1, 1, 1, 1, 1, 0 );
    trc = sphere_trace( start, end, var_57f6e7d1be00d5f9, grenade, contents );
    return trc[ "fraction" ] == 1;
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 0
// Checksum 0x0, Offset: 0x124a
// Size: 0x49
function fulton_refundsuper()
{
    self notify( "super_use_finished_lb" );
    self notify( "super_use_finished" );
    superinfo = scripts\mp\supers::getcurrentsuper();
    scripts\mp\supers::setsuperisinuse( 0 );
    scripts\mp\supers::setsuperexpended( 0 );
    superinfo.wasrefunded = 1;
    scripts\mp\supers::refundsuper();
}

// Namespace fulton / scripts\mp\equipment\fulton
// Params 0
// Checksum 0x0, Offset: 0x129b
// Size: 0x1e
function function_5b95dd8b798c16e1()
{
    if ( scripts\mp\equipment::hasequipment( "equip_extract" ) )
    {
        scripts\mp\equipment::incrementequipmentammo( "equip_extract", 1 );
    }
}

