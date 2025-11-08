#using script_3fddda92c991755e;
#using script_57614a088fb41089;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\wm_objectives;
#using scripts\mp\hud_message;
#using scripts\mp\utility\script;

#namespace wm_ui;

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0xe70
// Size: 0x10
function init()
{
    waittillframeend();
    scripts\mp\flags::gameflaginit( "ui_objectives_setup", 0 );
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 1
// Checksum 0x0, Offset: 0xe88
// Size: 0x1e0
function function_56e0031a424d8009( capture_zones )
{
    player = self;
    custom_icon = undefined;
    var_eed4d285ffd8460f = 0;
    total_zones = 0;
    show_counter = 0;
    
    if ( isdefined( capture_zones ) )
    {
        if ( capture_zones.size == 1 )
        {
            icon_suffix = capture_zones[ 0 ].objectivekey;
            
            switch ( icon_suffix )
            {
                case #"hash_fac2c5f6bddd49bd":
                    custom_icon = 0;
                    break;
                case #"hash_fac2c2f6bddd4504":
                    custom_icon = 1;
                    break;
                case #"hash_fac2c3f6bddd4697":
                    custom_icon = 2;
                    break;
            }
            
            var_eed4d285ffd8460f = 1;
        }
        else if ( capture_zones.size > 1 )
        {
            show_counter = 1;
            total_zones = capture_zones.size;
        }
    }
    
    var_fd3f3786e1ff0478 = scripts\mp\gametypes\wm_objectives::function_fb82e12375af065f();
    
    if ( is_equal( player.pers[ "team" ], game[ "attackers" ] ) )
    {
        uid = generate_uid( "WAR_CAPTURE_UID" );
        ui_key = "WAR_CAPTURE";
        player start_objective( uid, ui_key );
        
        if ( isdefined( custom_icon ) )
        {
            function_8733c2caee45c023( player, uid, custom_icon );
        }
        
        function_c1edc8a24a424e72( player, uid, var_eed4d285ffd8460f );
        
        if ( show_counter )
        {
            function_cae7c80607a403a7( player, uid, total_zones, var_fd3f3786e1ff0478 );
        }
    }
    else if ( is_equal( player.pers[ "team" ], game[ "defenders" ] ) )
    {
        uid = generate_uid( "WAR_DEFEND_UID" );
        ui_key = "WAR_DEFEND";
        player start_objective( uid, ui_key );
        
        if ( isdefined( custom_icon ) )
        {
            function_8733c2caee45c023( player, uid, custom_icon );
        }
        
        function_c1edc8a24a424e72( player, uid, var_eed4d285ffd8460f );
        
        if ( show_counter )
        {
            function_cae7c80607a403a7( player, uid, total_zones, var_fd3f3786e1ff0478 );
        }
    }
    
    if ( var_eed4d285ffd8460f )
    {
        player thread function_8f9f8e317d100761();
    }
    
    if ( show_counter )
    {
        player thread function_98625aa96f4af3f4();
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x1070
// Size: 0x11b
function function_8f9f8e317d100761()
{
    level endon( "game_ended" );
    level endon( "end_zone_objective" );
    
    while ( true )
    {
        if ( !isdefined( self ) || !isalive( self ) )
        {
            break;
        }
        
        if ( isdefined( level.zone.capture_zones ) )
        {
            if ( level.zone.capture_zones.size > 1 )
            {
                break;
            }
            
            zone = level.zone.capture_zones[ 0 ];
            progress = zone.curprogress / zone.usetime;
            state = undefined;
            
            if ( zone.stalemate )
            {
                state = 1;
            }
            else if ( is_equal( self.pers[ "team" ], game[ "attackers" ] ) )
            {
                state = 2;
            }
            else if ( is_equal( self.pers[ "team" ], game[ "defenders" ] ) )
            {
                state = 3;
            }
            else
            {
                state = 0;
            }
            
            function_b41a05f6198e9a29( self, progress, state );
        }
        
        waitframe();
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x1193
// Size: 0x46
function function_98625aa96f4af3f4()
{
    level endon( "game_ended" );
    level endon( "end_zone_objective" );
    self endon( "disconnect" );
    var_fd3f3786e1ff0478 = scripts\mp\gametypes\wm_objectives::function_fb82e12375af065f();
    
    while ( var_fd3f3786e1ff0478 > 0 )
    {
        level waittill( "wm_zone_captured" );
        var_fd3f3786e1ff0478--;
        function_92b2c173041b8fb6( self, var_fd3f3786e1ff0478 );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 1
// Checksum 0x0, Offset: 0x11e1
// Size: 0x192
function function_bd670364611e5003( objectives )
{
    player = self;
    
    if ( isdefined( objectives ) )
    {
        if ( !isdefined( level.var_d7365b1fc402bfb6 ) )
        {
            level.var_d7365b1fc402bfb6 = spawnstruct();
        }
        
        if ( !isdefined( level.var_d7365b1fc402bfb6.total_bombs ) )
        {
            level.var_d7365b1fc402bfb6.total_bombs = objectives.size;
        }
        
        if ( !isdefined( level.var_d7365b1fc402bfb6.remaining_bombs ) )
        {
            level.var_d7365b1fc402bfb6.remaining_bombs = level.var_d7365b1fc402bfb6.total_bombs;
        }
    }
    
    if ( is_equal( player.pers[ "team" ], game[ "attackers" ] ) )
    {
        uid = generate_uid( "WAR_BOMB_DEFUSE_UID" );
        ui_key = "WAR_BOMB_DEFUSE";
        player start_objective( uid, ui_key );
        function_cae7c80607a403a7( player, uid, level.var_d7365b1fc402bfb6.total_bombs, level.var_d7365b1fc402bfb6.remaining_bombs );
        return;
    }
    
    if ( is_equal( player.pers[ "team" ], game[ "defenders" ] ) )
    {
        uid = generate_uid( "WAR_BOMB_DEFEND_UID" );
        ui_key = "WAR_BOMB_DEFEND";
        player start_objective( uid, ui_key );
        function_cae7c80607a403a7( player, uid, level.var_d7365b1fc402bfb6.total_bombs, level.var_d7365b1fc402bfb6.remaining_bombs );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x137b
// Size: 0xca
function function_ace0b0228cd34c4b()
{
    if ( level.zone.objectivetype == 2 && isdefined( level.var_d7365b1fc402bfb6 ) )
    {
        prev_remaining = level.var_d7365b1fc402bfb6.remaining_bombs;
        
        if ( isdefined( prev_remaining ) && prev_remaining > 0 )
        {
            remaining = prev_remaining - 1;
            level.var_d7365b1fc402bfb6.remaining_bombs = remaining;
            
            foreach ( player in level.players )
            {
                function_92b2c173041b8fb6( player, remaining );
            }
        }
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x144d
// Size: 0xa0
function function_a79d4af0fcd2254()
{
    player = self;
    
    if ( is_equal( player.pers[ "team" ], game[ "attackers" ] ) )
    {
        uid = generate_uid( "WAR_HOSTAGE_RESCUE_UID" );
        ui_key = "WAR_HOSTAGE_RESCUE";
        player start_objective( uid, ui_key );
        return;
    }
    
    if ( is_equal( player.pers[ "team" ], game[ "defenders" ] ) )
    {
        uid = generate_uid( "WAR_HOSTAGE_DEFEND_UID" );
        ui_key = "WAR_HOSTAGE_DEFEND";
        player start_objective( uid, ui_key );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x14f5
// Size: 0xa0
function function_31c1ef0e3da10143()
{
    player = self;
    
    if ( is_equal( player.pers[ "team" ], game[ "attackers" ] ) )
    {
        uid = generate_uid( "WAR_DESTROY_PLANT_ATTACKERS_UID" );
        ui_key = "WAR_DESTROY_PLANT_ATTACKERS";
        player start_objective( uid, ui_key );
        return;
    }
    
    if ( is_equal( player.pers[ "team" ], game[ "defenders" ] ) )
    {
        uid = generate_uid( "WAR_DESTROY_PLANT_DEFENDERS_UID" );
        ui_key = "WAR_DESTROY_PLANT_DEFENDERS";
        player start_objective( uid, ui_key );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x159d
// Size: 0x1ab
function function_9fcbcb3aa626b914()
{
    player = self;
    
    while ( !isdefined( level.escortvehicles[ 0 ] ) )
    {
        waitframe();
    }
    
    setomnvar( "ui_wm_escort_objective_id", level.escortvehicles[ 0 ].marker.objidnum );
    
    foreach ( vehicle in level.escortvehicles )
    {
        if ( isdefined( vehicle.checkpoints ) )
        {
            foreach ( i, checkpoint in vehicle.checkpoints )
            {
                if ( istrue( checkpoint.visible ) )
                {
                    setomnvar( "ui_wm_escort_checkpoint_" + i, checkpoint.progress );
                }
            }
        }
    }
    
    if ( is_equal( player.pers[ "team" ], game[ "attackers" ] ) )
    {
        uid = generate_uid( "WAR_TANK_ESCORT_ATTACKERS_UID" );
        ui_key = "WAR_TANK_ESCORT_ATTACKERS";
        player start_objective( uid, ui_key );
        return;
    }
    
    if ( is_equal( player.pers[ "team" ], game[ "defenders" ] ) )
    {
        uid = generate_uid( "WAR_TANK_ESCORT_DEFENDERS_UID" );
        ui_key = "WAR_TANK_ESCORT_DEFENDERS";
        player start_objective( uid, ui_key );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x1750
// Size: 0xa0
function function_3de47cff2123e1d()
{
    player = self;
    
    if ( is_equal( player.pers[ "team" ], game[ "attackers" ] ) )
    {
        uid = generate_uid( "WAR_AI_BOSS_ATTACKERS_UID" );
        ui_key = "WAR_AI_BOSS_ATTACKERS";
        player start_objective( uid, ui_key );
        return;
    }
    
    if ( is_equal( player.pers[ "team" ], game[ "defenders" ] ) )
    {
        uid = generate_uid( "WAR_AI_BOSS_DEFENDERS_UID" );
        ui_key = "WAR_AI_BOSS_DEFENDERS";
        player start_objective( uid, ui_key );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x17f8
// Size: 0xa0
function function_55c691baef314f84()
{
    player = self;
    
    if ( is_equal( player.pers[ "team" ], game[ "attackers" ] ) )
    {
        uid = generate_uid( "WAR_AI_BOSS_ZONE_ATTACKERS_UID" );
        ui_key = "WAR_AI_BOSS_ZONE_ATTACKERS";
        player start_objective( uid, ui_key );
        return;
    }
    
    if ( is_equal( player.pers[ "team" ], game[ "defenders" ] ) )
    {
        uid = generate_uid( "WAR_AI_BOSS_ZONE_DEFENDERS_UID" );
        ui_key = "WAR_AI_BOSS_ZONE_DEFENDERS";
        player start_objective( uid, ui_key );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x18a0
// Size: 0x123
function function_db1805fcbcb64e80()
{
    player = self;
    hack_zones = level.zone.hackzones;
    
    if ( isdefined( hack_zones ) && hack_zones.size > 1 )
    {
        show_counter = 1;
        total_zones = hack_zones.size;
    }
    
    var_fd3f3786e1ff0478 = scripts\mp\gametypes\wm_objectives::function_fb82e12375af065f();
    
    if ( is_equal( player.pers[ "team" ], game[ "attackers" ] ) )
    {
        uid = generate_uid( "WAR_HACK_ATTACK_UID" );
        ui_key = "WAR_HACK_ATTACK";
        player start_objective( uid, ui_key );
        
        if ( show_counter )
        {
            function_cae7c80607a403a7( player, uid, total_zones, var_fd3f3786e1ff0478 );
        }
    }
    else if ( is_equal( player.pers[ "team" ], game[ "defenders" ] ) )
    {
        uid = generate_uid( "WAR_HACK_DEFEND_UID" );
        ui_key = "WAR_HACK_DEFEND";
        player start_objective( uid, ui_key );
        
        if ( show_counter )
        {
            function_cae7c80607a403a7( player, uid, total_zones, var_fd3f3786e1ff0478 );
        }
    }
    
    if ( show_counter )
    {
        player thread function_375e9b4b38c52544();
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x19cb
// Size: 0x46
function function_375e9b4b38c52544()
{
    level endon( "game_ended" );
    level endon( "end_hack_zone_objective" );
    self endon( "disconnect" );
    var_fd3f3786e1ff0478 = scripts\mp\gametypes\wm_objectives::function_fb82e12375af065f();
    
    while ( var_fd3f3786e1ff0478 > 0 )
    {
        level waittill( "obj_hack_zone_uploaded" );
        var_fd3f3786e1ff0478--;
        function_92b2c173041b8fb6( self, var_fd3f3786e1ff0478 );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x1a19
// Size: 0x16d
function function_84b6083a11611721()
{
    player = self;
    total_zones = 0;
    hack_zones = level.zone.hackzones;
    
    if ( isdefined( hack_zones ) && hack_zones.size > 1 )
    {
        total_zones = hack_zones.size;
    }
    
    currentphase = scripts\mp\gametypes\wm_objectives::function_d277ca7e1acc3003();
    var_fd3f3786e1ff0478 = scripts\mp\gametypes\wm_objectives::function_77dccebe95510a4f();
    ui_keys = function_7f3a51d588ffeb11();
    uids = function_e53cbc2fb3dfe2bf();
    index = -1;
    
    if ( is_equal( player.pers[ "team" ], game[ "attackers" ] ) )
    {
        index = 0;
    }
    else if ( is_equal( player.pers[ "team" ], game[ "defenders" ] ) )
    {
        index = 1;
    }
    
    uid = uids[ index ];
    ui_key = ui_keys[ index ];
    
    if ( isdefined( currentphase ) && currentphase == "hack" )
    {
        player start_objective( uid, ui_key );
        function_cae7c80607a403a7( player, uid, total_zones, var_fd3f3786e1ff0478 );
        player thread function_62f6b2de158a6952();
        player thread function_20ecdab10ad77b65();
        return;
    }
    
    setomnvar( "ui_wm_objective_phase_" + level.zone.index, 1 );
    player start_objective( uid, ui_key, 1 );
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x1b8e
// Size: 0x44
function function_20ecdab10ad77b65()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    level waittill( "hack_zone_upload_full_complete" );
    function_be0ddc8cccc0f4a4( is_equal( self.pers[ "team" ], game[ "attackers" ] ) );
    waitframe();
    thread function_84b6083a11611721();
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x1bda
// Size: 0x46
function function_62f6b2de158a6952()
{
    level endon( "game_ended" );
    level endon( "hack_zone_upload_full_complete" );
    self endon( "disconnect" );
    var_fd3f3786e1ff0478 = scripts\mp\gametypes\wm_objectives::function_77dccebe95510a4f();
    
    while ( var_fd3f3786e1ff0478 > 0 )
    {
        level waittill( "obj_hack_zone_uploaded" );
        var_fd3f3786e1ff0478--;
        function_92b2c173041b8fb6( self, var_fd3f3786e1ff0478 );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x1c28
// Size: 0x4b
function function_7f3a51d588ffeb11()
{
    currentphase = scripts\mp\gametypes\wm_objectives::function_d277ca7e1acc3003();
    
    if ( isdefined( currentphase ) && currentphase == "hack" )
    {
        return [ "WAR_HACK_BOMB_ATTACK_PHASE_1", "WAR_HACK_BOMB_DEFEND_PHASE_1" ];
    }
    
    return [ "WAR_HACK_BOMB_ATTACK_PHASE_2", "WAR_HACK_BOMB_DEFEND_PHASE_2" ];
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x1c7c
// Size: 0x4b
function function_e53cbc2fb3dfe2bf()
{
    currentphase = scripts\mp\gametypes\wm_objectives::function_d277ca7e1acc3003();
    
    if ( isdefined( currentphase ) && currentphase == "hack" )
    {
        return [ "WAR_HACK_BOMB_ATTACK_PHASE_1_UID", "WAR_HACK_BOMB_DEFEND_PHASE_1_UID" ];
    }
    
    return [ "WAR_HACK_BOMB_ATTACK_PHASE_2_UID", "WAR_HACK_BOMB_DEFEND_PHASE_2_UID" ];
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x1cd0
// Size: 0x1ab
function function_400f3f1de2faf5e1()
{
    player = self;
    
    while ( !isdefined( level.escortvehicles[ 0 ] ) )
    {
        waitframe();
    }
    
    setomnvar( "ui_wm_escort_objective_id", level.escortvehicles[ 0 ].marker.objidnum );
    
    foreach ( vehicle in level.escortvehicles )
    {
        if ( isdefined( vehicle.checkpoints ) )
        {
            foreach ( i, checkpoint in vehicle.checkpoints )
            {
                if ( istrue( checkpoint.visible ) )
                {
                    setomnvar( "ui_wm_escort_checkpoint_" + i, checkpoint.progress );
                }
            }
        }
    }
    
    if ( is_equal( player.pers[ "team" ], game[ "attackers" ] ) )
    {
        uid = generate_uid( "WAR_ESCORT_WHEELSON_ATTACK_UID" );
        ui_key = "WAR_ESCORT_WHEELSON_ATTACK";
        player start_objective( uid, ui_key );
        return;
    }
    
    if ( is_equal( player.pers[ "team" ], game[ "defenders" ] ) )
    {
        uid = generate_uid( "WAR_ESCORT_WHEELSON_DEFEND_UID" );
        ui_key = "WAR_ESCORT_WHEELSON_DEFEND";
        player start_objective( uid, ui_key );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x1e83
// Size: 0x139
function function_1fcd300591a7cf98()
{
    player = self;
    currentphase = scripts\mp\gametypes\wm_objectives::function_d277ca7e1acc3003();
    totalflags = level.requiredflag;
    var_585990e6fdb983a8 = namespace_16a6643951556450::function_ce0967f06e5921a4();
    ui_keys = function_fcc3c58a459eb914();
    uids = function_d6e9255e29b5fd5c();
    index = -1;
    
    if ( is_equal( player.pers[ "team" ], game[ "attackers" ] ) )
    {
        index = 0;
    }
    else if ( is_equal( player.pers[ "team" ], game[ "defenders" ] ) )
    {
        index = 1;
    }
    
    uid = uids[ index ];
    ui_key = ui_keys[ index ];
    
    if ( isdefined( currentphase ) && currentphase == "capture_flag" )
    {
        player start_objective( uid, ui_key );
        function_cae7c80607a403a7( player, uid, totalflags, var_585990e6fdb983a8 );
        player thread function_ff17535db12ae897();
        return;
    }
    
    setomnvar( "ui_wm_objective_phase_" + level.zone.index, 1 );
    player start_objective( uid, ui_key, 1 );
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x1fc4
// Size: 0x4b
function function_fcc3c58a459eb914()
{
    currentphase = scripts\mp\gametypes\wm_objectives::function_d277ca7e1acc3003();
    
    if ( isdefined( currentphase ) && currentphase == "capture_flag" )
    {
        return [ "WAR_CAPTURE_FLAG_ATTACK_PHASE_1", "WAR_CAPTURE_FLAG_DEFEND_PHASE_1" ];
    }
    
    return [ "WAR_CAPTURE_FLAG_ATTACK_PHASE_2", "WAR_CAPTURE_FLAG_DEFEND_PHASE_2" ];
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x2018
// Size: 0x4b
function function_d6e9255e29b5fd5c()
{
    currentphase = scripts\mp\gametypes\wm_objectives::function_d277ca7e1acc3003();
    
    if ( isdefined( currentphase ) && currentphase == "capture_flag" )
    {
        return [ "WAR_CAPTURE_FLAG_ATTACK_PHASE_1_UID", "WAR_CAPTURE_FLAG_DEFEND_PHASE_1_UID" ];
    }
    
    return [ "WAR_CAPTURE_FLAG_ATTACK_PHASE_2_UID", "WAR_CAPTURE_FLAG_DEFEND_PHASE_2_UID" ];
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x206c
// Size: 0x6b
function function_ff17535db12ae897()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_585990e6fdb983a8 = namespace_16a6643951556450::function_ce0967f06e5921a4();
    
    while ( var_585990e6fdb983a8 > 0 )
    {
        level waittill( "flag_placed" );
        var_585990e6fdb983a8--;
        function_92b2c173041b8fb6( self, var_585990e6fdb983a8 );
    }
    
    function_be0ddc8cccc0f4a4( is_equal( self.pers[ "team" ], game[ "attackers" ] ) );
    waitframe();
    thread function_1fcd300591a7cf98();
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 1
// Checksum 0x0, Offset: 0x20df
// Size: 0xeb
function function_f56dd59bba71b655( attackerswon )
{
    omnvar = "ui_wm_objective_state_" + level.zone.index;
    
    if ( attackerswon )
    {
        setomnvar( omnvar, 2 );
    }
    else
    {
        setomnvar( omnvar, 3 );
    }
    
    foreach ( player in level.players )
    {
        if ( is_equal( player.pers[ "team" ], game[ "attackers" ] ) )
        {
            player function_4ca6dc38a2cb2639( attackerswon );
            continue;
        }
        
        if ( is_equal( player.pers[ "team" ], game[ "defenders" ] ) )
        {
            player function_4ca6dc38a2cb2639( !attackerswon );
        }
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 1
// Checksum 0x0, Offset: 0x21d2
// Size: 0x1c8
function function_d2ac05c6539c221e( objectivetype )
{
    player = self;
    setomnvar( "ui_wm_objective_state_" + level.zone.index, 1 );
    setomnvar( "ui_wm_objective_phase_" + level.zone.index, 0 );
    
    if ( isdefined( level.zone.objectivetype ) )
    {
        switch ( level.zone.objectivetype )
        {
            case 1:
                player thread function_56e0031a424d8009( level.zone.capture_zones );
                break;
            case 2:
                player thread function_bd670364611e5003( level.zone.objectives );
                break;
            case 3:
                player thread function_a79d4af0fcd2254();
                break;
            case 5:
                player thread function_31c1ef0e3da10143();
                break;
            case 6:
                player thread function_9fcbcb3aa626b914();
                break;
            case 11:
                player thread function_400f3f1de2faf5e1();
                break;
            case 7:
                player thread function_3de47cff2123e1d();
                break;
            case 8:
                player thread function_55c691baef314f84();
                break;
            case 9:
                player thread function_db1805fcbcb64e80();
                break;
            case 10:
                player thread function_84b6083a11611721();
                break;
            case 12:
                player thread function_1fcd300591a7cf98();
                break;
            default:
                break;
        }
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 4
// Checksum 0x0, Offset: 0x23a2
// Size: 0x3f
function function_cae7c80607a403a7( player, uid, total, remaining )
{
    function_15010f27afb2d1e7( player );
    function_41e69df7eeb5c17b( player, uid, total );
    function_a92e843c02dc6414( player, uid, remaining );
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 2
// Checksum 0x0, Offset: 0x23e9
// Size: 0x67
function function_92b2c173041b8fb6( player, remaining )
{
    if ( isdefined( player.objective_tracker ) && isdefined( player.objective_tracker.active_uid ) )
    {
        uid = player.objective_tracker.active_uid;
        function_a92e843c02dc6414( player, uid, remaining );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 3
// Checksum 0x0, Offset: 0x2458
// Size: 0x79
function function_b41a05f6198e9a29( player, progress, state )
{
    if ( isdefined( player.objective_tracker ) && isdefined( player.objective_tracker.active_uid ) )
    {
        uid = player.objective_tracker.active_uid;
        function_3e38fac7ccd01903( player, uid, progress );
        function_c718b293158313c9( player, uid, state );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x24d9
// Size: 0x6c
function function_23db8dc38b007d5e()
{
    timeremaining = int( scripts\mp\gamelogic::gettimeremaining() );
    
    foreach ( player in level.players )
    {
        function_5e299d656e336919( player, timeremaining );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 2
// Checksum 0x0, Offset: 0x254d
// Size: 0x67
function function_5e299d656e336919( player, timeremaining )
{
    if ( isdefined( player.objective_tracker ) && isdefined( player.objective_tracker.active_uid ) )
    {
        uid = player.objective_tracker.active_uid;
        function_5d2c66d2ea6e4267( player, uid, timeremaining );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 2
// Checksum 0x0, Offset: 0x25bc
// Size: 0x86
function function_557efb699f50447b( oobtimelimit, isfallback )
{
    if ( !isdefined( oobtimelimit ) )
    {
        scripts\mp\utility\script::demoforcesre( "ooBTimeLimit is not defined" );
        return;
    }
    
    if ( oobtimelimit <= 0 )
    {
        scripts\mp\utility\script::demoforcesre( "ooBTimeLimit: " + oobtimelimit + " must be greater than 0" );
        return;
    }
    
    player = self;
    oobtype = 1;
    
    if ( isdefined( isfallback ) )
    {
        oobtype = 4;
    }
    
    player setclientomnvar( "ui_out_of_bounds_type", oobtype );
    player setclientomnvar( "ui_out_of_bounds_countdown", gettime() + oobtimelimit * 1000 );
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 1
// Checksum 0x0, Offset: 0x264a
// Size: 0x58
function function_353ca278babb871e( player )
{
    var_77a7be006731f124 = "scripted_widget_objective_tracker_jup_wm";
    
    if ( isdefined( level.var_77a7be006731f124 ) )
    {
        var_77a7be006731f124 = level.var_77a7be006731f124;
    }
    
    player_init( player, "ObjectiveTracker_WarMode", var_77a7be006731f124, 26, 265 );
    player function_d2ac05c6539c221e();
    player thread function_524eac445bf29eab();
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 3
// Checksum 0x0, Offset: 0x26aa
// Size: 0xa4
function start_objective( uid, ui_key, var_4f1c7c8ad5d5b9e4 )
{
    completed = 0;
    var_185416cb8a76fb63 = isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.objectives[ uid ] );
    
    if ( isdefined( self.objective_tracker ) )
    {
        scripts\mp\flags::gameflagset( "ui_objectives_setup" );
        
        if ( !istrue( var_185416cb8a76fb63 ) )
        {
            add_objective( uid, undefined, undefined, ui_key, completed, var_4f1c7c8ad5d5b9e4 );
        }
        
        return;
    }
    
    level.pending_uid = uid;
    level.var_1837cfa1aeb8ff0b = ui_key;
    scripts\mp\flags::gameflagclear( "ui_objectives_setup" );
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 2
// Checksum 0x0, Offset: 0x2756
// Size: 0x75
function complete_objective( uid, is_successful )
{
    var_185416cb8a76fb63 = isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.objectives[ uid ] );
    
    if ( istrue( var_185416cb8a76fb63 ) && !istrue( self.objective_tracker.objectives[ uid ].is_completed ) )
    {
        function_c0257db3a941f1b6( uid, is_successful );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 1
// Checksum 0x0, Offset: 0x27d3
// Size: 0x7b
function function_4ca6dc38a2cb2639( is_successful )
{
    if ( isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.active_uid ) )
    {
        uid = self.objective_tracker.active_uid;
        
        if ( !istrue( self.objective_tracker.objectives[ uid ].is_completed ) )
        {
            function_c0257db3a941f1b6( uid, is_successful );
        }
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 1
// Checksum 0x0, Offset: 0x2856
// Size: 0xa1
function function_be0ddc8cccc0f4a4( is_successful )
{
    if ( isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.active_uid ) )
    {
        uid = self.objective_tracker.active_uid;
        
        if ( !istrue( self.objective_tracker.objectives[ uid ].is_completed ) )
        {
            function_c0257db3a941f1b6( uid, is_successful );
        }
        
        self.objective_tracker.active_uid = undefined;
        self.objective_tracker.active_completed = undefined;
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 1
// Checksum 0x0, Offset: 0x28ff
// Size: 0x48
function clear_objective( uid )
{
    var_8f5353255e77c5bf = isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.objectives[ uid ] );
    
    if ( istrue( var_8f5353255e77c5bf ) )
    {
        remove_objective( uid );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x294f
// Size: 0x63
function function_d4a8824fbf63451d()
{
    current_obj = undefined;
    next_uid = self.objective_tracker.next_uid;
    
    if ( isdefined( next_uid ) && isdefined( self.objective_tracker.objectives[ next_uid ] ) )
    {
        current_obj = self.objective_tracker.objectives[ next_uid ];
    }
    
    return current_obj;
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x29bb
// Size: 0x215
function function_2ea2aacc5d66ae03()
{
    if ( !scripts\mp\flags::gameflag( "ui_objectives_setup" ) )
    {
        if ( isdefined( level.pending_uid ) && isdefined( level.var_1837cfa1aeb8ff0b ) )
        {
            foreach ( player in level.players )
            {
                player start_objective( level.pending_uid, level.var_1837cfa1aeb8ff0b );
            }
        }
    }
    
    if ( !isdefined( self ) || !isdefined( self.objective_tracker ) || !isdefined( self.objective_tracker.objectives ) )
    {
        return;
    }
    
    self.objective_tracker.var_1710c224de197b0a = level.framedurationseconds;
    current_obj = function_d4a8824fbf63451d();
    
    if ( isdefined( current_obj ) )
    {
        if ( !isdefined( self.objective_tracker.active_uid ) )
        {
            if ( istrue( current_obj.var_4f1c7c8ad5d5b9e4 ) )
            {
                function_7fcc6994dd0b0374( current_obj.uid, current_obj.ui_key );
            }
            else
            {
                function_3b4b24bbf0814ee6( current_obj.uid, current_obj.ui_key, current_obj.is_completed, current_obj.is_successful );
            }
        }
        else if ( self.objective_tracker.active_uid != current_obj.uid )
        {
            function_4c43cb3c8fcb9b87();
        }
        else if ( !isdefined( self.objective_tracker.active_completed ) || self.objective_tracker.active_completed != current_obj.is_completed )
        {
            if ( istrue( current_obj.is_completed ) )
            {
                function_d463ec55daebbd66( current_obj.is_successful );
            }
        }
        
        return;
    }
    
    if ( isdefined( self.objective_tracker.active_uid ) )
    {
        function_4c43cb3c8fcb9b87();
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 1
// Checksum 0x0, Offset: 0x2bd8
// Size: 0x39
function function_a2b714e5d5977e3a( zone )
{
    ui_objective = function_707fa37138f06a58( zone.objectivetype );
    
    if ( isdefined( ui_objective ) )
    {
        setomnvar( "ui_wm_objective", ui_objective );
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 1
// Checksum 0x0, Offset: 0x2c19
// Size: 0x101
function function_707fa37138f06a58( objectivetype )
{
    switch ( objectivetype )
    {
        case 1:
            if ( scripts\cp_mp\utility\game_utility::getmapname() == "mp_jup_dam" )
            {
                return 9;
            }
            else
            {
                return 1;
            }
        case 2:
            if ( scripts\cp_mp\utility\game_utility::getmapname() == "mp_jup_dam" )
            {
                return 10;
            }
            else
            {
                return 2;
            }
        case 3:
            return 3;
        case 4:
            return 4;
        case 5:
            return 5;
        case 6:
            return 6;
        case 7:
            return 7;
        case 8:
            return 8;
        case 9:
            return 11;
        case 10:
            return 12;
        case 11:
            return 13;
        case 12:
            return 14;
        default:
            break;
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 1
// Checksum 0x0, Offset: 0x2d22
// Size: 0x1d
function function_20c1029d048bbe3c( attackingteam )
{
    setomnvar( "ui_wm_axis_attacking", attackingteam == "axis" );
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x2d47
// Size: 0x47
function function_e20cff3c3800c3a()
{
    setomnvar( "ui_wm_show_objectives", 0 );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    wait 5;
    function_104402acd2337387( self.zone.objectivetype );
    wait 1;
    setomnvar( "ui_wm_show_objectives", 1 );
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 1
// Checksum 0x0, Offset: 0x2d96
// Size: 0x167
function function_104402acd2337387( objectivetype )
{
    switch ( objectivetype )
    {
        case 1:
            scripts\mp\hud_message::notifyteam( "jup_wm_zone_attack", "jup_wm_zone_defend", game[ "attackers" ] );
            break;
        case 2:
            scripts\mp\hud_message::notifyteam( "jup_wm_bomb_attack", "jup_wm_bomb_defend", game[ "attackers" ] );
            break;
        case 3:
            scripts\mp\hud_message::notifyteam( "jup_wm_hostage_attack", "jup_wm_hostage_defend", game[ "attackers" ] );
            break;
        case 4:
            scripts\mp\hud_message::notifyteam( "jup_wm_destroy_attack", "jup_wm_destroy_defend", game[ "attackers" ] );
            break;
        case 5:
            scripts\mp\hud_message::notifyteam( "jup_wm_plant_attack", "jup_wm_plant_defend", game[ "attackers" ] );
            break;
        case 6:
        case 11:
            scripts\mp\hud_message::notifyteam( "jup_wm_escort_attack", "jup_wm_escort_defend", game[ "attackers" ] );
            break;
        case 7:
            scripts\mp\hud_message::notifyteam( "jup_wm_boss_attack", "jup_wm_boss_defend", game[ "attackers" ] );
            break;
        case 8:
            scripts\mp\hud_message::notifyteam( "jup_wm_boss_zone_attack", "jup_wm_boss_zone_defend", game[ "attackers" ] );
            break;
        default:
            break;
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 2
// Checksum 0x0, Offset: 0x2f05
// Size: 0xbf
function function_51bce80de8cbf370( var_a56d40e76fdbc670, var_15ec18bea9b1ec17 )
{
    if ( isdefined( level.zone.objective.params[ "transitionSplash" ] ) )
    {
        attackersplash = level.zone.objective.params[ "transitionSplash" ][ 0 ];
        defendersplash = level.zone.objective.params[ "transitionSplash" ][ 1 ];
        scripts\mp\hud_message::notifyteam( attackersplash, defendersplash, game[ "attackers" ] );
        return;
    }
    
    function_ab0851fa181e1fb2( var_a56d40e76fdbc670 );
    waitframe();
    function_b5b3534cd8504c4b( var_15ec18bea9b1ec17 );
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 1
// Checksum 0x0, Offset: 0x2fcc
// Size: 0x167
function function_ab0851fa181e1fb2( objectivetype )
{
    switch ( objectivetype )
    {
        case 1:
            scripts\mp\hud_message::notifyteam( "jup_wm_secured_zone", "jup_wm_secured_zone_enemy", game[ "attackers" ] );
            break;
        case 2:
            scripts\mp\hud_message::notifyteam( "jup_wm_secured_bomb", "jup_wm_secured_bomb_enemy", game[ "attackers" ] );
            break;
        case 3:
            scripts\mp\hud_message::notifyteam( "jup_wm_secured_hostage", "jup_wm_secured_hostage_enemy", game[ "attackers" ] );
            break;
        case 4:
            scripts\mp\hud_message::notifyteam( "jup_wm_secured_destroy", "jup_wm_secured_destroy_enemy", game[ "attackers" ] );
            break;
        case 5:
            scripts\mp\hud_message::notifyteam( "jup_wm_secured_plant", "jup_wm_secured_plant_enemy", game[ "attackers" ] );
            break;
        case 6:
        case 11:
            scripts\mp\hud_message::notifyteam( "jup_wm_secured_escort", "jup_wm_secured_escort_enemy", game[ "attackers" ] );
            break;
        case 7:
            scripts\mp\hud_message::notifyteam( "jup_wm_secured_boss", "jup_wm_secured_boss_enemy", game[ "attackers" ] );
            break;
        case 8:
            scripts\mp\hud_message::notifyteam( "jup_wm_secured_boss_zone", "jup_wm_secured_boss_zone_enemy", game[ "attackers" ] );
            break;
        default:
            break;
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 1
// Checksum 0x0, Offset: 0x313b
// Size: 0x167
function function_b5b3534cd8504c4b( objectivetype )
{
    switch ( objectivetype )
    {
        case 1:
            scripts\mp\hud_message::notifyteam( "jup_wm_next_zone", "jup_wm_next_zone_enemy", game[ "attackers" ] );
            break;
        case 2:
            scripts\mp\hud_message::notifyteam( "jup_wm_next_bomb", "jup_wm_next_bomb_enemy", game[ "attackers" ] );
            break;
        case 3:
            scripts\mp\hud_message::notifyteam( "jup_wm_next_hostage", "jup_wm_next_hostage_enemy", game[ "attackers" ] );
            break;
        case 4:
            scripts\mp\hud_message::notifyteam( "jup_wm_next_destroy", "jup_wm_next_destroy_enemy", game[ "attackers" ] );
            break;
        case 5:
            scripts\mp\hud_message::notifyteam( "jup_wm_next_plant", "jup_wm_next_plant_enemy", game[ "attackers" ] );
            break;
        case 6:
        case 11:
            scripts\mp\hud_message::notifyteam( "jup_wm_next_escort", "jup_wm_next_escort_enemy", game[ "attackers" ] );
            break;
        case 7:
            scripts\mp\hud_message::notifyteam( "jup_wm_next_boss", "jup_wm_next_boss_enemy", game[ "attackers" ] );
            break;
        case 8:
            scripts\mp\hud_message::notifyteam( "jup_wm_next_boss_zone", "jup_wm_next_boss_zone_enemy", game[ "attackers" ] );
            break;
        default:
            break;
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 0
// Checksum 0x0, Offset: 0x32aa
// Size: 0x183
function function_524eac445bf29eab()
{
    self endon( "game_ended" );
    self endon( "disconnect" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    while ( true )
    {
        self waittill( "joined_team" );
        lastteam = self.pers[ "last_team" ];
        
        if ( isdefined( lastteam ) && self.team != lastteam )
        {
            current_obj = function_d4a8824fbf63451d();
            
            if ( !isdefined( current_obj ) )
            {
                continue;
            }
            
            if ( isdefined( self.objective_tracker.active_uid ) )
            {
                self.objective_tracker.next_uid = undefined;
                wait 1;
            }
            
            objectivetype = level.zone.objectivetype;
            self.objective_tracker.objectives[ current_obj.uid ] = undefined;
            current_obj.uid = function_7e6a8f883ef06080( objectivetype, self.team );
            current_obj.ui_key = function_37b37dfde06a36af( objectivetype, self.team );
            current_obj.var_9c9dc0bc7ea4a64e = 1;
            current_obj.var_b768c68c436ee397 = 1;
            self.objective_tracker.objectives[ current_obj.uid ] = current_obj;
            self.objective_tracker.next_uid = current_obj.uid;
            self.objective_tracker.active_uid = undefined;
        }
    }
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 2
// Checksum 0x0, Offset: 0x3435
// Size: 0x156
function function_37b37dfde06a36af( objectivetype, team )
{
    side = ter_op( team == game[ "attackers" ], 0, 1 );
    var_877dcafdfba1ebda = function_7f3a51d588ffeb11();
    var_a18f2d067f37ee8d = function_fcc3c58a459eb914();
    mp = [ [], [ "WAR_CAPTURE", "WAR_DEFEND" ], [ "WAR_BOMB_DEFUSE", "WAR_BOMB_DEFEND" ], [ "WAR_HOSTAGE_RESCUE", "WAR_HOSTAGE_DEFEND" ], [ "", "" ], [ "WAR_DESTROY_PLANT_ATTACKERS", "WAR_DESTROY_PLANT_DEFENDERS" ], [ "WAR_TANK_ESCORT_ATTACKERS", "WAR_TANK_ESCORT_DEFENDERS" ], [ "WAR_AI_BOSS_ATTACKERS", "WAR_AI_BOSS_DEFENDERS" ], [ "WAR_AI_BOSS_ZONE_ATTACKERS", "WAR_AI_BOSS_ZONE_DEFENDERS" ], [ "WAR_HACK_ATTACK", "WAR_HACK_DEFEND" ], var_877dcafdfba1ebda, [ "WAR_ESCORT_WHEELSON_ATTACK", "WAR_ESCORT_WHEELSON_DEFEND" ], var_a18f2d067f37ee8d ];
    return mp[ objectivetype ][ side ];
}

// Namespace wm_ui / scripts\mp\gametypes\wm_ui
// Params 2
// Checksum 0x0, Offset: 0x3594
// Size: 0x34
function function_7e6a8f883ef06080( objectivetype, team )
{
    prefix = function_37b37dfde06a36af( objectivetype, team ) + "_UID";
    return generate_uid( prefix );
}

