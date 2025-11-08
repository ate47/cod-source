#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\gun;
#using scripts\mp\hud_message;
#using scripts\mp\music_and_dialog;
#using scripts\mp\persistence;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\points;

#namespace get_high;

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0xaf4
// Size: 0x43
function init()
{
    level.denyclasschoice = 1;
    level.bypassclasschoicefunc = &scripts\mp\class::alwaysgamemodeclass;
    level.nosuspensemusic = 1;
    level.musicenabled = 0;
    setspecialloadouts();
    
    /#
        level thread function_c12ed49f3a38bd86();
    #/
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0xb3f
// Size: 0xb2
function onstartgametype()
{
    setdvar( @"bg_falldamageminheight", 1000000 );
    setdvar( @"bg_falldamagemaxheight", 1000001 );
    setdvar( @"hash_180a6f432cfb6644", 1000000 );
    setdvar( @"hash_5dfbfd642e45b4b2", 1000001 );
    function_8b645c00ced7e3aa();
    function_ccf85d7e826d2c58();
    level thread function_4cd8f5379d59a1dc();
    level thread rock_pickups();
    level thread function_e41460cac0fd6c8b();
    level thread run_targets();
    
    if ( function_c9257c7ca72092d2() )
    {
        level thread function_4158ab699b721127();
    }
    
    function_b18b47e5d7e369cc( 15 );
    game[ "dialog" ][ "get_high_reached_end" ] = "dx_mp_mpcc_door_chec_door";
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 1
// Checksum 0x0, Offset: 0xbf9
// Size: 0x36
function function_b18b47e5d7e369cc( var_c429c0a3bbcac7b6 )
{
    trigger = getent( "checkpoint_" + var_c429c0a3bbcac7b6, "targetname" );
    trigger.var_c9553196cf9c8f6d = 1;
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0xc37
// Size: 0x56
function function_ccf85d7e826d2c58()
{
    var_3cdb9c22c4ad4fa4 = getent( "get_high_mode_end", "targetname" );
    level.maxheight = floor( var_3cdb9c22c4ad4fa4.origin[ 2 ] / 39.37 ) - 2;
    setomnvar( "ui_altimeter_max_height", level.maxheight );
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0xc95
// Size: 0x71
function run_targets()
{
    targets = getentarray( "get_high_target", "targetname" );
    
    foreach ( target in targets )
    {
        target setcandamage( 1 );
        target thread function_8e90986ed52da36c();
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0xd0e
// Size: 0x82
function function_8e90986ed52da36c()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        self waittill( "damage", dmg, player );
        
        if ( isdefined( player.var_6304f26df25a43a[ self getentitynumber() ] ) )
        {
            continue;
        }
        
        self hidefromplayer( player );
        player thread scripts\mp\utility\points::doscoreevent( #"hash_da4d3a59d273bd01" );
        player.var_6304f26df25a43a[ self getentitynumber() ] = self;
        player playlocalsound( "jup_gethigh_target_hit" );
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 1
// Checksum 0x0, Offset: 0xd98
// Size: 0x74
function onplayerconnect( player )
{
    player skydive_setdeploymentstatus( 1 );
    player scripts\mp\class::function_a16868d4dcd81a4b();
    player.pers[ "gamemodeLoadout" ] = level.oic_loadouts[ "axis" ];
    player loadweaponsforplayer( [ "iw9_me_fists_mp" ], 1 );
    player thread function_10f5dfb0f5993398();
    player thread function_1ca18f8f2c81e020();
    player thread scripts\mp\gametypes\gun::refillammo();
    player thread function_596dea770999caf1();
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0xe14
// Size: 0x4c
function function_596dea770999caf1()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    if ( isdefined( level.var_c4a7316b1d2c930e ) )
    {
        self.var_c4a7316b1d2c930e = level.var_c4a7316b1d2c930e;
        return;
    }
    
    level waittill( "start_time_set" );
    self.var_c4a7316b1d2c930e = level.var_c4a7316b1d2c930e;
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 1
// Checksum 0x0, Offset: 0xe68
// Size: 0x96
function onspawnplayer( revivespawn )
{
    if ( !isdefined( self.height_tracked ) )
    {
        thread height_manager();
    }
    
    if ( !isdefined( self.checkpoints ) )
    {
        self.checkpoints = [];
    }
    
    if ( !isdefined( self.var_6304f26df25a43a ) )
    {
        self.var_6304f26df25a43a = [];
    }
    
    if ( !isdefined( self.var_f7b7a4f1a9e36112 ) )
    {
        thread function_36011f47d98d4491();
    }
    
    level notify( "spawned_player" );
    self setclientomnvar( "ui_br_altimeter_state", 2 );
    self setclientomnvar( "ui_br_altimeter_height", 0 );
    thread function_c6df49cca235d926();
    thread modedisableexecution();
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0xf06
// Size: 0x5c
function function_36011f47d98d4491()
{
    if ( !gameflag( "prematch_done" ) )
    {
        level waittill( "prematch_music" );
        scripts\mp\music_and_dialog::function_cd6fa41e597b8df0( "mp_infil" );
        thread function_3e765f10c850e98e();
        self.var_f7b7a4f1a9e36112 = 1;
        return;
    }
    
    wait 10;
    scripts\mp\music_and_dialog::function_cd6fa41e597b8df0( "mp_infil" );
    thread function_3e765f10c850e98e();
    self.var_f7b7a4f1a9e36112 = 1;
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0xf6a
// Size: 0x71
function function_3e765f10c850e98e()
{
    level waittill( "start_game_win_audio" );
    
    foreach ( player in level.players )
    {
        player scripts\mp\music_and_dialog::function_cd6fa41e597b8df0( "mp_victory" );
        player setsoundsubmix( "mp_matchend_music", 2 );
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0xfe3
// Size: 0x52
function modedisableexecution()
{
    self notify( "modeDisableExecution" );
    self endon( "modeDisableExecution" );
    self endon( "disconnect" );
    val::set( "modeExecution", "execution_attack", 0 );
    self waittill( "giveLoadout" );
    
    if ( val::get( "execution_attack" ) )
    {
        val::set( "modeExecution", "execution_attack", 0 );
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x103d
// Size: 0x3c
function function_c6df49cca235d926()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    self disableoffhandthrowback();
    
    while ( true )
    {
        self waittill( "grenade_thrown", grenade );
        grenade thread delete_rock();
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x1081
// Size: 0x13
function delete_rock()
{
    self endon( "entitydeleted" );
    wait 5;
    self delete();
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 2
// Checksum 0x0, Offset: 0x109c
// Size: 0x50
function function_6f304eb7784e15( equipmentref, slot )
{
    if ( !scripts\mp\equipment::hasequipment( equipmentref ) )
    {
        scripts\mp\equipment::giveequipment( equipmentref, slot );
        scripts\mp\equipment::setequipmentslotammo( slot, 1 );
        return;
    }
    
    var_a414c300ac57f347 = scripts\mp\equipment::getequipmentslotammo( slot ) + 1;
    scripts\mp\equipment::setequipmentslotammo( slot, var_a414c300ac57f347 );
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 5
// Checksum 0x0, Offset: 0x10f4
// Size: 0x3c
function onplayerscore( event, player, originalpoints, victim, eventinfo )
{
    if ( event == #"value" )
    {
        return originalpoints;
    }
    
    return 0;
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x1139
// Size: 0xa2
function init_spawns()
{
    scripts\mp\spawnlogic::addstartspawnpoints( "mp_high_spawn_start", 1 );
    scripts\mp\spawnlogic::addspawnpoints( "allies", "mp_high_spawn" );
    scripts\mp\spawnlogic::addspawnpoints( "allies", "mp_high_spawn_secondary", 1, 1 );
    scripts\mp\spawnlogic::addspawnpoints( "axis", "mp_high_spawn" );
    scripts\mp\spawnlogic::addspawnpoints( "axis", "mp_high_spawn_secondary", 1, 1 );
    spawns = scripts\mp\spawnlogic::getspawnpointarray( "mp_high_spawn" );
    spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray( "mp_high_spawn_secondary" );
    scripts\mp\spawnlogic::registerspawnset( "primary", spawns );
    scripts\mp\spawnlogic::registerspawnset( "fallback", spawnssecondary );
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x11e3
// Size: 0xb0
function getspawnpoint()
{
    spawnpoint = undefined;
    
    if ( !isdefined( self.checkpoints ) || self.checkpoints.size == 0 )
    {
        spawnpoints = scripts\mp\spawnlogic::getstartspawnpoints();
        
        if ( !isdefined( level.requiresminstartspawns ) )
        {
            assertex( spawnpoints.size != 0 || spawnpoints.size >= 8, "<dev string:x1c>" + 8 + "<dev string:x36>" );
        }
        
        if ( spawnpoints.size > 0 )
        {
            spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn( spawnpoints, 1 );
        }
        
        if ( !isdefined( spawnpoint ) )
        {
            spawnpoint = random( spawnpoints );
        }
    }
    else
    {
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint( self, self.pers[ "team" ], function_feadf98b662bb889() );
    }
    
    return spawnpoint;
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 2
// Checksum 0x0, Offset: 0x129c
// Size: 0xa9
function function_e756e197bf6cade6( player, var_a12200f94a14a411 )
{
    player setclientomnvar( "ui_altimeter_max_player_height", var_a12200f94a14a411 );
    player.var_a12200f94a14a411 = var_a12200f94a14a411;
    
    foreach ( otherplayer in level.players )
    {
        if ( otherplayer != player )
        {
            if ( otherplayer.var_b93eda9c77bb971f < var_a12200f94a14a411 )
            {
                otherplayer.var_b93eda9c77bb971f = var_a12200f94a14a411;
                otherplayer setclientomnvar( "ui_altimeter_max_enemy_height", var_a12200f94a14a411 );
            }
        }
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x134d
// Size: 0x218
function height_manager()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self notify( "height_manager" );
    self endon( "height_manager" );
    self.height_tracked = 1;
    zero_height = self.origin[ 2 ];
    new_height = zero_height / 39.37;
    current_height = 0;
    var_bac45da587a172cd = -1;
    var_c8987d7a4dbb6519 = 5;
    scripts\mp\persistence::statsetchild( "round", "score", 0 );
    self.var_a12200f94a14a411 = 0;
    self.var_b93eda9c77bb971f = 0;
    self setclientomnvar( "ui_altimeter_max_player_height", 0 );
    self setclientomnvar( "ui_altimeter_max_enemy_height", 0 );
    self.var_9ae1e018f79a43f8 = 0;
    self.var_9a946262deaa8914 = 0;
    
    while ( true )
    {
        current_height = self.origin[ 2 ];
        var_d78624b2f5a6698c = current_height / 39.37;
        ceiling = new_height + var_c8987d7a4dbb6519;
        nextheight = int( self.var_9a946262deaa8914 + var_c8987d7a4dbb6519 );
        
        if ( var_d78624b2f5a6698c > nextheight )
        {
            self.var_9a946262deaa8914 = nextheight;
            
            if ( !istrue( self.var_660b700bd32206d4 ) && !istrue( self.var_458f6ef3818b11dc ) )
            {
                level scripts\mp\gamescore::_setplayerscore( self, self.var_9a946262deaa8914 );
            }
            
            if ( nextheight % 10 == 0 )
            {
                thread scripts\mp\utility\points::doscoreevent( #"get_high_10_meters" );
                self playlocalsound( "jup_gethigh_score_100" );
            }
        }
        
        waitframe();
        var_6bf6fb10376c2a03 = var_d78624b2f5a6698c / level.maxheight;
        var_6bf6fb10376c2a03 = max( 0, min( var_6bf6fb10376c2a03, 1 ) );
        self setclientomnvar( "ui_br_altimeter_height", var_6bf6fb10376c2a03 );
        var_37cfb16f552688be = int( max( 1, var_d78624b2f5a6698c ) );
        var_37cfb16f552688be = int( min( var_37cfb16f552688be, level.maxheight ) );
        self setclientomnvar( "ui_br_altimeter_vertical_speed", var_37cfb16f552688be );
        
        if ( var_37cfb16f552688be > self.var_9ae1e018f79a43f8 )
        {
            self.var_9ae1e018f79a43f8 = var_37cfb16f552688be;
        }
        
        if ( var_bac45da587a172cd < var_6bf6fb10376c2a03 )
        {
            var_bac45da587a172cd = var_6bf6fb10376c2a03;
            function_e756e197bf6cade6( self, var_bac45da587a172cd );
        }
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x156d
// Size: 0x2ac
function setspecialloadouts()
{
    level.oic_loadouts[ "allies" ][ "loadoutPrimary" ] = "jup_cp24_pi_glima21";
    level.oic_loadouts[ "allies" ][ "loadoutPrimaryAttachment" ] = "iw9_minireddot04_pstl";
    level.oic_loadouts[ "allies" ][ "loadoutPrimaryAttachment2" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutPrimaryCamo" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutPrimaryReticle" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutPrimaryAddBlueprintAttachments" ] = 0;
    level.oic_loadouts[ "allies" ][ "loadoutPrimaryVariantID" ] = 2;
    level.oic_loadouts[ "allies" ][ "loadoutSecondary" ] = "iw9_me_fists_mp";
    level.oic_loadouts[ "allies" ][ "loadoutSecondaryAttachment" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutSecondaryAttachment2" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutSecondaryCamo" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutSecondaryReticle" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutSecondaryVariantID" ] = 0;
    level.oic_loadouts[ "allies" ][ "loadoutEquipmentPrimary" ] = "equip_rock";
    level.oic_loadouts[ "allies" ][ "loadoutEquipmentSecondary" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutStreakType" ] = "assault";
    level.oic_loadouts[ "allies" ][ "loadoutKillstreak1" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutKillstreak2" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutKillstreak3" ] = "none";
    level.oic_loadouts[ "allies" ][ "loadoutPerks" ] = [ "specialty_grenadier_vest", "specialty_ninja_gloves", "specialty_ultra_light_boots", "specialty_blacklight_flashlight", "specialty_null" ];
    level.oic_loadouts[ "allies" ][ "loadoutGesture" ] = "playerData";
    level.oic_loadouts[ "allies" ][ "loadoutFieldUpgrade1" ] = "super_deadsilence";
    level.oic_loadouts[ "allies" ][ "loadoutFieldUpgrade2" ] = "none";
    level.oic_loadouts[ "axis" ] = level.oic_loadouts[ "allies" ];
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x1821
// Size: 0x26d
function function_8b645c00ced7e3aa()
{
    level.checkpoints = [];
    
    while ( true )
    {
        index = level.checkpoints.size;
        trigger = getent( "checkpoint_" + index + 1, "targetname" );
        
        if ( isdefined( trigger ) )
        {
            trigger.spawnpoints = [];
            spawnpoints = getspawnarray( "mp_high_spawn" );
            
            foreach ( spawner in spawnpoints )
            {
                if ( !is_equal( spawner.target, trigger.targetname ) )
                {
                    continue;
                }
                
                trigger.spawnpoints[ trigger.spawnpoints.size ] = spawner;
            }
            
            level.checkpoints[ level.checkpoints.size ] = trigger;
            trigger.var_c9553196cf9c8f6d = 1;
            scripts\mp\spawnlogic::registerspawnset( "primary" + "_" + trigger.targetname, trigger.spawnpoints );
            continue;
        }
        
        break;
    }
    
    foreach ( checkpoint in level.checkpoints )
    {
        checkpoint thread function_6d475315fcd75b0c();
        
        if ( isdefined( checkpoint.target ) )
        {
            floor_trig = getent( checkpoint.target, "targetname" );
            floor_trig.checkpoint = checkpoint;
            floor_trig thread function_845ec03de28d7564();
        }
    }
    
    player_checkpoint_trigger = getent( "player_checkpoint_trigger", "targetname" );
    player_checkpoint_trigger thread function_845ec03de28d7564();
    var_3cdb9c22c4ad4fa4 = getent( "get_high_mode_end", "targetname" );
    var_3cdb9c22c4ad4fa4 thread function_cc72ca834f01c961();
    var_93972af8c625eded = getstruct( "ending_door_pos", "targetname" );
    
    if ( isdefined( var_93972af8c625eded ) )
    {
        var_d2038cb311281123 = spawn( "trigger_radius", var_93972af8c625eded.origin, 0, 32, 128 );
        var_d2038cb311281123 thread function_4a4297c755f57569();
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 1
// Checksum 0x0, Offset: 0x1a96
// Size: 0x12f
function function_4a4297c755f57569( var_392af30b501461af )
{
    level endon( "game_ended" );
    
    while ( true )
    {
        self waittill( "trigger", player );
        player thread scripts\mp\utility\dialog::leaderdialogonplayer( "get_high_reached_end" );
        
        if ( function_c9257c7ca72092d2() && !istrue( var_392af30b501461af ) && isdefined( player.var_9e3f1befdd0f6bd2 ) && player.var_9e3f1befdd0f6bd2.size >= level.var_f3cdd6ffb42201b9 )
        {
            player function_fe6ace91263f2d12();
            continue;
        }
        
        player.checkpoints = [];
        player.var_6304f26df25a43a = [];
        
        foreach ( target in getentarray( "get_high_target", "targetname" ) )
        {
            target showtoplayer( player );
        }
        
        player thread height_manager();
        player.var_c4a7316b1d2c930e = gettime();
        player.var_660b700bd32206d4 = 0;
        player.var_458f6ef3818b11dc = 1;
        player function_ad91532168dbf0be();
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x1bcd
// Size: 0xca
function function_845ec03de28d7564()
{
    while ( true )
    {
        self waittill( "trigger", player );
        
        if ( isdefined( self.checkpoint ) && !array_contains( player.checkpoints, self.checkpoint ) )
        {
            continue;
        }
        
        if ( isdefined( player.var_9ae1e018f79a43f8 ) && player.var_9ae1e018f79a43f8 > 0 )
        {
            if ( issharedfuncdefined( "hud", "teamPlayerCardSplash" ) )
            {
                level thread [[ getsharedfunc( "hud", "teamPlayerCardSplash" ) ]]( "high_player_fell", player, undefined, player.var_9ae1e018f79a43f8 );
            }
            
            player.var_9ae1e018f79a43f8 = 0;
        }
        
        if ( isdefined( player.checkpoints ) )
        {
            player function_ad91532168dbf0be();
        }
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x1c9f
// Size: 0x12b
function function_cc72ca834f01c961()
{
    while ( true )
    {
        self waittill( "trigger", player );
        
        if ( !istrue( player.var_660b700bd32206d4 ) )
        {
            player.var_660b700bd32206d4 = 1;
            var_d09e0821a88feb42 = gettime() - player.var_c4a7316b1d2c930e;
            var_b6384cd3ddabadb7 = int( ( 1200000 - var_d09e0821a88feb42 ) / 1000 );
            var_b6384cd3ddabadb7 = max( var_b6384cd3ddabadb7, 0 );
            level scripts\mp\gamescore::_setplayerscore( player, int( var_b6384cd3ddabadb7 ) );
            player thread scripts\mp\utility\points::doscoreevent( #"get_high_completed" );
            player scripts\cp_mp\challenges::function_79abd07d1b2903d7( "get_higher_run_complete", var_d09e0821a88feb42 );
            playerheight = player getclientomnvar( "ui_br_altimeter_vertical_speed" );
            player thread scripts\mp\hud_message::showsplash( "high_top_reached_player", playerheight );
            
            if ( !isdefined( level.var_bdde153f985eca45 ) )
            {
                if ( issharedfuncdefined( "hud", "teamPlayerCardSplash" ) )
                {
                    level thread [[ getsharedfunc( "hud", "teamPlayerCardSplash" ) ]]( "high_top_reached_first", player );
                }
                
                level.var_bdde153f985eca45 = 1;
            }
            
            player playlocalsound( "jup_gethigh_score_completed" );
            player scripts\mp\music_and_dialog::function_cd6fa41e597b8df0( "mp_round_winning" );
        }
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x1dd2
// Size: 0x118
function function_e41460cac0fd6c8b()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        timeremaining = int( scripts\mp\gamelogic::gettimeremaining() );
        
        if ( timeremaining <= 300000 && !isdefined( level.var_c9069fa71752b0cd ) )
        {
            foreach ( player in level.players )
            {
                player thread scripts\mp\hud_message::showsplash( "high_five_mins_remaining" );
            }
            
            level.var_c9069fa71752b0cd = 1;
        }
        else if ( timeremaining <= 60000 && !isdefined( level.var_faf8bb64a0189a91 ) )
        {
            foreach ( player in level.players )
            {
                player thread scripts\mp\hud_message::showsplash( "high_final_minute" );
            }
            
            level.var_faf8bb64a0189a91 = 1;
        }
        
        waitframe();
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x1ef2
// Size: 0x8c
function function_ad91532168dbf0be()
{
    player = self;
    spawnpoint = player [[ level.getspawnpoint ]]();
    angles = ( 0, 0, 0 );
    
    if ( isdefined( spawnpoint.angles ) )
    {
        angles = spawnpoint.angles;
    }
    
    player setorigin( spawnpoint.origin );
    player setplayerangles( angles );
    player playlocalsound( "jup_gethigh_checkpoint_respawn" );
    player.var_fd503ed0e2304768 = 1;
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x1f86
// Size: 0x11a
function function_6d475315fcd75b0c()
{
    while ( true )
    {
        self waittill( "trigger", player );
        
        if ( !isdefined( player.checkpoints ) )
        {
            player.checkpoints = [];
        }
        
        if ( array_contains( player.checkpoints, self ) )
        {
            continue;
        }
        
        if ( istrue( self.var_c9553196cf9c8f6d ) )
        {
            for ( i = 0; i < level.checkpoints.size ; i++ )
            {
                var_45e4b845100be02a = level.checkpoints[ i ];
                
                if ( is_equal( self, var_45e4b845100be02a ) )
                {
                    break;
                }
                
                if ( !array_contains( player.checkpoints, var_45e4b845100be02a ) )
                {
                    player.checkpoints[ player.checkpoints.size ] = var_45e4b845100be02a;
                }
            }
        }
        
        player.checkpoints[ player.checkpoints.size ] = self;
        player playlocalsound( "jup_gethigh_checkpoint_reached" );
        player thread scripts\mp\hud_message::showsplash( "high_checkpoint_reached" );
        player thread scripts\mp\utility\points::doscoreevent( #"get_high_checkpoint" );
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x20a8
// Size: 0x223
function function_10f5dfb0f5993398()
{
    self endon( "disconnect" );
    
    if ( !isdefined( self.var_858efc56e1ae4e03 ) )
    {
        self.var_63f4e0a906dd9e53 = 0;
        self.var_858efc56e1ae4e03 = spawn( "script_model", self.origin );
        self.var_858efc56e1ae4e03 showonlytoplayer( self );
    }
    
    while ( true )
    {
        wait 0.1;
        
        if ( !istrue( self isonground() || self isswimming() || self ishanging() || self ismantling() || self isonladder() || level.gameended ) && !istrue( self.var_63f4e0a906dd9e53 ) )
        {
            for ( i = 0; i < 15 ; i++ )
            {
                if ( istrue( self isonground() || self isswimming() || self ishanging() || self ismantling() || self isonladder() ) || !isalive( self ) )
                {
                    break;
                }
                
                wait 0.1;
            }
            
            if ( istrue( self isonground() || self isswimming() || self ishanging() || self ismantling() || self isonladder() || level.gameended ) || !isalive( self ) )
            {
                continue;
            }
            
            self.var_63f4e0a906dd9e53 = 1;
            self.var_fd503ed0e2304768 = 0;
            self.var_858efc56e1ae4e03 playloopsound( "jup_gethigh_falling_lp" );
        }
        
        if ( istrue( self isonground() || self isswimming() || self ishanging() || self ismantling() || self isonladder() || level.gameended ) && istrue( self.var_63f4e0a906dd9e53 ) )
        {
            if ( !isalive( self ) )
            {
                self playlocalsound( "jup_gethigh_death" );
            }
            else if ( !istrue( self.var_fd503ed0e2304768 ) )
            {
                self playlocalsound( "jup_gethigh_falling_land" );
            }
            
            self.var_858efc56e1ae4e03 stoploopsound();
            self.var_63f4e0a906dd9e53 = 0;
            
            if ( istrue( level.gameended ) )
            {
                break;
            }
        }
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x22d3
// Size: 0x2a
function function_1ca18f8f2c81e020()
{
    self endon( "disconnect" );
    level waittill( "game_ended" );
    
    if ( !isdefined( self.var_660b700bd32206d4 ) )
    {
        self playlocalsound( "jup_gethigh_score_timeout" );
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x2305
// Size: 0x2f
function function_feadf98b662bb889()
{
    return "primary" + "_" + self.checkpoints[ self.checkpoints.size - 1 ].targetname;
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x233d
// Size: 0xac
function rock_pickups()
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    rock_pickups = getstructarray( "get_high_rock_pickup", "targetname" );
    
    foreach ( struct in rock_pickups )
    {
        rock = spawn( "script_model", struct.origin );
        rock setmodel( "lm_loot_offhand_wm_rock" );
        rock hudoutlineenable( "outline_depth_white" );
        rock thread function_9839e892f48728cb();
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x23f1
// Size: 0xd4
function function_9839e892f48728cb()
{
    level endon( "game_ended" );
    rock = self;
    rock.trigger = spawn( "trigger_radius", rock.origin, 0, 32, 32 );
    equipmentref = "equip_rock";
    slot = scripts\mp\equipment::getdefaultslot( equipmentref );
    
    while ( true )
    {
        rock.trigger waittill( "trigger", player );
        
        if ( player scripts\mp\equipment::hasequipment( equipmentref ) && player scripts\mp\equipment::getequipmentslotammo( slot ) >= 3 )
        {
            continue;
        }
        
        break;
    }
    
    player playsoundtoplayer( "br_pickup_weap", player, player );
    player thread function_6f304eb7784e15( equipmentref, slot );
    rock delete();
    rock.trigger delete();
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x24cd
// Size: 0x24
function function_4cd8f5379d59a1dc()
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    level.var_c4a7316b1d2c930e = gettime();
    level notify( "start_time_set" );
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x24f9
// Size: 0x12
function function_c9257c7ca72092d2()
{
    return getdvarint( @"hash_7512a5bc22fbb22f", 1 );
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x2514
// Size: 0x1cc
function function_4158ab699b721127()
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    var_a05a4c0b592c06d9 = getstructarray( "secret_pickup", "script_noteworthy" );
    level.var_f3cdd6ffb42201b9 = getdvarint( @"hash_8e7fb0ea81f50d10", -1 );
    
    if ( level.var_f3cdd6ffb42201b9 == -1 )
    {
        level.var_f3cdd6ffb42201b9 = var_a05a4c0b592c06d9.size;
    }
    
    allspawns = getspawnarray( "mp_high_spawn" );
    var_87f7e8809ce5b9e2 = [];
    
    foreach ( var_4525ebcbb0371747 in allspawns )
    {
        if ( var_4525ebcbb0371747.target == "secret_ending" )
        {
            var_87f7e8809ce5b9e2 = array_add( var_87f7e8809ce5b9e2, var_4525ebcbb0371747 );
        }
    }
    
    if ( var_87f7e8809ce5b9e2.size > 0 )
    {
        scripts\mp\spawnlogic::registerspawnset( "primary" + "_secret_ending", var_87f7e8809ce5b9e2 );
    }
    
    foreach ( var_b30f0de276d63eb0 in var_a05a4c0b592c06d9 )
    {
        var_eacc607e613ec695 = scripts\common\utility::spawn_model( "jup_vertigo_collectible_coin_01", var_b30f0de276d63eb0.origin, ( 90, 0, 0 ) );
        var_eacc607e613ec695 thread function_16542e7fc8964c99();
        var_eacc607e613ec695 thread function_ce4ab753ee817fa5();
    }
    
    var_da539da79a5520c7 = getstruct( "secret_return_door_pos", "targetname" );
    
    if ( isdefined( var_da539da79a5520c7 ) )
    {
        var_2f00a35a9332dcf5 = spawn( "trigger_radius", var_da539da79a5520c7.origin, 0, 32, 128 );
        var_2f00a35a9332dcf5 thread function_4a4297c755f57569( 1 );
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x26e8
// Size: 0x28
function function_16542e7fc8964c99()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        self rotateyaw( 360, 2 );
        wait 2;
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x2718
// Size: 0xed
function function_ce4ab753ee817fa5()
{
    level endon( "game_ended" );
    self.trigger = spawn( "trigger_radius", self.origin, 0, 32, 32 );
    entnumber = self getentitynumber();
    
    while ( true )
    {
        self.trigger waittill( "trigger", player );
        
        if ( !isdefined( player.var_9e3f1befdd0f6bd2 ) )
        {
            player.var_9e3f1befdd0f6bd2 = [];
        }
        
        if ( !array_contains( player.var_9e3f1befdd0f6bd2, entnumber ) )
        {
            player.var_9e3f1befdd0f6bd2 = array_add( player.var_9e3f1befdd0f6bd2, entnumber );
            player playsoundtoplayer( "jup_gethigh_coin_collect", player, player );
            self hidefromplayer( player );
            self.trigger disableplayeruse( player );
            player thread scripts\mp\hud_message::showsplash( "get_high_secret_pickup", player.var_9e3f1befdd0f6bd2.size );
        }
    }
}

// Namespace get_high / scripts\mp\gametypes\get_high
// Params 0
// Checksum 0x0, Offset: 0x280d
// Size: 0x50
function function_fe6ace91263f2d12()
{
    var_6fbfad9bb2744498 = spawnstruct();
    var_6fbfad9bb2744498.targetname = "secret_ending";
    self.checkpoints = array_add( self.checkpoints, var_6fbfad9bb2744498 );
    scripts\cp_mp\challenges::function_79abd07d1b2903d7( "get_higher_secret_ending" );
    function_ad91532168dbf0be();
}

/#

    // Namespace get_high / scripts\mp\gametypes\get_high
    // Params 0
    // Checksum 0x0, Offset: 0x2865
    // Size: 0x140, Type: dev
    function function_c12ed49f3a38bd86()
    {
        while ( true )
        {
            val = getdvarint( @"hash_c46a3276e5792b4c", 0 );
            
            if ( val && isdefined( level.players ) )
            {
                foreach ( player in level.players )
                {
                    var_e4ddcb07f95ecfaa = undefined;
                    
                    foreach ( checkpoint in level.checkpoints )
                    {
                        if ( !isdefined( player.checkpoints ) || !array_contains( player.checkpoints, checkpoint ) )
                        {
                            var_e4ddcb07f95ecfaa = checkpoint;
                            break;
                        }
                    }
                    
                    if ( isdefined( var_e4ddcb07f95ecfaa ) )
                    {
                        player.checkpoints[ player.checkpoints.size ] = var_e4ddcb07f95ecfaa;
                        player function_ad91532168dbf0be();
                    }
                }
            }
            
            setdvar( @"hash_c46a3276e5792b4c", 0 );
            waitframe();
            waitframe();
        }
    }

#/
