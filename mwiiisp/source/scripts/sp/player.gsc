#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\whizby;
#using scripts\engine\math;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\analytics;
#using scripts\sp\audio;
#using scripts\sp\equipment\offhands;
#using scripts\sp\gameskill;
#using scripts\sp\heartbeat_sp;
#using scripts\sp\input_watcher;
#using scripts\sp\loot;
#using scripts\sp\player\edgehang;
#using scripts\sp\player\gestures;
#using scripts\sp\player_stats;
#using scripts\sp\swim_sp;
#using scripts\sp\utility;

#namespace player;

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x1589
// Size: 0x3a4
function init()
{
    if ( !add_init_script( "level_player", &init ) )
    {
        return;
    }
    
    val::register( "shotgun_overkill", 0, 1, "$self", &function_b2c2a8f72b5d9583, "$value" );
    initplayerdvars();
    initplayervfx();
    initplayerprecache();
    level.players = getentarray( "player", "classname" );
    level.player = level.players[ 0 ];
    level.player.lastenemykilltime = 0;
    level.player.lastenemydmgtime = 0;
    level.player.deathshieldfunc = &deathshieldfunc;
    level.player.gs = spawnstruct();
    level.player.gs.scripteddamagemultiplier = 1;
    level.player.gs.scripteddeathshielddurationscale = 1;
    level.player.gs.var_f3cb481e3e3b2a24 = 1;
    level.player.gs.var_302587891497f2db = 1;
    level.player.gs.basehealthdamagemultiplier = 1;
    level.player.gs.basehealthexplosivedamagemultiplier = 1;
    level.player.maxhealth = 100;
    level.player.health = 100;
    level.player.lasthealth = 100;
    level.player.var_24c43aff3e21ac3d = 0.7;
    level.player.pers = [];
    level.player initplayerdefaultsettings();
    level.player initplayeromnvars();
    level.player initplayernotifies();
    level.player initplayerentflags();
    level.player initplayerdamage();
    level.player initplayerfocus();
    level.player initplayerfoley();
    level.player function_601bf6bcdce65b67();
    level.player thread hud_think();
    level.player thread ladderpistol();
    level.player thread edgehang();
    level.player thread watchweaponswap();
    
    if ( istrue( level.var_bae0e0b3c3ce64a3 ) )
    {
        thread scripts\sp\utility::function_353f16f0014a5e30();
    }
    
    setdvarifuninitialized( @"hash_92edcd4e782939e5", 1 );
    level.player thread scripts\sp\player\gestures::function_160704ee50b41fa();
    
    if ( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.var_e682083c33f4331f ) )
    {
        setsaveddvar( @"hash_4bdbfc1e7f0ba01b", level.gamemodebundle.var_e682083c33f4331f );
    }
    
    if ( isdefined( level.gamemodebundle ) && !istrue( level.gamemodebundle.var_d3ba092396991d5a ) )
    {
        level.player thread scripts\sp\player\gestures::function_5231b0f285527a15();
    }
    
    level.player thread scripts\sp\input_watcher::function_f65d06cca9dfed8e();
    post_load_precache( &playerpostload );
    level.callbackplayerdamage = &onplayerdamaged;
}

// Namespace player / scripts\sp\player
// Params 8
// Checksum 0x0, Offset: 0x1935
// Size: 0x6b
function codecallback_playerdamage( damage, attacker, inflictor, direction, point, type, partname, objweapon )
{
    [[ level.callbackplayerdamage ]]( damage, attacker, inflictor, direction, point, type, partname, objweapon );
    self.lasthealth = self.health;
}

// Namespace player / scripts\sp\player
// Params 8, eflags: 0x4
// Checksum 0x0, Offset: 0x19a8
// Size: 0xe3
function private onplayerdamaged( damage, attacker, inflictor, direction, point, type, partname, objweapon )
{
    player = self;
    player.hadarmor = hasarmor();
    
    if ( !isalive( player ) )
    {
        player thread ondeathfinalhit( attacker, type, damage );
        return;
    }
    
    if ( !isdefined( point ) )
    {
        point = player.origin;
    }
    
    player.dmgtoplayer = damage;
    player.dmgpoint = point;
    player dispersedamage( player.damage.disperse, damage, attacker, direction, point, type, objweapon, inflictor );
    thread scripts\sp\analytics::analytics_playerdamage( attacker, objweapon, damage, type, partname );
    maintainhealthfloor();
}

