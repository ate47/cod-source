#using scripts\common\ae_utility;
#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\supers\supers;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\class;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\equipment\tac_insert;
#using scripts\mp\hud_message;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spectating;
#using scripts\mp\supers;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\usability;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;

#namespace tac_insert;

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 0
// Checksum 0x0, Offset: 0x835
// Size: 0x2a
function tacinsert_init()
{
    level.tacinserts = [];
    scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback( &tacinsert_onjoinedteam );
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        level thread tacinsert_deleteontoofar();
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x867
// Size: 0x69
function tacinsert_onjoinedteam( player )
{
    foreach ( tacinsert in level.tacinserts )
    {
        tacinsert tacinsert_updatepickupusability( player );
        tacinsert tacinsert_updatedestroyusability( player );
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 0
// Checksum 0x0, Offset: 0x8d8
// Size: 0x13b
function tacinsert_deleteontoofar()
{
    level endon( "game_ended" );
    bundle = supers::function_bf9c7e9dd30180e3( "super_tac_insert" );
    
    while ( true )
    {
        tacinserts = level.tacinserts;
        checks = 0;
        
        foreach ( tacinsert in tacinserts )
        {
            if ( !isdefined( tacinsert ) )
            {
                continue;
            }
            
            if ( istrue( tacinsert.isdestroyed ) )
            {
                continue;
            }
            
            if ( !isdefined( tacinsert.owner ) )
            {
                continue;
            }
            
            distsq = distance2dsquared( tacinsert.origin, tacinsert.owner.origin );
            var_7484b6defeda6fce = bundle.var_99760dae8f3dda04 * bundle.var_99760dae8f3dda04;
            
            if ( distsq >= var_7484b6defeda6fce )
            {
                tacinsert.owner thread scripts\mp\hud_message::showsplash( "tac_insert_fail_br_too_far" );
                tacinsert tacinsert_destroy( 0 );
            }
            
            checks++;
            
            if ( checks >= 5 )
            {
                checks = 0;
                waitframe();
            }
        }
        
        waitframe();
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 3
// Checksum 0x0, Offset: 0xa1b
// Size: 0x23
function tacinsert_set( equipmentref, slot, variantid )
{
    thread tacinsert_monitorupdatespawnposition();
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 2
// Checksum 0x0, Offset: 0xa46
// Size: 0x1b
function tacinsert_unset( equipmentref, slot )
{
    self notify( "end_monitorTIUse" );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 0
// Checksum 0x0, Offset: 0xa69
// Size: 0x85
function tacinsert_monitorupdatespawnposition()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "end_monitorTIUse" );
    self.tispawnposition = [];
    
    while ( true )
    {
        tacinsert_updatespawnposition();
        currentweapon = self getheldoffhand();
        var_c5aeb8763ac1e868 = currentweapon.basename == "flare_mp";
        var_46bf0299656795d3 = ter_op( var_c5aeb8763ac1e868, 0.05, 1 );
        waittill_any_timeout_1( var_46bf0299656795d3, "offhand_pullback" );
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0xaf6
// Size: 0x40
function function_48444bc9e4a578ff( player )
{
    player endon( "disconnect" );
    level endon( "game_ended" );
    player endon( "end_monitorTIUse" );
    player endon( "end_movingUpdate" );
    
    while ( true )
    {
        wait 1;
        player function_3ad5d3768653f711( self, 1 );
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 0
// Checksum 0x0, Offset: 0xb3e
// Size: 0x35
function tacinsert_updatespawnposition()
{
    spawnpos = self.origin;
    result = tacinsert_isvalidspawnposition( spawnpos );
    
    if ( istrue( result ) )
    {
        tacinsert_cachespawnposition( spawnpos );
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0xb7b
// Size: 0x33, Type: bool
function function_801a0264d93b7be6( spawnpos )
{
    spawnposoffset = spawnpos + ( 0, 0, 3 );
    
    if ( !canspawn( spawnposoffset ) )
    {
        return false;
    }
    
    return true;
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 2
// Checksum 0x0, Offset: 0xbb7
// Size: 0x6a, Type: bool
function tacinsert_isvalidspawnposition( spawnpos, isonspawn )
{
    if ( !function_801a0264d93b7be6( spawnpos ) )
    {
        return false;
    }
    
    if ( !isalive( self ) )
    {
        return true;
    }
    
    if ( scripts\mp\outofbounds::istouchingoobtrigger() )
    {
        return false;
    }
    
    if ( !self isonground() && !self isswimming() )
    {
        return false;
    }
    
    if ( !istrue( isonspawn ) )
    {
        waitframe();
    }
    
    if ( !self isonground() && !self isswimming() )
    {
        return false;
    }
    
    return true;
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0xc2a
// Size: 0x51
function tacinsert_cachespawnposition( newposition )
{
    if ( isdefined( self.tispawnposition[ 0 ] ) && self.tispawnposition[ 0 ] == newposition )
    {
        return;
    }
    
    self.tispawnposition[ 1 ] = self.tispawnposition[ 0 ];
    self.tispawnposition[ 0 ] = newposition;
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 0
// Checksum 0x0, Offset: 0xc83
// Size: 0x4b
function tacinsert_getspawnposition()
{
    if ( isdefined( self.tispawnposition ) )
    {
        if ( isdefined( self.tispawnposition[ 1 ] ) )
        {
            return self.tispawnposition[ 1 ];
        }
        else if ( isdefined( self.tispawnposition[ 0 ] ) )
        {
            return self.tispawnposition[ 0 ];
        }
    }
    
    return undefined;
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 0
// Checksum 0x0, Offset: 0xcd7
// Size: 0x9
function deletetacinsert()
{
    tacinsert_destroy();
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0xce8
// Size: 0x2a
function tacinsert_used( grenade )
{
    result = tacinsert_deploy( grenade );
    
    if ( !istrue( result ) )
    {
        grenade delete();
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0xd1a
// Size: 0x3b7, Type: bool
function tacinsert_deploy( grenade )
{
    grenade setscriptablepartstate( "visibility", "hide", 0 );
    tacinsert_updatespawnposition();
    spawnposition = tacinsert_getspawnposition();
    
    if ( !isdefined( spawnposition ) )
    {
        scripts\mp\hud_message::showerrormessage( "MP/TAC_INSERT_CANNOT_PLACE" );
        thread function_3fd179c2e0859395();
        return false;
    }
    
    distfromplayersq = distancesquared( self.origin, spawnposition );
    
    if ( distfromplayersq >= 65536 )
    {
        scripts\mp\hud_message::showerrormessage( "MP/TAC_INSERT_CANNOT_PLACE" );
        thread function_3fd179c2e0859395();
        return false;
    }
    
    if ( touchingbadtrigger() )
    {
        scripts\mp\hud_message::showerrormessage( "MP/TAC_INSERT_CANNOT_PLACE" );
        thread function_3fd179c2e0859395();
        return false;
    }
    
    startpos = spawnposition + ( 0, 0, 16 );
    endpos = spawnposition + ( 0, 0, -16 );
    
    if ( !function_6aa9474826722600( grenade, startpos, endpos ) )
    {
        scripts\mp\hud_message::showerrormessage( "MP/TAC_INSERT_CANNOT_PLACE" );
        thread function_3fd179c2e0859395();
        return false;
    }
    
    if ( isdefined( level.var_ca4e08767cbdae12 ) )
    {
        canplant = grenade [[ level.var_ca4e08767cbdae12 ]]();
        
        if ( !canplant )
        {
            scripts\mp\hud_message::showerrormessage( "MP/TAC_INSERT_CANNOT_PLACE" );
            thread function_3fd179c2e0859395();
            return false;
        }
    }
    
    if ( isdefined( level.var_f91a05bc873bd121 ) )
    {
        if ( !self [[ level.var_f91a05bc873bd121 ]]( spawnposition ) )
        {
            scripts\mp\hud_message::showerrormessage( "MP/TAC_INSERT_CANNOT_PLACE" );
            thread function_3fd179c2e0859395();
            return false;
        }
    }
    
    spawnpoint_clearspawnpoint( 0, 0, 1 );
    isplayerunderwater = self isswimunderwater();
    isplayerswimming = self isswimming();
    tacinsert = undefined;
    
    if ( isplayerunderwater )
    {
        tacinsert = function_f480e30874e3b591( grenade, startpos, endpos );
    }
    else
    {
        tacinsert = function_1f15609989e6bf6f( grenade, startpos, endpos, isplayerswimming );
    }
    
    if ( !isdefined( tacinsert ) )
    {
        scripts\mp\hud_message::showerrormessage( "MP/TAC_INSERT_CANNOT_PLACE" );
        thread function_3fd179c2e0859395();
        return false;
    }
    
    thread function_176bfee86c8e71cc( tacinsert );
    tacinsert setscriptablepartstate( "visibility", "show", 0 );
    function_69248052b7181e1a( tacinsert );
    tacinsert scripts\mp\sentientpoolmanager::registersentient( "Tactical_Static", self );
    level thread scripts\mp\battlechatter_mp::trysaylocalsound( self, #"bc_fieldupgrade_action_tacinsert" );
    scripts\mp\weapons::onequipmentplanted( tacinsert, "equip_tac_insert", &tacinsert_destroy );
    var_93494d8d17d67d84 = getgametype() == "siege";
    thread scripts\mp\weapons::monitordisownedequipment( self, tacinsert, var_93494d8d17d67d84 );
    tacinsert scripts\cp_mp\emp_debuff::set_apply_emp_callback( &tacinsert_empapplied );
    
    if ( issharedfuncdefined( "emp", "setEMP_Applied_Callback" ) )
    {
        tacinsert [[ getsharedfunc( "emp", "setEMP_Applied_Callback" ) ]]( &tacinsert_empapplied );
    }
    
    tacinsert scripts\cp_mp\equipment\haywire::function_172d848d58051fdf( &tacinsert_empapplied );
    tacinsert function_49197cd063a740ea( &tacinsert_destroy );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread scripts\common\elevators::isentitytouchingdoortrigger( tacinsert );
        }
    }
    
    var_90ae7709c6cc1672 = self isswimming();
    spawnpoint_setspawnpoint( spawnposition, self.angles, tacinsert, 1, var_90ae7709c6cc1672 );
    thread function_b2e205b73c40f44f( grenade );
    entnum = tacinsert getentitynumber();
    level.tacinserts[ entnum ] = tacinsert;
    
    if ( isdefined( level.tacinsert_gamemode_callback ) )
    {
        self [[ level.tacinsert_gamemode_callback ]]();
    }
    
    scripts\cp_mp\challenges::function_d997435895422ecc( "super_tac_insert", function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"use" ) );
    return true;
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x10da
// Size: 0x35
function function_176bfee86c8e71cc( tacinsert )
{
    tacinsert endon( "tacInsert_destroyed" );
    waittill_any_3( "disconnect", "joined_team", "joined_spectators" );
    tacinsert tacinsert_destroy( 0, 1, 1 );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 3
// Checksum 0x0, Offset: 0x1117
// Size: 0x1c4
function function_f480e30874e3b591( grenade, startpos, endpos )
{
    ignoreents = [ self, grenade ];
    watercontents = scripts\engine\trace::create_contents( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 );
    waterstarttrace = self.origin + ( 0, 0, 3000 );
    waterendtrace = self.origin;
    var_da869fb61136a01a = scripts\engine\trace::ray_trace( waterstarttrace, waterendtrace, ignoreents, watercontents, 0 );
    assertex( var_da869fb61136a01a[ "<dev string:x1c>" ] != "<dev string:x27>", "<dev string:x37>" );
    var_ce551e860b6694b3 = var_da869fb61136a01a[ "position" ];
    geostarttrace = self.origin;
    geocontents = physics_createcontents( [ "physicscontents_itemclip", "physicscontents_item" ] );
    var_f6b508749cbf85c4 = scripts\engine\trace::ray_trace( geostarttrace, var_ce551e860b6694b3, ignoreents, geocontents, 1 );
    
    if ( var_f6b508749cbf85c4[ "hittype" ] != "hittype_none" )
    {
        return;
    }
    
    if ( !canspawn( var_ce551e860b6694b3, self ) )
    {
        return;
    }
    
    tacinsertpos = self.origin;
    var_f2674c33fe0cece = self.angles;
    bundle = supers::function_bf9c7e9dd30180e3( "super_tac_insert" );
    grenade.angles = var_f2674c33fe0cece;
    tacinsert = scripts\mp\utility\weapon::_launchgrenade( "flare_mp", tacinsertpos, ( 0, 0, 0 ), undefined, 1, grenade );
    tacinsert.angles = var_f2674c33fe0cece;
    tacinsert thread function_48444bc9e4a578ff( self );
    thread function_c21a6baeeb5139be( tacinsert );
    return tacinsert;
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x12e4
// Size: 0xd5
function function_69248052b7181e1a( tacinsert )
{
    tacinsert.team = self.team;
    tacinsert.owner = self;
    tacinsert scripts\cp_mp\ent_manager::registerspawn( 3, &deletetacinsert );
    tacinsert setscriptablepartstate( "smoke", "active", 0 );
    tacinsert.issuper = isdefined( self.super ) && self.super.staticdata.ref == "super_tac_insert";
    tacinsert.superid = level.superglobals.staticsuperdata[ "super_tac_insert" ].id;
    tacinsert thread tacinsert_setupandwaitfordeath( self );
    tacinsert thread tacinsert_destroyongameended();
    tacinsert setotherent( self );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 4
// Checksum 0x0, Offset: 0x13c1
// Size: 0x1ca
function function_1f15609989e6bf6f( grenade, startpos, endpos, var_5a413baccf7593f7 )
{
    ignoreents = [ self, grenade ];
    contentoverride = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 1, 0 );
    traceresult = scripts\engine\trace::ray_trace_detail( startpos, endpos, ignoreents, contentoverride, 0 );
    
    if ( traceresult[ "hittype" ] == "hittype_none" )
    {
        waitframe();
        radius = 14;
        traceresult = scripts\engine\trace::sphere_trace( startpos, endpos, radius, ignoreents, contentoverride, 0 );
    }
    
    if ( traceresult[ "hittype" ] == "hittype_none" )
    {
        return undefined;
    }
    
    normal = traceresult[ "normal" ];
    tacinsertpos = traceresult[ "position" ] + normal * ( 0, 0, 0.5 );
    spawnposition = tacinsert_getspawnposition();
    distancesq = distancesquared( spawnposition, tacinsertpos );
    
    if ( distancesq > 196 )
    {
        return undefined;
    }
    
    bundle = supers::function_bf9c7e9dd30180e3( "super_tac_insert" );
    tacinsert = scripts\mp\utility\weapon::_launchgrenade( bundle.offhandweapon, tacinsertpos, ( 0, 0, 0 ), undefined, 1, grenade );
    tacinsert.angles = self.angles;
    
    if ( istrue( var_5a413baccf7593f7 ) )
    {
        thread function_c21a6baeeb5139be( grenade );
    }
    
    traceresultent = traceresult[ "entity" ];
    
    if ( isdefined( traceresultent ) && scripts\cp_mp\utility\killstreak_utility::function_3c5c5d86ef14420e( traceresultent ) )
    {
        tacinsert linkto( traceresultent );
        var_c4c31894d4002f8a = getdvarint( @"hash_956f65ae92f862e", 1 );
        
        if ( var_c4c31894d4002f8a )
        {
            tacinsert thread function_48444bc9e4a578ff( self );
        }
    }
    
    return tacinsert;
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x1594
// Size: 0x127
function function_b2e205b73c40f44f( tacinsertent )
{
    tacinsertent endon( "missile_water_impact" );
    level endon( "game_ended" );
    timer = 0;
    destroyti = 0;
    
    while ( true )
    {
        msg = tacinsertent waittill_notify_or_timeout_return( "missile_stuck", 0.25 );
        
        if ( msg == "missile_stuck" )
        {
            break;
        }
        
        if ( timer >= 2 )
        {
            break;
        }
        
        spawnpoint = self.setspawnpoint;
        
        if ( !isdefined( spawnpoint ) )
        {
            destroyti = 1;
        }
        else
        {
            level thread draw_angles( tacinsertent.angles, tacinsertent.origin, ( 1, 0, 0 ), 1000, 100 );
            distancesq = distancesquared( tacinsertent.origin, spawnpoint.playerspawnpos );
            
            if ( distancesq > 196 )
            {
                destroyti = 1;
            }
        }
        
        if ( destroyti )
        {
            break;
        }
        
        timer += 0.25;
    }
    
    if ( destroyti )
    {
        scripts\mp\hud_message::showerrormessage( "MP/TAC_INSERT_CANNOT_PLACE" );
        tacinsertent tacinsert_destroy( 0, 0, 1 );
        function_3fd179c2e0859395();
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x16c3
// Size: 0x3a
function function_c21a6baeeb5139be( grenade )
{
    self endon( "disconnect" );
    grenade endon( "death" );
    level endon( "game_ended" );
    grenade waittill( "missile_stuck" );
    grenade setscriptablepartstate( "splash", "splash", 0 );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x1705
// Size: 0x32
function tacinsert_setupandwaitfordeath( owner )
{
    thread tacinsert_damagelistener( owner );
    thread tacinsert_destroyuselistener( owner );
    
    if ( !self.issuper )
    {
        thread tacinsert_pickuplistener( owner );
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x173f
// Size: 0x45
function tacinsert_damagelistener( owner )
{
    bundle = supers::function_bf9c7e9dd30180e3( "super_tac_insert" );
    scripts\mp\damage::monitordamage( bundle.maxhealth, "hitequip", &tacinsert_handledeathdamage, &tacinsert_modifydamage, 1 );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x178c
// Size: 0x4a
function tacinsert_modifydamage( data )
{
    objweapon = data.objweapon;
    type = data.meansofdeath;
    return utility::handlemeleedamage( objweapon, type, data.damage );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x17df
// Size: 0x9d
function tacinsert_handledeathdamage( data )
{
    attacker = data.attacker;
    self notify( "enemy_destroyed_equipment", attacker );
    
    if ( !isdefined( self.owner ) || istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) ) )
    {
        self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer( "ti_destroyed", undefined, undefined, self.origin );
        attacker thread scripts\mp\battlechatter_mp::onfieldupgradedestroy( #"bc_fieldupgrade_killfirm_tacinsert" );
        attacker thread scripts\mp\utility\points::doscoreevent( #"destroyed_equipment" );
    }
    
    thread tacinsert_destroy( 1 );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x1884
// Size: 0x116
function tacinsert_pickuplistener( owner )
{
    self endon( "death" );
    level endon( "game_ended" );
    owner endon( "disconnect" );
    self.pickuptrigger = spawn( "script_origin", self.origin );
    self.pickuptrigger makeusable();
    self.pickuptrigger setcursorhint( "HINT_NOICON" );
    self.pickuptrigger sethintstring( &"MP_PATCH/PICKUP_TI" );
    self.pickuptrigger linkto( self );
    
    foreach ( player in level.players )
    {
        tacinsert_updatepickupusability( player );
    }
    
    for ( ;; )
    {
        self.pickuptrigger waittill( "trigger", player );
        player playsound( "iw9_tactical_insert_flare_pu" );
        player scripts\mp\equipment::giveequipment( "equip_tac_insert", "secondary" );
        thread tacinsert_destroy( 0, 0, 1 );
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x19a2
// Size: 0x80
function tacinsert_updatepickupusability( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( self ) || !isdefined( self.pickuptrigger ) )
    {
        return;
    }
    
    if ( istrue( self.isdestroyed ) )
    {
        return;
    }
    
    isowner = isdefined( self.owner ) && player == self.owner;
    
    if ( isowner )
    {
        self.pickuptrigger enableplayeruse( player );
        return;
    }
    
    self.pickuptrigger disableplayeruse( player );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 3
// Checksum 0x0, Offset: 0x1a2a
// Size: 0x1ea
function tacinsert_destroy( wasdestroyed, var_809a2ecf919c757a, hidefeedback )
{
    if ( !isdefined( self ) || istrue( self.isdestroyed ) )
    {
        return;
    }
    
    self.isdestroyed = 1;
    self.ti_timer = undefined;
    self.var_eaea86358d19ed20 = undefined;
    
    if ( isdefined( self.owner ) )
    {
        if ( istrue( var_809a2ecf919c757a ) )
        {
            thread tacinsert_brrespawnsplash();
            self.owner scripts\mp\utility\stats::incpersstat( "tacticalInsertionSpawns", 1 );
            self.owner scripts\mp\supers::combatrecordsupermisc( "super_tac_insert" );
            self.owner scripts\cp_mp\challenges::function_d997435895422ecc( "super_tac_insert", function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"hit" ) );
            scripts\mp\analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, 1, istrue( wasdestroyed ) );
        }
        else
        {
            scripts\mp\analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, 0, istrue( wasdestroyed ) );
        }
        
        if ( !istrue( var_809a2ecf919c757a ) && !istrue( hidefeedback ) )
        {
            self.owner thread tacinsert_tacinsertdestroyedfeedback();
        }
        
        self.owner.setspawnpoint = undefined;
    }
    
    self makeunusable();
    
    if ( isdefined( self.pickuptrigger ) )
    {
        self.pickuptrigger delete();
    }
    
    self notify( "death" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner notify( "tacInsert_destroyed" );
    }
    
    if ( !istrue( self.skipscriptable ) )
    {
        self setscriptablepartstate( "smoke", "neutral", 0 );
    }
    
    if ( istrue( wasdestroyed ) && isdefined( self getscriptablepartstate( "destroy", 1 ) ) && isdefined( self getscriptablepartstate( "visibility", 1 ) ) )
    {
        self setscriptablepartstate( "destroy", "active", 0 );
        self setscriptablepartstate( "visibility", "hide", 0 );
    }
    
    thread tacinsert_delayeddelete();
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 0
// Checksum 0x0, Offset: 0x1c1c
// Size: 0x50
function tacinsert_tacinsertdestroyedfeedback()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    extrawait = 0;
    
    while ( !isreallyalive( self ) || isinkillcam() )
    {
        extrawait = 1;
        waitframe();
    }
    
    if ( extrawait )
    {
        wait 0.3;
    }
    
    hudicontype( "tacinsert_destroyed" );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 0
// Checksum 0x0, Offset: 0x1c74
// Size: 0x43
function tacinsert_brrespawnsplash()
{
    if ( !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        return;
    }
    
    owner = self.owner;
    level endon( "game_ended" );
    owner endon( "death_or_disconnect" );
    wait 1.5;
    owner thread scripts\mp\hud_message::showsplash( "tac_insert_success_br" );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 0
// Checksum 0x0, Offset: 0x1cbf
// Size: 0x1d
function tacinsert_destroyongameended()
{
    self endon( "death" );
    level waittill( "game_ended" );
    thread tacinsert_destroy( 0, 0, 1 );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 0
// Checksum 0x0, Offset: 0x1ce4
// Size: 0x13
function tacinsert_delayeddelete()
{
    wait 1;
    scripts\cp_mp\ent_manager::deregisterspawn();
    self delete();
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x1cff
// Size: 0xcc
function tacinsert_destroyuselistener( owner )
{
    self endon( "death" );
    level endon( "game_ended" );
    owner endon( "disconnect" );
    self makeusable();
    self enablemissilehint( 1 );
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( &"MP_PATCH/DESTROY_TI" );
    
    foreach ( player in level.players )
    {
        tacinsert_updatedestroyusability( player );
    }
    
    for ( ;; )
    {
        self waittill( "trigger", player );
        player notify( "destroyed_insertion", owner );
        player notify( "destroyed_equipment" );
        tacinsert_givepointsfordeath( player );
        thread tacinsert_destroy( 1 );
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x1dd3
// Size: 0x1a6
function tacinsert_respawn( var_fef2728753dd969c )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    if ( !isdefined( self.setspawnpoint ) )
    {
        return 0;
    }
    
    if ( scripts\mp\utility\game::isteamreviveenabled() && istrue( level.liveragdollrevive ) )
    {
        return 0;
    }
    
    if ( scripts\cp_mp\utility\game_utility::isinfectedgametype() && getdvarint( @"hash_b8bb29ae58a355f1", 1 ) )
    {
        return 0;
    }
    
    timeout = level.tispawndelay;
    
    if ( isdefined( var_fef2728753dd969c ) )
    {
        timeout = var_fef2728753dd969c;
    }
    
    if ( timeout == 0 )
    {
        return 0;
    }
    
    self.setspawnpoint setscriptablepartstate( "respawning", "active", 0 );
    cameraent = function_eeb16781ffde3d11();
    thread function_afe3d129af2c2ada( cameraent );
    childthread function_c273570f23917192( timeout );
    childthread function_e1a9e6a0debbc17f();
    childthread function_67567cb3076fb060( timeout );
    msg = function_efe4706df8361219( "use_ti_spawn", "tacInsert_destroyed", "force_spawn", "use_normal_spawn", "joined_team", "joined_spectators" );
    self setclientomnvar( "ui_super_tac_insert_respawn", 0 );
    self setclientomnvar( "ui_tom_ti_respawnTimer", 0 );
    
    if ( msg == "force_spawn" || msg == "use_normal_spawn" || msg == "tacInsert_destroyed" || msg == "joined_team" || msg == "joined_spectators" )
    {
        notdestroyed = msg != "tacInsert_destroyed";
        function_2fdad346acd5e7d5( cameraent );
        spawnpoint_clearspawnpoint( 1, 0, notdestroyed );
    }
    else if ( msg == "use_ti_spawn" )
    {
        thread function_167f151646e822dc( cameraent );
    }
    
    if ( isdefined( self.ti_timer ) )
    {
        return self.ti_timer;
    }
    
    return 0;
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x1f81
// Size: 0x62
function function_67567cb3076fb060( timeout )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    timeelapsed = 0;
    
    while ( !istrue( self.var_8e9d87c3fcb2bd19 ) )
    {
        timeelapsed += level.framedurationseconds;
        waitframe();
    }
    
    scripts\mp\utility\lower_message::setlowermessageomnvar( "waiting_to_spawn", int( gettime() + ( timeout - timeelapsed ) * 1000 ) );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x1feb
// Size: 0x14d
function function_afe3d129af2c2ada( cameraent )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    printspawnmessage( "tac Insert Spawn::tacInsert_activateSpawnCamera() START" );
    
    if ( isai( self ) )
    {
        return;
    }
    
    if ( istrue( level.gameended ) )
    {
        return;
    }
    
    if ( !isdefined( cameraent ) )
    {
        self.var_309a9b707ba4b596 = 0;
        self notify( "use_normal_spawn" );
        return;
    }
    
    self.var_309a9b707ba4b596 = 1;
    waitframe();
    
    if ( !isdefined( cameraent ) )
    {
        self.var_309a9b707ba4b596 = 0;
        self notify( "use_normal_spawn" );
        return;
    }
    
    scripts\mp\spectating::setdisabled();
    childthread function_41fd0549b6e60a03( 0, 0 );
    
    while ( !istrue( self.var_8e9d87c3fcb2bd19 ) )
    {
        waitframe();
    }
    
    waitframe();
    self setclientomnvar( "ui_tom_ti_respawnTimer", gettime() + level.tispawndelay * 1000 );
    self setclientomnvar( "ui_super_tac_insert_respawn", 1 );
    scripts\mp\playerlogic::respawn_asspectator( self.origin, self.angles );
    scripts\mp\utility\player::setdof_default();
    updatesessionstate( "spectator" );
    
    if ( scripts\cp_mp\utility\game_utility::isnightmap() )
    {
        self visionsetkillstreakforplayer( "iw9_mp_nvg_base_color" );
    }
    else
    {
        self visionsetkillstreakforplayer( "recon_drone_color_mp", 0 );
    }
    
    self cameralinkto( cameraent, "tag_origin", 0, 1 );
    childthread function_ca63411e99d83e54( cameraent );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x2140
// Size: 0x207
function function_167f151646e822dc( cameraent )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "joined_spectators" );
    self waittill( "ti_spawncamera_start" );
    self cameralinkto( cameraent, "tag_origin", 1, 1 );
    
    if ( scripts\cp_mp\utility\game_utility::isnightmap() )
    {
        self visionsetkillstreakforplayer( "iw9_mp_nvg_base_color" );
    }
    else
    {
        self visionsetkillstreakforplayer( "recon_drone_color_mp", 0 );
    }
    
    _freezecontrols( 1, undefined, "slamZoom" );
    scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
    scripts\cp_mp\utility\player_utility::function_379bb555405c16bb( "tac_insert::tacInsert_onSpawnCameraSlamZoom()" );
    self useinvisibleplayerduringspawnselection( 1 );
    self.plotarmor = 1;
    val::set( "slamZoom", "vehicle_use", 0 );
    assertex( isdefined( self.spawndata ), "<dev string:x79>" );
    assertex( isdefined( cameraent ), "<dev string:xbc>" );
    targetpos = self.spawndata.spawnorigin + ( 0, 0, 64 );
    targetangles = self.spawndata.spawnangles;
    var_a54a664cef414612 = getdvarfloat( @"hash_2552d1d61db3c4aa", 0.75 );
    childthread function_6a6876b45711760f( cameraent, targetpos, targetangles, var_a54a664cef414612 );
    function_eeeb466cb2ddd1c4( cameraent, targetpos, targetangles, var_a54a664cef414612 );
    function_2fdad346acd5e7d5( cameraent );
    updatesessionstate( "playing" );
    _freezecontrols( 0, undefined, "slamZoom" );
    scripts\cp_mp\utility\player_utility::function_6fb380927695ee76();
    scripts\cp_mp\utility\player_utility::function_985b0973f29da4f8( "tac_insert::tacInsert_onSpawnCameraSlamZoom()" );
    self useinvisibleplayerduringspawnselection( 0 );
    self.plotarmor = 0;
    val::reset_all( "slamZoom" );
    self notify( "spawned_player" );
    scripts\cp_mp\challenges::function_d997435895422ecc( "super_tac_insert", function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"activate" ) );
    level notify( "player_spawned", self, self.wasrevivespawn );
    thread scripts\mp\playerlogic::setspawnnotifyomnvar();
    self.wasrevivespawn = undefined;
    self.delayedspawnedplayernotify = undefined;
    self.spawndata = undefined;
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x234f
// Size: 0x5c
function function_3807e5acb77b5011( revivespawn )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    delay = getdvarfloat( @"hash_128ea8c781fb5fb8", 0.65 );
    wait delay;
    scripts\mp\class::giveloadout( self.team, self.class, undefined, undefined, revivespawn );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x23b3
// Size: 0x2e
function function_2fdad346acd5e7d5( cameraent )
{
    self cameraunlink( cameraent );
    self.var_309a9b707ba4b596 = undefined;
    self.var_8e9d87c3fcb2bd19 = undefined;
    cameraent delete();
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 4
// Checksum 0x0, Offset: 0x23e9
// Size: 0xdb
function function_eeeb466cb2ddd1c4( cameraent, targetpos, targetangles, var_a54a664cef414612 )
{
    anglecheck = math::anglebetweenvectors( anglestoforward( cameraent.angles ), anglestoforward( targetangles ) ) > 45;
    distcheck = distance2dsquared( cameraent.origin, targetpos ) > 1000000;
    wait 0.05;
    cameraent moveto( targetpos, var_a54a664cef414612, 0.1, 0.1 );
    rotateblendtime = getdvarfloat( @"hash_5474294e363a8320", 0.25 );
    wait var_a54a664cef414612 - rotateblendtime;
    cameraent rotateto( targetangles, rotateblendtime, 0.075, 0.075 );
    wait 0.25;
    self visionsetkillstreakforplayer( "", 0.05 );
    wait 0.05;
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 4
// Checksum 0x0, Offset: 0x24cc
// Size: 0x12f
function function_6a6876b45711760f( cameraent, targetpos, targetangles, var_a54a664cef414612 )
{
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip" ];
    contentoverride = physics_createcontents( content );
    airtrace = scripts\engine\trace::ray_trace( cameraent.origin, targetpos, undefined, contentoverride );
    groundtrace = scripts\engine\trace::ray_trace( targetpos, cameraent.origin, undefined, contentoverride );
    airfrac = airtrace[ "fraction" ];
    groundfrac = groundtrace[ "fraction" ];
    var_4727e885c8a34003 = 0.11;
    
    if ( airfrac < 1 )
    {
        if ( airfrac - 0.22 > 0 )
        {
            wait airfrac - 0.22;
        }
        
        holdtime = var_a54a664cef414612 - airfrac - groundfrac + var_4727e885c8a34003;
        thread function_41fd0549b6e60a03( 0.1, holdtime, 0.25 );
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x2603
// Size: 0x12a
function function_ca63411e99d83e54( cameraent )
{
    self endon( "use_ti_spawn" );
    self endon( "tacInsert_destroyed" );
    self endon( "force_spawn" );
    self endon( "use_normal_spawn" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    counter = 0;
    var_c8442f16520eec66 = getdvarint( @"hash_96cda220c7b9c3b8", 50 );
    var_1e730115822dc920 = getdvarfloat( @"hash_a7b33246bb4a88ce", 5 );
    var_616664ec7bbc47b3 = var_c8442f16520eec66 / 2;
    offset = 0;
    
    while ( true )
    {
        if ( counter == 0 )
        {
            offset = var_616664ec7bbc47b3;
        }
        else
        {
            offset = var_c8442f16520eec66;
            
            if ( counter % 2 == 1 )
            {
                offset *= -1;
            }
        }
        
        if ( !isdefined( cameraent ) )
        {
            return;
        }
        
        destination = cameraent.origin + anglestoright( cameraent.angles ) * offset;
        cameraent moveto( destination, ter_op( counter == 0, var_1e730115822dc920 / 2, var_1e730115822dc920 ), 0.25, 0.25 );
        
        while ( distancesquared( cameraent.origin, destination ) > 0.5 )
        {
            waitframe();
        }
        
        counter++;
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 3
// Checksum 0x0, Offset: 0x2735
// Size: 0x105
function function_41fd0549b6e60a03( var_f503170ef47452e7, holdtime, var_1bb7594c18d17443 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    if ( !isdefined( var_f503170ef47452e7 ) )
    {
        var_f503170ef47452e7 = 0;
    }
    
    if ( !isdefined( holdtime ) )
    {
        holdtime = 0;
    }
    
    if ( !isdefined( var_1bb7594c18d17443 ) )
    {
        var_1bb7594c18d17443 = 0.5;
    }
    
    fadeval = 0;
    totalframes = int( floor( var_f503170ef47452e7 / level.framedurationseconds ) );
    currentframe = 0;
    
    while ( currentframe <= totalframes )
    {
        if ( totalframes == 0 )
        {
            break;
        }
        
        fadeval = currentframe / totalframes;
        self setclientomnvar( "ui_world_fade", fadeval );
        currentframe++;
        waitframe();
    }
    
    self.var_8e9d87c3fcb2bd19 = 1;
    
    if ( holdtime > 0 )
    {
        wait holdtime;
    }
    
    totalframes = int( ceil( var_1bb7594c18d17443 / level.framedurationseconds ) );
    currentframe = 0;
    fadeval = 1;
    
    while ( currentframe <= totalframes )
    {
        fadeval = ( totalframes - currentframe ) / totalframes;
        self setclientomnvar( "ui_world_fade", fadeval );
        currentframe++;
        waitframe();
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 0
// Checksum 0x0, Offset: 0x2842
// Size: 0xdf
function function_eeb16781ffde3d11()
{
    spawndirection = anglestoup( self.setspawnpoint.angles );
    var_34066fb22d6b1469 = getdvarint( @"hash_2ace60ec27da45be", 50 );
    upoffset = getdvarint( @"hash_27a03e1f75a3fdda", 2000 );
    var_37e589a5e0f61a45 = self.setspawnpoint.origin + spawndirection * var_34066fb22d6b1469 + ( 0, 0, 1 ) * upoffset;
    spawncameraangles = vectortoangles( self.setspawnpoint.origin - var_37e589a5e0f61a45 );
    cameraent = spawn( "script_model", var_37e589a5e0f61a45 );
    cameraent setmodel( "tag_origin" );
    cameraent.angles = spawncameraangles;
    return cameraent;
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x292a
// Size: 0x34
function function_c273570f23917192( timeout )
{
    self endon( "tacInsert_destroyed" );
    self endon( "force_spawn" );
    self endon( "use_normal_spawn" );
    wait timeout;
    self.ti_timer = timeout;
    self notify( "use_ti_spawn" );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 0
// Checksum 0x0, Offset: 0x2966
// Size: 0xca
function function_e1a9e6a0debbc17f()
{
    self endon( "tacInsert_destroyed" );
    self endon( "force_spawn" );
    self endon( "use_ti_spawn" );
    timeheld = 0;
    timeelapsed = 0;
    
    while ( self usebuttonpressed() )
    {
        waitframe();
    }
    
    while ( isdefined( self ) )
    {
        timeelapsed += level.framedurationseconds;
        
        if ( self usebuttonpressed() )
        {
            timeheld += level.framedurationseconds;
            self setclientomnvar( "ui_exit_progress", timeheld / 0.45 );
            
            if ( timeheld > 0.45 )
            {
                self notify( "use_normal_spawn" );
                self.ti_timer = timeelapsed;
                return;
            }
        }
        else if ( timeheld > 0 )
        {
            timeheld -= level.framedurationseconds;
            self setclientomnvar( "ui_exit_progress", timeheld / 0.45 );
            
            if ( timeheld <= 0 )
            {
                timeheld = 0;
            }
        }
        
        waitframe();
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 2
// Checksum 0x0, Offset: 0x2a38
// Size: 0x1ff
function function_b90a2bd2987f0bac( origin, angles )
{
    baseangles = angles;
    angstep = 30;
    maxsteps = 360 / angstep;
    stepcount = 0;
    var_5a08ed54211895bf = 1;
    cameradistance = getdvarint( @"hash_984d01a22fdb9767", 50 );
    testvec = undefined;
    firstrun = 0;
    camerapos = origin;
    cameraangles = angles;
    radius = 2;
    passed = 0;
    
    while ( stepcount < maxsteps )
    {
        if ( stepcount == 0 )
        {
            testvec = anglestoforward( baseangles );
            stepcount++;
        }
        else
        {
            testvec = anglestoforward( baseangles + ( 0, ter_op( var_5a08ed54211895bf, angstep, angstep * -1 ) * stepcount, 0 ) );
            var_5a08ed54211895bf = !var_5a08ed54211895bf;
            
            if ( var_5a08ed54211895bf )
            {
                stepcount++;
            }
        }
        
        tracestart = origin + ( 0, 0, 2 );
        var_2d8064e28c26d52 = getdvarfloat( @"hash_9e4c984d178a39ed", 0.75 );
        var_64be15313632fb31 = getdvarfloat( @"hash_6a4a8ac28728f9ec", 0.5 );
        traceend = origin + testvec * cameradistance * var_2d8064e28c26d52 + ( 0, 0, cameradistance * var_64be15313632fb31 );
        trace = scripts\engine\trace::sphere_trace( tracestart, traceend, radius, [ self.setspawnpoint ], undefined, 1 );
        hitpos = trace[ "position" ];
        
        if ( trace[ "fraction" ] > 0.99 )
        {
            camerapos = hitpos;
            cameraangles = vectortoangles( vectornormalize( origin - camerapos ) );
            break;
        }
    }
    
    cameraent = spawn( "script_model", camerapos );
    cameraent setmodel( "tag_player" );
    cameraent.angles = cameraangles;
    return cameraent;
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x2c40
// Size: 0x58
function tacinsert_updatedestroyusability( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( istrue( self.isdestroyed ) )
    {
        return;
    }
    
    isenemy = scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, player );
    
    if ( isenemy )
    {
        self enableplayeruse( player );
        return;
    }
    
    self disableplayeruse( player );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x2ca0
// Size: 0x86
function tacinsert_empapplied( data )
{
    attacker = data.attacker;
    self notify( "enemy_destroyed_equipment", attacker );
    tacinsert_givepointsfordeath( attacker, 1 );
    
    if ( isdefined( self.owner ) && data.attacker != self.owner )
    {
        self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer( "ti_destroyed", undefined, undefined, self.origin );
    }
    
    thread tacinsert_destroy( 1 );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 2
// Checksum 0x0, Offset: 0x2d2e
// Size: 0x5a
function tacinsert_givepointsfordeath( attacker, fromemp )
{
    if ( istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) ) )
    {
        attacker notify( "destroyed_equipment" );
        attacker thread givescorefordestroyedtacinsert( fromemp );
        self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer( "ti_destroyed", undefined, undefined, self.origin );
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 3
// Checksum 0x0, Offset: 0x2d90
// Size: 0x1d0, Type: bool
function function_6aa9474826722600( grenade, starttracepos, endtracepos )
{
    validsurface = 1;
    ignoreent = [ self, grenade ];
    contentoverride = scripts\engine\trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 1, 1 );
    traceresult = scripts\engine\trace::sphere_trace( starttracepos, endtracepos, 20, ignoreent, contentoverride, 1 );
    
    if ( isdefined( traceresult ) )
    {
        if ( isdefined( traceresult[ "hittype" ] ) && traceresult[ "hittype" ] != "hittype_none" )
        {
            surfacetype = traceresult[ "surfacetype" ];
            
            if ( isdefined( surfacetype ) && surfacetype != "surftype_none" )
            {
                surfacetype = traceresult[ "surfacetype" ];
                
                if ( surfacetype == "surftype_glass_pane" )
                {
                    validsurface = 0;
                }
            }
            
            ent = traceresult[ "entity" ];
            
            if ( isdefined( ent ) )
            {
                istrain = is_train_ent( ent );
                
                if ( ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !istrain )
                {
                    validsurface = 0;
                }
                
                var_c4c31894d4002f8a = getdvarint( @"hash_956f65ae92f862e", 1 );
                
                if ( !var_c4c31894d4002f8a && istrain )
                {
                    validsurface = 0;
                }
                
                if ( getdvarint( @"hash_9b8b6a0216965e80", 1 ) == 1 && istrue( self.isinsideelevator ) )
                {
                    validsurface = 0;
                }
                
                if ( isdefined( ent.classname ) )
                {
                    switch ( ent.classname )
                    {
                        case #"hash_81903cb95a447b8c":
                        case #"hash_e224d0b635d0dadd":
                            validsurface = 0;
                            break;
                        case #"hash_3872eb7d97592cac":
                            if ( isdefined( ent.crate ) )
                            {
                                validsurface = 0;
                            }
                            
                            break;
                    }
                }
                
                if ( istrue( ent.var_c71aed356442f468 ) )
                {
                    validsurface = 0;
                }
            }
        }
    }
    
    return istrue( validsurface );
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 0
// Checksum 0x0, Offset: 0x2f69
// Size: 0x7c
function function_3fd179c2e0859395()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_3bdc9f6146deef30 = getdvarint( @"hash_3ab7920059d1179a", 1 );
    
    if ( var_3bdc9f6146deef30 == 0 )
    {
        return;
    }
    
    if ( istrue( level.isgroundwarinfected ) || scripts\cp_mp\utility\game_utility::isinfectedgametype() )
    {
        if ( level.infectedtactical == "equip_tac_insert" )
        {
            scripts\mp\equipment::giveequipment( level.infectedtactical, "secondary" );
        }
        
        return;
    }
    
    thread scripts\mp\supers::refundsuper();
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 1
// Checksum 0x0, Offset: 0x2fed
// Size: 0x15
function function_49197cd063a740ea( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 5
// Checksum 0x0, Offset: 0x300a
// Size: 0xf5
function spawnpoint_setspawnpoint( pos, angles, overrideent, isti, var_97f4d755d6790643 )
{
    spawnpoint_clearspawnpoint();
    spawnpoint = undefined;
    
    if ( isdefined( overrideent ) )
    {
        spawnpoint = overrideent;
    }
    else
    {
        spawnpoint = spawn( "script_model", pos );
    }
    
    spawnpoint.playerspawnpos = pos;
    spawnpoint.playerspawnangles = angles;
    spawnpoint.notti = !istrue( isti );
    spawnpoint.issuper = isdefined( overrideent ) && istrue( overrideent.issuper );
    spawnpoint.var_97f4d755d6790643 = var_97f4d755d6790643;
    
    if ( istrue( var_97f4d755d6790643 ) )
    {
        zoffset = getdvarint( @"hash_aae1c46aed802dea", 30 );
        spawnpoint.playerspawnpos += ( 0, 0, zoffset * -1 );
    }
    
    self.setspawnpoint = spawnpoint;
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 3
// Checksum 0x0, Offset: 0x3107
// Size: 0x64
function spawnpoint_clearspawnpoint( wasdestroyed, var_809a2ecf919c757a, hidefeedback )
{
    if ( isdefined( self.setspawnpoint ) )
    {
        if ( istrue( self.setspawnpoint.notti ) )
        {
            self.setspawnpoint delete();
            return;
        }
        
        self.setspawnpoint scripts\mp\equipment\tac_insert::tacinsert_destroy( wasdestroyed, var_809a2ecf919c757a, hidefeedback );
    }
}

// Namespace tac_insert / scripts\mp\equipment\tac_insert
// Params 2
// Checksum 0x0, Offset: 0x3173
// Size: 0x93
function function_3ad5d3768653f711( ent, isti )
{
    if ( !isdefined( ent ) )
    {
        self notify( "end_movingUpdate" );
        return;
    }
    
    spawnpoint = ent;
    spawnpoint.playerspawnpos = ent.origin;
    spawnpoint.playerspawnangles = ent.angles;
    spawnpoint.notti = !istrue( isti );
    spawnpoint.issuper = isdefined( ent ) && istrue( ent.issuper );
    self.setspawnpoint = spawnpoint;
}

