#namespace player;

// Namespace player / scripts\cp\player
// Params 0
// Checksum 0x0, Offset: 0x2c3
// Size: 0x21
function disable_player_weapon_info()
{
    setdvar( @"hash_c815d5683eea5b67", 1 );
    self setclientomnvar( "ui_hide_weapon_info", 1 );
}

// Namespace player / scripts\cp\player
// Params 1
// Checksum 0x0, Offset: 0x2ec
// Size: 0x2d
function allow_player_weapon_info( shownow )
{
    setdvar( @"hash_c815d5683eea5b67", 0 );
    
    if ( isdefined( shownow ) && shownow )
    {
        thread show_hud_listener_logic();
    }
}

// Namespace player / scripts\cp\player
// Params 0
// Checksum 0x0, Offset: 0x321
// Size: 0x2f
function hud_think()
{
    if ( getdvarint( @"hash_6a05cf71ef55ee41", 0 ) != 0 )
    {
        return;
    }
    
    thread button_notifies();
    thread hud_visibility_timer();
    thread show_hud_listener();
}

// Namespace player / scripts\cp\player
// Params 0
// Checksum 0x0, Offset: 0x358
// Size: 0x17e
function show_hud_listener()
{
    self endon( "disconnect" );
    self notify( "show_hud_listener" );
    self endon( "show_hud_listener" );
    self notifyonplayercommand( "reload_pressed", "+usereload" );
    self notifyonplayercommand( "reload_pressed", "+reload" );
    self notifyonplayercommand( "use_pressed", "+activate" );
    self notifyonplayercommand( "use_pressed", "+usereload" );
    self notifyonplayercommand( "frag_pressed", "+frag" );
    self notifyonplayercommand( "smoke_pressed", "+smoke" );
    self notifyonplayercommand( "melee_pressed", "+melee" );
    self notifyonplayercommand( "melee_pressed", "+melee_zoom" );
    self notifyonplayercommand( "melee_pressed", "+melee_sprint" );
    self notifyonplayercommand( "actionslot_weapon_pressed", "+actionslot 1" );
    event_notifies = [ "weapon_fired", "aim", "reload_pressed", "weapon_change", "weapon_swap", "hide_hud_omnvar_changed", "frag_pressed", "smoke_pressed", "offhand_ammo", "offhand_fired", "item_ammo", "item_loot", "show_hud_button_pressed", "show_hud_near_objective", "damage", "night_vision_on", "night_vision_off" ];
    
    while ( true )
    {
        waittill_hud_event_notify( event_notifies );
        show_hud_listener_logic();
    }
}

// Namespace player / scripts\cp\player
// Params 1
// Checksum 0x0, Offset: 0x4de
// Size: 0x57
function waittill_hud_event_notify( event_notifies )
{
    foreach ( note in event_notifies )
    {
        self endon( note );
    }
    
    self waittill( "forever" );
}

// Namespace player / scripts\cp\player
// Params 0
// Checksum 0x0, Offset: 0x53d
// Size: 0x63
function show_hud_listener_logic()
{
    player_demeanor = self getdemeanorviewmodel();
    primary = self getcurrentprimaryweapon();
    
    if ( player_demeanor != "safe" && !getdvarint( @"hash_c815d5683eea5b67" ) )
    {
        self setclientomnvar( "ui_hide_weapon_info", 0 );
    }
    
    self notify( "cancel_hide_hud" );
    wait 1;
    thread hud_visibility_timer();
}

// Namespace player / scripts\cp\player
// Params 0
// Checksum 0x0, Offset: 0x5a8
// Size: 0x3b
function hud_visibility_timer()
{
    self endon( "disconnect" );
    self endon( "cancel_hide_hud" );
    self notify( "hud_visibility_timer" );
    self endon( "hud_visibility_timer" );
    wait 20;
    self setclientomnvar( "ui_hide_weapon_info", 1 );
    thread hud_omnvar_change_listener();
}

// Namespace player / scripts\cp\player
// Params 0
// Checksum 0x0, Offset: 0x5eb
// Size: 0x71
function hud_omnvar_change_listener()
{
    self endon( "disconnect" );
    self notify( "hud_omnvar_change_listener" );
    self endon( "hud_omnvar_change_listener" );
    var_4e2aa722acd7e66e = self getclientomnvar( "ui_hide_hud" );
    var_564e8340eece203e = self getclientomnvar( "ui_hide_weapon_info" );
    
    while ( self getclientomnvar( "ui_hide_hud" ) == var_4e2aa722acd7e66e && self getclientomnvar( "ui_hide_weapon_info" ) == var_564e8340eece203e )
    {
        waitframe();
    }
    
    self notify( "hide_hud_omnvar_changed" );
}

// Namespace player / scripts\cp\player
// Params 0
// Checksum 0x0, Offset: 0x664
// Size: 0xba
function button_notifies()
{
    self endon( "disconnect" );
    self notify( "button_notifies" );
    self endon( "button_notifies" );
    self notifyonplayercommand( "show_hud_button_pressed", "+actionslot 1" );
    self notifyonplayercommand( "show_hud_button_pressed", "+actionslot 2" );
    self notifyonplayercommand( "show_hud_button_pressed", "+actionslot 3" );
    self notifyonplayercommand( "show_hud_button_pressed", "+actionslot 4" );
    self notifyonplayercommand( "show_hud_button_pressed", "night_vision_on" );
    self notifyonplayercommand( "show_hud_button_pressed", "night_vision_off" );
    self notifyonplayercommand( "show_hud_button_pressed", "+weapnext" );
    
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

// Namespace player / scripts\cp\player
// Params 0
// Checksum 0x0, Offset: 0x726
// Size: 0x18
function hide_hud_on_death()
{
    self waittill( "death" );
    self setclientomnvar( "ui_hide_weapon_info", 1 );
}