// Namespace player / scripts\sp\player
// Params 9
// Checksum 0x0, Offset: 0x1a93
// Size: 0x100
function calldamagefunctions( functionsfunc, damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage )
{
    self endon( "death" );
    
    foreach ( function in [[ functionsfunc ]]( type ) )
    {
        self childthread [[ function ]]( damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage );
    }
    
    foreach ( function in self.damage_functions )
    {
        self childthread [[ function ]]( damage, attacker, direction, point, type, overkilldamage, inflictor );
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x1b9b
// Size: 0x35
function playerpostload()
{
    level.player thread scripts\sp\swim_sp::function_9ac5625caf26591e();
    level.player thread scripts\sp\heartbeat_sp::function_767efe0110bfa73a();
    level.player thread scripts\engine\sp\objectives::function_f420c7fbd15a416b();
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x1bd8
// Size: 0x2a
function deathshieldfunc( bool )
{
    if ( utility::damageflag( 2 ) && !utility::damageflag( 1 ) )
    {
        self enabledeathshield( bool );
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x1c0a
// Size: 0x8e
function main()
{
    add_hint_string( "focus_hint", &"GAME/FOCUS_HINT", &focus_held_down );
    level.player playerdamagemain();
    level.player playeroffhandmain();
    level.player playeraltweapon();
    level.player playerfocusmain();
    level.player thread scripts\engine\sp\utility::playerwatch_unresolved_collision();
    
    /#
        level.player thread function_dad68fb5c4e5d2c1();
        level.player thread function_31a13be1530a809b();
    #/
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x1ca0
// Size: 0x26
function function_601bf6bcdce65b67()
{
    self.climbfists = make_weapon( "iw9_me_climbfists" );
    give_weapon( self.climbfists );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x1cce
// Size: 0xaa
function initplayerdvars()
{
    setdvarifuninitialized( @"hash_bfa6bedc37206c58", 1 );
    setdvarifuninitialized( @"hash_614d0737da55cb97", 1 );
    setsaveddvar( @"bg_falldamagemaxheight", 375 );
    setsaveddvar( @"bg_falldamageminheight", 220 );
    setsaveddvar( @"g_speed", 150 );
    setsaveddvar( @"hash_ecd52993b5dab130", 75 );
    setdvar( @"hash_c815d5683eea5b67", 0 );
    setsaveddvar( @"cg_crosshairenemycolor", 0 );
    setsaveddvar( @"hash_f7da54a18841a6f8", 30 );
    setdvarifuninitialized( @"hash_e7c074c9ef3fd481", 0 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x1d80
// Size: 0xec
function initplayervfx()
{
    level.g_effect[ "player_onfire_ignite" ] = loadfx( "vfx/iw8/core/player/vfx_player_onfire_ignite.vfx" );
    level.g_effect[ "player_offfire_extinguish" ] = loadfx( "vfx/iw8/core/player/vfx_player_offfire_extinguish.vfx" );
    level.g_effect[ "player_onfire_small" ] = loadfx( "vfx/iw8/core/player/vfx_player_onfire_small.vfx" );
    level.g_effect[ "player_onfire_med" ] = loadfx( "vfx/iw8/core/player/vfx_player_onfire_med.vfx" );
    level.g_effect[ "player_onfire_large" ] = loadfx( "vfx/iw8/core/player/vfx_player_onfire_large.vfx" );
    level.g_effect[ "player_offfire_small" ] = loadfx( "vfx/iw8/core/player/vfx_player_offfire_small.vfx" );
    level.g_effect[ "player_offfire_med" ] = loadfx( "vfx/iw8/core/player/vfx_player_offfire_med.vfx" );
    level.g_effect[ "player_offfire_large" ] = loadfx( "vfx/iw8/core/player/vfx_player_offfire_large.vfx" );
    level.g_effect[ "player_armor_break" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_shield_break.vfx" );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x1e74
// Size: 0x17e
function initplayerprecache()
{
    precachestring( &"GAME/GET_TO_COVER" );
    precachestring( &"GAME/GET_TO_COVER_SWIM" );
    directions = [ "bottom", "left", "right" ];
    
    foreach ( direction in directions )
    {
        precacheshader( "fullscreen_blood_" + direction );
        precacheshader( "fullscreen_blood_" + direction + "_alt" );
        precacheshader( "fullscreen_blood_" + direction + "_splash" );
        precacheshader( "fullscreen_dirt_" + direction );
        precacheshader( "fullscreen_dirt_" + direction + "_splash" );
        
        if ( utility::playerarmorenabled() )
        {
            precacheshader( "fullscreen_armor_" + direction );
            precacheshader( "fullscreen_armor_" + direction + "_splash" );
        }
    }
    
    precacheshader( "ui_player_pain_damage_overlay" );
    precacheshader( "ui_player_pain_fire_overlay" );
    precacheshader( "ui_player_pain_impact_overlay" );
    precacheshader( "ui_player_pain_blood_overlay" );
    precacheshader( "ui_player_pain_deathsdoor_pulse_overlay" );
    precachesuit( "iw9_defaultsuit_sp" );
    precachesuit( "iw9_creep" );
    precachesuit( "iw9_cqb" );
    
    if ( utility::playerarmorenabled() )
    {
        precacheshader( "hud_icon_loot_armor" );
        precacheshader( "ui_player_pain_damage_overlay" );
        precacheshader( "ui_player_pain_armorbreak_overlay" );
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x1ffa
// Size: 0x25
function initplayeromnvars()
{
    self setclientomnvar( "ui_gettocover_state", 0 );
    
    if ( utility::playerarmorenabled() )
    {
        self setclientomnvar( "ui_armor_red_flash", 0 );
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x2027
// Size: 0x2dd
function initplayernotifies()
{
    self notifyonplayercommand( "reload_pressed", "+usereload" );
    self notifyonplayercommand( "reload_pressed", "+reload" );
    self notifyonplayercommand( "frag_pressed", "+frag" );
    self notifyonplayercommand( "frag_released", "-frag" );
    self notifyonplayercommand( "smoke_pressed", "+smoke" );
    self notifyonplayercommand( "smoke_released", "-smoke" );
    self notifyonplayercommand( "melee_pressed", "+melee" );
    self notifyonplayercommand( "melee_pressed", "+melee_zoom" );
    self notifyonplayercommand( "melee_pressed", "+melee_sprint" );
    self notifyonplayercommand( "sprint_pressed", "+sprint" );
    self notifyonplayercommand( "sprint_pressed", "+sprint_zoom" );
    self notifyonplayercommand( "sprint_pressed", "+breath_sprint" );
    self notifyonplayercommand( "attack_pressed", "+attack" );
    self notifyonplayercommand( "attack_released", "-attack" );
    self notifyonplayercommand( "attack_pressed", "+attack_akimbo_accessible" );
    self notifyonplayercommand( "attack_released", "-attack_akimbo_accessible" );
    self notifyonplayercommand( "ads_pressed", "+toggleads_throw" );
    self notifyonplayercommand( "ads_pressed", "+speed_throw" );
    self notifyonplayercommand( "ads_pressed", "+ads_akimbo_accessible" );
    self notifyonplayercommand( "ads_released", "-toggleads_throw" );
    self notifyonplayercommand( "ads_released", "-speed_throw" );
    self notifyonplayercommand( "ads_released", "-ads_akimbo_accessible" );
    self notifyonplayercommand( "focus_pressed", "+focus" );
    self notifyonplayercommand( "focus_released", "-focus" );
    self notifyonplayercommand( "reload_pressed", "+usereload" );
    self notifyonplayercommand( "reload_pressed", "+reload" );
    self notifyonplayercommand( "use_pressed", "+activate" );
    self notifyonplayercommand( "use_pressed", "+usereload" );
    self notifyonplayercommand( "stance_pressed", "+stance" );
    self notifyonplayercommand( "stance_pressed", "+togglecrouch" );
    self notifyonplayercommand( "stance_pressed", "+movedown" );
    self notifyonplayercommand( "jump_pressed", "+gostand" );
    self notifyonplayercommand( "jump_pressed", "+stanceup" );
    self notifyonplayercommand( "jump_pressed", "+mantle" );
    self notifyonplayercommand( "weapon_switch_pressed", "+weapnext" );
    self notifyonplayercommand( "weapon_switch_pressed", "+weapprev" );
    self notifyonplayercommand( "weapon_switch_pressed", "selectweapon1" );
    self notifyonplayercommand( "weapon_switch_pressed", "selectweapon2" );
    self notifyonplayercommand( "weapon_switch_pressed", "selectweapon3" );
    self notifyonplayercommand( "actionslot1", "+actionslot 1" );
    self notifyonplayercommand( "actionslot2", "+actionslot 2" );
    self notifyonplayercommand( "actionslot3", "+actionslot 3" );
    self notifyonplayercommand( "actionslot4", "+actionslot 4" );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x230c
// Size: 0x1a
function initplayerentflags()
{
    ent_flag_init( "global_hint_in_use" );
    ent_flag_init( "player_zero_attacker_accuracy" );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x232e
// Size: 0x1a5
function initplayerdamage()
{
    self.damage = spawnstruct();
    dispersedamagepush( &dispersedamagedefault, &damagefunctions );
    self.damage.impactsfx = spawn_script_origin();
    self.damage.impactsfx linkto( self );
    self.damage.pulsesfx = spawn_script_origin();
    self.damage.pulsesfx linkto( self );
    self.damage.activescreeneffectoverlays = [];
    self.damage.flags = 0;
    self.damage.firedamage = 0;
    self.damage.firehealth = 100;
    self.damage.altdirectionalbloodoverlay = 0;
    self.damage.lastdiretionalbloodtime = -99999;
    initdamageoverlay();
    initdeathsdooroverlaypulse();
    initbloodoverlay();
    bundle = isdefined( level.gamemodebundle ) ? level.gamemodebundle : spawnstruct();
    visionsetdamagedistortion( isdefined( bundle.var_813a06af0c271672 ) ? bundle.var_813a06af0c271672 : "damage_radial" );
    visionsetdamagecolor( isdefined( bundle.var_96467afb3300bf50 ) ? bundle.var_96467afb3300bf50 : "damage_severe" );
    visionsetwhizby( "whizby" );
}

// Namespace player / scripts\sp\player
// Params 2
// Checksum 0x0, Offset: 0x24db
// Size: 0xf3
function dispersedamagepush( dispersedamagefunc, damagefunctionsfunc )
{
    assert( isdefined( self.damage ) );
    newnode = spawnstruct();
    newnode.func = dispersedamagefunc;
    newnode.var_11f23d2919cdd79d = damagefunctionsfunc;
    
    if ( isdefined( self.damage.disperse ) )
    {
        self.damage.disperse.next = newnode;
        
        if ( !isdefined( newnode.var_11f23d2919cdd79d ) )
        {
            newnode.var_11f23d2919cdd79d = self.damage.disperse.var_11f23d2919cdd79d;
        }
        
        newnode.prev = self.damage.disperse;
    }
    
    self.damage.disperse = newnode;
    return newnode;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x25d7
// Size: 0x110
function dispersedamagepop( dispersedamagenode )
{
    assert( isdefined( dispersedamagenode ) );
    assert( isdefined( dispersedamagenode.func ) );
    
    if ( isdefined( dispersedamagenode.prev ) )
    {
        dispersedamagenode.prev.next = dispersedamagenode.next;
    }
    
    if ( isdefined( dispersedamagenode.next ) )
    {
        dispersedamagenode.next.prev = dispersedamagenode.prev;
    }
    
    if ( is_equal( self.damage.disperse, dispersedamagenode ) )
    {
        self.damage.disperse = dispersedamagenode.prev;
    }
    
    dispersedamagenode.func = undefined;
    dispersedamagenode.next = undefined;
    dispersedamagenode.prev = undefined;
    dispersedamagenode.var_11f23d2919cdd79d = undefined;
    assert( isdefined( self.damage.disperse ) );
}

// Namespace player / scripts\sp\player
// Params 8
// Checksum 0x0, Offset: 0x26ef
// Size: 0x7f
function dispersedamage( dispersedamagenode, damage, attacker, direction, point, type, objweapon, inflictor )
{
    player = self;
    
    if ( isdefined( dispersedamagenode ) && isdefined( dispersedamagenode.func ) )
    {
        player [[ dispersedamagenode.func ]]( dispersedamagenode, damage, attacker, direction, point, type, objweapon, inflictor );
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x2776
// Size: 0x1a8
function initdamageoverlay()
{
    self.damage.overlay = newclienthudelem( self );
    self.damage.overlay.sort = 12;
    self.damage.overlay.x = 0;
    self.damage.overlay.y = 0;
    self.damage.overlay.alignx = "left";
    self.damage.overlay.aligny = "top";
    self.damage.overlay.foreground = 0;
    self.damage.overlay.lowresbackground = 1;
    self.damage.overlay.horzalign = "fullscreen";
    self.damage.overlay.vertalign = "fullscreen";
    self.damage.overlay.alpha = 0;
    self.damage.overlay.enablehudlighting = 1;
    self.damage.overlay setshader( "ui_player_pain_damage_overlay", 640, 480 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x2926
// Size: 0x1a8
function initfiredamageoverlay()
{
    self.damage.firedamageoverlay = newclienthudelem( self );
    self.damage.firedamageoverlay.sort = 9;
    self.damage.firedamageoverlay.x = 0;
    self.damage.firedamageoverlay.y = 0;
    self.damage.firedamageoverlay.alignx = "left";
    self.damage.firedamageoverlay.aligny = "top";
    self.damage.firedamageoverlay.foreground = 0;
    self.damage.firedamageoverlay.lowresbackground = 1;
    self.damage.firedamageoverlay.horzalign = "fullscreen";
    self.damage.firedamageoverlay.vertalign = "fullscreen";
    self.damage.firedamageoverlay.alpha = 0;
    self.damage.firedamageoverlay.enablehudlighting = 1;
    self.damage.firedamageoverlay setshader( "ui_player_pain_fire_overlay", 640, 480 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x2ad6
// Size: 0x1a8
function initfirepainoverlay()
{
    self.damage.firepainoverlay = newclienthudelem( self );
    self.damage.firepainoverlay.sort = 8;
    self.damage.firepainoverlay.x = 0;
    self.damage.firepainoverlay.y = 0;
    self.damage.firepainoverlay.alignx = "left";
    self.damage.firepainoverlay.aligny = "top";
    self.damage.firepainoverlay.foreground = 0;
    self.damage.firepainoverlay.lowresbackground = 1;
    self.damage.firepainoverlay.horzalign = "fullscreen";
    self.damage.firepainoverlay.vertalign = "fullscreen";
    self.damage.firepainoverlay.alpha = 0;
    self.damage.firepainoverlay.enablehudlighting = 1;
    self.damage.firepainoverlay setshader( "ui_player_pain_impact_overlay", 640, 480 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x2c86
// Size: 0x1a8
function initdeathsdooroverlaypulse()
{
    self.damage.deathsdooroverlaypulse = newclienthudelem( self );
    self.damage.deathsdooroverlaypulse.sort = 10;
    self.damage.deathsdooroverlaypulse.x = 0;
    self.damage.deathsdooroverlaypulse.y = 0;
    self.damage.deathsdooroverlaypulse.alignx = "left";
    self.damage.deathsdooroverlaypulse.aligny = "top";
    self.damage.deathsdooroverlaypulse.foreground = 0;
    self.damage.deathsdooroverlaypulse.lowresbackground = 1;
    self.damage.deathsdooroverlaypulse.horzalign = "fullscreen";
    self.damage.deathsdooroverlaypulse.vertalign = "fullscreen";
    self.damage.deathsdooroverlaypulse.alpha = 0;
    self.damage.deathsdooroverlaypulse.enablehudlighting = 1;
    self.damage.deathsdooroverlaypulse setshader( "ui_player_pain_deathsdoor_pulse_overlay", 640, 480 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x2e36
// Size: 0x1a7
function initbloodoverlay()
{
    self.damage.bloodoverlay = newclienthudelem( self );
    self.damage.bloodoverlay.sort = 11;
    self.damage.bloodoverlay.x = 0;
    self.damage.bloodoverlay.y = 0;
    self.damage.bloodoverlay.alignx = "left";
    self.damage.bloodoverlay.aligny = "top";
    self.damage.bloodoverlay.foreground = 0;
    self.damage.bloodoverlay.lowresbackground = 1;
    self.damage.bloodoverlay.horzalign = "fullscreen";
    self.damage.bloodoverlay.vertalign = "fullscreen";
    self.damage.bloodoverlay.alpha = 0;
    self.damage.bloodoverlay.enablehudlighting = 0;
    self.damage.bloodoverlay setshader( "ui_player_pain_blood_overlay", 640, 480 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x2fe5
// Size: 0xec
function initplayerfocus()
{
    self.focus = spawnstruct();
    self.focus.enemies = [];
    self.focus.additionalents = [];
    self.focus.buttonhelddown = 0;
    self.focus.usedonce = 0;
    self.focus.timeadjust = 0;
    self.focus.disabled = 0;
    self.focus.speed = 0;
    forcesetamount( 0 );
    set_focus_objectives_update_display( 0 );
    set_focus_infinite_hold( 0 );
    setomnvar( "ui_show_objectives", 0 );
    setsaveddvar( @"objectivealphaenabled", 1 );
    setsaveddvar( @"objectivealpha", 0 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x30d9
// Size: 0x22
function initplayerfoley()
{
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x3103
// Size: 0x63
function initplayerdefaultsettings()
{
    self allowdoublejump( 0 );
    self allowwallrun( 0 );
    self enabledeathshield( 1 );
    player_movement_state();
    registersharedfunc( "player", "getTakeCoverWarnings", &gettakecoverwarnings );
    registersharedfunc( "player", "setTakeCoverWarnings", &settakecoverwarnings );
    utility::setcoverwarningcount();
    scripts\sp\player_stats::init_stats();
    initarmor();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x316e
// Size: 0x77
function watchweaponswap()
{
    self endon( "death" );
    weaponcallbackparams = spawnstruct();
    
    for ( lastweapon = undefined; true ; lastweapon = weapon )
    {
        weapon = self getcurrentweapon();
        weaponcallbackparams.lastweapon = lastweapon;
        weaponcallbackparams.weapon = weapon;
        callback::callback( "player_weapon_change", weaponcallbackparams );
        self waittill( "weapon_change" );
        updateviewkickscale();
    }
}

/#

    // Namespace player / scripts\sp\player
    // Params 0
    // Checksum 0x0, Offset: 0x31ed
    // Size: 0xbb, Type: dev
    function function_194fb483a3eec865()
    {
        while ( true )
        {
            self waittill( "<dev string:x1c>", amount );
            
            foreach ( name, type in self.ammo )
            {
                if ( playerlootenabled() )
                {
                    scripts\sp\loot::waittillnextloottime();
                    scripts\sp\loot::playlootsound( name );
                    
                    if ( level.loot.types[ name ].createnotification )
                    {
                        thread scripts\sp\loot::createnotification( name );
                    }
                }
                
                setammonameamount( name, getammonamemaxamount( name ) );
            }
        }
    }

#/

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x32b0
// Size: 0x76
function getammonameamount( ammoname )
{
    amount = 0;
    
    foreach ( weapon in self getweaponslistprimaries() )
    {
        if ( getammoname( weapon ) == ammoname )
        {
            amount = self getweaponammostock( weapon );
            break;
        }
    }
    
    return amount;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x332f
// Size: 0x87
function getammonamemaxamount( ammoname )
{
    amount = 0;
    
    foreach ( weapon in self getweaponslistprimaries() )
    {
        if ( getammoname( weapon ) == ammoname )
        {
            if ( weapon.maxammo > amount )
            {
                amount = weapon.maxammo;
            }
        }
    }
    
    return amount;
}

// Namespace player / scripts\sp\player
// Params 2
// Checksum 0x0, Offset: 0x33bf
// Size: 0x6e
function setammonameamount( ammoname, amount )
{
    foreach ( weapon in self getweaponslistprimaries() )
    {
        if ( getammoname( weapon ) == ammoname )
        {
            self setweaponammostock( weapon, amount );
        }
    }
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x3435
// Size: 0x41
function getammoname( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return undefined;
    }
    
    if ( isnullweapon( weapon ) )
    {
        return undefined;
    }
    
    ammoname = getweaponammopoolname( weapon );
    ammoname = attachmentammonamehack( ammoname );
    ammoname = localizeammonamehack( ammoname );
    return ammoname;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x347f
// Size: 0x90
function localizeammonamehack( ammoname )
{
    if ( ammoname == %".45 acp" )
    {
        return %".45 acp";
    }
    else if ( ammoname == %"12 gauge" )
    {
        return %"12 gauge";
    }
    else if ( ammoname == %"rocket" )
    {
        return %"rocket";
    }
    else if ( ammoname == %"hash_1c4243c41b2e739b" )
    {
        return %"hash_1c4243c41b2e739b";
    }
    else if ( ammoname == %"hash_71e5eeb8b03626c2" )
    {
        return %"hash_71e5eeb8b03626c2";
    }
    
    return ammoname;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x3518
// Size: 0x42
function attachmentammonamehack( ammoname )
{
    if ( ammoname == %"ub_mike203" || ammoname == %"ub_flare" || ammoname == %"ub_golf25" )
    {
        return %"hash_71e5eeb8b03626c2";
    }
    
    return ammoname;
}

/#

    // Namespace player / scripts\sp\player
    // Params 0
    // Checksum 0x0, Offset: 0x3563
    // Size: 0xaf, Type: dev
    function function_dad68fb5c4e5d2c1()
    {
        setdvar( @"hash_458d682e4c270c67", "<dev string:x26>" );
        loadoutfunctions = [];
        loadoutfunctions[ "<dev string:x27>" ] = &weaponswap;
        loadoutfunctions[ "<dev string:x2e>" ] = &setarmor;
        loadoutfunctions[ "<dev string:x34>" ] = &setarmorplate;
        loadoutfunctions[ "<dev string:x3f>" ] = &offhandswap;
        loadoutfunctions[ "<dev string:x47>" ] = &offhandremover;
        
        while ( true )
        {
            newrequest = getdvar( @"hash_458d682e4c270c67" );
            
            if ( newrequest != "<dev string:x26>" )
            {
                updateplayerloadout( loadoutfunctions, newrequest );
                setdvar( @"hash_458d682e4c270c67", "<dev string:x26>" );
            }
            
            waitframe();
        }
    }

    // Namespace player / scripts\sp\player
    // Params 0
    // Checksum 0x0, Offset: 0x361a
    // Size: 0x20f, Type: dev
    function function_31a13be1530a809b()
    {
        setdvarifuninitialized( @"debug_deathsdoor", 0 );
        self.debughealthhud = spawnstruct();
        self.debughealthhud.var_946b001669de27fb = [];
        self.debughealthhud.active = 0;
        self.debughealthhud.overkill = 0;
        
        while ( !isdefined( self.damage.firedamage ) && !isdefined( level.audio ) )
        {
            waitframe();
        }
        
        while ( true )
        {
            if ( getdvarint( @"player_debughealth" ) && !self.debughealthhud.active )
            {
                thread function_cdac508141881a7c();
                self.debughealthhud.active = 1;
            }
            
            if ( !getdvarint( @"player_debughealth" ) && self.debughealthhud.active )
            {
                self notify( "<dev string:x55>" );
                
                foreach ( hudelm in self.debughealthhud.var_946b001669de27fb )
                {
                    self.debughealthhud.var_946b001669de27fb = array_remove( self.debughealthhud.var_946b001669de27fb, hudelm );
                    hudelm destroy();
                }
                
                self.debughealthhud.active = 0;
            }
            
            if ( getdvarint( @"debug_deathsdoor" ) && !istrue( self.debug_deathsdoor ) )
            {
                self.debug_deathsdoor = 1;
                do_damage( 1, self.origin );
            }
            
            if ( !getdvarint( @"debug_deathsdoor" ) && istrue( self.debug_deathsdoor ) )
            {
                self.debug_deathsdoor = 0;
            }
            
            waitframe();
        }
    }

    // Namespace player / scripts\sp\player
    // Params 0
    // Checksum 0x0, Offset: 0x3831
    // Size: 0x45b, Type: dev
    function function_cdac508141881a7c()
    {
        self endon( "<dev string:x55>" );
        x_start = -90;
        y = 400;
        fontscale = 1;
        function_6840973f983f0bae( "<dev string:x6d>", "<dev string:x78>" );
        function_6840973f983f0bae( "<dev string:x87>", "<dev string:x8e>" );
        function_6840973f983f0bae( "<dev string:x98>", "<dev string:xa3>" );
        function_6840973f983f0bae( "<dev string:xb2>", "<dev string:xbd>" );
        colorfiredamagemin = ( 1, 1, 1 );
        var_ae3f90b5a65ddb1 = ( 1, 1, 0 );
        var_b08050b5a8e72cd = ( 1, 0, 0 );
        var_8153fff453d53ba = ( 1, 0, 0 );
        var_83829ff45636b10 = ( 0, 1, 0 );
        
        while ( true )
        {
            waittillframeend();
            normfire = math::normalize_value( 0, 100, self.damage.firedamage );
            
            if ( normfire > 0.5 )
            {
                color = math::factor_value( var_ae3f90b5a65ddb1, var_b08050b5a8e72cd, ( normfire - 0.5 ) * 2 );
            }
            else
            {
                color = math::factor_value( colorfiredamagemin, var_ae3f90b5a65ddb1, normfire * 2 );
            }
            
            self.debughealthhud.var_946b001669de27fb[ "<dev string:x6d>" ] setvalue( self.damage.firedamage );
            self.debughealthhud.var_946b001669de27fb[ "<dev string:x6d>" ].color = color;
            
            if ( utility::damageflag( 2 ) )
            {
                color = ( 1, 0, 0 );
            }
            else
            {
                color = ( 0, 1, 0 );
            }
            
            self.debughealthhud.var_946b001669de27fb[ "<dev string:x87>" ] setvalue( self.health );
            self.debughealthhud.var_946b001669de27fb[ "<dev string:x87>" ].color = color;
            normfire = math::normalize_value( 0, 100, self.damage.firehealth );
            color = math::factor_value( var_8153fff453d53ba, var_83829ff45636b10, normfire );
            self.debughealthhud.var_946b001669de27fb[ "<dev string:x98>" ] setvalue( self.damage.firehealth );
            self.debughealthhud.var_946b001669de27fb[ "<dev string:x98>" ].color = color;
            
            if ( isalive( self ) )
            {
                if ( utility::damageflag( 2 ) )
                {
                    if ( utility::damageflag( 1 ) )
                    {
                        deathshieldtime = getdeathsshieldduration();
                        self.debughealthhud.var_946b001669de27fb[ "<dev string:xb2>" ] settext( "<dev string:xcb>" + deathshieldtime + "<dev string:xdd>" );
                        self.debughealthhud.var_946b001669de27fb[ "<dev string:xb2>" ].color = ( 0, 1, 0 );
                    }
                    else
                    {
                        deathsdoortime = getdeathsdoorduration();
                        self.debughealthhud.var_946b001669de27fb[ "<dev string:xb2>" ] settext( "<dev string:xe6>" + deathsdoortime + "<dev string:xdd>" );
                        self.debughealthhud.var_946b001669de27fb[ "<dev string:xb2>" ].color = ( 1, 0, 0 );
                    }
                }
                else
                {
                    self.debughealthhud.var_946b001669de27fb[ "<dev string:xb2>" ] settext( "<dev string:xf5>" );
                    self.debughealthhud.var_946b001669de27fb[ "<dev string:xb2>" ].color = ( 0.75, 0.75, 0.75 );
                }
            }
            else
            {
                self.debughealthhud.var_946b001669de27fb[ "<dev string:xb2>" ] settext( "<dev string:xf9>" );
                self.debughealthhud.var_946b001669de27fb[ "<dev string:xb2>" ].color = ( 0.5, 0.5, 0.5 );
            }
            
            waitframe();
        }
    }

    // Namespace player / scripts\sp\player
    // Params 2
    // Checksum 0x0, Offset: 0x3c94
    // Size: 0xb6, Type: dev
    function function_d04335746de340a9( reason, amount )
    {
        if ( !getdvarint( @"player_debughealth" ) )
        {
            return;
        }
        
        if ( !isdefined( reason ) )
        {
            reason = "<dev string:xfe>";
        }
        
        if ( !isdefined( amount ) )
        {
            amount = "<dev string:x12e>";
        }
        else
        {
            amount = "<dev string:x130>" + amount;
        }
        
        function_6840973f983f0bae( "<dev string:x13c>", "<dev string:x142>" );
        self.debughealthhud.var_946b001669de27fb[ "<dev string:x13c>" ] settext( "<dev string:x14a>" + reason + amount );
        self.debughealthhud.var_946b001669de27fb[ "<dev string:x13c>" ].color = ( 1, 0, 0 );
    }

    // Namespace player / scripts\sp\player
    // Params 2
    // Checksum 0x0, Offset: 0x3d52
    // Size: 0x111, Type: dev
    function function_6840973f983f0bae( id, label )
    {
        ybase = 75;
        rowspacing = 15;
        yoffset = self.debughealthhud.var_946b001669de27fb.size * rowspacing;
        hudelm = newclienthudelem( self );
        hudelm.sort = 10;
        hudelm.x = 10;
        hudelm.y = ybase + yoffset;
        hudelm.fontscale = 1;
        hudelm.alignx = "<dev string:x155>";
        hudelm.aligny = "<dev string:x15a>";
        hudelm.horzalign = "<dev string:x15e>";
        hudelm.vertalign = "<dev string:x15e>";
        hudelm.sort = 1;
        hudelm.label = label;
        self.debughealthhud.var_946b001669de27fb[ id ] = hudelm;
    }

    // Namespace player / scripts\sp\player
    // Params 2
    // Checksum 0x0, Offset: 0x3e6b
    // Size: 0x6a, Type: dev
    function updateplayerloadout( loadoutfunctions, newrequest )
    {
        tokens = strtok( newrequest, "<dev string:x169>" );
        type = tokens[ 0 ];
        request = tokens[ 1 ];
        
        if ( isdefined( loadoutfunctions[ type ] ) )
        {
            [[ loadoutfunctions[ type ] ]]( request );
            return;
        }
        
        assertmsg( type + "<dev string:x16b>" );
    }

    // Namespace player / scripts\sp\player
    // Params 1
    // Checksum 0x0, Offset: 0x3edd
    // Size: 0x3c, Type: dev
    function weaponswap( weapon )
    {
        currentweapon = self getcurrentprimaryweapon();
        
        if ( isdefined( currentweapon ) )
        {
            take_weapon( currentweapon );
        }
        
        self giveweapon( weapon );
        self switchtoweaponimmediate( weapon );
    }

    // Namespace player / scripts\sp\player
    // Params 1
    // Checksum 0x0, Offset: 0x3f21
    // Size: 0x26, Type: dev
    function setarmor( amount )
    {
        setarmoramount( int( amount ) );
        self.hadarmor = 1;
    }

    // Namespace player / scripts\sp\player
    // Params 1
    // Checksum 0x0, Offset: 0x3f4f
    // Size: 0x2f, Type: dev
    function setarmorplate( amount )
    {
        setarmorplateamount( self.armor.plates + int( amount ) );
    }

    // Namespace player / scripts\sp\player
    // Params 1
    // Checksum 0x0, Offset: 0x3f86
    // Size: 0x28, Type: dev
    function offhandremover( slot )
    {
        offhand = self getcurrentoffhand( slot );
        take_offhand( offhand );
    }

#/

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x3fb6
// Size: 0x162
function goprohelmetprecache( helmetmodel, overlay, vision )
{
    if ( isdefined( helmetmodel ) )
    {
        precachemodel( helmetmodel );
        level.player.goprohelmet = helmetmodel;
    }
    
    if ( isdefined( overlay ) )
    {
        precacheshader( overlay );
        level.player.goprooverlay = newclienthudelem( level.player );
        level.player.goprooverlay.sort = 0;
        level.player.goprooverlay.foreground = 0;
        level.player.goprooverlay.horzalign = "fullscreen";
        level.player.goprooverlay.vertalign = "fullscreen";
        level.player.goprooverlay.alpha = 0;
        level.player.goprooverlay.enablehudlighting = 1;
        level.player.goprooverlay setshader( overlay, 640, 480 );
    }
    
    level.player.goprovision = vision;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x4120
// Size: 0x13
function goprotest()
{
    level.player thread goproplayerthread();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x413b
// Size: 0x41
function goproplayerthread()
{
    self endon( "death" );
    togglebutton = "dpad_right";
    
    while ( true )
    {
        buttondebounce( togglebutton );
        thread goprohelmet();
        buttondebounce( togglebutton );
        thread gopronone();
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x4184
// Size: 0xd3
function goprohelmet()
{
    self notify( "new_Gopro" );
    helmet = undefined;
    goprocamerasettings( 1 );
    global_offset = ( 0, 0, 0 );
    offset_gun = ( -3, -1, 5 ) + global_offset;
    offset_helmet = ( 10, 5, -10 ) + global_offset;
    
    if ( isdefined( self.goprohelmet ) )
    {
        helmet = spawn( "script_model", self.origin );
        helmet setmodel( self.goprohelmet );
        helmet linktoplayerview( self, "tag_origin", offset_helmet, ( -90, 90, 0 ), 1, "view_jostle" );
    }
    
    self waittill( "new_Gopro" );
    
    if ( isdefined( helmet ) )
    {
        helmet delete();
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x425f
// Size: 0x12
function gopronone()
{
    goprocamerasettings( 0 );
    self notify( "new_Gopro" );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x4279
// Size: 0x265
function goprocamerasettings( state )
{
    if ( state )
    {
        level.player modifybasefov( 85, 0.05 );
        setsaveddvar( @"cg_fov", 85 );
        
        if ( isdefined( self.goprovision ) )
        {
            visionsetfadetoblack( self.goprovision, 0 );
        }
        
        if ( isdefined( self.goprooverlay ) )
        {
            self.goprooverlay.alpha = 1;
        }
        
        givegoproattachments();
        setsaveddvar( @"hash_ed28298c207316ae", 0.1585 );
        setsaveddvar( @"hash_979b5474be3b9b47", -0.478 );
        setsaveddvar( @"hash_960ef00238357bbc", 0.014 );
        setsaveddvar( @"hash_83bbe73116f488d6", 1 );
        setsaveddvar( @"hash_c533867ac3fdc690", 6 );
        setsaveddvar( @"hash_94d94e451d01da61", 8 );
        setsaveddvar( @"hash_d026a87a69c3281c", 2 );
        setsaveddvar( @"hash_d50a0278d87ca09d", 2.1 );
        setsaveddvar( @"hash_ea4c44a08cd23d5d", 2 );
        setomnvar( "ui_hide_hud", 1 );
        setsaveddvar( @"cg_drawcrosshair", 0 );
        return;
    }
    
    level.player modifybasefov( 65, 0.05 );
    setsaveddvar( @"cg_fov", 65 );
    
    if ( isdefined( self.goprovision ) )
    {
        visionsetfadetoblack( "", 0 );
    }
    
    if ( isdefined( self.goprooverlay ) )
    {
        self.goprooverlay.alpha = 0;
    }
    
    takegoproattachments();
    setsaveddvar( @"hash_ed28298c207316ae", 0 );
    setsaveddvar( @"hash_979b5474be3b9b47", 0 );
    setsaveddvar( @"hash_960ef00238357bbc", 0 );
    setsaveddvar( @"hash_83bbe73116f488d6", 0 );
    setsaveddvar( @"hash_94d94e451d01da61", 1 );
    setsaveddvar( @"hash_c533867ac3fdc690", 1 );
    setsaveddvar( @"hash_d026a87a69c3281c", 1 );
    setsaveddvar( @"hash_d50a0278d87ca09d", 1 );
    setsaveddvar( @"hash_ea4c44a08cd23d5d", 1 );
    setomnvar( "ui_hide_hud", 0 );
    setsaveddvar( @"cg_drawcrosshair", 1 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x44e6
// Size: 0xe2
function givegoproattachments()
{
    if ( isdefined( self.goprohasattachments ) )
    {
        return;
    }
    
    currentweapon = self.currentweapon;
    weapons = self.primaryinventory;
    
    foreach ( weapon in weapons )
    {
        attachments = weapon.attachments;
        attachments = array_add( attachments, "gopro_no_ads" );
        attachments = alphabetize( attachments );
        newweapon = make_weapon( getweaponbasename( weapon ), attachments );
        self takeweapon( weapon );
        self giveweapon( newweapon );
    }
    
    switchtoweaponwithbasename( currentweapon );
    self.goprohasattachments = 1;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x45d0
// Size: 0xe1
function takegoproattachments()
{
    if ( !isdefined( self.goprohasattachments ) )
    {
        return;
    }
    
    currentweapon = self.currentweapon;
    weapons = self.primaryinventory;
    
    foreach ( weapon in weapons )
    {
        attachments = weapon.attachments;
        attachments = array_remove( attachments, "gopro_no_ads" );
        attachments = alphabetize( attachments );
        newweapon = make_weapon( getweaponbasename( weapon ), attachments );
        self takeweapon( weapon );
        self giveweapon( newweapon );
    }
    
    switchtoweaponwithbasename( currentweapon );
    self.goprohasattachments = undefined;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x46b9
// Size: 0x7b
function switchtoweaponwithbasename( weapontocheck )
{
    weapons = self.primaryinventory;
    
    foreach ( weapon in weapons )
    {
        if ( getweaponbasename( weapon ) == getweaponbasename( weapontocheck ) )
        {
            self switchtoweaponimmediate( weapon );
            break;
        }
    }
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x473c
// Size: 0x41
function buttondebounce( button )
{
    while ( !level.player buttonpressed( button ) )
    {
        wait 0.05;
    }
    
    while ( level.player buttonpressed( button ) )
    {
        wait 0.05;
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x4785
// Size: 0x24
function ladderpistol()
{
    setsaveddvar( @"ladderenableweapon", 1 );
    setsaveddvar( @"hash_cb9877bb7c7c0aa7", 1 );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x47b1
// Size: 0x67
function managereloadammo( currentgun )
{
    clipcount = self getweaponammoclip( currentgun );
    maxclip = weaponclipsize( currentgun );
    ammostock = self getammocount( currentgun ) - clipcount;
    var_1eed17ddcd10f1a9 = maxclip - clipcount;
    ammostock -= var_1eed17ddcd10f1a9;
    self setweaponammostock( currentgun, ammostock );
    self setweaponammoclip( currentgun, maxclip );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x4820
// Size: 0x28
function playeraltweapon()
{
    enableplayeraltweapon();
    val::register( "weapon_alt_mode", 1, 1, "$self", &enableplayeraltweapon, "$value" );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x4850
// Size: 0x37
function enableplayeraltweapon( enabled )
{
    if ( !isdefined( enabled ) )
    {
        enabled = 1;
    }
    
    if ( enabled )
    {
        self setactionslot( 3, "altMode" );
        return;
    }
    
    self setactionslot( 3, "" );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x488f
// Size: 0x20
function playerdamagemain()
{
    updatedamageindicatortype();
    
    if ( !isdefined( self.damage_functions ) )
    {
        self.damage_functions = [];
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x48b7
// Size: 0x1e
function armorbroke()
{
    return ter_op( self.hadarmor && !hasarmor(), 1, 0 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x48de
// Size: 0x33
function maintainhealthfloor()
{
    if ( self.health > 0 && self.health < 2 )
    {
        set_normalhealth( 2 / self.maxhealth );
    }
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x4919
// Size: 0x4f
function ondeathfinalhit( attacker, type, damage )
{
    if ( type != "MOD_FIRE" )
    {
        thread damagebloodoverlaydirectional( attacker.origin, type, 60 );
    }
    
    thread deathsdooroverlaypulsefinal();
    
    /#
        function_d04335746de340a9( type, damage );
    #/
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x4970
// Size: 0x81
function damagefunctions( type )
{
    switch ( type )
    {
        case #"hash_d8646db4e6ee3658":
            return [ &damagefire, &regeneratehealth ];
        default:
            return [ &defaultdamagenotify, &shouldkillimmediatly, &damageinvulnerability, &deathshieldinvulnerability, &regeneratehealth, &damageeffects, &takecoverwarning ];
    }
}

// Namespace player / scripts\sp\player
// Params 8
// Checksum 0x0, Offset: 0x49f9
// Size: 0x4b
function defaultdamagenotify( damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage )
{
    self notify( "defaultDamage" );
}

// Namespace player / scripts\sp\player
// Params 8
// Checksum 0x0, Offset: 0x4a4c
// Size: 0x35a
function dispersedamagedefault( node, damage, attacker, direction, point, type, objweapon, inflictor )
{
    var_1ec0dfb9527e6635 = isdefined( attacker ) && istrue( attacker.var_7a35ca824ce166e3 );
    
    if ( !var_1ec0dfb9527e6635 )
    {
        damage = handleexplosivedamage( damage, type, objweapon );
        damage = utility::handlemeleedamage( objweapon, type, damage );
    }
    
    if ( hasarmor() && armorprotectsdamagetype( type, objweapon ) )
    {
        lastarmor = min( getarmoramount(), getarmormaxamount() );
        inversearmorratio = 1 - getarmoramount() / getarmormaxamount();
        armordamagetohealthratio = math::factor_value( self.gs.armordamagetohealthratiomin, self.gs.armordamagetohealthratiomax, inversearmorratio );
        var_1f64448b420572a4 = min( damage * 2.5, lastarmor );
        var_94df9d4cf117c6df = var_1f64448b420572a4 * armordamagetohealthratio;
        overflow = damage - lastarmor;
        
        if ( overflow > 0 )
        {
            var_ddf0cb2b266da061 = self.gs.damagemultiplierhealth / self.gs.damagemultiplierarmor;
            overflow *= var_ddf0cb2b266da061;
        }
        else
        {
            overflow = 0;
        }
        
        var_94df9d4cf117c6df += overflow;
        finalarmor = clamp( lastarmor - var_1f64448b420572a4, 0, getarmormaxamount() );
        setarmoramount( finalarmor );
    }
    else if ( type == "MOD_FIRE" )
    {
        firedamagemin = 3.5;
        var_94df9d4cf117c6df = 0;
        firedamage = damage * 1 / self.damagemultiplier;
        
        if ( firedamage < firedamagemin )
        {
            firedamage = firedamagemin;
        }
        
        self.damage.firedamage += firedamage * getfireengulfrate();
        self.damage.firedamage = min( self.damage.firedamage, 100 );
    }
    else if ( shouldflashinvul( type ) )
    {
        var_94df9d4cf117c6df = 0;
    }
    else
    {
        var_94df9d4cf117c6df = damage;
    }
    
    overkilldamage = max( var_94df9d4cf117c6df - self.lasthealth, 0 );
    
    if ( isbulletdamage( type ) && isdefined( attacker ) && isai( attacker ) && isalive( attacker ) )
    {
        addbattlechatternotify( attacker, undefined, "shot_at_target", "target_wounded" );
    }
    
    if ( !istrue( self.var_91921c3ae8981de2 ) && isspreadweapon( objweapon ) && self.lasthealth > self.maxhealth * 0.8 )
    {
        overkilldamage = 0;
    }
    
    finalhealth = clamp( self.lasthealth - var_94df9d4cf117c6df, 1, self.maxhealth );
    set_normalhealth( finalhealth / self.maxhealth );
    calldamagefunctions( node.var_11f23d2919cdd79d, damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage );
    return overkilldamage;
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x4daf
// Size: 0x7c
function handleexplosivedamage( damage, type, objweapon )
{
    if ( !isexplosivedamage( type ) )
    {
        return damage;
    }
    
    if ( isdefined( objweapon ) && isdefined( objweapon.basename ) && objweapon.basename == "flash" )
    {
        return 0;
    }
    
    return damage * self.gs.damagemultiplierexplosive * self.gs.basehealthexplosivedamagemultiplier;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x4e34
// Size: 0x46, Type: bool
function shouldflashinvul( type )
{
    flashinvultypes = [ "MOD_RIFLE_BULLET", "MOD_PISTOL_BULLET" ];
    
    if ( isdefined( self.flashinvul ) && array_contains( flashinvultypes, type ) )
    {
        return true;
    }
    
    return false;
}

// Namespace player / scripts\sp\player
// Params 8
// Checksum 0x0, Offset: 0x4e83
// Size: 0xae
function damagefire( damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage )
{
    self notify( "damage_fire" );
    self endon( "damage_fire" );
    
    if ( !utility::damageflag( 32 ) )
    {
        thread setplayeronfire( attacker, inflictor );
    }
    
    if ( !utility::damageflag( 16 ) )
    {
        thread setplayerinfire();
    }
    
    wait 0.1;
    
    if ( utility::damageflag( 16 ) )
    {
        thread setplayeroutoffire();
    }
    
    lerpoutfireintensity();
    
    if ( utility::damageflag( 32 ) )
    {
        thread setplayerofffire();
    }
}

// Namespace player / scripts\sp\player
// Params 2
// Checksum 0x0, Offset: 0x4f39
// Size: 0x100
function firehealth( attacker, inflictor )
{
    self endon( "death" );
    self endon( "damage_fire_off" );
    wait 0.05;
    timer = 0;
    firehealthfloat = self.damage.firehealth;
    
    while ( true )
    {
        deathtime = getfireinvulseconds();
        
        if ( self.damage.firedamage >= 100 )
        {
            timer += 0.05;
        }
        else
        {
            timer -= 0.05;
        }
        
        timer = clamp( timer, 0, deathtime );
        firehealthfloat = ( 1 - timer / deathtime ) * 100;
        firehealthfloat = clamp( firehealthfloat, 0, 100 );
        self.damage.firehealth = math::round_float( firehealthfloat, 0 );
        
        if ( self.damage.firehealth == 0 )
        {
            killplayer( attacker, "MOD_FIRE", inflictor, "fire" );
        }
        
        waitframe();
    }
}

// Namespace player / scripts\sp\player
// Params 2
// Checksum 0x0, Offset: 0x5041
// Size: 0x30
function setplayeronfire( attacker, inflictor )
{
    utility::setdamageflag( 32, 1 );
    thread firehealth( attacker, inflictor );
    thread firedamagefx();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x5079
// Size: 0x1b
function setplayerofffire()
{
    self notify( "damage_fire_off" );
    utility::setdamageflag( 32, 0 );
    firedamagefxoff();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x509c
// Size: 0x15
function setplayerinfire()
{
    utility::setdamageflag( 16, 1 );
    thread firedamagegesture();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x50b9
// Size: 0x13
function setplayeroutoffire()
{
    utility::setdamageflag( 16, 0 );
    firedamagegesturesoff();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x50d4
// Size: 0x8d
function firedamagegesture()
{
    if ( !shouldplayfiregesture() )
    {
        return;
    }
    
    level.player forceplaygestureviewmodel( "ges_player_onfire", undefined, 0.75 );
    level.player val::set( "onfire", "ads", 0 );
    level.player val::set( "onfire", "reload", 0 );
    level.player val::set( "onfire", "autoreload", 0 );
    level.player.firegesture = 1;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x5169
// Size: 0x5c
function firedamagegesturesoff()
{
    if ( !isdefined( level.player.firegesture ) )
    {
        return;
    }
    
    level.player stopgestureviewmodel( "ges_player_onfire", 0.5, 0 );
    level.player val::reset_all( "onfire" );
    level.player.firegesture = undefined;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x51cd
// Size: 0x81, Type: bool
function shouldplayfiregesture()
{
    if ( isnullweapon( level.player getcurrentprimaryweapon() ) )
    {
        return false;
    }
    
    if ( level.player isthrowinggrenade() )
    {
        return false;
    }
    
    if ( level.player islinked() )
    {
        return false;
    }
    
    if ( !level.player isweaponsenabled() )
    {
        return false;
    }
    
    if ( level.player isonladder() )
    {
        return false;
    }
    
    if ( !level.player val::get( "weapon" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x5257
// Size: 0x5e
function initfirevfxent()
{
    self.damage.firevfx = spawn_tag_origin();
    self.damage.firevfx function_a0988f4b4d0099f5( ( 50, 0, 0 ) );
    thread firedamagevfxintensitythink( self.damage.firevfx );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x52bd
// Size: 0x1c
function initfirefxrumbleent()
{
    self.damage.firerumble = get_rumble_ent();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x52e1
// Size: 0x8a
function initfiresfxfire()
{
    self.damage.firesfx = spawn_script_origin();
    self.damage.firesfx function_a0988f4b4d0099f5();
    self.damage.firesfx playloopsound( "fire_damage" );
    self.damage.firesfx scalevolume( 0, 0 );
    self.damage.firesfx scalepitch( 0, 0 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x5373
// Size: 0x8a
function initfiresfxdrone()
{
    self.damage.firedronesfx = spawn_script_origin();
    self.damage.firedronesfx function_a0988f4b4d0099f5();
    self.damage.firedronesfx playloopsound( "fire_damage_drone" );
    self.damage.firedronesfx scalevolume( 0, 0 );
    self.damage.firedronesfx scalepitch( 0, 0 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x5405
// Size: 0x8a
function initfiresfxsmolder()
{
    self.damage.firesmolsfx = spawn_script_origin();
    self.damage.firesmolsfx function_a0988f4b4d0099f5();
    self.damage.firesmolsfx playloopsound( "fire_damage_smolder" );
    self.damage.firesmolsfx scalevolume( 0, 0 );
    self.damage.firesmolsfx scalepitch( 0, 0 );
}

// Namespace player / scripts\sp\player
// Params 2
// Checksum 0x0, Offset: 0x5497
// Size: 0xef
function function_a0988f4b4d0099f5( var_59325d95a0d5d0a7, var_a8d22612edc48539 )
{
    if ( level.player.model == "" )
    {
        parent_ent = level.player getlinkedparent();
        
        if ( isdefined( parent_ent ) )
        {
            if ( parent_ent tagexists( "tag_origin" ) )
            {
                self linkto( parent_ent, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            }
        }
        else
        {
            println( "<dev string:x1d1>" );
        }
        
        return;
    }
    
    origin_offset = ter_op( isdefined( var_59325d95a0d5d0a7 ), var_59325d95a0d5d0a7, ( 0, 0, 0 ) );
    angles_offset = ter_op( isdefined( var_a8d22612edc48539 ), var_a8d22612edc48539, ( 0, 0, 0 ) );
    self linkto( level.player, "tag_origin", origin_offset, angles_offset );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x558e
// Size: 0x4f7
function firedamagefx()
{
    self endon( "damage_fire_off" );
    
    if ( !isdefined( self.damage.firevfx ) )
    {
        initfirevfxent();
    }
    
    if ( !isdefined( self.damage.firerumble ) )
    {
        initfirefxrumbleent();
    }
    
    if ( !isdefined( self.damage.firesfx ) )
    {
        initfiresfxfire();
    }
    
    if ( !isdefined( self.damage.firedronesfx ) )
    {
        initfiresfxdrone();
    }
    
    if ( !isdefined( self.damage.firesmolsfx ) )
    {
        initfiresfxsmolder();
    }
    
    if ( !isdefined( self.damage.firedamageoverlay ) )
    {
        initfiredamageoverlay();
    }
    
    if ( !isdefined( self.damage.firepainoverlay ) )
    {
        initfirepainoverlay();
    }
    
    var_7f95907716ab9868 = 0;
    var_e3128fc679e209da = 0.1;
    var_8835c8515b73d615 = 0;
    
    while ( true )
    {
        waittillframeend();
        normfire = firedamageratio();
        self.damage.firepainoverlay.alpha = math::factor_value( 0.45, 1, normfire );
        
        if ( utility::damageflag( 16 ) )
        {
            var_7f95907716ab9868 = normfire;
            
            if ( !var_8835c8515b73d615 )
            {
                playfxontag( level.g_effect[ "player_onfire_ignite" ], self.damage.firevfx, "tag_origin" );
                thread play_sound_in_space( "fire_damage_start", level.player.origin );
                earthquake( 0.2, 0.4, level.player.origin, 2000 );
                level.player playrumbleonentity( "damage_light" );
                var_8835c8515b73d615 = 1;
            }
        }
        else
        {
            var_7f95907716ab9868 -= var_e3128fc679e209da;
            var_7f95907716ab9868 = max( 0, var_7f95907716ab9868 );
            
            if ( var_8835c8515b73d615 )
            {
                playfxontag( level.g_effect[ "player_offfire_extinguish" ], self.damage.firevfx, "tag_origin" );
                thread play_sound_in_space( "fire_damage_stop", level.player.origin );
                earthquake( 0.1, 0.4, level.player.origin, 2000 );
                level.player playrumbleonentity( "damage_light" );
                var_8835c8515b73d615 = 0;
            }
        }
        
        self.damage.firedamageoverlay.alpha = math::factor_value( 0.45, 1, var_7f95907716ab9868 );
        self.damage.firerumble.intensity = math::factor_value( 0, 0.8, var_7f95907716ab9868 );
        quakemag = math::factor_value( 0.02, 0.15, var_7f95907716ab9868 );
        earthquake( quakemag, 0.2, level.player.origin, 2000 );
        radialdistortion = math::factor_value( 0, -0.01, var_7f95907716ab9868 );
        radialstrength = math::factor_value( 0, 0.02, var_7f95907716ab9868 );
        setsaveddvar( @"hash_ed28298c207316ae", radialdistortion );
        setsaveddvar( @"hash_960ef00238357bbc", radialstrength );
        var_e8969eff0dcb80fd = math::factor_value( 0, 1.1, var_7f95907716ab9868 * var_7f95907716ab9868 );
        var_3ce42a7c66acba32 = math::factor_value( 1.7, 2, var_7f95907716ab9868 );
        self.damage.firedronesfx scalevolume( var_e8969eff0dcb80fd, 0.05 );
        self.damage.firedronesfx scalepitch( var_3ce42a7c66acba32, 0.05 );
        firesfxvol = math::factor_value( 0, 1.7, var_7f95907716ab9868 );
        firesfxpitch = math::factor_value( 0.8, 1.2, var_7f95907716ab9868 );
        self.damage.firesfx scalevolume( firesfxvol, 0.05 );
        self.damage.firesfx scalepitch( firesfxpitch, 0.05 );
        var_778089fdaada72dd = math::factor_value( 0.2, 1.1, normfire );
        var_914418bf31fca312 = math::factor_value( 0.7, 1.3, normfire );
        self.damage.firesmolsfx scalevolume( var_778089fdaada72dd, 0.05 );
        self.damage.firesmolsfx scalepitch( var_914418bf31fca312, 0.05 );
        waitframe();
    }
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x5a8d
// Size: 0xdf
function firedamagevfxintensitythink( fxent )
{
    fxent endon( "death" );
    currentfx = "";
    
    while ( true )
    {
        waittillframeend();
        
        if ( utility::damageflag( 16 ) )
        {
            firevfxnames = getonfirevfxnames();
        }
        else
        {
            firevfxnames = getofffirevfxnames();
        }
        
        var_c59c1d18b26c886e = firevfxnames.size;
        firefxindex = math::round_float( firedamageratio() * var_c59c1d18b26c886e, 0, 1 );
        firefxindex = min( firefxindex, var_c59c1d18b26c886e - 1 );
        firefxindex = int( firefxindex );
        desiredfx = firevfxnames[ firefxindex ];
        
        if ( currentfx != desiredfx )
        {
            if ( currentfx != "" )
            {
                stopfxontag( level.g_effect[ currentfx ], fxent, "tag_origin" );
            }
            
            playfxontag( level.g_effect[ desiredfx ], fxent, "tag_origin" );
            currentfx = desiredfx;
        }
        
        waitframe();
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x5b74
// Size: 0x1e
function getonfirevfxnames()
{
    return [ "player_onfire_small", "player_onfire_med", "player_onfire_large" ];
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x5b9b
// Size: 0x1e
function getofffirevfxnames()
{
    return [ "player_offfire_small", "player_offfire_med", "player_offfire_large" ];
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x5bc2
// Size: 0xd2
function firedamagefxoff()
{
    self.damage.firevfx delete();
    self.damage.firerumble delete();
    thread fadeoverlayanddestroy( self.damage.firedamageoverlay, 1 );
    thread fadeoverlayanddestroy( self.damage.firepainoverlay, 1 );
    thread fadesoundanddelete( self.damage.firesfx, 1 );
    thread fadesoundanddelete( self.damage.firedronesfx, 1 );
    thread fadesoundanddelete( self.damage.firesmolsfx, 1 );
    thread removeradialdistortion( 0.5 );
}

// Namespace player / scripts\sp\player
// Params 2
// Checksum 0x0, Offset: 0x5c9c
// Size: 0x38
function fadesoundanddelete( soundent, fadetime )
{
    self endon( "damage_fire" );
    
    if ( !isdefined( soundent ) )
    {
        return;
    }
    
    soundent scalevolume( 0, fadetime );
    wait fadetime;
    
    if ( !isdefined( soundent ) )
    {
        return;
    }
    
    soundent delete();
}

// Namespace player / scripts\sp\player
// Params 2
// Checksum 0x0, Offset: 0x5cdc
// Size: 0x44
function fadeoverlayanddestroy( overlay, fadetime )
{
    self endon( "damage_fire" );
    
    if ( !isdefined( overlay ) )
    {
        return;
    }
    
    overlay fadeovertime( fadetime );
    overlay.alpha = 0;
    wait fadetime;
    
    if ( !isdefined( overlay ) )
    {
        return;
    }
    
    overlay destroy();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x5d28
// Size: 0x44
function removefiredamageimmediate()
{
    if ( !utility::damageflag( 32 ) )
    {
        return;
    }
    
    self notify( "damage_fire" );
    self.damage.firedamage = 0;
    
    if ( utility::damageflag( 16 ) )
    {
        setplayeroutoffire();
    }
    
    setplayerofffire();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x5d74
// Size: 0x112
function lerpoutfireintensity()
{
    self endon( "damage_fire" );
    firedamagefloat = self.damage.firedamage;
    old_origin = level.player.origin;
    
    while ( self.damage.firedamage > 0 )
    {
        playermovespeed = length( old_origin - level.player.origin );
        var_fb7fbd10123a25d = math::normalize_value( 0, 10, playermovespeed );
        firedecaytime = math::factor_value( 3.5, 3.5, var_fb7fbd10123a25d );
        var_24010786bcc872d5 = 0.05 * 100 / firedecaytime;
        firedamagefloat -= var_24010786bcc872d5;
        firedamagefloat = clamp( firedamagefloat, 0, 100 );
        self.damage.firedamage = math::round_float( firedamagefloat, 0 );
        old_origin = level.player.origin;
        wait 0.05;
    }
}

// Namespace player / scripts\sp\player
// Params 6
// Checksum 0x0, Offset: 0x5e8e
// Size: 0xef
function killplayer( attacker, type, inflictor, reason, amount, objweapon )
{
    if ( !val::get( "death" ) )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"debug_deathsdoor" ) || isgodmode( self ) )
        {
            return;
        }
        
        function_d04335746de340a9( reason, amount );
    #/
    
    self enabledeathshield( 0 );
    self disableinvulnerability();
    
    if ( isdefined( objweapon ) )
    {
        self.overkillweapon = objweapon;
    }
    
    if ( isdefined( inflictor ) && isdefined( type ) )
    {
        self kill( self.origin, attacker, inflictor, type );
        return;
    }
    
    if ( isdefined( inflictor ) )
    {
        self kill( self.origin, attacker, inflictor );
        return;
    }
    
    if ( isdefined( type ) )
    {
        self kill( self.origin, attacker, attacker, type );
        return;
    }
    
    self kill( self.origin, attacker );
}

// Namespace player / scripts\sp\player
// Params 2
// Checksum 0x0, Offset: 0x5f85
// Size: 0x45, Type: bool
function armorprotectsdamagetype( type, objweapon )
{
    if ( type == "MOD_MELEE" )
    {
        return false;
    }
    
    if ( type == "MOD_FALLING" )
    {
        return false;
    }
    
    if ( type == "MOD_TRIGGER_HURT" )
    {
        return false;
    }
    
    if ( type == "MOD_FIRE" )
    {
        return false;
    }
    
    return true;
}

// Namespace player / scripts\sp\player
// Params 8
// Checksum 0x0, Offset: 0x5fd3
// Size: 0xb8
function shouldkillimmediatly( damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage )
{
    if ( shouldoverkill( overkilldamage, type ) )
    {
        killplayer( attacker, type, inflictor, "Excessive Damage", overkilldamage, objweapon );
    }
    
    if ( shouldkillmelee( attacker, type, inflictor ) )
    {
        killplayer( attacker, type, inflictor, "Melee'd while Deathsheild" );
    }
    
    if ( function_2f4eba16f43de70d( attacker, type, inflictor ) )
    {
        killplayer( attacker, type, inflictor, "Explosion damage while Deathsheild" );
    }
    
    if ( shouldkillfalling( damage, type ) )
    {
        killplayer( attacker, type, inflictor, "Fell too far", damage );
    }
}

// Namespace player / scripts\sp\player
// Params 2
// Checksum 0x0, Offset: 0x6093
// Size: 0x56, Type: bool
function shouldoverkill( damage, type )
{
    if ( self.health != 1 )
    {
        return false;
    }
    
    if ( isexplosivedamage( type ) )
    {
        overkillmodifier = 1;
    }
    else
    {
        overkillmodifier = self.damagemultiplier;
    }
    
    if ( damage < 100 * overkillmodifier )
    {
        return false;
    }
    
    return true;
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x60f2
// Size: 0x35, Type: bool
function shouldkillmelee( attacker, type, inflictor )
{
    if ( utility::damageflag( 1 ) && type == "MOD_MELEE" )
    {
        return true;
    }
    
    return false;
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x6130
// Size: 0x6f, Type: bool
function function_2f4eba16f43de70d( attacker, type, inflictor )
{
    explosivetypes = [ "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE", "MOD_GRENADE", "MOD_GRENADE_SPLASH" ];
    
    if ( utility::damageflag( 1 ) && array_contains( explosivetypes, type ) )
    {
        return true;
    }
    
    return false;
}

// Namespace player / scripts\sp\player
// Params 2
// Checksum 0x0, Offset: 0x61a8
// Size: 0x29, Type: bool
function shouldkillfalling( damage, type )
{
    if ( !isdefined( type ) )
    {
        return false;
    }
    
    return type == "MOD_FALLING" && damage == 100;
}

// Namespace player / scripts\sp\player
// Params 8
// Checksum 0x0, Offset: 0x61da
// Size: 0x6e
function damageinvulnerability( damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage )
{
    if ( !shoulddodamageinvulnerabilty() )
    {
        return;
    }
    
    invulnerabletime = getinvultime();
    enabledamageinvulnerability();
    wait invulnerabletime;
    disabledamageinvulnerability();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x6250
// Size: 0x32, Type: bool
function shoulddodamageinvulnerabilty()
{
    if ( ent_flag( "player_zero_attacker_accuracy" ) )
    {
        return false;
    }
    
    if ( self.health == 1 )
    {
        return false;
    }
    
    if ( utility::damageflag( 1 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x628b
// Size: 0x15
function getinvultime()
{
    return self.gs.invultime_ondamage;
}

// Namespace player / scripts\sp\player
// Params 8
// Checksum 0x0, Offset: 0x62a9
// Size: 0x154
function deathshieldinvulnerability( damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage )
{
    if ( !shouldactivatedeathshield() )
    {
        return;
    }
    
    var_e6d2e0c60ac02585 = getdeathsshieldduration();
    deathsdoortime = getdeathsdoorduration();
    
    /#
        if ( getdvarint( @"debug_deathsdoor" ) )
        {
            deathsdoortime = 0;
        }
    #/
    
    utility::setdamageflag( 1, 1 );
    enabledamageinvulnerability();
    enabledeathsdoor();
    wait var_e6d2e0c60ac02585;
    
    /#
        while ( getdvarint( @"debug_deathsdoor" ) )
        {
            waitframe();
        }
    #/
    
    var_a40ccf7bb77cd395 = getdvar( @"bg_falldamageminheight" );
    
    if ( val::get( "death" ) )
    {
        self enabledeathshield( 0 );
        maxfall = getdvarint( @"bg_falldamagemaxheight", 375 );
        setsaveddvar( @"bg_falldamageminheight", int( maxfall - 1 ) );
    }
    
    utility::setdamageflag( 1, 0 );
    disabledamageinvulnerability();
    wait deathsdoortime;
    disabledeathsdoor();
    self enabledeathshield( 1 );
    setsaveddvar( @"bg_falldamageminheight", int( var_a40ccf7bb77cd395 ) );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x6405
// Size: 0x15
function getdeathsdoorduration()
{
    return self.gs.deathsdoorduration;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x6423
// Size: 0x29
function getdeathsshieldduration()
{
    return self.gs.invultime_deathshieldduration * self.gs.scripteddeathshielddurationscale;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x6455
// Size: 0xa2
function enabledeathsdoor()
{
    self.deathsdoor = 1;
    self enableplayerbreathsystem( 0 );
    self notify( "startHeartbeatPulse" );
    utility::setdamageflag( 2, 1 );
    thread scripts\sp\audio::set_deathsdoor();
    early_fade = 0.5;
    overlaytime = getdeathsshieldduration() + getdeathsdoorduration() + gethealthregentime() - early_fade;
    thread deathsdooroverlaypulse( overlaytime );
    fadetime = 0.5;
    holdtime = overlaytime - fadetime;
    thread bloodoverlay( 1, holdtime, fadetime );
    updatedeathsdoorvisionset();
    self painvisionon();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x64ff
// Size: 0x9f
function updatedeathsdoorvisionset()
{
    if ( !utility::damageflag( 2 ) )
    {
        return 0;
    }
    
    if ( level.player isnightvisionon() )
    {
        if ( isdefined( self.damage.var_85b4a9b6802b3a0f ) )
        {
            visionsetpain( self.damage.var_85b4a9b6802b3a0f );
        }
        else
        {
            visionsetpain( "damage_deathsdoor_nvg" );
        }
        
        return;
    }
    
    if ( isdefined( self.damage.var_94afcf2ebc7b6f48 ) )
    {
        visionsetpain( self.damage.var_94afcf2ebc7b6f48 );
        return;
    }
    
    visionsetpain( "damage_deathsdoor" );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x65a6
// Size: 0x96
function disabledeathsdoor( instant )
{
    self notify( "disableDeathsDoor" );
    self endon( "disableDeathsDoor" );
    
    if ( !isdefined( instant ) )
    {
        instant = 0;
    }
    
    if ( !instant )
    {
        lerpouttime = gethealthregentime();
        thread scripts\sp\audio::restore_after_deathsdoor( lerpouttime * 0.2 );
    }
    else
    {
        lerpouttime = 0;
    }
    
    lerpoutrate = getvisionlerprate( lerpouttime );
    setsaveddvar( @"hash_e42b132626b5992b", lerpoutrate );
    self painvisionoff();
    self enableplayerbreathsystem( 1 );
    self.deathsdoor = 0;
    utility::setdamageflag( 2, 0 );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x6644
// Size: 0x7f
function lerpdeathsdoorpulsenorm( outtime )
{
    self notify( "lerpDeathsDoorNorm" );
    self endon( "lerpDeathsDoorNorm" );
    self endon( "death" );
    timer = outtime;
    self.deathsdoorpulsenorm = 1;
    
    while ( timer > 0 )
    {
        self.deathsdoorpulsenorm = math::normalize_value( 0, outtime, timer );
        self.deathsdoorpulsenorm = math::normalized_float_smooth_out( self.deathsdoorpulsenorm );
        timer -= 0.05;
        waitframe();
    }
    
    self.deathsdoorpulsenorm = 0;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x66cb
// Size: 0x23
function enabledamageinvulnerability()
{
    ent_flag_set( "player_zero_attacker_accuracy" );
    self.attackeraccuracy = 0;
    self.ignorerandombulletdamage = 1;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x66f6
// Size: 0x15
function disabledamageinvulnerability()
{
    ent_flag_clear( "player_zero_attacker_accuracy" );
    scripts\sp\gameskill::update_player_attacker_accuracy();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x6713
// Size: 0x5e, Type: bool
function shouldactivatedeathshield()
{
    /#
        if ( getdvarint( @"debug_deathsdoor" ) && !istrue( level.audio.in_deathsdoor ) )
        {
            return true;
        }
    #/
    
    if ( self.health != 1 )
    {
        return false;
    }
    
    if ( utility::damageflag( 1 ) )
    {
        return false;
    }
    
    if ( utility::damageflag( 2 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace player / scripts\sp\player
// Params 8
// Checksum 0x0, Offset: 0x677a
// Size: 0x119
function regeneratehealth( damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage )
{
    self endon( "death" );
    self notify( "regenerateHealth_singleton" );
    self endon( "regenerateHealth_singleton" );
    self endon( "armorUseSuccess" );
    
    if ( !canregenhealth() )
    {
        return;
    }
    
    regendelay = gethealthregendelay();
    self.currentregendelay = regendelay;
    wait regendelay;
    
    while ( utility::damageflag( 2 ) || utility::damageflag( 32 ) )
    {
        waitframe();
    }
    
    finalhealth = self.health;
    
    while ( self.health < self.maxhealth )
    {
        var_24493f7b31ecfbd = gethealthregenpersecond();
        frameregen = var_24493f7b31ecfbd * 0.05;
        finalhealth = clamp( finalhealth + frameregen, 0, self.maxhealth );
        set_normalhealth( finalhealth / self.maxhealth );
        waitframe();
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x689b
// Size: 0x29
function gethealthregenpersecond()
{
    return self.gs.healthregenrate * self.gs.var_f3cb481e3e3b2a24;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x68cd
// Size: 0x15
function getfireinvulseconds()
{
    return self.gs.healthfireinvulseconds;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x68eb
// Size: 0x15
function getfireengulfrate()
{
    return self.gs.healthfireengulfrate;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x6909
// Size: 0x34
function gethealthregentime()
{
    regenamount = self.maxhealth - self.health;
    var_48c07ca96fba732e = regenamount / gethealthregenpersecond();
    return var_48c07ca96fba732e;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x6946
// Size: 0x29
function gethealthregendelay()
{
    return self.gs.healthregendelay * self.gs.var_302587891497f2db;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x6978
// Size: 0x4a, Type: bool
function canregenhealth()
{
    if ( istrue( self.disable_health_regen ) )
    {
        return false;
    }
    
    if ( isdefined( self.gs.armorratiohealthregenthreshold ) && armorratio() > self.gs.armorratiohealthregenthreshold )
    {
        return false;
    }
    
    return true;
}

// Namespace player / scripts\sp\player
// Params 8
// Checksum 0x0, Offset: 0x69cb
// Size: 0xf6
function damageeffects( damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage )
{
    effectfunctions = [ &damagesfx, &damagerumble, &damageradialdistortion, &damagepainvision, &damagescreenshake, &updatedamageoverlay, &damagebloodoverlay, &damageshock ];
    factor = damageratio( damage );
    
    foreach ( function in effectfunctions )
    {
        self childthread [[ function ]]( point, factor, type );
    }
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x6ac9
// Size: 0x113
function damagesfx( origin, factor, type )
{
    self endon( "damageDefault" );
    type = "MOD_MELEE";
    impactsfx = getimpactsfx( type );
    yellsfx = getvocalpainsfx( type );
    
    if ( isdefined( impactsfx ) )
    {
        self.damage.impactsfx playsound( impactsfx );
    }
    
    if ( armorbroke() )
    {
        self.armor.sfx playsound( "plr_armor_gone" );
    }
    
    wait 0.25;
    
    if ( !utility::damageflag( 4 ) )
    {
        volume = math::factor_value( 0.75, 1.75, factor );
        self.damage.impactsfx scalevolume( volume );
        self.damage.impactsfx playsound( yellsfx );
        utility::setdamageflag( 4, 1 );
        delaythread( 3, &setdamageflag, 4, 0 );
    }
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x6be4
// Size: 0x2e
function getimpactsfx( type )
{
    if ( !hasarmor() )
    {
        if ( type == "MOD_MELEE" )
        {
            return;
        }
        
        return "plr_proto_bullet_impact";
    }
    
    return "plr_proto_bullet_impact_armor";
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x6c1a
// Size: 0x23
function getvocalpainsfx( type )
{
    if ( !hasarmor() )
    {
        return "plr_breath_pain_init";
    }
    
    return "plr_proto_yell_armor";
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x6c45
// Size: 0x1b
function stopimpactsfx()
{
    self.damage.impactsfx stopsounds();
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x6c68
// Size: 0x57
function damageshock( origin, factor, type )
{
    if ( isexplosivedamage( type ) && !istrue( self.disableexplosiveshellshock ) )
    {
        duration = math::factor_value( 3, 3, factor );
        self shellshock( "explosion", 3 );
    }
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x6cc7
// Size: 0x40
function damagerumble( origin, factor, type )
{
    if ( factor > 0.4 )
    {
        self playrumbleonentity( "damage_heavy" );
        return;
    }
    
    self playrumbleonentity( "damage_light" );
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x6d0f
// Size: 0x11a
function damagescreenshake( origin, factor, type )
{
    pitch = math::factor_value( 0.82, 1.2, factor );
    yaw = math::factor_value( 0.65, 0.8, factor );
    roll = math::factor_value( 0.68, 1.25, factor );
    duration = math::factor_value( 1.12, 1.85, factor );
    durationup = math::factor_value( 0.1, 0.32, factor );
    durationdown = duration - durationup - 0.05;
    
    if ( isexplosivedamage( type ) )
    {
        pitch *= 5;
        yaw *= 5;
        roll *= 5;
    }
    
    screenshake( origin, pitch, yaw, roll, duration, durationup, durationdown, 0, 1, 0.5, 1 );
    
    if ( armorbroke() )
    {
        earthquake( 0.3, 0.65, self.origin, 5000 );
    }
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x6e31
// Size: 0x8d
function damageradialdistortion( origin, factor, type )
{
    self endon( "stopPainOverlays" );
    
    if ( utility::damageflag( 32 ) )
    {
        return;
    }
    
    distortion = math::factor_value( 0.045, 0.045, factor );
    strength = math::factor_value( 0.09, 0.09, factor );
    outtime = math::factor_value( 0.2, 0.2, factor );
    radial_distortion( distortion, strength, outtime, origin );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x6ec6
// Size: 0x57
function removeradialdistortion( outtime )
{
    childthread lerp_saveddvar( @"hash_ed28298c207316ae", 0, outtime );
    childthread lerp_saveddvar( @"hash_979b5474be3b9b47", 0, outtime );
    childthread lerp_saveddvar( @"hash_960ef00238357bbc", 0, outtime );
    childthread lerp_saveddvar( @"hash_bc02f8e41595c9a8", 0, outtime );
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x6f25
// Size: 0x1cb
function damagepainvision( origin, factor, type )
{
    self endon( "damageDefault" );
    self endon( "death" );
    
    if ( !shoulddopainvision() )
    {
        return 0;
    }
    
    if ( !hasarmor() )
    {
        if ( level.player isnightvisionon() )
        {
            if ( isdefined( self.damage.var_3448f6d5527bfdd0 ) )
            {
                visionsetpain( self.damage.var_3448f6d5527bfdd0 );
            }
            else
            {
                visionsetpain( "damage_nvg" );
            }
        }
        else if ( isdefined( self.damage.scriptedpainvision ) )
        {
            visionsetpain( self.damage.scriptedpainvision );
        }
        else
        {
            visionsetpain( "damage_severe" );
        }
        
        lerpin = math::factor_value( 0, 0, factor );
        lerpout = math::factor_value( 1.9, 1.9, factor );
        holdtime = math::factor_value( 0.05, 0.05, factor );
    }
    else
    {
        if ( isdefined( self.damage.var_4324a9d071ec7a6a ) )
        {
            visionsetpain( self.damage.var_4324a9d071ec7a6a );
        }
        else
        {
            visionsetpain( "damage_armor" );
        }
        
        lerpin = math::factor_value( 0, 0, factor );
        lerpout = math::factor_value( 1.9, 1.9, factor );
        holdtime = math::factor_value( 0.05, 0.05, factor );
    }
    
    setsaveddvar( @"hash_b61c9c6a24b5671e", lerpin );
    setsaveddvar( @"hash_e42b132626b5992b", lerpout );
    self painvisionon();
    wait holdtime;
    self painvisionoff();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x70f8
// Size: 0x22, Type: bool
function shoulddopainvision()
{
    if ( utility::damageflag( 2 ) )
    {
        return false;
    }
    
    if ( self.health == 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x7123
// Size: 0x2e
function damagebloodoverlay( origin, factor, type )
{
    damagebloodoverlaydirectional( origin, type );
    damagebloodoverlayfullscreen( origin, factor, type );
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x7159
// Size: 0x23c
function damagebloodoverlaydirectional( origin, type, outtime )
{
    if ( utility::iswegameplatform() )
    {
        return;
    }
    
    time = gettime();
    
    if ( time - self.damage.lastdiretionalbloodtime < 200 )
    {
        return;
    }
    else
    {
        self.damage.lastdiretionalbloodtime = time;
    }
    
    explosivetypes = [ "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE", "MOD_GRENADE", "MOD_GRENADE_SPLASH" ];
    sides = getplayersidesfromposition( origin );
    materialsuffix = "";
    
    if ( isdefined( self.damage.var_edc58801037437fa ) )
    {
        prefix = self.damage.var_edc58801037437fa;
    }
    else if ( array_contains( explosivetypes, type ) )
    {
        prefix = "fullscreen_dirt_";
    }
    else if ( !hasarmor() )
    {
        prefix = "fullscreen_blood_";
        
        if ( self.damage.altdirectionalbloodoverlay )
        {
            materialsuffix = "_alt";
            self.damage.altdirectionalbloodoverlay = 0;
        }
        else
        {
            self.damage.altdirectionalbloodoverlay = 1;
        }
    }
    else
    {
        prefix = "fullscreen_armor_";
    }
    
    if ( !isdefined( outtime ) )
    {
        outtime = 2;
    }
    
    foreach ( side, type in sides )
    {
        material = prefix + side;
        splashmaterial = material + "_splash";
        material += materialsuffix;
        randomoffsets = createscreeneffectoffsets( randomfloatrange( 0, 1 ), randomfloatrange( 0, 1 ), randomfloatrange( 0, 1 ) );
        createscreeneffectext( side, material, 0.15, outtime, randomoffsets, 1, 1 );
        createscreeneffectext( side, splashmaterial, 0.15, 0.15, randomoffsets, 0, 1 );
    }
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x739d
// Size: 0x75
function damagebloodoverlayfullscreen( origin, factor, type )
{
    if ( utility::damageflag( 2 ) )
    {
        return;
    }
    
    bloodalpha = math::factor_value( 0.6, 0.3, healthratio() );
    holdtime = gethealthregendelay();
    fadetime = gethealthregentime();
    thread bloodoverlay( bloodalpha, holdtime, fadetime );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x741a
// Size: 0x4c
function isexplosivedamage( type )
{
    explosivetypes = [ "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE" ];
    return array_contains( explosivetypes, type );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x746f
// Size: 0x1d, Type: bool
function isspreadweapon( objweapon )
{
    return isdefined( objweapon ) && weaponclass( objweapon ) == "spread";
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x7495
// Size: 0x43
function createscreeneffectoffsets( x, y, scale )
{
    offsets = [];
    offsets[ "x" ] = x;
    offsets[ "y" ] = y;
    offsets[ "scale" ] = scale;
    return offsets;
}

// Namespace player / scripts\sp\player
// Params 6
// Checksum 0x0, Offset: 0x74e1
// Size: 0x41
function createscreeneffect( side, shader, intime, outtime, randomoffsets, fadein )
{
    createscreeneffectext( side, shader, intime, outtime, randomoffsets, fadein, 0 );
}

// Namespace player / scripts\sp\player
// Params 7
// Checksum 0x0, Offset: 0x752a
// Size: 0x277
function createscreeneffectext( side, shader, intime, outtime, randomoffsets, fadein, lowres )
{
    hud = newclienthudelem( self );
    hud.sort = 13;
    hud.foreground = 0;
    hud.lowresbackground = lowres;
    hud.horzalign = "fullscreen";
    hud.vertalign = "fullscreen";
    hud.alpha = 0;
    hud.enablehudlighting = 1;
    x = 0;
    y = 0;
    finalx = 0;
    finaly = 0;
    finalscale = math::factor_value( 0.9, 1.25, randomoffsets[ "scale" ] );
    
    switch ( side )
    {
        case #"hash_c9b3133a17a3b2d0":
            hud.aligny = "top";
            hud.alignx = "left";
            x = -640;
            y = math::factor_value( -30, 30, randomoffsets[ "y" ] );
            finaly = y;
            finalx = math::factor_value( -55, 0, randomoffsets[ "x" ] );
            break;
        case #"hash_96815ce4f2a3dbc5":
            hud.aligny = "top";
            hud.alignx = "right";
            x = 1280;
            y = math::factor_value( -30, 30, randomoffsets[ "y" ] );
            finaly = y;
            finalx = math::factor_value( 0, 55, randomoffsets[ "x" ] ) + 640;
            break;
        case #"hash_dcbcc9b3083fb78a":
            hud.aligny = "bottom";
            hud.alignx = "left";
            y = 960;
            x = math::factor_value( -50, 50, randomoffsets[ "x" ] );
            finaly = math::factor_value( 0, 50, randomoffsets[ "y" ] );
            finaly += 480;
            finalx = x;
            break;
    }
    
    hud.x = x;
    hud.y = y;
    hud setshader( shader, 640, 640 );
    thread screeneffectcleanup( hud );
    thread animatescreeneffect( hud, intime, outtime, finalx, finaly, finalscale, fadein );
}

// Namespace player / scripts\sp\player
// Params 7
// Checksum 0x0, Offset: 0x77a9
// Size: 0x122
function animatescreeneffect( hud, intime, outtime, x, y, scale, fadein )
{
    hud endon( "destroySreenEffectOverlay" );
    
    if ( !fadein )
    {
        hud scaleovertime( intime, int( 640 * scale ), int( 480 * scale ) );
        hud moveovertime( intime );
        hud.x = x;
        hud.y = y;
        intime = 0.05;
        hud.alpha = 1;
        wait 0.05;
    }
    else
    {
        hud scaleovertime( intime, int( 640 * scale ), int( 480 * scale ) );
        hud.x = x;
        hud.y = y;
        wait 0.15;
        hud fadeovertime( intime );
        hud.alpha = 1;
        wait intime;
    }
    
    hud fadeovertime( outtime );
    hud.alpha = 0;
    wait outtime + 0.05;
    hud notify( "destroySreenEffectOverlay" );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x78d3
// Size: 0x76
function screeneffectcleanup( hud )
{
    self.damage.activescreeneffectoverlays = array_add( self.damage.activescreeneffectoverlays, hud );
    hud waittill( "destroySreenEffectOverlay" );
    self.damage.activescreeneffectoverlays = array_remove( self.damage.activescreeneffectoverlays, hud );
    hud destroy();
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x7951
// Size: 0x24f
function updatedamageoverlay( origin, factor, type )
{
    self endon( "damageDefault" );
    self endon( "stopPainOverlays" );
    armor_broke = armorbroke();
    
    if ( isdefined( self.damage.scriptedoverlay ) )
    {
        self.damage.overlay setshader( self.damage.scriptedoverlay, 640, 480 );
        multiplier = 0.6;
    }
    else if ( armor_broke )
    {
        multiplier = 0;
        
        if ( !isdefined( self.damage.armorvfx ) )
        {
            self.damage.armorvfx = spawn_tag_origin();
            self.damage.armorvfx function_a0988f4b4d0099f5( ( 50, 0, 0 ) );
        }
        
        playfxontag( level.g_effect[ "player_armor_break" ], self.damage.armorvfx, "tag_origin" );
    }
    else if ( !hasarmor() )
    {
        self.damage.overlay setshader( "ui_player_pain_damage_overlay", 640, 480 );
        multiplier = 0.8;
    }
    else
    {
        self.damage.overlay setshader( "ui_player_pain_damage_overlay", 640, 480 );
        multiplier = 0.6;
    }
    
    self.damage.overlay fadeovertime( 0.05 );
    self.damage.overlay.alpha = max( self.damage.overlay.alpha, multiplier );
    wait 0.05;
    
    if ( armor_broke )
    {
        fadeouttime = 1;
    }
    else
    {
        fadeouttime = math::factor_value( 0.2, 0.2, factor );
    }
    
    self.damage.overlay fadeovertime( fadeouttime );
    self.damage.overlay.alpha = 0;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x7ba8
// Size: 0x134
function deathsdooroverlaypulse( overlaytime )
{
    self notify( "deathsDoorPulse" );
    self endon( "deathsDoorPulse" );
    self endon( "stopPainOverlays" );
    self endon( "death" );
    pulsealpha = 1;
    thread lerpdeathsdoorpulsenorm( overlaytime );
    
    while ( pulsealpha > 0 )
    {
        time = gettime();
        pulsestarttime = time;
        pulseduration = math::factor_value( 1000, 600, self.deathsdoorpulsenorm );
        
        while ( time < pulsestarttime + pulseduration )
        {
            time = gettime();
            pulsealphamin = 0.1;
            pulsealphamax = 0.4;
            pulsenormalized = ( time - pulsestarttime ) / pulseduration;
            pulsefraction = math::normalized_cos_wave( pulsenormalized );
            pulsealpha = math::factor_value( pulsealphamin, pulsealphamax, pulsefraction );
            pulsealpha *= self.deathsdoorpulsenorm;
            self.damage.deathsdooroverlaypulse fadeovertime( 0.05 );
            self.damage.deathsdooroverlaypulse.alpha = pulsealpha;
            waitframe();
        }
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x7ce4
// Size: 0x85
function deathsdooroverlaypulsefinal()
{
    self.damage.deathsdooroverlaypulse fadeovertime( 0.05 );
    self.damage.deathsdooroverlaypulse.alpha = 0.7;
    waitframe();
    self.damage.deathsdooroverlaypulse fadeovertime( 0.5 );
    self.damage.deathsdooroverlaypulse.alpha = 0.4;
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0x7d71
// Size: 0xd3
function bloodoverlay( alpha, holdtime, fadetime )
{
    if ( utility::iswegameplatform() )
    {
        return;
    }
    
    minfadetime = 0.5;
    
    if ( fadetime <= minfadetime )
    {
        fadetime = minfadetime;
    }
    
    self notify( "deathsDoorOverlay" );
    self endon( "deathsDoorOverlay" );
    self endon( "stopPainOverlays" );
    self endon( "death" );
    self.damage.bloodoverlay fadeovertime( 0.05 );
    self.damage.bloodoverlay.alpha = alpha;
    wait holdtime;
    self.damage.bloodoverlay fadeovertime( fadetime );
    self.damage.bloodoverlay.alpha = 0;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x7e4c
// Size: 0x98
function playpulsesfx( pulseduration )
{
    pulsevolume = math::normalized_to_growth_clamps( 0, 1, self.deathsdoorpulsenorm );
    pulsedelay = pulseduration * 0.8 / 1000;
    self.damage.pulsesfx scalevolume( pulsevolume );
    wait pulsedelay;
    self.damage.pulsesfx stopsounds();
    self.damage.pulsesfx playsound( "proto_heartbeat" );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x7eec
// Size: 0x20, Type: bool
function shoulddohealthdamageeffects( type )
{
    if ( isdefined( type ) && !armorprotectsdamagetype( type ) )
    {
        return true;
    }
    
    return true;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x7f15
// Size: 0xe4
function getplayersidesfromposition( position )
{
    forwardvec = vectornormalize( anglestoforward( self.angles ) );
    rightvec = vectornormalize( anglestoright( self.angles ) );
    var_44ade5cf4179de8f = vectornormalize( ( position[ 0 ], position[ 1 ], 0 ) - ( self.origin[ 0 ], self.origin[ 1 ], 0 ) );
    fdot = vectordot( var_44ade5cf4179de8f, forwardvec );
    rdot = vectordot( var_44ade5cf4179de8f, rightvec );
    sides = [];
    
    if ( abs( fdot ) > 0.819152 )
    {
        sides[ "bottom" ] = 1;
    }
    else if ( rdot > 0 )
    {
        sides[ "right" ] = 1;
    }
    else
    {
        sides[ "left" ] = 1;
    }
    
    return sides;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8002
// Size: 0xd5
function updatearmorui()
{
    self notify( "scr_armorAmountChange" );
    self setclientomnvar( "ui_armor_percent", armorratio() );
    self setclientomnvar( "ui_armor_progress", 0 );
    
    if ( !hasarmor() && function_85e373bb15921966() && !usingarmorplate() )
    {
        self setclientomnvar( "ui_armor_hint", "use_armor" );
    }
    else
    {
        self setclientomnvar( "ui_armor_hint", "hide_armor" );
    }
    
    if ( hasarmor() )
    {
        self setclientomnvar( "ui_armor_red_flash", 0 );
        
        if ( haslowarmor() )
        {
            self setclientomnvar( "ui_armor_warning", "low_armor" );
        }
        else
        {
            self setclientomnvar( "ui_armor_warning", "hide_armor" );
        }
        
        return;
    }
    
    self setclientomnvar( "ui_armor_red_flash", 0.75 );
    self setclientomnvar( "ui_armor_warning", "no_armor" );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x80df
// Size: 0x3a
function gettakecoverwarnings()
{
    takecoverwarnings = 0;
    
    if ( getprojectname() == "JUP" )
    {
        takecoverwarnings = self getplayerprogression( "takeCoverWarnings" );
    }
    else
    {
        takecoverwarnings = self getlocalplayerprofiledata( "takeCoverWarnings" );
    }
    
    return takecoverwarnings;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x8122
// Size: 0x36
function settakecoverwarnings( count )
{
    if ( getprojectname() == "JUP" )
    {
        self setplayerprogression( "takeCoverWarnings", count );
        return;
    }
    
    self setlocalplayerprofiledata( "takeCoverWarnings", count );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8160
// Size: 0x11
function playeroffhandmain()
{
    self endon( "death" );
    childthread scripts\sp\equipment\offhands::offhandfiremanager();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8179
// Size: 0x5d
function usearmorplateinput()
{
    self endon( "death" );
    self endon( "stop_armor_plate_input" );
    childthread function_4e1fffe2ed27a3e8();
    
    while ( utility::playerarmorenabled() )
    {
        self notifyonplayercommand( "armor_pressed", "+armor" );
        self waittill( "armor_pressed" );
        tryusearmor();
    }
    
    self notifyonplayercommandremove( "armor_pressed", "+armor" );
    self notify( "stop_armor_plate_input" );
}

// Namespace player / scripts\sp\player
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x81de
// Size: 0x6a
function private function_4e1fffe2ed27a3e8()
{
    framesheld = 0;
    framesrequired = 5;
    
    for ( var_78f441b541014ef2 = 0; true ; var_78f441b541014ef2 = 1 )
    {
        waitframe();
        
        if ( !self usinggamepad() || !self weaponswitchbuttonpressed() )
        {
            framesheld = 0;
            var_78f441b541014ef2 = 0;
            continue;
        }
        
        framesheld++;
        
        if ( framesheld >= framesrequired && !var_78f441b541014ef2 )
        {
            self notify( "armor_pressed" );
            framesheld = 0;
        }
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8250
// Size: 0x70
function tryusearmor()
{
    if ( !istrue( utility::playerarmorenabled() ) )
    {
        return;
    }
    
    self endon( "death" );
    
    if ( !playercanusearmorplate() )
    {
        level.player setclientomnvar( "ui_armor_warning", "hide_armor" );
        waitframe();
        
        if ( hasmaxarmor() )
        {
            return;
        }
        
        if ( function_85e373bb15921966() == 0 )
        {
            level.player setclientomnvar( "ui_armor_warning", "no_armor" );
        }
        
        return;
    }
    
    thread function_f2a4a5aed60e552d();
}

// Namespace player / scripts\sp\player
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x82c8
// Size: 0x1a, Type: bool
function private playercanusearmorplate()
{
    if ( usingarmorplate() )
    {
        return false;
    }
    
    if ( !caninsertarmor() )
    {
        return false;
    }
    
    return true;
}

// Namespace player / scripts\sp\player
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x82eb
// Size: 0xa4, Type: bool
function private caninsertarmor()
{
    if ( !isalive( self ) || self isparachuting() || self isskydiving() || self isonladder() )
    {
        return false;
    }
    
    if ( self ismeleeing() )
    {
        return false;
    }
    
    if ( !val::get( "armor" ) )
    {
        return false;
    }
    
    if ( !getdvarint( @"hash_bfa6bedc37206c58" ) )
    {
        return false;
    }
    
    if ( hasmaxarmor() )
    {
        return false;
    }
    
    if ( function_34895a6255f4587a() && !function_85e373bb15921966() )
    {
        return false;
    }
    
    if ( isdefined( self.veh ) && self.veh.driver == self )
    {
        return false;
    }
    
    return true;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8398
// Size: 0x2b
function function_46cd39650beb293f()
{
    if ( !isdefined( level.armorobjweapon ) )
    {
        level.armorobjweapon = makeweapon( "iw9_armor_plate_deploy_sp" );
    }
    
    return level.armorobjweapon;
}

// Namespace player / scripts\sp\player
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x83cc
// Size: 0x12d
function private function_f2a4a5aed60e552d()
{
    self endon( "death" );
    
    if ( istrue( self.insertingarmorplate ) || self isswitchingweapon() )
    {
        return;
    }
    
    function_d28eb7f4f8aff36c( 1 );
    applyarmorcancelplayercommands();
    function_43d4382b6cea4df9( 1 );
    self.armor.var_e67f0cc08a262a07 = self getcurrentweapon();
    armorweaponobj = function_46cd39650beb293f();
    var_1c8661e7315eba10 = 0;
    var_7ab9a8f132665d68 = getarmormaxamount();
    armoramount = getarmoramount();
    
    if ( getdvarint( @"hash_d8e69627073e0766" ) )
    {
        iprintln( "Give armor weapon" );
    }
    
    if ( 1 || !function_3ab255ccd3be6392() )
    {
        self giveweapon( armorweaponobj );
    }
    else
    {
        self giveweapon( armorweaponobj, 0, 0, 0, 1 );
        var_1c8661e7315eba10 = 1;
    }
    
    self switchtoweapon( armorweaponobj );
    weaponchanged = function_c29986cfa0913dce();
    
    if ( weaponchanged )
    {
        thread watchcancelnotifies();
        insertarmor( var_1c8661e7315eba10 );
    }
    else if ( getdvarint( @"hash_d8e69627073e0766" ) )
    {
        iprintln( "Give Armor Weapon Canceled!" );
    }
    
    armor_cleanup();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8501
// Size: 0x2e, Type: bool
function function_c29986cfa0913dce()
{
    outcome = waittill_any_return_4( "mantle_start", "scr_change_swim_state", "try_armor_cancel", "weapon_change" );
    return outcome == "weapon_change";
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8538
// Size: 0x4e
function armor_cleanup()
{
    restore_weapon();
    
    if ( getdvarint( @"hash_d8e69627073e0766" ) )
    {
        iprintln( "Restore values and cleanup - FINISHED!" );
    }
    
    function_25aae4d93a36c291();
    function_43d4382b6cea4df9( 0 );
    self.stoparmorinsert = 0;
    self notify( "insertArmorComplete" );
    function_d28eb7f4f8aff36c( 0 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x858e
// Size: 0xfd
function restore_weapon()
{
    if ( getdvarint( @"hash_d8e69627073e0766" ) )
    {
        iprintln( "take armor weapon" );
    }
    
    self takeweapon( function_46cd39650beb293f() );
    self switchtoweapon( self.armor.var_e67f0cc08a262a07 );
    self disableweaponswitch();
    
    for ( i = 0; i < 5 ; i++ )
    {
        if ( self getcurrentweapon() == self.armor.var_e67f0cc08a262a07 )
        {
            break;
        }
        
        waitframe();
        
        if ( getdvarint( @"hash_d8e69627073e0766" ) )
        {
            iprintln( "Waiting for weapon switch" );
        }
    }
    
    if ( self getcurrentweapon() != self.armor.var_e67f0cc08a262a07 )
    {
        if ( getdvarint( @"hash_d8e69627073e0766" ) )
        {
            iprintln( "NUCLEAR OPTION FORCE WEAPON SWITCH" );
        }
        
        self switchtoweaponimmediate( self.armor.var_e67f0cc08a262a07 );
        waitframe();
    }
    
    self enableweaponswitch();
}

// Namespace player / scripts\sp\player
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x8693
// Size: 0x52
function private watchcancelnotifies()
{
    self endon( "insertArmorComplete" );
    self.stoparmorinsert = 0;
    outcome = waittill_any_return_5( "death", "mantle_start", "scr_change_swim_state", "try_armor_cancel", "armor_plate_done" );
    
    if ( outcome != "armor_plate_done" )
    {
        self.stoparmorinsert = 1;
    }
}

// Namespace player / scripts\sp\player
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x86ed
// Size: 0x72
function private insertarmor( var_45bb64ad6ea299e5 )
{
    if ( !caninsertarmor() || istrue( self.stoparmorinsert ) )
    {
        return;
    }
    
    var_9b8771694b81127f = 1.5;
    
    if ( var_45bb64ad6ea299e5 )
    {
        var_9b8771694b81127f += 1;
    }
    
    function_9d7d7f9a7e534266( var_9b8771694b81127f );
    waittillframeend();
    
    while ( !self.stoparmorinsert && function_4e03f222ed8b54a1() )
    {
        function_9d7d7f9a7e534266( var_9b8771694b81127f );
        waittillframeend();
    }
    
    self notify( "armor_plate_done" );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x8767
// Size: 0x78
function function_9d7d7f9a7e534266( var_9b8771694b81127f )
{
    if ( getdvarint( @"hash_d8e69627073e0766" ) )
    {
        iprintln( "Inserting Plate" );
    }
    
    if ( istrue( function_c6a8892dc659d692( var_9b8771694b81127f ) ) )
    {
        if ( getdvarint( @"hash_d8e69627073e0766" ) )
        {
            iprintln( "Armor Plate Inserted" );
        }
        
        function_70dbac9e7b6d1e2d();
        wait 0.14;
        return;
    }
    
    if ( getdvarint( @"hash_d8e69627073e0766" ) )
    {
        iprintln( "Armor Plate Canceled!" );
    }
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x87e7
// Size: 0x24, Type: bool
function function_c6a8892dc659d692( var_9b8771694b81127f )
{
    self endon( "mantle_start" );
    self endon( "scr_change_swim_state" );
    self endon( "try_armor_cancel" );
    wait var_9b8771694b81127f;
    return true;
}

// Namespace player / scripts\sp\player
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x8814
// Size: 0x43
function private function_70dbac9e7b6d1e2d()
{
    setarmorplateamount( function_85e373bb15921966() - 1 );
    function_842cabfa42775bf();
    
    if ( val::get( "health_regen" ) )
    {
        set_normalhealth( 1 );
    }
    
    self.hadarmor = 1;
    self notify( "armor_plate_inserted" );
}

// Namespace player / scripts\sp\player
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x885f
// Size: 0xc1
function private function_43d4382b6cea4df9( isusingarmor )
{
    if ( isusingarmor )
    {
        val::set( "armor", "weapon_switch", 0 );
        val::set( "armor", "script_weapon_switch", 0 );
        val::set( "armor", "mantle", 0 );
        val::set( "armor", "melee", 0 );
        val::set( "armor", "offhand_weapons", 0 );
        val::set( "armor", "offhand_throwback", 0 );
        val::set( "armor", "offhand_weapons", 0 );
        
        if ( !function_34895a6255f4587a() )
        {
            val::set( "armor", "usability", 0 );
        }
    }
    else
    {
        val::reset_all( "armor" );
    }
    
    self.insertingarmorplate = isusingarmor;
}

// Namespace player / scripts\sp\player
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x8928
// Size: 0x29
function private function_4e03f222ed8b54a1()
{
    if ( !caninsertarmor() )
    {
        return 0;
    }
    
    isholdinggamepad = is_player_gamepad_enabled() && self weaponswitchbuttonpressed();
    return isholdinggamepad;
}

// Namespace player / scripts\sp\player
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x895a
// Size: 0xa4
function private applyarmorcancelplayercommands()
{
    if ( function_34895a6255f4587a() )
    {
        self notifyonplayercommand( "try_armor_cancel", "+weapnext" );
        self notifyonplayercommand( "try_armor_cancel", "+weapprev" );
        self notifyonplayercommand( "try_armor_cancel", "selectweapon1" );
        self notifyonplayercommand( "try_armor_cancel", "selectweapon2" );
        self notifyonplayercommand( "try_armor_cancel", "selectweapon3" );
        self notifyonplayercommand( "try_armor_cancel", "+attack" );
        self notifyonplayercommand( "try_armor_cancel", "+smoke" );
        self notifyonplayercommand( "try_armor_cancel", "+frag" );
        self notifyonplayercommand( "try_armor_cancel", "+melee_zoom" );
    }
}

// Namespace player / scripts\sp\player
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x8a06
// Size: 0x9b
function private function_25aae4d93a36c291()
{
    self notifyonplayercommandremove( "try_armor_cancel", "+weapnext" );
    self notifyonplayercommandremove( "try_armor_cancel", "+weapprev" );
    self notifyonplayercommandremove( "try_armor_cancel", "selectweapon1" );
    self notifyonplayercommandremove( "try_armor_cancel", "selectweapon2" );
    self notifyonplayercommandremove( "try_armor_cancel", "selectweapon3" );
    self notifyonplayercommandremove( "try_armor_cancel", "+attack" );
    self notifyonplayercommandremove( "try_armor_cancel", "+smoke" );
    self notifyonplayercommandremove( "try_armor_cancel", "+frag" );
    self notifyonplayercommandremove( "try_armor_cancel", "+melee_zoom" );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8aa9
// Size: 0x15
function healthratio()
{
    return self.health / self.maxhealth;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8ac7
// Size: 0x18
function firedamageratio()
{
    return self.damage.firedamage / 100;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8ae8
// Size: 0xb
function healthratioinverse()
{
    return 1 - healthratio();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8afc
// Size: 0x15, Type: bool
function hasmaxhealth()
{
    return self.health == self.maxhealth;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x8b1a
// Size: 0x20
function damageratio( damage )
{
    return math::normalize_value( 40, 160, damage / self.damagemultiplier );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8b43
// Size: 0x12, Type: bool
function belowcriticalhealththreshold()
{
    return self.health < criticalhealththreshold();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8b5e
// Size: 0x15
function criticalhealththreshold()
{
    return self.maxhealth * self.var_24c43aff3e21ac3d;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8b7c
// Size: 0xa
function function_693be821d14ede2f()
{
    return utility::damageflag( 2 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8b8f
// Size: 0x18e
function initarmor()
{
    if ( utility::playerarmorenabled() )
    {
        if ( function_12f67117d9715486() )
        {
            setsaveddvar( @"bg_piggybackarmoronnvg", 1 );
        }
        
        utility::add_hint_string( "full_plates", &"SHARED_HINTSTRINGS/ARMOR_PLATES_FULL" );
        setdvarifuninitialized( @"hash_d8e69627073e0766", 0 );
        self.armor = spawnstruct();
        self.armor.sfx = spawn_script_origin();
        self.armor.sfx linkto( self );
        self.armor.plates = 0;
        self.armor.maxplates = 3;
        self.armor.amount = 0;
        self.armor.maxamount = 33.3333;
        self.armor.everhadarmor = 0;
        self.armor.toggleuifunc = &armortoggleui;
        function_d28eb7f4f8aff36c( 0 );
        self setclientomnvar( "ui_equipment_id_health", 27 );
        self setclientomnvar( "ui_equipment_id_health_numCharges", self.armor.plates );
        self setclientomnvar( "ui_equipment_id_health_maxCharges", self.armor.maxplates );
        self setclientomnvar( "ui_armor_percent", armorratio() );
        thread usearmorplateinput();
        armortoggleui();
        return;
    }
    
    armornoui();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8d25
// Size: 0x2d, Type: bool
function function_12f67117d9715486()
{
    mapname = getdvar( @"g_mapname" );
    return mapname == "shadowbase" || mapname == "sp_jup_flashback";
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8d5b
// Size: 0x1a, Type: bool
function hasarmor()
{
    return getdvarint( @"hash_bfa6bedc37206c58" ) && getarmoramount();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8d7e
// Size: 0x15
function getarmoramount()
{
    return self.armor.amount;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8d9c
// Size: 0x15
function getarmormaxamount()
{
    return self.armor.maxamount;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x8dba
// Size: 0x20
function setarmormaxamount( amount )
{
    self.armor.maxamount = amount;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x8de2
// Size: 0x61
function setarmoramount( amount )
{
    self.armor.amount = clamp( amount, 0, getarmormaxamount() );
    self setclientomnvar( "ui_armor_percent", armorratio() );
    sethadarmor();
    updatedamagemultiplier();
    updatearmorui();
    updatedamageindicatortype();
    updateviewkickscale();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8e4b
// Size: 0x6f
function function_4171eeb7b092920f()
{
    armormaxamount = getarmormaxamount();
    currentamount = getarmoramount();
    var_7945128481e38b2c = currentamount + 5;
    
    if ( var_7945128481e38b2c < armormaxamount / 3 )
    {
        setarmoramount( armormaxamount / 3 );
        return;
    }
    
    if ( var_7945128481e38b2c < armormaxamount / 3 * 2 )
    {
        setarmoramount( armormaxamount / 3 * 2 );
        return;
    }
    
    setarmoramount( armormaxamount );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8ec2
// Size: 0x1b
function function_842cabfa42775bf()
{
    armormaxamount = getarmormaxamount();
    setarmoramount( armormaxamount );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8ee5
// Size: 0x4c, Type: bool
function function_3ab255ccd3be6392()
{
    armormaxamount = getarmormaxamount();
    currentamount = getarmoramount();
    
    if ( currentamount == 0 || currentamount == armormaxamount / 3 || currentamount == armormaxamount / 3 * 2 || currentamount == armormaxamount )
    {
        return false;
    }
    
    return true;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8f3a
// Size: 0xf, Type: bool
function haslowarmor()
{
    return getarmoramount() <= lowarmorthreshold();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8f52
// Size: 0x1b
function lowarmorthreshold()
{
    return self.armor.maxamount * 0.25;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8f76
// Size: 0xf, Type: bool
function hasmaxarmor()
{
    return getarmoramount() == getarmormaxamount();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8f8e
// Size: 0x20
function armorratio()
{
    if ( getarmormaxamount() > 0 )
    {
        return ( getarmoramount() / getarmormaxamount() );
    }
    
    return 0;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8fb6
// Size: 0xb
function armorratioinverse()
{
    return 1 - armorratio();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8fca
// Size: 0x1a
function function_85e373bb15921966()
{
    return int( self.armor.plates );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x8fed
// Size: 0x17, Type: bool
function function_34895a6255f4587a()
{
    return self.armor.maxplates > 0;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x900d
// Size: 0x5e
function setarmorplateamount( amount )
{
    self.armor.plates = int( clamp( amount, 0, function_c241aeec324282f0() ) );
    self setclientomnvar( "ui_equipment_id_health_numCharges", self.armor.plates );
    sethadarmor();
    updatearmorui();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9073
// Size: 0x67
function sethadarmor()
{
    if ( self.armor.everhadarmor )
    {
        return;
    }
    
    if ( self.armor.plates > 0 || self.armor.amount > 0 )
    {
        self.armor.everhadarmor = 1;
        armortoggleui();
    }
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x90e2
// Size: 0x6c
function armortoggleui( b_value )
{
    if ( !isdefined( b_value ) )
    {
        b_value = 1;
    }
    
    if ( b_value && self.armor.everhadarmor && val::get( "armor" ) && getdvarint( @"hash_bfa6bedc37206c58" ) )
    {
        setomnvar( "ui_armor_show", 1 );
        return;
    }
    
    setomnvar( "ui_armor_show", 0 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9156
// Size: 0xe
function armornoui()
{
    setomnvar( "ui_armor_show", 0 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x916c
// Size: 0x1a
function function_c241aeec324282f0()
{
    return int( self.armor.maxplates );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x918f
// Size: 0xf, Type: bool
function hasmaxarmorplates()
{
    return function_85e373bb15921966() == function_c241aeec324282f0();
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x91a7
// Size: 0x20
function function_53586c1cec4a904( amount )
{
    self.armor.maxplates = amount;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x91cf
// Size: 0x15
function usingarmorplate()
{
    return self.armor.usingplate;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x91ed
// Size: 0x20
function function_d28eb7f4f8aff36c( boolean )
{
    self.armor.usingplate = boolean;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9215
// Size: 0x2f
function updatedamageindicatortype()
{
    if ( !hasarmor() )
    {
        setsaveddvar( @"hash_f64594b71057fdac", 0 );
        return;
    }
    
    setsaveddvar( @"hash_f64594b71057fdac", 1 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x924c
// Size: 0x6e
function updatedamagemultiplier()
{
    if ( hasarmor() )
    {
        self.damagemultiplier = self.gs.damagemultiplierarmor;
        return;
    }
    
    self.damagemultiplier = self.gs.damagemultiplierhealth * self.gs.scripteddamagemultiplier * self.gs.basehealthdamagemultiplier;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x92c2
// Size: 0x55
function updateviewkickscale()
{
    scale = function_97889c70f9bff377( self.currentweapon );
    scale *= self.gs.flinchmultiplier;
    
    if ( hasarmor() )
    {
        self setviewkickscale( scale + 0.7 );
        return;
    }
    
    self setviewkickscale( scale );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x931f
// Size: 0x64
function function_97889c70f9bff377( weapon )
{
    scale = undefined;
    flinchtype = weapongetflinchtype( weapon );
    
    if ( flinchtype == 4 )
    {
        scale = 0.2;
    }
    else if ( flinchtype == 3 )
    {
        scale = 0.08;
    }
    else if ( flinchtype == 1 )
    {
        scale = 0.1;
    }
    else
    {
        scale = 0.05;
    }
    
    return scale;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x938c
// Size: 0xe2
function weapongetflinchtype( weaponobj )
{
    class = "none";
    flinchtype = -1;
    
    if ( isdefined( weaponobj ) && !isnullweapon( weaponobj ) )
    {
        class = weaponclass( weaponobj.basename );
        
        switch ( class )
        {
            case #"hash_719417cb1de832b6":
                flinchtype = 1;
                break;
            case #"hash_6191aaef9f922f96":
                if ( weaponobj.basename == "iw8_sn_mike14" || weaponobj.basename == "iw8_sn_sksierra" || weaponobj.basename == "iw8_sn_sbeta" || weaponobj.basename == "iw8_sn_romeo700" )
                {
                    flinchtype = 3;
                }
                else
                {
                    flinchtype = 4;
                }
                
                break;
            default:
                flinchtype = 0;
                break;
        }
    }
    
    return flinchtype;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x9477
// Size: 0x25
function set_normalhealth( normalamount )
{
    self setnormalhealth( normalamount );
    self.lasthealth = self.health;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x94a4
// Size: 0x20
function disable_player_weapon_info()
{
    setdvar( @"hash_c815d5683eea5b67", 1 );
    setomnvar( "ui_hide_weapon_info", 1 );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x94cc
// Size: 0x2c
function allow_player_weapon_info( shownow )
{
    setdvar( @"hash_c815d5683eea5b67", 0 );
    
    if ( isdefined( shownow ) && shownow )
    {
        show_hud_listener_logic();
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9500
// Size: 0x2a
function hud_think()
{
    thread button_notifies();
    thread hide_hud_on_death();
    thread hud_visibility_timer();
    thread show_hud_listener();
    thread function_be78dbc6c861438f();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9532
// Size: 0xd7
function show_hud_listener()
{
    self endon( "death" );
    event_notifies = [ "weapon_fired", "aim", "reload_pressed", "weapon_change", "weapon_swap", "hide_hud_omnvar_changed", "frag_pressed", "smoke_pressed", "equipment_change", "current_primary_ammo", "offhand_ammo", "item_ammo", "item_loot", "show_hud_button_pressed", "ammo_pickup", "damage", "armor_pickup", "update_models" ];
    
    while ( true )
    {
        waittill_hud_event_notify( event_notifies );
        
        if ( !in_realism_mode() )
        {
            show_hud_listener_logic();
        }
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9611
// Size: 0x5b
function function_be78dbc6c861438f()
{
    self endon( "death" );
    var_fe6cdb53c48aab11 = [ "reload_start", "weapon_change", "frag_pressed", "smoke_pressed" ];
    
    while ( true )
    {
        waittill_hud_event_notify( var_fe6cdb53c48aab11 );
        
        if ( in_realism_mode() )
        {
            show_hud_listener_logic( 1 );
        }
    }
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x9674
// Size: 0x57
function waittill_hud_event_notify( event_notifies )
{
    foreach ( note in event_notifies )
    {
        self endon( note );
    }
    
    self waittill( "forever" );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x96d3
// Size: 0x6a
function show_hud_listener_logic( showinrealism )
{
    if ( in_realism_mode() && !istrue( showinrealism ) )
    {
        return;
    }
    
    player_demeanor = get_player_demeanor();
    
    if ( player_demeanor != "safe" && !getdvarint( @"hash_c815d5683eea5b67" ) )
    {
        setomnvar( "ui_hide_weapon_info", 0 );
    }
    
    self notify( "cancel_hide_hud" );
    wait 1;
    thread hud_visibility_timer();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9745
// Size: 0x3d
function hud_visibility_timer()
{
    self endon( "death" );
    self endon( "cancel_hide_hud" );
    
    if ( in_realism_mode() )
    {
        wait 2;
    }
    else
    {
        wait 5;
    }
    
    setomnvar( "ui_hide_weapon_info", 1 );
    childthread hud_omnvar_change_listener();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x978a
// Size: 0x57
function hud_omnvar_change_listener()
{
    var_4e2aa722acd7e66e = getomnvar( "ui_hide_hud" );
    var_564e8340eece203e = getomnvar( "ui_hide_weapon_info" );
    
    while ( getomnvar( "ui_hide_hud" ) == var_4e2aa722acd7e66e && getomnvar( "ui_hide_weapon_info" ) == var_564e8340eece203e )
    {
        waitframe();
    }
    
    self notify( "hide_hud_omnvar_changed" );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x97e9
// Size: 0xca
function button_notifies()
{
    self endon( "death" );
    level.player notifyonplayercommand( "show_hud_button_pressed", "+actionslot 1" );
    level.player notifyonplayercommand( "show_hud_button_pressed", "+actionslot 2" );
    level.player notifyonplayercommand( "show_hud_button_pressed", "+actionslot 3" );
    level.player notifyonplayercommand( "show_hud_button_pressed", "+actionslot 4" );
    level.player notifyonplayercommand( "show_hud_button_pressed", "nightvision" );
    level.player notifyonplayercommand( "show_hud_button_pressed", "+weapnext" );
    
    while ( true )
    {
        if ( self adsbuttonpressed() )
        {
            self notify( "aim" );
        }
        
        if ( self meleebuttonpressed() )
        {
            self notify( "melee" );
        }
        
        waitframe();
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x98bb
// Size: 0x17
function hide_hud_on_death()
{
    self waittill( "death" );
    setomnvar( "ui_hide_weapon_info", 1 );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x98da
// Size: 0x17
function function_f339af78be052464( enabled )
{
    setomnvar( "ui_show_weapon_info_force", enabled );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x98f9
// Size: 0x17
function function_53663eba19c92159( enabled )
{
    setomnvar( "ui_show_equipment_info_force", enabled );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x9918
// Size: 0x17
function function_2a64ec3c9d4ce7a5( enabled )
{
    setomnvar( "ui_show_armor_health_force", enabled );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9937
// Size: 0x22
function playerfocusmain()
{
    self endon( "death" );
    setsaveddvar( @"r_hudoutlineoccludedcolorfromfill", 1 );
    childthread focusmonitor();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9961
// Size: 0x19b
function focusmonitor()
{
    while ( true )
    {
        situation = waittill_any_ents_return( self, "focus_pressed", level, "objectives_updated" );
        
        if ( situation == "focus_pressed" && !self.focus.disabled )
        {
            self.focus.buttonhelddown = 1;
            thread scripts\sp\analytics::update_focus_counter();
            
            if ( !self.focus.usedonce )
            {
                self.focus.usedonce = 1;
            }
            
            thread focusactivate();
            focusrelease_waittill();
            self.focus.buttonhelddown = 0;
            
            if ( !self.focus.disabled )
            {
                wait 5;
                function_8915b78ca380c336();
            }
            
            thread focusdeactivate();
            continue;
        }
        
        if ( situation == "objectives_updated" )
        {
            if ( focus_objectives_update_display() )
            {
                setsaveddvar( @"objectivealpha", 0.6 );
                setomnvar( "ui_show_objectives", 1 );
                thread focustimeadjust();
                
                for ( endtime = getfocusendtime(); gettime() < endtime ; endtime = getfocusendtime() )
                {
                    wait 0.1;
                    
                    if ( self.focus.timeadjust )
                    {
                        self.focus.timeadjust = 0;
                    }
                }
                
                self notify( "stop_focust_time_adjust" );
                
                while ( focus_infinite_hold() )
                {
                    waitframe();
                }
                
                function_8915b78ca380c336();
                thread focusdeactivate();
            }
        }
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9b04
// Size: 0x1f
function focusenable()
{
    self.focus.disabled = 0;
    self notify( "focus_enabled" );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9b2b
// Size: 0x20
function focusdisable()
{
    self.focus.disabled = 1;
    self notify( "focus_disabled" );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9b53
// Size: 0x11
function focusrelease_waittill()
{
    self endon( "focus_disabled" );
    self waittill( "focus_released" );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x9b6c
// Size: 0x20
function function_aad8bf13ced72be3( speed )
{
    self.focus.speed = speed;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9b94
// Size: 0x2d
function function_8915b78ca380c336()
{
    while ( self.focus.speed > length( self getvelocity() ) )
    {
        wait 0.25;
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9bc9
// Size: 0xd
function getfocusendtime()
{
    return gettime() + 5000;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9bdf
// Size: 0x44
function focustimeadjust()
{
    self endon( "stop_focust_time_adjust" );
    
    while ( true )
    {
        level waittill( "objectives_updated_state", event );
        
        if ( event != "invisible" )
        {
            self.focus.timeadjust = 1;
        }
    }
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0x9c2b
// Size: 0x20
function forcesetamount( amount )
{
    self.focus.amount = amount;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9c53
// Size: 0x15
function forceamount()
{
    return self.focus.amount;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9c71
// Size: 0x16d
function focusactivate()
{
    currentalpha = getdvarfloat( @"objectivealpha" );
    var_61e4a82a839679f1 = 1 - math::normalize_value( 0, 0.6, currentalpha );
    intime = var_61e4a82a839679f1 * 0.5;
    endtime = gettime() + intime * 1000;
    frames = intime * 20;
    var_a0576da143262bd2 = math::factor_value( 0.6, 0, currentalpha );
    alphaslice = var_a0576da143262bd2 / frames;
    focushighlightadditionalentsenable();
    setomnvar( "ui_show_objectives", 1 );
    
    if ( function_ec0de9419bd49f54() )
    {
        if ( istrue( self.focus.markedshown ) && function_7c4cc9d23819ab0a() )
        {
            function_75d9abc6aee4731( 0 );
        }
        else
        {
            self.focus.markedshown = 1;
        }
    }
    
    while ( gettime() < endtime )
    {
        currentalpha = getdvarfloat( @"objectivealpha" );
        nextalpha = clamp( currentalpha + alphaslice, 0, 0.6 );
        setsaveddvar( @"objectivealpha", nextalpha );
        forcesetamount( nextalpha );
        forcesethudoutlinealpha( nextalpha );
        waitframe();
    }
    
    setsaveddvar( @"objectivealpha", 0.6 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9de6
// Size: 0x146
function focusdeactivate()
{
    self endon( "focus_pressed" );
    
    if ( focus_objectives_update_display() )
    {
        level endon( "objectives_updated" );
    }
    
    currentalpha = getdvarfloat( @"objectivealpha" );
    var_e7538877552f790d = math::normalize_value( 0, 0.6, currentalpha );
    outtime = var_e7538877552f790d * 2.5;
    endtime = gettime() + outtime * 1000;
    frames = outtime * 20;
    var_620ff22de9679d7a = math::factor_value( 0, 0.6, var_e7538877552f790d );
    alphaslice = var_620ff22de9679d7a / frames;
    setomnvar( "ui_show_objectives", 0 );
    
    while ( gettime() < endtime )
    {
        currentalpha = getdvarfloat( @"objectivealpha" );
        nextalpha = clamp( currentalpha - alphaslice, 0, 0.6 );
        setsaveddvar( @"objectivealpha", nextalpha );
        forcesetamount( nextalpha );
        forcesethudoutlinealpha( nextalpha );
        waitframe();
    }
    
    focushighlightadditionalentsdisable();
    setsaveddvar( @"objectivealpha", 0 );
    
    if ( function_7c4cc9d23819ab0a() )
    {
        function_75d9abc6aee4731( 0 );
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9f34
// Size: 0x91
function focushighlightadditionalentsenable()
{
    if ( !isdefined( self.focus.additionalents ) )
    {
        return;
    }
    
    if ( !self.focus.additionalents.size )
    {
        return;
    }
    
    foreach ( ent in self.focus.additionalents )
    {
        ent hudoutlineenable( "outline_nodepth_white" );
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0x9fcd
// Size: 0x74
function focushighlightadditionalentsdisable()
{
    if ( !self.focus.additionalents.size )
    {
        return;
    }
    
    foreach ( ent in self.focus.additionalents )
    {
        ent hudoutlinedisable();
    }
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa049
// Size: 0x2e
function forcesethudoutlinealpha( alpha )
{
    setsaveddvar( hashcat( @"hash_1429c8e20321bbcd", 1 ), "1 1 1" + " " + alpha );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa07f
// Size: 0x2d
function getvisionlerprate( outtime )
{
    rate = 1 / max( 0.01, outtime );
    return clamp( rate, 0, 30 );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa0b5
// Size: 0xc6
function offhandremove( equipment )
{
    hadweapon = 0;
    
    foreach ( offhand in self.offhandinventory )
    {
        if ( offhand.basename == equipment.basename )
        {
            self takeweapon( offhand );
            hadweapon = 1;
        }
    }
    
    if ( hadweapon )
    {
        if ( scripts\sp\equipment\offhands::getweaponoffhandtype( equipment ) == "primaryoffhand" )
        {
            setclassfunc = &setoffhandprimaryclassfunc;
        }
        else
        {
            setclassfunc = &setoffhandsecondaryclassfunc;
        }
        
        self [[ setclassfunc ]]( "none" );
        scripts\sp\loot::removeoffhandloot( equipment );
    }
}

// Namespace player / scripts\sp\player
// Params 3
// Checksum 0x0, Offset: 0xa183
// Size: 0x305
function offhandswap( equipment, var_1c7780cbd65c3c09, additional_attachments )
{
    weapon = undefined;
    attachments = [];
    
    if ( !isdefined( additional_attachments ) )
    {
        additional_attachments = [];
    }
    
    if ( isarray( equipment ) )
    {
        foreach ( item in equipment )
        {
            if ( i == 0 )
            {
                weapon = item;
                attachments = array_combine( attachments, getweapondefaultattachments( weapon ) );
                continue;
            }
            
            attachments[ attachments.size ] = item;
        }
    }
    else
    {
        weapon = equipment;
        attachments = getweapondefaultattachments( weapon );
    }
    
    if ( weapon == "none" )
    {
        assertmsg( "do not use offhandSwap with type <none>, use offhandRemove()" );
    }
    
    if ( !scripts\sp\equipment\offhands::offhandisprecached( weapon ) )
    {
        assertmsg( "offhand <" + weapon + "> is not precached, call offhandPrecache( missionOffhandArray ) after load::main and before give_offhand()" );
    }
    
    if ( scripts\sp\equipment\offhands::getweaponoffhandtype( weapon ) == "primaryoffhand" )
    {
        var_6c85c3860ab378b3 = "secondaryoffhand";
        setclassfunc = &setoffhandprimaryclassfunc;
    }
    else
    {
        var_6c85c3860ab378b3 = "primaryoffhand";
        setclassfunc = &setoffhandsecondaryclassfunc;
    }
    
    var_e56a188d1825c45b = self getcurrentoffhand( var_6c85c3860ab378b3 );
    
    foreach ( offhand in self.offhandinventory )
    {
        if ( offhand.basename != var_e56a188d1825c45b.basename )
        {
            self takeweapon( offhand );
        }
    }
    
    class = scripts\sp\equipment\offhands::getweaponoffhandclass( weapon );
    self [[ setclassfunc ]]( class );
    
    if ( isstring( weapon ) )
    {
        weapon = makeweapon( weapon );
    }
    
    if ( istrue( attachments.size ) )
    {
        foreach ( attachment in attachments )
        {
            weapon = weapon withattachment( attachment );
        }
    }
    
    if ( istrue( additional_attachments.size ) )
    {
        foreach ( attachment in additional_attachments )
        {
            weapon = weapon withattachment( attachment );
        }
    }
    
    self giveweapon( weapon );
    
    if ( isdefined( var_1c7780cbd65c3c09 ) )
    {
        foreach ( offhand in self.offhandinventory )
        {
            if ( offhand.basename != var_e56a188d1825c45b.basename )
            {
                self setweaponammoclip( offhand, var_1c7780cbd65c3c09 );
            }
        }
    }
    
    scripts\sp\loot::setoffhandloot( weapon );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa490
// Size: 0x13
function setoffhandsecondaryclassfunc( class )
{
    self setoffhandsecondaryclass( class );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa4ab
// Size: 0x13
function setoffhandprimaryclassfunc( class )
{
    self setoffhandprimaryclass( class );
}

// Namespace player / scripts\sp\player
// Params 2
// Checksum 0x0, Offset: 0xa4c6
// Size: 0x39
function dodamagefilter( health, type )
{
    if ( isdefined( type ) && isexplosivedamage( type ) )
    {
        health = int( health * 1 / self.damagemultiplier );
    }
    
    return health;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa508
// Size: 0x82
function player_cinematic_motion_override( cinematicmotionoverride )
{
    level.player.cinematicmotionoverride = cinematicmotionoverride;
    
    if ( level.player val::get( "cinematic_motion" ) )
    {
        if ( isdefined( level.player.cinematicmotionoverride ) )
        {
            level.player setcinematicmotionoverride( level.player.cinematicmotionoverride );
            return;
        }
        
        level.player clearcinematicmotionoverride();
    }
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa592
// Size: 0x39
function set_player_ignore_random_bullet_damage( bool )
{
    if ( !isdefined( bool ) )
    {
        bool = 1;
    }
    
    level.player.scriptedignorerandombulletdamage = bool;
    level.player scripts\sp\gameskill::update_player_attacker_accuracy();
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa5d3
// Size: 0x169
function player_movement_state( state )
{
    if ( !isdefined( state ) )
    {
        state = "default";
    }
    
    switch ( state )
    {
        case #"hash_a25aba0197cd06fa":
            suit = "iw9_creep";
            movespeed = 90;
            jogenabled = 0;
            break;
        case #"hash_1a53266c17b7d481":
            suit = "iw9_cqb";
            movespeed = 120;
            jogenabled = 0;
            break;
        case #"hash_7038dec66d8275be":
            suit = function_da3aeaac893bc11f();
            movespeed = 150;
            jogenabled = 1;
            break;
        default:
            assertmsg( "movement state <" + state + "> is not a valid type.  please use <creep> <cqb> or <default>" );
            suit = function_da3aeaac893bc11f();
            movespeed = 150;
            jogenabled = 1;
            break;
    }
    
    level.player.movementstate = state;
    level.player setsuit( suit );
    
    if ( level.player val::get( "jog" ) && !jogenabled || !level.player val::get( "jog" ) && jogenabled )
    {
        if ( !jogenabled )
        {
            level.player val::set( "player_movement_state", "jog", 0 );
        }
        else
        {
            level.player val::reset_all( "player_movement_state" );
        }
    }
    
    player_speed_set( movespeed, 0.5 );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0xa744
// Size: 0x40
function function_da3aeaac893bc11f()
{
    if ( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.playerdefaultsuit ) )
    {
        return level.gamemodebundle.playerdefaultsuit;
    }
    
    return "iw9_defaultsuit_sp";
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa78d
// Size: 0x1d
function function_e9e42cffedaa98d5( amount )
{
    if ( !playerarmorenabled() )
    {
        return;
    }
    
    setarmorplateamount( amount );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0xa7b2
// Size: 0x12
function function_e636201766496e1()
{
    if ( !playerarmorenabled() )
    {
        return;
    }
    
    return function_85e373bb15921966();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0xa7cd
// Size: 0x25
function give_player_max_armor()
{
    if ( !playerarmorenabled() )
    {
        return;
    }
    
    setarmoramount( int( 100 ) );
    self.hadarmor = 1;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0xa7fa
// Size: 0x1c
function remove_all_armor()
{
    if ( !playerarmorenabled() )
    {
        return;
    }
    
    setarmorplateamount( 0 );
    setarmoramount( 0 );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa81e
// Size: 0x20
function function_b8fe4107049fc35f( visionset )
{
    self.damage.var_4324a9d071ec7a6a = visionset;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa846
// Size: 0x20
function function_61e425bf9c03bb99( visionset )
{
    self.damage.var_3448f6d5527bfdd0 = visionset;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa86e
// Size: 0x20
function function_22373ff2c7bf69b( visionset )
{
    self.damage.scriptedpainvision = visionset;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa896
// Size: 0x20
function function_a134d43a2fb54f72( visionset )
{
    self.damage.var_94afcf2ebc7b6f48 = visionset;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa8be
// Size: 0x20
function function_4a82b4c07f9a8934( visionset )
{
    self.damage.var_85b4a9b6802b3a0f = visionset;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa8e6
// Size: 0x31
function set_player_max_health( newhealth )
{
    self.gs.scripteddamagemultiplier = self.maxhealth / newhealth;
    updatedamagemultiplier();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0xa91f
// Size: 0x1f
function function_e443c62448cfda13()
{
    return self.maxhealth / self.gs.scripteddamagemultiplier;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa947
// Size: 0x20
function function_301ed26b815bb60c( shader )
{
    self.damage.scriptedoverlay = shader;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa96f
// Size: 0x20
function function_103ef5621139a415( shader )
{
    self.damage.var_edc58801037437fa = shader;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa997
// Size: 0x29
function scale_player_death_shield_duration( scale )
{
    if ( !isdefined( scale ) )
    {
        scale = 1;
    }
    
    self.gs.scripteddeathshielddurationscale = scale;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa9c8
// Size: 0x29
function function_308d3ad6f4ca4c08( scale )
{
    if ( !isdefined( scale ) )
    {
        scale = 1;
    }
    
    self.gs.var_f3cb481e3e3b2a24 = scale;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xa9f9
// Size: 0x29
function function_7c5d4fb9ede97ebd( scale )
{
    if ( !isdefined( scale ) )
    {
        scale = 1;
    }
    
    self.gs.var_302587891497f2db = scale;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xaa2a
// Size: 0x10f
function remove_damage_effects_instantly( var_2625c6f710d4e980 )
{
    self notify( "stopPainOverlays" );
    
    if ( !isdefined( var_2625c6f710d4e980 ) )
    {
        var_2625c6f710d4e980 = 0;
    }
    
    self painvisionoff();
    
    if ( utility::damageflag( 2 ) )
    {
        disabledeathsdoor( 1 );
    }
    
    removefiredamageimmediate();
    removeradialdistortion( 0 );
    stopimpactsfx();
    
    if ( !var_2625c6f710d4e980 )
    {
        foreach ( overlay in self.damage.activescreeneffectoverlays )
        {
            overlay notify( "destroySreenEffectOverlay" );
        }
    }
    
    self.damage.overlay destroy();
    self.damage.bloodoverlay destroy();
    self.damage.deathsdooroverlaypulse destroy();
    initdamageoverlay();
    initbloodoverlay();
    initdeathsdooroverlaypulse();
}

// Namespace player / scripts\sp\player
// Params 4
// Checksum 0x0, Offset: 0xab41
// Size: 0x96
function radial_distortion( distortion, strength, outtime, origin )
{
    self notify( "radialDistortion" );
    self endon( "radialDistortion" );
    setsaveddvar( @"hash_ed28298c207316ae", distortion );
    setsaveddvar( @"hash_979b5474be3b9b47", -1 );
    setsaveddvar( @"hash_960ef00238357bbc", strength );
    
    if ( isdefined( origin ) )
    {
        setsaveddvar( @"hash_bc02f8e41595c9a8", 1 );
        setsaveddvar( @"hash_841b904ab274bece", origin );
    }
    
    if ( isdefined( outtime ) )
    {
        removeradialdistortion( outtime );
    }
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xabdf
// Size: 0x36
function set_focus_objectives_update_display( boolean )
{
    self.focus.objectivesupdatedisplay = boolean;
    level.player setclientomnvar( "ui_disable_objective_reveal_fanfare", !boolean );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0xac1d
// Size: 0x15
function focus_objectives_update_display()
{
    return self.focus.objectivesupdatedisplay;
}

// Namespace player / scripts\sp\player
// Params 2
// Checksum 0x0, Offset: 0xac3b
// Size: 0x5f
function function_75d9abc6aee4731( markedonly, var_d7e35db6665412ba )
{
    self.focus.showmarkedonly = markedonly;
    self.focus.var_af8764067ff2ab84 = var_d7e35db6665412ba;
    self.focus.markedshown = 0;
    self setclientomnvar( "ui_show_only_marked_objectives", markedonly );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0xaca2
// Size: 0x16, Type: bool
function function_ec0de9419bd49f54()
{
    return istrue( self.focus.showmarkedonly );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0xacc1
// Size: 0x16, Type: bool
function function_7c4cc9d23819ab0a()
{
    return istrue( self.focus.var_af8764067ff2ab84 );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xace0
// Size: 0x20
function set_focus_infinite_hold( boolean )
{
    self.focus.infinitehold = boolean;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0xad08
// Size: 0x15
function focus_infinite_hold()
{
    return self.focus.infinitehold;
}

// Namespace player / scripts\sp\player
// Params 4
// Checksum 0x0, Offset: 0xad26
// Size: 0x33
function focus_display_hint( delay, timeout, endonentity, endonmessage )
{
    display_hint( "focus_hint", timeout, delay, endonentity, endonmessage );
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0xad61
// Size: 0x1f
function focus_held_down()
{
    return level.player.focus.buttonhelddown;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xad89
// Size: 0x27
function set_player_ladder_weapon( weap )
{
    if ( !isweapon( weap ) )
    {
        weap = make_weapon( weap );
    }
    
    self.ladderweapon = weap;
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xadb8
// Size: 0x14
function function_62439e99895fbfec( var_2771377b7eada859 )
{
    thread function_41ee246015fa055d( var_2771377b7eada859 );
}

// Namespace player / scripts\sp\player
// Params 1
// Checksum 0x0, Offset: 0xadd4
// Size: 0x49d
function function_41ee246015fa055d( var_2771377b7eada859 )
{
    self notify( "start_wind_effect" );
    self endon( "stop_wind_effect" );
    self endon( "death" );
    self.wind = spawnstruct();
    
    if ( !isdefined( self.wind.positioner ) )
    {
        self.wind.positioner = spawn_tag_origin();
    }
    
    if ( !isdefined( self.wind.frontwind ) )
    {
        self.wind.frontwind = spawn_tag_origin();
    }
    
    if ( !isdefined( self.wind.backwind ) )
    {
        self.wind.backwind = spawn_tag_origin();
    }
    
    self.wind.frontwind linkto( self.wind.positioner, "tag_origin", ( 500, 0, 0 ), ( 0, 0, 0 ) );
    self.wind.backwind linkto( self.wind.positioner, "tag_origin", ( -500, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( !isdefined( var_2771377b7eada859 ) )
    {
        assertmsg( "this function requires an ent to drive the wind direction" );
    }
    
    thread function_530d5648cb42a961();
    self setclientomnvar( "ui_whizby_side_loop", 1 );
    self setclientomnvar( "ui_whizby_front_loop", 1 );
    thread cycleanim();
    self.nowhizby = 1;
    level.player setcinematicmotionoverride( "iw9_on_vehicle" );
    
    while ( true )
    {
        if ( !isdefined( var_2771377b7eada859 ) )
        {
            break;
        }
        
        playerang = self getplayerangles();
        eyepos = self geteye();
        
        if ( self.wind.positioner islinked() )
        {
            self.wind.positioner unlink();
        }
        
        self.wind.positioner.origin = level.player.origin;
        
        if ( isdefined( var_2771377b7eada859 ) )
        {
            self.wind.positioner.angles = var_2771377b7eada859.angles;
            self.wind.positioner linkto( var_2771377b7eada859 );
        }
        
        playeraxis = anglestoaxis( playerang );
        forwardpos = self.wind.frontwind.origin;
        toforwardvec = vectornormalize( forwardpos - eyepos );
        toforwarddot = vectordot( toforwardvec, playeraxis[ "forward" ] );
        torightdot = vectordot( toforwardvec, playeraxis[ "right" ] );
        toupdot = vectordot( toforwardvec, playeraxis[ "up" ] );
        
        if ( toforwarddot > 0 )
        {
            frontloop = 1;
            whizybyent = self.wind.frontwind getentitynumber();
        }
        else
        {
            frontloop = 2;
            whizybyent = self.wind.backwind getentitynumber();
        }
        
        var_dd9bb8522cc9e666 = abs( toforwarddot );
        var_b4b4994e3604ce34 = 1 - abs( toforwarddot );
        var_f3dae9eeecbc6a28 = clamp( -1 * toforwarddot, 0, 1 );
        var_3783a488b009bc61 = scripts\common\whizby::function_dbabf852a35102e4( torightdot, toupdot );
        var_dd9bb8522cc9e666 = math::normalized_float_smooth_out( var_dd9bb8522cc9e666 );
        var_b4b4994e3604ce34 = math::normalized_float_smooth_out( var_b4b4994e3604ce34 );
        var_dd9bb8522cc9e666 = math::factor_value( 0, self.wind.intensitycurrent * 0.65, var_dd9bb8522cc9e666 );
        var_b4b4994e3604ce34 = math::factor_value( 0, self.wind.intensitycurrent * 0.45, var_b4b4994e3604ce34 );
        self setclientomnvar( "ui_whizby_alpha_front", var_dd9bb8522cc9e666 );
        self setclientomnvar( "ui_whizby_alpha_side", var_b4b4994e3604ce34 );
        self setclientomnvar( "ui_whizby_side_angle", int( var_3783a488b009bc61 ) );
        
        if ( self getclientomnvar( "ui_whizby_ent" ) != whizybyent )
        {
            self setclientomnvar( "ui_whizby_ent", whizybyent );
            self setclientomnvar( "ui_whizby_front_loop", frontloop );
        }
        
        wait 0.05;
    }
    
    function_f2add024b4cc6df7();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0xb279
// Size: 0x39
function cycleanim()
{
    self endon( "stop_wind_effect" );
    self endon( "death" );
    
    while ( true )
    {
        self setclientomnvar( "ui_whizby_notify", gettime() );
        wait randomfloatrange( 0.15, 0.25 );
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0xb2ba
// Size: 0x70
function windquakes()
{
    self endon( "stop_wind_effect" );
    self endon( "death" );
    
    while ( true )
    {
        if ( self.wind.intensitycurrent > 0 )
        {
            earthquake( 0.1 * self.wind.intensitycurrent, 0.13, self.origin, 2000 );
        }
        
        wait randomfloatrange( 0.05, 0.12 );
    }
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0xb332
// Size: 0xa
function function_f2add024b4cc6df7()
{
    thread function_ebc4929caff73078();
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0xb344
// Size: 0x125
function function_ebc4929caff73078()
{
    self endon( "start_wind_effect" );
    self endon( "stop_wind_effect" );
    self endon( "death" );
    self.wind.intensity = 0;
    level.player clearcinematicmotionoverride();
    
    while ( self.wind.intensitycurrent > 0.01 )
    {
        waitframe();
    }
    
    if ( !isdefined( self.wind.positioner ) )
    {
        self.wind.positioner delete();
    }
    
    if ( !isdefined( self.wind.frontwind ) )
    {
        self.wind.frontwind delete();
    }
    
    if ( !isdefined( self.wind.frontwind ) )
    {
        self.wind.backwind delete();
    }
    
    self setclientomnvar( "ui_whizby_front_loop", 0 );
    self setclientomnvar( "ui_whizby_side_loop", 0 );
    self setclientomnvar( "ui_whizby_ent", -1 );
    self.nowhizby = 0;
    self notify( "stop_wind_effect" );
}

// Namespace player / scripts\sp\player
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xb471
// Size: 0x1e
function private function_b2c2a8f72b5d9583( b_value )
{
    if ( !isdefined( b_value ) )
    {
        b_value = 1;
    }
    
    self.var_91921c3ae8981de2 = b_value;
}

// Namespace player / scripts\sp\player
// Params 0
// Checksum 0x0, Offset: 0xb497
// Size: 0xc7
function function_530d5648cb42a961()
{
    self endon( "stop_wind_effect" );
    self endon( "death" );
    
    if ( !isdefined( self.wind.intensity ) )
    {
        self.wind.intensity = 1;
    }
    
    if ( !isdefined( self.wind.intensitycurrent ) )
    {
        self.wind.intensitycurrent = 0;
    }
    
    while ( true )
    {
        waitframe();
        self.wind.intensitycurrent += ( self.wind.intensity - self.wind.intensitycurrent ) * 0.15;
    }
}

// Namespace player / scripts\sp\player
// Params 4
// Checksum 0x0, Offset: 0xb566
// Size: 0x99
function getplayersinradius( origin, radius, desiredteam, excludeent )
{
    player = level.players[ 0 ];
    
    if ( isalive( player ) )
    {
        if ( distancesquared( player.origin, origin ) <= squared( radius ) )
        {
            if ( isdefined( desiredteam ) )
            {
                if ( isdefined( player.team ) && player.team != desiredteam )
                {
                    return [];
                }
            }
            
            if ( isdefined( excludeent ) )
            {
                if ( player == excludeent )
                {
                    return [];
                }
            }
            
            return [ player ];
        }
    }
    
    return [];
}

