#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_loadout;
#using scripts\mp\class;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;

#namespace gold_gun;

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0x6de
// Size: 0x89
function function_10cc8368e439ae59()
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    foreach ( player in level.players )
    {
        player thread function_8c754119e5c784f8();
        player thread function_af6e58ce205b9f2c();
        player function_f77861444d155833();
    }
    
    level thread function_b8fb39265d8a05a8();
    scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 1
// Checksum 0x0, Offset: 0x76f
// Size: 0x39
function onplayerdisconnect( disconnectedplayer )
{
    if ( istrue( disconnectedplayer.raygun ) )
    {
        disconnectedplayer thread function_4a25cb7438a05c3f();
        disconnectedplayer thread function_b030a187e2c1d0f2();
        disconnectedplayer.raygun = 0;
    }
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0x7b0
// Size: 0x21
function function_f77861444d155833()
{
    if ( istrue( self.outlined ) )
    {
        self hudoutlinedisable( self );
        self.outlined = undefined;
    }
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0x7d9
// Size: 0x9b
function function_b8fb39265d8a05a8()
{
    while ( !isdefined( level.players ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        foreach ( player in array_randomize( level.players ) )
        {
            if ( !istrue( player.hasspawned ) )
            {
                continue;
            }
            
            if ( !scripts\mp\utility\player::isreallyalive( player ) )
            {
                continue;
            }
            
            player function_ec950a4796a1a57();
            return;
        }
        
        wait 0.5;
    }
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0x87c
// Size: 0x46
function function_8c754119e5c784f8()
{
    self endon( "death" );
    self endon( "disconnect" );
    self.loadout_class_selected = 0;
    self waittill( "loadout_class_selected" );
    
    if ( isvalidclass( self.class ) )
    {
        self.loadout_class_selected = 1;
        function_c10ee10d262dfd32();
    }
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0x8ca
// Size: 0x4d
function function_c10ee10d262dfd32()
{
    self.pers[ "prev_class" ] = self.class;
    self.pers[ "prev_classCache" ] = self.classstruct;
    scripts\mp\class::addclassstructtocache( self.classstruct, self.class );
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0x91f
// Size: 0x54
function function_af6e58ce205b9f2c()
{
    self endon( "death" );
    self endon( "disconnect" );
    
    while ( true )
    {
        self waittill( "swapLoadout" );
        self waittill( "giveLoadout_start" );
        
        if ( isvalidclass( self.class ) && self.class != "gamemode" )
        {
            function_c10ee10d262dfd32();
        }
    }
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0x97b
// Size: 0xed
function function_ec950a4796a1a57()
{
    player = self;
    player.raygun = 1;
    
    if ( isvalidclass( player.class ) )
    {
        player function_c10ee10d262dfd32();
    }
    
    player function_5525b1dc78ff5ab4();
    player.pers[ "gamemodeLoadout" ] = level.aon_loadouts[ "allies" ];
    
    if ( istrue( level.var_8ac4c18576d7e2d3 ) )
    {
        self.preloadedclassstruct = undefined;
    }
    
    player scripts\mp\class::giveloadout( player.pers[ "team" ], "gamemode", 0, 1 );
    player _takeweapon( "iw9_me_fists_mp" );
    player scripts\mp\class::blockclasschange();
    player disableweaponswitch();
    player disableweaponpickup();
    player hudoutlineenable( "outline_depth_red" );
    player thread function_c8458e8bd7248c4c();
    player setclientomnvar( "ui_gold_gun_show_perk_hud", 1 );
    player scripts\mp\hud_message::showsplash( "mp_terminus_gun" );
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0xa70
// Size: 0x53
function function_76548c401fba9e3d()
{
    player = self;
    player.raygun = 0;
    player function_52aaf4a680ab51a0();
    player scripts\mp\class::unblockclasschange();
    player hudoutlinedisable( "outline_depth_red" );
    player enableweaponswitch();
    player enableweaponpickup();
    player setclientomnvar( "ui_gold_gun_show_perk_hud", 0 );
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0xacb
// Size: 0xbc
function function_52aaf4a680ab51a0()
{
    if ( isdefined( self.pers[ "prev_class" ] ) )
    {
        if ( isdefined( self.pers[ "prev_classCache" ] ) )
        {
            function_7b782d0fa3071b68( self.pers[ "prev_class" ] );
            scripts\mp\class::preloadandqueueclassstruct( self.pers[ "prev_classCache" ], 1, 1 );
            scripts\mp\class::giveloadout( self.team, self.pers[ "prev_class" ], 0, 1 );
        }
        else
        {
            assertex( isdefined( self.pers[ "<dev string:x1c>" ] ), "<dev string:x2f>" );
        }
        
        return;
    }
    
    assertex( isdefined( self.pers[ "<dev string:x70>" ] ), "<dev string:x7e>" );
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0xb8f
// Size: 0x81
function function_5525b1dc78ff5ab4()
{
    self setclientomnvar( "ui_skip_loadout", 1 );
    self.pers[ "class" ] = "gamemode";
    self.pers[ "lastClass" ] = "";
    self.class = self.pers[ "class" ];
    self.lastclass = self.pers[ "lastClass" ];
    
    if ( isbot( self ) )
    {
        self.classcallback = &scripts\mp\bots\bots_loadout::function_b606843c205d2dfc;
    }
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 1
// Checksum 0x0, Offset: 0xc18
// Size: 0x85
function function_7b782d0fa3071b68( class )
{
    self setclientomnvar( "ui_skip_loadout", 0 );
    self.pers[ "class" ] = class;
    self.pers[ "lastClass" ] = "";
    self.class = self.pers[ "class" ];
    self.lastclass = self.pers[ "lastClass" ];
    
    if ( isbot( self ) )
    {
        self.classcallback = &scripts\mp\bots\bots_loadout::function_b606843c205d2dfc;
    }
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0xca5
// Size: 0x92
function function_cfd132407d0f14b3()
{
    waitframe();
    defaultperks = [ "specialty_selectivehearing", "specialty_pistoldraw", "specialty_location_marking" ];
    
    foreach ( perk in self.loadoutperks )
    {
        if ( !arraycontains( defaultperks, perk ) )
        {
            scripts\mp\utility\perk::removeperk( perk );
        }
    }
    
    self.perkscleared = 1;
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0xd3f
// Size: 0x2c
function function_f85a7539bef30847()
{
    if ( !scripts\mp\utility\player::isreallyalive( self ) )
    {
        if ( istrue( self.raygun ) )
        {
            return "gamemode";
        }
        
        return;
    }
    
    return self.class;
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0xd73
// Size: 0xd, Type: bool
function function_e048e0ef10222493()
{
    return !istrue( self.raygun );
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0xd89
// Size: 0x4d
function cleanupswaploadoutflags()
{
    self endon( "disconnect" );
    self endon( "death" );
    waittill_any_ents( self, "death", level, "prematch_over" );
    ent_flag_clear( "swapLoadout_blocked", 1 );
    ent_flag_clear( "swapLoadout_pending", 1 );
    ent_flag_clear( "swapLoadout_complete", 1 );
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 10
// Checksum 0x0, Offset: 0xdde
// Size: 0x140
function function_44d72e27a2afecf7( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    level waittill_notify_or_timeout( "gold_gun_kill_evaluated", 0.1 );
    
    if ( istrue( self.raygun ) )
    {
        if ( smeansofdeath == "MOD_SUICIDE" || attacker == self )
        {
            function_76548c401fba9e3d();
            self.remove_perks = 1;
            thread function_4a25cb7438a05c3f();
            thread function_b030a187e2c1d0f2();
            return;
        }
        
        if ( isdefined( attacker ) && isplayer( attacker ) && !istrue( attacker.raygun ) )
        {
            function_76548c401fba9e3d();
            self.remove_perks = 1;
            thread function_4a25cb7438a05c3f();
            wait 0.3;
            
            if ( !is_dead_or_dying( attacker ) && attacker.sessionstate != "spectator" && !istrue( attacker.spectatekillcam ) && !istrue( attacker.killcam ) )
            {
                attacker function_ec950a4796a1a57();
                return;
            }
            
            thread function_b030a187e2c1d0f2();
        }
    }
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0xf26
// Size: 0x1d5
function function_b030a187e2c1d0f2()
{
    level.var_8ac4c18576d7e2d3 = 1;
    
    switch ( level.mapname )
    {
        case #"hash_f5c1537d785c2cef":
            targetposworld = ( 1600, 1616, -158 );
            var_485ed3db03228352 = ( 0, 0, 90 );
            var_a8d0d5fea370a2ac = 1;
            break;
        case #"hash_3b9b3e57c88e6a79":
            targetposworld = ( 733.5, 1150.5, 99 );
            var_485ed3db03228352 = ( 0, 0, 90 );
            var_a8d0d5fea370a2ac = 1;
            break;
        case #"hash_747a4e7f49a356a3":
            targetposworld = ( 972, 1339, 19 );
            var_485ed3db03228352 = ( 0, 0, 90 );
            var_a8d0d5fea370a2ac = 1;
            break;
        default:
            targetposworld = self.origin;
            var_485ed3db03228352 = ( self.angles[ 0 ], self.angles[ 1 ], self.angles[ 2 ] );
            var_a49f3378e7b03e7b = ( 0, -5, 0 );
            var_a8d0d5fea370a2ac = 0;
            break;
    }
    
    gunmodel = spawnweaponwithattachments( "jup_pi_goldengun_mp", targetposworld, var_485ed3db03228352 );
    
    if ( !istrue( var_a8d0d5fea370a2ac ) )
    {
        var_ce61d73cfdee619d = gunmodel localtoworldcoords( var_a49f3378e7b03e7b );
        gunmodel.origin = var_ce61d73cfdee619d;
        var_5ce5bf640ea164d = ( 0, 0.5, 0 );
        targetposworld = gunmodel localtoworldcoords( var_5ce5bf640ea164d );
        var_d993a04208646bdc = 0.5;
        gunmodel moveto( targetposworld, var_d993a04208646bdc );
    }
    
    gunmodel thread function_c8458e8bd7248c4c( 1 );
    gunmodel hudoutlineenable( "outline_nodepth_white" );
    gunmodel makeusable();
    gunmodel sethinttag( "tag_origin" );
    gunmodel setuseholdduration( "duration_short" );
    gunmodel thread function_44533f21c13295c6();
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0x1103
// Size: 0x85
function function_44533f21c13295c6()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    self endon( "death" );
    
    while ( true )
    {
        wait 0.05;
        self waittill( "trigger", player, droppeditem );
        
        if ( !scripts\mp\utility\player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !scripts\mp\gameobjects::proxtriggerlos( player ) )
        {
            continue;
        }
        
        player function_ec950a4796a1a57();
        thread function_4a25cb7438a05c3f();
        self makeunusable();
        self delete();
        level.var_8ac4c18576d7e2d3 = 0;
    }
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 1
// Checksum 0x0, Offset: 0x1190
// Size: 0x113
function function_c8458e8bd7248c4c( var_8ce6b63fa3ba3490 )
{
    requestfunc = undefined;
    
    if ( scripts\engine\utility::issharedfuncdefined( "game", "requestObjectiveID" ) )
    {
        requestfunc = scripts\engine\utility::getsharedfunc( "game", "requestObjectiveID" );
    }
    
    if ( isdefined( requestfunc ) )
    {
        objid = [[ requestfunc ]]( 99 );
        self.objid = objid;
        scripts\mp\objidpoolmanager::objective_add_objective( objid, "active", self.origin, "jup_hud_icon_minimap_raygun" );
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
        scripts\mp\objidpoolmanager::update_objective_sethot( objid, !istrue( var_8ce6b63fa3ba3490 ) );
    }
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0x12ab
// Size: 0x31
function function_4a25cb7438a05c3f()
{
    if ( scripts\engine\utility::issharedfuncdefined( "game", "returnObjectiveID" ) )
    {
        [[ scripts\engine\utility::getsharedfunc( "game", "returnObjectiveID" ) ]]( self.objid );
    }
}

// Namespace gold_gun / scripts\mp\gametypes\gold_gun
// Params 0
// Checksum 0x0, Offset: 0x12e4
// Size: 0x2e9
function function_3de4b167d29ad5c2()
{
    level.aon_loadouts[ "allies" ][ "loadoutPrimary" ] = "jup_pi_goldengun_mp";
    level.aon_loadouts[ "allies" ][ "loadoutPrimaryAttachment" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutPrimaryAttachment2" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutPrimaryCamo" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutPrimaryReticle" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutPrimaryVariantID" ] = -1;
    level.aon_loadouts[ "allies" ][ "loadoutSecondary" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSecondaryAttachment" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSecondaryAttachment2" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSecondaryCamo" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSecondaryReticle" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSecondaryVariantID" ] = -1;
    level.aon_loadouts[ "allies" ][ "loadoutEquipmentPrimary" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutEquipmentSecondary" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSuper" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutStreakType" ] = "assault";
    level.aon_loadouts[ "allies" ][ "loadoutKillstreak1" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutKillstreak2" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutKillstreak3" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutUsingSpecialist" ] = 1;
    level.aon_loadouts[ "allies" ][ "loadoutPerks" ] = [ "specialty_canvas_sneakers", "specialty_lightweight_vest", "specialty_null", "specialty_null" ];
    level.aon_loadouts[ "allies" ][ "loadoutExtraPerks" ] = [ "specialty_null", "specialty_null" ];
    level.aon_loadouts[ "allies" ][ "loadoutGesture" ] = "playerData";
    level.aon_loadouts[ "allies" ][ "loadoutFieldUpgrade1" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutFieldUpgrade2" ] = "none";
    level.aon_loadouts[ "axis" ] = level.aon_loadouts[ "allies" ];
}

