#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\movers;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\weapons;

#namespace placeable;

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 0
// Checksum 0x0, Offset: 0x32e
// Size: 0x19
function init()
{
    if ( !isdefined( level.placeableconfigs ) )
    {
        level.placeableconfigs = [];
    }
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 2
// Checksum 0x0, Offset: 0x34f
// Size: 0x79, Type: bool
function giveplaceable( streakname, var_41dbe7a9c2a55dab )
{
    placeable = createplaceable( streakname );
    removeperks();
    self.carrieditem = placeable;
    
    /#
        if ( getdvarint( @"hash_cae913bf39486207", 0 ) != 0 )
        {
            var_41dbe7a9c2a55dab = 0;
        }
    #/
    
    result = onbegincarrying( streakname, placeable, 1, var_41dbe7a9c2a55dab );
    self.carrieditem = undefined;
    restoreperks();
    return isdefined( placeable );
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 1
// Checksum 0x0, Offset: 0x3d1
// Size: 0x10f
function createplaceable( streakname )
{
    if ( isdefined( self.iscarrying ) && self.iscarrying )
    {
        return;
    }
    
    config = level.placeableconfigs[ streakname ];
    obj = spawn( "script_model", self.origin );
    obj setmodel( config.modelbase );
    obj.angles = self.angles;
    obj.owner = self;
    obj.team = self.team;
    obj.config = config;
    obj.firstplacement = 1;
    
    if ( isdefined( config.oncreatedelegate ) )
    {
        obj [[ config.oncreatedelegate ]]( streakname );
    }
    
    obj deactivate( streakname );
    obj thread timeout( streakname );
    obj thread handleuse( streakname );
    obj thread onkillstreakdisowned( streakname );
    obj thread ongameended( streakname );
    return obj;
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 1
// Checksum 0x0, Offset: 0x4e9
// Size: 0x86
function handleuse( streakname )
{
    self endon( "death" );
    level endon( "game_ended" );
    
    while ( true )
    {
        self waittill( "trigger", player );
        assert( player == self.owner );
        assert( !isdefined( self.carriedby ) );
        
        if ( !isreallyalive( player ) )
        {
            continue;
        }
        
        if ( isdefined( self getlinkedparent() ) )
        {
            self unlink();
        }
        
        player onbegincarrying( streakname, self, 0 );
    }
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 4
// Checksum 0x0, Offset: 0x577
// Size: 0x1ae
function onbegincarrying( streakname, placeable, allowcancel, var_41dbe7a9c2a55dab )
{
    self endon( "death_or_disconnect" );
    assert( isreallyalive( self ) );
    placeable thread oncarried( streakname, self );
    val::set( "carry", "weapon", 0 );
    
    if ( !isai( self ) )
    {
        self notifyonplayercommand( "placePlaceable", "+attack" );
        self notifyonplayercommand( "placePlaceable", "+attack_akimbo_accessible" );
        self notifyonplayercommand( "cancelPlaceable", "+actionslot 4" );
        
        if ( !self isconsoleplayer() )
        {
            self notifyonplayercommand( "cancelPlaceable", "+actionslot 5" );
            self notifyonplayercommand( "cancelPlaceable", "+actionslot 6" );
            self notifyonplayercommand( "cancelPlaceable", "+actionslot 7" );
        }
    }
    
    while ( true )
    {
        if ( isdefined( var_41dbe7a9c2a55dab ) && var_41dbe7a9c2a55dab == 1 && !self isonladder() && self isonground() && !self ismantling() )
        {
            result = "placePlaceable";
        }
        else
        {
            result = waittill_any_return_3( "placePlaceable", "cancelPlaceable", "force_cancel_placement" );
        }
        
        if ( !isdefined( placeable ) )
        {
            val::reset_all( "carry" );
            return 1;
        }
        
        if ( result == "cancelPlaceable" && allowcancel || result == "force_cancel_placement" )
        {
            placeable oncancel( streakname, result == "force_cancel_placement" && !isdefined( placeable.firstplacement ) );
            return 0;
        }
        
        if ( placeable.canbeplaced )
        {
            placeable thread onplaced( streakname );
            val::reset_all( "carry" );
            return 1;
        }
        
        waitframe();
    }
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 2
// Checksum 0x0, Offset: 0x72d
// Size: 0xe3
function oncancel( streakname, var_ddd5b75d0cd367c5 )
{
    if ( isdefined( self.carriedby ) )
    {
        owner = self.carriedby;
        owner forceusehintoff();
        owner.iscarrying = undefined;
        owner.carrieditem = undefined;
        owner val::reset_all( "carry" );
    }
    
    if ( isdefined( self.bombsquadmodel ) )
    {
        self.bombsquadmodel delete();
    }
    
    if ( isdefined( self.carriedobj ) )
    {
        self.carriedobj delete();
    }
    
    config = level.placeableconfigs[ streakname ];
    
    if ( isdefined( config.oncanceldelegate ) )
    {
        self [[ config.oncanceldelegate ]]( streakname );
    }
    
    if ( isdefined( var_ddd5b75d0cd367c5 ) && var_ddd5b75d0cd367c5 )
    {
        scripts\mp\weapons::equipmentdeletevfx();
    }
    
    self delete();
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 1
// Checksum 0x0, Offset: 0x818
// Size: 0x26b
function onplaced( streakname )
{
    config = level.placeableconfigs[ streakname ];
    self.origin = self.placementorigin;
    self.angles = self.carriedobj.angles;
    self playsound( config.placedsfx );
    showplacedmodel( streakname );
    
    if ( isdefined( config.onplaceddelegate ) )
    {
        self [[ config.onplaceddelegate ]]( streakname );
    }
    
    owner = self.owner;
    owner forceusehintoff();
    owner.iscarrying = undefined;
    self.carriedby = undefined;
    self.isplaced = 1;
    self.firstplacement = undefined;
    
    if ( isdefined( config.headiconheight ) )
    {
        self.headiconid = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, config.headiconheight, 0, undefined, undefined, undefined, 1 );
    }
    
    thread handledamage( streakname );
    thread handledeath( streakname );
    self makeusable();
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( config.hintstring );
    scripts\mp\sentientpoolmanager::registersentient( "Killstreak_Ground", self.owner );
    
    foreach ( player in level.players )
    {
        if ( player == owner )
        {
            self enableplayeruse( player );
            continue;
        }
        
        self disableplayeruse( player );
    }
    
    if ( isdefined( self.shouldsplash ) )
    {
        level thread teamplayercardsplash( config.splashname, owner );
        self.shouldsplash = 0;
    }
    
    data = spawnstruct();
    data.linkparent = self.moving_platform;
    data.endonstring = "carried";
    
    if ( isdefined( config.onmovingplatformcollision ) )
    {
        data.deathoverridecallback = config.onmovingplatformcollision;
    }
    
    thread scripts\mp\movers::handle_moving_platforms( data );
    thread watchplayerconnected();
    self notify( "placed" );
    self.carriedobj delete();
    self.carriedobj = undefined;
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 2
// Checksum 0x0, Offset: 0xa8b
// Size: 0xd0
function oncarried( streakname, carrier )
{
    config = level.placeableconfigs[ streakname ];
    assert( isplayer( carrier ) );
    assertex( carrier == self.owner, "<dev string:x1c>" );
    self.carriedobj = carrier createcarriedobject( streakname );
    self.isplaced = undefined;
    self.carriedby = carrier;
    carrier.iscarrying = 1;
    deactivate( streakname );
    hideplacedmodel( streakname );
    
    if ( isdefined( config.oncarrieddelegate ) )
    {
        self [[ config.oncarrieddelegate ]]( streakname );
    }
    
    thread updateplacement( streakname, carrier );
    thread oncarrierdeath( streakname, carrier );
    self notify( "carried" );
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 2
// Checksum 0x0, Offset: 0xb63
// Size: 0x1e9
function updateplacement( streakname, carrier )
{
    carrier endon( "death_or_disconnect" );
    level endon( "game_ended" );
    self endon( "placed" );
    self endon( "death" );
    self.canbeplaced = 1;
    prevcanbeplaced = -1;
    config = level.placeableconfigs[ streakname ];
    placementoffset = ( 0, 0, 0 );
    
    if ( isdefined( config.placementoffsetz ) )
    {
        placementoffset = ( 0, 0, config.placementoffsetz );
    }
    
    carriedobj = self.carriedobj;
    
    while ( true )
    {
        placement = carrier canplayerplacesentry( 1, config.placementradius );
        self.placementorigin = placement[ "origin" ];
        carriedobj.origin = self.placementorigin + placementoffset;
        carriedobj.angles = placement[ "angles" ];
        self.canbeplaced = carrier isonground() && placement[ "result" ] && abs( self.placementorigin[ 2 ] - carrier.origin[ 2 ] ) < config.placementheighttolerance;
        
        if ( isdefined( placement[ "entity" ] ) )
        {
            self.moving_platform = placement[ "entity" ];
        }
        else
        {
            self.moving_platform = undefined;
        }
        
        if ( self.canbeplaced != prevcanbeplaced )
        {
            if ( self.canbeplaced )
            {
                carriedobj setmodel( config.modelplacement );
                carrier forceusehinton( config.placestring );
            }
            else
            {
                carriedobj setmodel( config.modelplacementfailed );
                carrier forceusehinton( config.cannotplacestring );
            }
        }
        
        prevcanbeplaced = self.canbeplaced;
        waitframe();
    }
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 1
// Checksum 0x0, Offset: 0xd54
// Size: 0x4f
function deactivate( streakname )
{
    self makeunusable();
    hideheadicons();
    config = level.placeableconfigs[ streakname ];
    
    if ( isdefined( config.ondeactivedelegate ) )
    {
        self [[ config.ondeactivedelegate ]]( streakname );
    }
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 0
// Checksum 0x0, Offset: 0xdab
// Size: 0x12
function hideheadicons()
{
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( self.headiconid );
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 1
// Checksum 0x0, Offset: 0xdc5
// Size: 0x52
function handledamage( streakname )
{
    self endon( "carried" );
    config = level.placeableconfigs[ streakname ];
    scripts\mp\damage::monitordamage( config.maxhealth, config.damagefeedback, &handledeathdamage, &modifydamage, 1 );
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 1
// Checksum 0x0, Offset: 0xe1f
// Size: 0x12c
function modifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    modifieddamage = damage;
    config = self.config;
    
    if ( isdefined( config.allowmeleedamage ) && config.allowmeleedamage )
    {
        modifieddamage = utility::handlemeleedamage( objweapon, type, modifieddamage );
    }
    
    if ( isdefined( config.allowempdamage ) && config.allowempdamage )
    {
        modifieddamage = scripts\mp\damage::handleempdamage( objweapon, type, modifieddamage );
    }
    
    modifieddamage = scripts\mp\damage::handlemissiledamage( objweapon, type, modifieddamage );
    modifieddamage = scripts\mp\damage::handlegrenadedamage( objweapon, type, modifieddamage );
    modifieddamage = scripts\mp\damage::handleapdamage( objweapon, type, modifieddamage, attacker );
    
    if ( isdefined( config.modifydamage ) )
    {
        modifieddamage = self [[ config.modifydamage ]]( objweapon, type, modifieddamage );
    }
    
    return modifieddamage;
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 1
// Checksum 0x0, Offset: 0xf54
// Size: 0xde
function handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    config = self.config;
    notifyattacker = scripts\mp\damage::onkillstreakkilled( self.streakname, attacker, objweapon, type, damage, config.scorepopup, config.destroyedvo );
    
    if ( notifyattacker && isdefined( config.ondestroyeddelegate ) )
    {
        self [[ config.ondestroyeddelegate ]]( self.streakname, attacker, self.owner, type );
    }
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 1
// Checksum 0x0, Offset: 0x103a
// Size: 0x85
function handledeath( streakname )
{
    self endon( "carried" );
    self waittill( "death" );
    config = level.placeableconfigs[ streakname ];
    
    if ( isdefined( self ) )
    {
        deactivate( streakname );
        
        if ( isdefined( config.modeldestroyed ) )
        {
            self setmodel( config.modeldestroyed );
        }
        
        if ( isdefined( config.ondeathdelegate ) )
        {
            self [[ config.ondeathdelegate ]]( streakname );
        }
        
        self delete();
    }
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 2
// Checksum 0x0, Offset: 0x10c7
// Size: 0x50
function oncarrierdeath( streakname, carrier )
{
    self endon( "placed" );
    self endon( "death" );
    carrier endon( "disconnect" );
    carrier waittill( "death" );
    
    if ( self.canbeplaced )
    {
        thread onplaced( streakname );
        return;
    }
    
    oncancel( streakname );
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 1
// Checksum 0x0, Offset: 0x111f
// Size: 0x43
function onkillstreakdisowned( streakname )
{
    self endon( "death" );
    level endon( "game_ended" );
    childthread watchownerstatus( "disconnect", streakname );
    childthread watchownerstatus( "joined_team", streakname );
    childthread watchownerstatus( "joined_spectators", streakname );
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 2
// Checksum 0x0, Offset: 0x116a
// Size: 0x27
function watchownerstatus( notifymsg, streakname )
{
    self.owner waittill( notifymsg );
    cleanup( streakname );
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 1
// Checksum 0x0, Offset: 0x1199
// Size: 0x22
function ongameended( streakname )
{
    self endon( "death" );
    level waittill( "game_ended" );
    cleanup( streakname );
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 1
// Checksum 0x0, Offset: 0x11c3
// Size: 0x2b
function cleanup( streakname )
{
    if ( isdefined( self.isplaced ) )
    {
        self notify( "death" );
        return;
    }
    
    oncancel( streakname );
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 0
// Checksum 0x0, Offset: 0x11f6
// Size: 0x2e
function watchplayerconnected()
{
    self endon( "death" );
    
    while ( true )
    {
        level waittill( "connected", player );
        thread onplayerconnected( player );
    }
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 1
// Checksum 0x0, Offset: 0x122c
// Size: 0x29
function onplayerconnected( owner )
{
    self endon( "death" );
    owner endon( "disconnect" );
    owner waittill( "spawned_player" );
    self disableplayeruse( owner );
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 1
// Checksum 0x0, Offset: 0x125d
// Size: 0xb6
function timeout( streakname )
{
    self endon( "death" );
    level endon( "game_ended" );
    config = level.placeableconfigs[ streakname ];
    lifespan = config.lifespan;
    
    while ( lifespan > 0 )
    {
        wait 1;
        scripts\mp\hostmigration::waittillhostmigrationdone();
        
        if ( !isdefined( self.carriedby ) )
        {
            lifespan -= 1;
        }
    }
    
    if ( isdefined( self.owner ) && isdefined( config.gonevo ) )
    {
        self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer( config.gonevo );
    }
    
    self notify( "death" );
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 0
// Checksum 0x0, Offset: 0x131b
// Size: 0x2a
function removeweapons()
{
    if ( self hasweapon( "iw6_riotshield_mp" ) )
    {
        self.restoreweapon = "iw6_riotshield_mp";
        _takeweapon( "iw6_riotshield_mp" );
    }
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 0
// Checksum 0x0, Offset: 0x134d
// Size: 0x2a
function removeperks()
{
    if ( _hasperk( "specialty_explosivebullets" ) )
    {
        self.restoreperk = "specialty_explosivebullets";
        removeperk( "specialty_explosivebullets" );
    }
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 0
// Checksum 0x0, Offset: 0x137f
// Size: 0x29
function restoreweapons()
{
    if ( isdefined( self.restoreweapon ) )
    {
        _giveweapon( self.restoreweapon );
        self.restoreweapon = undefined;
    }
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 0
// Checksum 0x0, Offset: 0x13b0
// Size: 0x29
function restoreperks()
{
    if ( isdefined( self.restoreperk ) )
    {
        giveperk( self.restoreperk );
        self.restoreperk = undefined;
    }
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 1
// Checksum 0x0, Offset: 0x13e1
// Size: 0x36
function showplacedmodel( streakname )
{
    self show();
    
    if ( isdefined( self.bombsquadmodel ) )
    {
        self.bombsquadmodel show();
        level notify( "update_bombsquad" );
    }
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 1
// Checksum 0x0, Offset: 0x141f
// Size: 0x2e
function hideplacedmodel( streakname )
{
    self hide();
    
    if ( isdefined( self.bombsquadmodel ) )
    {
        self.bombsquadmodel hide();
    }
}

// Namespace placeable / scripts\mp\killstreaks\placeable
// Params 1
// Checksum 0x0, Offset: 0x1455
// Size: 0xf4
function createcarriedobject( streakname )
{
    assertex( isdefined( self ), "<dev string:x5e>" );
    
    if ( isdefined( self.iscarrying ) && self.iscarrying )
    {
        return;
    }
    
    carriedobj = spawnturret( "misc_turret", self.origin + ( 0, 0, 25 ), "sentry_minigun_mp" );
    carriedobj.angles = self.angles;
    carriedobj.owner = self;
    config = level.placeableconfigs[ streakname ];
    carriedobj setmodel( config.modelbase );
    carriedobj maketurretinoperable();
    carriedobj setturretmodechangewait( 1 );
    carriedobj setmode( "sentry_offline" );
    carriedobj makeunusable();
    carriedobj setsentryowner( self );
    carriedobj setsentrycarrier( self );
    carriedobj setcandamage( 0 );
    carriedobj notsolid();
    return carriedobj;
}

