#using scripts\common\callbacks;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\playerhealth;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace damage_effects;

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0x46d
// Size: 0x38
function init()
{
    if ( !isdefined( level.var_562530bdb8e83b66 ) )
    {
        level.var_562530bdb8e83b66 = 0.55;
    }
    
    if ( !isdefined( level.var_fdd1af3c4c6cbe86 ) )
    {
        level.var_fdd1af3c4c6cbe86 = 0.7;
    }
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0x4ad
// Size: 0x129
function function_9bc46d4b8891a740()
{
    if ( !isplayer( self ) || isbot( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.damage ) )
    {
        self.damage = spawnstruct();
    }
    else if ( isdefined( self.damage.var_7076478738f62d10 ) )
    {
        foreach ( overlay in self.damage.var_7076478738f62d10 )
        {
            if ( isdefined( overlay ) )
            {
                overlay destroy();
            }
        }
    }
    
    self.damage.var_7076478738f62d10 = [];
    self.damage.var_f4687931bd3b8634 = [];
    self.damage.altdirectionalbloodoverlay = 0;
    self.damage.lastdiretionalbloodtime = -99999;
    initdeathsdooroverlaypulse();
    function_12bd9b0199862940();
    thread function_fba4aaaecf8e34ac();
    thread function_c0124edee3a13496();
    thread function_54117659a8e5c5b4();
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0x5de
// Size: 0x25b
function initdeathsdooroverlaypulse()
{
    if ( !isdefined( level.projectbundle ) || !isdefined( level.projectbundle.var_1ad4a3f795bf0321 ) )
    {
        return;
    }
    
    self.damage.deathsdooroverlaypulse = newclienthudelem( self );
    self.damage.deathsdooroverlaypulse.sort = 9;
    self.damage.deathsdooroverlaypulse.x = 0;
    self.damage.deathsdooroverlaypulse.y = 0;
    self.damage.deathsdooroverlaypulse.alignx = "left";
    self.damage.deathsdooroverlaypulse.aligny = "top";
    self.damage.deathsdooroverlaypulse.foreground = 0;
    self.damage.deathsdooroverlaypulse.lowresbackground = 1;
    self.damage.deathsdooroverlaypulse.horzalign = "fullscreen";
    self.damage.deathsdooroverlaypulse.vertalign = "fullscreen";
    self.damage.deathsdooroverlaypulse.alpha = 0;
    self.damage.deathsdooroverlaypulse.enablehudlighting = 0;
    self.damage.deathsdooroverlaypulse.scramblerdisabled = 1;
    self.damage.deathsdooroverlaypulse setshader( level.projectbundle.var_1ad4a3f795bf0321, 640, 480 );
    self.damage.deathsdooroverlaypulse.var_eeda4296ae80e949 = 0;
    self.damage.var_7076478738f62d10 = array_add( self.damage.var_7076478738f62d10, self.damage.deathsdooroverlaypulse );
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0x841
// Size: 0x23c
function function_12bd9b0199862940()
{
    if ( !isdefined( level.projectbundle ) || !isdefined( level.projectbundle.var_e44fdf0e370e159a ) )
    {
        return;
    }
    
    self.damage.var_5d28af440fb50e5a = newclienthudelem( self );
    self.damage.var_5d28af440fb50e5a.sort = 10;
    self.damage.var_5d28af440fb50e5a.x = 0;
    self.damage.var_5d28af440fb50e5a.y = 0;
    self.damage.var_5d28af440fb50e5a.alignx = "left";
    self.damage.var_5d28af440fb50e5a.aligny = "top";
    self.damage.var_5d28af440fb50e5a.foreground = 0;
    self.damage.var_5d28af440fb50e5a.lowresbackground = 1;
    self.damage.var_5d28af440fb50e5a.horzalign = "fullscreen";
    self.damage.var_5d28af440fb50e5a.vertalign = "fullscreen";
    self.damage.var_5d28af440fb50e5a.alpha = 0;
    self.damage.var_5d28af440fb50e5a.enablehudlighting = 0;
    self.damage.var_5d28af440fb50e5a.scramblerdisabled = 1;
    self.damage.var_5d28af440fb50e5a setshader( level.projectbundle.var_e44fdf0e370e159a, 640, 480 );
    self.damage.var_f4687931bd3b8634 = array_add( self.damage.var_7076478738f62d10, self.damage.var_5d28af440fb50e5a );
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0xa85
// Size: 0x7e
function function_fba4aaaecf8e34ac()
{
    overlays = self.damage.var_7076478738f62d10;
    waittill_any_2( "death_or_disconnect", "ending_cinematic" );
    
    foreach ( overlay in overlays )
    {
        if ( isdefined( overlay ) )
        {
            overlay destroy();
        }
    }
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0xb0b
// Size: 0x88
function function_c0124edee3a13496()
{
    overlays = self.damage.var_f4687931bd3b8634;
    waittill_any_4( "disconnect", "death_delay_finished", "spawned", "ending_cinematic" );
    
    foreach ( overlay in overlays )
    {
        if ( isdefined( overlay ) )
        {
            overlay destroy();
        }
    }
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 1
// Checksum 0x0, Offset: 0xb9b
// Size: 0x25
function function_3d879029586de3( alphavalue )
{
    if ( getdvarint( @"touch_enabled" ) )
    {
        return ( alphavalue * 0.6 );
    }
    
    return alphavalue;
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 1
// Checksum 0x0, Offset: 0xbc9
// Size: 0xf3
function onenterdeathsdoor( smeansofdeath )
{
    if ( istrue( self.deathsdoor ) )
    {
        return;
    }
    
    self.deathsdoor = 1;
    self.painbreathloopsplayed = 0;
    self.var_632fcfdf269b9dc8 = gettime();
    self notify( "startHeartbeatPulse" );
    
    if ( !istrue( self.deathsdoorsfx ) && !istrue( self.var_a9982aba7477cc90 ) )
    {
        self.deathsdoorsfx = 1;
        self stoplocalsound( "deaths_door_out" );
        self playlocalsound( "deaths_door_in" );
        function_501be800abf11f33( 0.2, 1 );
        self enableplayerbreathsystem( 0 );
        self setentitysoundcontext( "deaths_door", "active", 0.1 );
        thread playerbreathingpainsound();
        
        if ( isplayer( self ) && !isbot( self ) )
        {
            function_9030f56a68f604dc();
            function_c2e66bc8cbf81b2d();
        }
    }
    
    if ( level.healthregendisabled )
    {
        self painvisionon();
    }
    
    self notify( "deaths_door_enter" );
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 1
// Checksum 0x0, Offset: 0xcc4
// Size: 0xee
function playerbreathingpainsound( healthcap )
{
    self endon( "death_or_disconnect" );
    self endon( "deaths_door_exit" );
    self endon( "healed" );
    self endon( "joined_spectators" );
    self endon( "last_stand_revived" );
    level endon( "game_ended" );
    self.painbreathloopsplayed = default_to( self.painbreathloopsplayed, 0 );
    wait 0.5;
    
    while ( true )
    {
        if ( isusingremote() )
        {
            waitframe();
            continue;
        }
        
        if ( !val::get( "health_regen" ) || level.healthregendisabled || level.var_be39d6b46044f344 < 40 )
        {
            self.painbreathloopsplayed++;
            
            if ( self.painbreathloopsplayed > ter_op( istrue( self.hasdonepainbreathloopthislife ), 1, 4 ) )
            {
                wait 1;
                self.hasdonepainbreathloopthislife = 1;
                onexitdeathsdoor( 0 );
                break;
            }
        }
        
        self playlocalsound( "plr_breath_pain_ong_exh" );
        wait 1.7;
    }
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 1
// Checksum 0x0, Offset: 0xdba
// Size: 0xdd
function onexitdeathsdoor( healed )
{
    if ( istrue( healed ) )
    {
        self.painbreathloopsplayed = 0;
        self.hasdonepainbreathloopthislife = 0;
    }
    
    if ( !istrue( self.deathsdoor ) )
    {
        return;
    }
    
    self.deathsdoor = 0;
    self.deathsdoorsfx = 0;
    
    if ( isplayer( self ) && !isbot( self ) )
    {
        function_86765f42c27f4bee();
        function_7067dfb2023a23b7();
    }
    
    self stoplocalsound( "deaths_door_in" );
    self playlocalsound( "deaths_door_out" );
    function_a2b4e6088394bade();
    self playlocalsound( ter_op( isfemale(), "Fem_breathing_better", "breathing_better" ) );
    self setentitysoundcontext( "deaths_door", "", 0.1 );
    self enableplayerbreathsystem( 1 );
    
    if ( level.healthregendisabled )
    {
        self painvisionoff();
    }
    
    self notify( "deaths_door_exit" );
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0xe9f
// Size: 0x22
function function_9030f56a68f604dc()
{
    if ( !isdefined( self.damage.deathsdooroverlaypulse ) )
    {
        return;
    }
    
    thread function_41a40f1e0a6aa78e();
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0xec9
// Size: 0x7e
function function_c2e66bc8cbf81b2d()
{
    if ( !isdefined( self.damage.var_5d28af440fb50e5a ) )
    {
        return;
    }
    
    self.damage.var_5d28af440fb50e5a fadeovertime( 0.15 );
    self.damage.var_5d28af440fb50e5a.alpha = function_3d879029586de3( 1 );
    self.damage.var_5d28af440fb50e5a.var_8a8941ad64562137 = 1;
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0xf4f
// Size: 0x10
function function_86765f42c27f4bee()
{
    thread function_47b9c7c77690bb03( 0, 3.5 );
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0xf67
// Size: 0x57
function function_7067dfb2023a23b7()
{
    if ( !isdefined( self.damage.var_5d28af440fb50e5a ) )
    {
        return;
    }
    
    self.damage.var_5d28af440fb50e5a fadeovertime( 2 );
    self.damage.var_5d28af440fb50e5a.alpha = 0;
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0xfc6
// Size: 0x67
function applyshrapnelfx()
{
    self endon( "disconnect" );
    self notify( "applyShrapnelFX" );
    self endon( "applyShrapnelFX" );
    self setclientomnvar( "ui_shrapnel_overlay", 1 );
    self playlocalsound( "iw8_mp_perk_shrapnel" );
    endednormally = applyshrapnelfxinternal();
    
    if ( istrue( endednormally ) )
    {
        self setclientomnvar( "ui_shrapnel_overlay", 2 );
        return;
    }
    
    self setclientomnvar( "ui_shrapnel_overlay", 3 );
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0x1035
// Size: 0x45, Type: bool
function applyshrapnelfxinternal()
{
    self endon( "death" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    level endon( "game_ended" );
    value = waittill_any_return_3( "shrapnel_ended_early", "shrapnel_ended", "force_regeneration" );
    return value == "shrapnel_ended";
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0x1083
// Size: 0x4c
function function_6410111baf734017()
{
    if ( !isdefined( level.var_194088d9669cb53d ) )
    {
        level.var_194088d9669cb53d = getdvarint( @"scr_attacker_time_buffer_ms", 2000 );
        level.var_1736de83d797adc0 = getdvarint( @"hash_2fd03831cb8a51e6", 4000 );
    }
    
    return level.var_194088d9669cb53d;
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0x10d8
// Size: 0x18, Type: bool
function function_549fbfada3618987()
{
    var_194088d9669cb53d = function_6410111baf734017();
    return var_194088d9669cb53d > 2000;
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0x10f9
// Size: 0x66
function updatefirsttimedamaged()
{
    if ( function_549fbfada3618987() )
    {
        assert( isdefined( level.var_1736de83d797adc0 ) );
        
        if ( !isdefined( self.lasttimedamaged ) )
        {
            self.firsttimedamaged = gettime();
            return;
        }
        
        if ( gettime() - self.lasttimedamaged > level.var_1736de83d797adc0 )
        {
            self.firsttimedamaged = gettime();
        }
    }
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0x1167
// Size: 0xd3
function removeoldattackersovertime()
{
    self endon( "damage" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( !isdefined( self.attackers ) )
    {
        return;
    }
    
    var_194088d9669cb53d = function_6410111baf734017();
    
    while ( true )
    {
        time = gettime();
        
        foreach ( guid, attacker in self.attackers )
        {
            if ( isdefined( attacker ) && time - self.attackerdata[ guid ].lasttimedamaged < var_194088d9669cb53d )
            {
                continue;
            }
            
            self.attackers[ guid ] = undefined;
            self.attackerdata[ guid ] = undefined;
        }
        
        waitframe();
    }
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0x1242
// Size: 0x16
function function_446043a04ae1bfe()
{
    self.attackers = [];
    self.attackerdata = [];
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 7
// Checksum 0x0, Offset: 0x1260
// Size: 0x115
function damageeffects( idamage, eattacker, smeansofdeath, vpoint, lightarmordamage, objweapon, shitloc )
{
    self endon( "death_or_disconnect" );
    self notify( "damageEffects" );
    
    if ( !isplayer( self ) || isbot( self ) || issimulationplayer( self ) )
    {
        return;
    }
    
    if ( isingodmode( self ) )
    {
        return;
    }
    
    factor = damageratio( idamage + lightarmordamage );
    
    if ( !isdefined( eattacker ) && smeansofdeath == "MOD_FALLING" )
    {
        eattacker = self;
    }
    
    childthread damagepainvision( vpoint, factor, smeansofdeath, idamage, objweapon );
    childthread damagebloodoverlaydirectional( vpoint, factor, smeansofdeath, idamage, objweapon, shitloc );
    var_2809cfd0f803f738 = { #objweapon:objweapon, #lightarmordamage:lightarmordamage, #vpoint:vpoint, #smeansofdeath:smeansofdeath, #eattacker:eattacker, #idamage:idamage };
    callback::callback( "on_player_damage_effects", var_2809cfd0f803f738 );
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 5
// Checksum 0x0, Offset: 0x137d
// Size: 0xc4
function damagepainvision( vpoint, factor, smeansofdeath, idamage, objweapon )
{
    self endon( "damageEffects" );
    self endon( "death_or_disconnect" );
    
    if ( !shoulddopainvision( objweapon ) )
    {
        return 0;
    }
    
    if ( function_c1af921b6351d49a( smeansofdeath ) )
    {
        self function_2f6b8c6721d18b0b( "vsp_fall" );
        self function_9227c84d3fb311a3( "vsp_bullet" );
        return;
    }
    
    if ( function_3e54581e73dff375( smeansofdeath ) )
    {
        eventtype = "vsp_fall";
    }
    else if ( function_6a97b15cdcd5961b( smeansofdeath ) )
    {
        eventtype = "vsp_fire";
    }
    else if ( function_9ca01a02f4efc7f6( smeansofdeath ) )
    {
        eventtype = "vsp_explosive";
    }
    else
    {
        eventtype = "vsp_bullet";
    }
    
    self function_2f6b8c6721d18b0b( eventtype );
    self function_9227c84d3fb311a3( eventtype );
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 1
// Checksum 0x0, Offset: 0x1449
// Size: 0x46, Type: bool
function shoulddopainvision( objweapon )
{
    if ( istrue( level.wpinprogress ) || istrue( self.focus ) )
    {
        return false;
    }
    
    if ( isdefined( objweapon ) && objweapon.basename == "dragonsbreath_mp" )
    {
        return false;
    }
    
    return true;
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 1
// Checksum 0x0, Offset: 0x1498
// Size: 0x26
function function_52f60ac82b866362( fadetime )
{
    if ( istrue( level.wpinprogress ) )
    {
        return;
    }
    
    self visionsetnakedforplayer( "", fadetime );
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 6
// Checksum 0x0, Offset: 0x14c6
// Size: 0x1ff
function damagebloodoverlaydirectional( vpoint, factor, smeansofdeath, idamage, objweapon, shitloc )
{
    if ( !isdefined( vpoint ) )
    {
        return;
    }
    
    if ( !function_9c9288020fccd597( factor, smeansofdeath, idamage, objweapon, shitloc ) )
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
    
    sides = getplayersidesfromposition( vpoint );
    materialsuffix = "";
    
    if ( function_9ca01a02f4efc7f6( smeansofdeath ) )
    {
        prefix = "fullscreen_dirt_";
    }
    else if ( !scripts\cp_mp\armor::hasarmor() )
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
    
    foreach ( side, type in sides )
    {
        material = prefix + side;
        splashmaterial = material + "_splash";
        material += materialsuffix;
        randomoffsets = createscreeneffectoffsets( randomfloatrange( 0, 1 ), randomfloatrange( 0, 1 ), randomfloatrange( 0, 1 ) );
        createscreeneffect( side, material, 0.15, 2, randomoffsets, 1, 1, 1 );
        createscreeneffect( side, splashmaterial, 0.15, 0.15, randomoffsets, 0, 1, 1 );
    }
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 1
// Checksum 0x0, Offset: 0x16cd
// Size: 0x53, Type: bool
function function_9ca01a02f4efc7f6( smeansofdeath )
{
    explosivemods = [ "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE", "MOD_GRENADE", "MOD_GRENADE_SPLASH" ];
    
    if ( array_contains( explosivemods, smeansofdeath ) )
    {
        return true;
    }
    
    return false;
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 1
// Checksum 0x0, Offset: 0x1729
// Size: 0x24, Type: bool
function function_3e54581e73dff375( smeansofdeath )
{
    if ( smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_IMPACT" )
    {
        return true;
    }
    
    return false;
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 1
// Checksum 0x0, Offset: 0x1756
// Size: 0x19, Type: bool
function function_6a97b15cdcd5961b( smeansofdeath )
{
    if ( smeansofdeath == "MOD_FIRE" )
    {
        return true;
    }
    
    return false;
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 1
// Checksum 0x0, Offset: 0x1778
// Size: 0x19, Type: bool
function function_c1af921b6351d49a( smeansofdeath )
{
    if ( smeansofdeath == "MOD_DOWN" )
    {
        return true;
    }
    
    return false;
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 5
// Checksum 0x0, Offset: 0x179a
// Size: 0xb1, Type: bool
function function_9c9288020fccd597( factor, smeansofdeath, idamage, objweapon, shitloc )
{
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( isdefined( idamage ) && idamage <= 12 )
    {
        return false;
    }
    
    if ( utility::iswegameplatform() )
    {
        return false;
    }
    
    if ( scripts\common\swim_common::isplayerunderwater() )
    {
        return false;
    }
    
    if ( function_3e54581e73dff375( smeansofdeath ) || function_6a97b15cdcd5961b( smeansofdeath ) )
    {
        return false;
    }
    
    if ( isdefined( objweapon ) && objweapon.basename == "dragonsbreath_mp" )
    {
        return false;
    }
    
    if ( istrue( self.inlaststand ) )
    {
        return false;
    }
    
    if ( isdefined( shitloc ) && shitloc == "shield" )
    {
        return false;
    }
    
    return true;
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 1
// Checksum 0x0, Offset: 0x1854
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

// Namespace damage_effects / scripts\common\damage_effects
// Params 3
// Checksum 0x0, Offset: 0x1941
// Size: 0x43
function createscreeneffectoffsets( x, y, scale )
{
    offsets = [];
    offsets[ "x" ] = x;
    offsets[ "y" ] = y;
    offsets[ "scale" ] = scale;
    return offsets;
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 8
// Checksum 0x0, Offset: 0x198d
// Size: 0x29b
function createscreeneffect( side, shader, intime, outtime, randomoffsets, fadein, lowres, containsblood )
{
    hud = newclienthudelem( self );
    hud.sort = 13;
    hud.foreground = 0;
    hud.lowresbackground = lowres;
    hud.horzalign = "fullscreen";
    hud.vertalign = "fullscreen";
    hud.alpha = 0;
    hud.enablehudlighting = 1;
    hud.scramblerdisabled = 1;
    hud.var_8a8941ad64562137 = containsblood;
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
    hud setshader( shader, 640, 480 );
    thread screeneffectcleanup( hud );
    thread animatescreeneffect( hud, intime, outtime, finalx, finaly, finalscale, fadein );
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 1
// Checksum 0x0, Offset: 0x1c30
// Size: 0x27
function screeneffectcleanup( hud )
{
    function_81a2b809749b4189( hud );
    
    if ( isdefined( hud ) )
    {
        hud notify( "destroySreenEffectOverlay" );
        hud destroy();
    }
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 1
// Checksum 0x0, Offset: 0x1c5f
// Size: 0x1a
function function_81a2b809749b4189( hud )
{
    self endon( "death_or_disconnect" );
    hud waittill( "destroySreenEffectOverlay" );
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 7
// Checksum 0x0, Offset: 0x1c81
// Size: 0x166
function animatescreeneffect( hud, intime, outtime, x, y, scale, fadein )
{
    self endon( "death_or_disconnect" );
    hud endon( "destroySreenEffectOverlay" );
    width = int( 640 * scale );
    height = int( 480 * scale );
    
    if ( !fadein )
    {
        width = int( 640 * scale );
        height = int( 480 * scale );
        hud scaleovertime( intime, width, height );
        hud moveovertime( intime );
        hud.x = x;
        hud.y = y;
        intime = 0.05;
        hud.alpha = function_3d879029586de3( 1 );
        wait 0.05;
    }
    else
    {
        hud scaleovertime( intime, width, height );
        hud.x = x;
        hud.y = y;
        wait 0.15;
        hud fadeovertime( intime );
        hud.alpha = function_3d879029586de3( 1 );
        wait intime;
    }
    
    if ( isdefined( hud ) )
    {
        hud fadeovertime( outtime );
        hud.alpha = 0;
    }
    
    wait outtime + 0.05;
    
    if ( isdefined( hud ) )
    {
        hud notify( "destroySreenEffectOverlay" );
    }
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 1
// Checksum 0x0, Offset: 0x1def
// Size: 0x16
function damageratio( idamage )
{
    return math::normalize_value( 10, 40, idamage );
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0x1e0e
// Size: 0x76, Type: bool
function function_2a9705c393c0e2c4()
{
    return self.deathsdoor || isdefined( self.damage ) && isdefined( self.damage.deathsdooroverlaypulse ) && isdefined( self.damage.deathsdooroverlaypulse.var_eeda4296ae80e949 ) && self.damage.deathsdooroverlaypulse.var_eeda4296ae80e949 > 0;
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0x1e8d
// Size: 0x199
function function_41a40f1e0a6aa78e()
{
    self notify( "deaths_door_overlay_pulse" );
    self endon( "death_or_disconnect" );
    self endon( "deaths_door_overlay_pulse" );
    thread function_47b9c7c77690bb03( 1, 0.3 );
    regendelaytime = function_5c0987ada94437df();
    starttime = gettime();
    
    if ( !isdefined( self.heartbeat ) || !isdefined( self.heartbeat.pulsetime ) )
    {
        return;
    }
    
    while ( function_2a9705c393c0e2c4() )
    {
        pulsefraction = self.heartbeat.pulsetime;
        pulsealphamax = math::factor_value( 0.15, 0.45, pulsefraction );
        pulsealphamin = math::factor_value( 0.05, 0.28, pulsefraction );
        timepassed = gettime() - starttime;
        
        if ( regendelaytime > 0 )
        {
            var_3b56fe29ad0cb0b5 = math::normalize_value( 0, regendelaytime, timepassed );
        }
        else
        {
            var_3b56fe29ad0cb0b5 = 0;
        }
        
        pulsealpha = math::factor_value( pulsealphamax, pulsealphamin, var_3b56fe29ad0cb0b5 );
        
        if ( isdefined( self.damage.deathsdooroverlaypulse ) )
        {
            pulsealpha *= self.damage.deathsdooroverlaypulse.var_eeda4296ae80e949;
            pulsealpha = function_3d879029586de3( pulsealpha );
            self.damage.deathsdooroverlaypulse fadeovertime( 0.05 );
            self.damage.deathsdooroverlaypulse.alpha = pulsealpha;
        }
        
        waitframe();
    }
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 2
// Checksum 0x0, Offset: 0x202e
// Size: 0x106
function function_252173bf5ac108a3( startalpha, time )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( self.deathsdoor )
    {
        return;
    }
    
    if ( !isdefined( self.damage ) )
    {
        return;
    }
    
    self notify( "deaths_door_overlay_pulse_oneoff" );
    self endon( "deaths_door_overlay_pulse_oneoff" );
    self endon( "deaths_door_overlay_pulse" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    starttime = time;
    
    while ( time > 0 )
    {
        if ( !isdefined( self.damage.deathsdooroverlaypulse ) )
        {
            return;
        }
        
        timefactor = math::normalize_value( 0, starttime, time );
        pulsealpha = math::factor_value( 0, startalpha, timefactor );
        pulsealpha = function_3d879029586de3( pulsealpha );
        self.damage.deathsdooroverlaypulse fadeovertime( 0.05 );
        self.damage.deathsdooroverlaypulse.alpha = pulsealpha;
        wait 0.05;
        time -= 0.05;
    }
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 2
// Checksum 0x0, Offset: 0x213c
// Size: 0x149
function function_47b9c7c77690bb03( targetalpha, time )
{
    self notify( "lerpDeathDoorOverlayAlpha" );
    self endon( "lerpDeathDoorOverlayAlpha" );
    self endon( "death_or_disconnect" );
    
    if ( !isdefined( self.damage ) || !isdefined( self.damage.deathsdooroverlaypulse ) )
    {
        return;
    }
    
    timer = time;
    startalpha = self.damage.deathsdooroverlaypulse.var_eeda4296ae80e949;
    
    while ( timer > 0 )
    {
        if ( !isdefined( self.damage ) || !isdefined( self.damage.deathsdooroverlaypulse ) )
        {
            return;
        }
        
        normtime = math::normalize_value( 0, time, timer );
        var_eeda4296ae80e949 = math::factor_value( targetalpha, startalpha, normtime );
        self.damage.deathsdooroverlaypulse.var_eeda4296ae80e949 = var_eeda4296ae80e949;
        timer -= 0.05;
        waitframe();
    }
    
    if ( isdefined( self.damage ) && isdefined( self.damage.deathsdooroverlaypulse ) )
    {
        self.damage.deathsdooroverlaypulse.var_eeda4296ae80e949 = targetalpha;
    }
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 1
// Checksum 0x0, Offset: 0x228d
// Size: 0xf0
function falldamageeffects( falldamage )
{
    factor = falldamage / self.maxhealth;
    var_2ff497a47c266950 = getdvarfloat( @"scr_falling_damage_min_shock_factor", 0.5 );
    
    if ( factor >= var_2ff497a47c266950 )
    {
        var_4bc08db3876de031 = getdvarfloat( @"scr_falling_damage_max_shock_duration", 3 );
        var_b1505e7ce3af8fea = 1 - var_2ff497a47c266950;
        shockfactor = ( factor - var_2ff497a47c266950 ) / var_b1505e7ce3af8fea;
        shockduration = shockfactor * var_4bc08db3876de031;
        scripts\cp_mp\utility\shellshock_utility::_shellshock( "falldamage", "damage", shockduration, 0, 0 );
    }
    
    pulsetime = math::factor_value( 0.5, 0.5, factor );
    pulsealpha = math::factor_value( 0.3, 0.7, factor );
    function_252173bf5ac108a3( pulsealpha, pulsetime );
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 0
// Checksum 0x0, Offset: 0x2385
// Size: 0x52
function function_54117659a8e5c5b4()
{
    self.var_dd452cc5c546120b = "deaths_door_mp";
    
    if ( isdefined( level.var_c3934394c0f5cb03 ) )
    {
        self.var_dd452cc5c546120b = level.var_c3934394c0f5cb03;
        return;
    }
    
    if ( level.gametype == "dungeons" )
    {
        self.var_dd452cc5c546120b = "deaths_door_sp";
    }
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 2
// Checksum 0x0, Offset: 0x23df
// Size: 0x64
function function_501be800abf11f33( fadetime, scale )
{
    str_submix = default_to( self.var_dd452cc5c546120b, "deaths_door_mp" );
    n_fadetime = default_to( fadetime, -1 );
    n_scale = default_to( scale, 1 );
    self setsoundsubmix( str_submix, n_fadetime, n_scale );
}

// Namespace damage_effects / scripts\common\damage_effects
// Params 1
// Checksum 0x0, Offset: 0x244b
// Size: 0x56
function function_a2b4e6088394bade( fadetime )
{
    str_submix = default_to( self.var_dd452cc5c546120b, "deaths_door_mp" );
    n_fadetime = default_to( fadetime, undefined );
    
    if ( isdefined( n_fadetime ) )
    {
        self clearsoundsubmix( str_submix, n_fadetime );
        return;
    }
    
    self clearsoundsubmix( str_submix );
}

