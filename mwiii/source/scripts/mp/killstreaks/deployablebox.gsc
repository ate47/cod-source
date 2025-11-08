#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\gameobjects;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\deployablebox;
#using scripts\mp\movers;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\shellshock;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\weapon;

#namespace deployablebox;

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 0
// Checksum 0x0, Offset: 0x3a3
// Size: 0x19
function init()
{
    if ( !isdefined( level.boxsettings ) )
    {
        level.boxsettings = [];
    }
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 8
// Checksum 0x0, Offset: 0x3c4
// Size: 0x60, Type: bool
function begindeployableviamarker( streakinfo, lifeid, boxtype, projectileentity, weaponname, damagefuncoverride, deathfuncoverride, var_2deffe8b3af50b42 )
{
    thread scripts\mp\killstreaks\deployablebox::cleanupdeployablemarkerondisconnect( projectileentity );
    thread watchdeployablemarkerplacement( streakinfo, boxtype, lifeid, projectileentity, weaponname, damagefuncoverride, deathfuncoverride, var_2deffe8b3af50b42 );
    return true;
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 8
// Checksum 0x0, Offset: 0x42d
// Size: 0x11b
function watchdeployablemarkerplacement( streakinfo, boxtype, lifeid, marker, weaponname, damagefunc, deathfunc, timeoutfunc )
{
    self endon( "spawned_player" );
    self endon( "disconnect" );
    
    if ( !isdefined( marker ) )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    if ( !isdefined( weaponname ) )
    {
        assertmsg( "<dev string:x8e>" );
        return;
    }
    
    if ( !isreallyalive( self ) )
    {
        marker delete();
    }
    
    marker makecollidewithitemclip( 1 );
    self notify( "deployable_deployed" );
    marker.owner = self;
    marker.weaponname = weaponname;
    self.marker = marker;
    
    if ( isgrenadedeployable( boxtype ) )
    {
        self thread [[ level.boxsettings[ boxtype ].grenadeusefunc ]]( marker );
        return;
    }
    
    marker playsoundtoplayer( level.boxsettings[ boxtype ].deployedsfx, self );
    marker thread markeractivate( streakinfo, lifeid, boxtype, &box_setactive, damagefunc, deathfunc, timeoutfunc );
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x550
// Size: 0x3b
function cleanupdeployablemarkerondisconnect( marker )
{
    marker endon( "death" );
    marker endon( "late_missile_stuck" );
    marker thread scripts\mp\utility\script::notifyafterframeend( "missile_stuck", "late_missile_stuck" );
    self waittill( "disconnect" );
    marker delete();
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x593
// Size: 0x1e
function override_box_moving_platform_death( data )
{
    self.isdestroyed = 1;
    self notify( "death" );
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 7
// Checksum 0x0, Offset: 0x5b9
// Size: 0x1e2
function markeractivate( streakinfo, lifeid, boxtype, usedcallback, damagecallback, deathcallback, timeoutcallback )
{
    self notify( "markerActivate" );
    self endon( "markerActivate" );
    self waittill( "missile_stuck" );
    owner = self.owner;
    position = self.origin;
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    box = createboxforplayer( boxtype, position, owner );
    data = spawnstruct();
    data.linkparent = self getlinkedparent();
    
    if ( isdefined( data.linkparent ) && isdefined( data.linkparent.model ) && data.linkparent.model != "" )
    {
        box.origin = data.linkparent.origin;
        grandparent = data.linkparent getlinkedparent();
        
        if ( isdefined( grandparent ) )
        {
            data.linkparent = grandparent;
        }
        else
        {
            data.linkparent = undefined;
        }
    }
    
    data.deathoverridecallback = &override_box_moving_platform_death;
    box thread scripts\mp\movers::handle_moving_platforms( data );
    box.moving_platform = data.linkparent;
    box setotherent( owner );
    waitframe();
    box thread [[ usedcallback ]]( damagecallback, deathcallback, timeoutcallback );
    level callback::callback( "killstreak_finish_use", { #streakinfo:streakinfo } );
    self delete();
    
    if ( isdefined( box ) && box touchingbadtrigger() )
    {
        self.isdestroyed = 1;
        box notify( "death" );
    }
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x7a3
// Size: 0x41, Type: bool
function deployableexclusion( parentmodel )
{
    if ( parentmodel == "mp_satcom" )
    {
        return true;
    }
    else if ( issubstr( parentmodel, "paris_catacombs_iron" ) )
    {
        return true;
    }
    else if ( issubstr( parentmodel, "mp_warhawk_iron_gate" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 0
// Checksum 0x0, Offset: 0x7ed
// Size: 0x7c, Type: bool
function isholdingdeployablebox()
{
    curweap = self getcurrentweapon();
    
    if ( isdefined( curweap ) )
    {
        foreach ( var_98770f6793c42216 in level.boxsettings )
        {
            if ( getcompleteweaponname( curweap ) == var_98770f6793c42216.weaponinfo )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 3
// Checksum 0x0, Offset: 0x872
// Size: 0x164
function createboxforplayer( boxtype, position, owner )
{
    assertex( isdefined( owner ), "<dev string:xfd>" );
    var_86280fefb94b6b28 = level.boxsettings[ boxtype ];
    box = spawn( "script_model", position - ( 0, 0, 1 ) );
    box setmodel( var_86280fefb94b6b28.modelbase );
    box.health = 999999;
    box.maxhealth = var_86280fefb94b6b28.maxhealth;
    box.angles = owner.angles;
    box.boxtype = boxtype;
    box.owner = owner;
    box.team = owner.team;
    box.id = var_86280fefb94b6b28.id;
    
    if ( isdefined( var_86280fefb94b6b28.dpadname ) )
    {
        box.dpadname = var_86280fefb94b6b28.dpadname;
    }
    
    if ( isdefined( var_86280fefb94b6b28.maxuses ) )
    {
        box.usesremaining = var_86280fefb94b6b28.maxuses;
    }
    
    box box_setinactive();
    box thread box_handleownerdisconnect();
    box addboxtolevelarray();
    return box;
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 3
// Checksum 0x0, Offset: 0x9df
// Size: 0x44f
function box_setactive( damagecallback, deathcallback, timeoutcallback )
{
    var_86280fefb94b6b28 = level.boxsettings[ self.boxtype ];
    self.inuse = 0;
    curobjid = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    
    if ( curobjid == -1 )
    {
        return;
    }
    
    scripts\mp\objidpoolmanager::objective_add_objective( curobjid, "invisible", ( 0, 0, 0 ) );
    
    if ( !isdefined( self getlinkedparent() ) )
    {
        scripts\mp\objidpoolmanager::update_objective_position( curobjid, self.origin );
    }
    else
    {
        scripts\mp\objidpoolmanager::update_objective_onentity( curobjid, self );
    }
    
    scripts\mp\objidpoolmanager::update_objective_state( curobjid, "active" );
    scripts\mp\objidpoolmanager::update_objective_icon( curobjid, var_86280fefb94b6b28.shadername );
    scripts\mp\objidpoolmanager::update_objective_setbackground( curobjid, 1 );
    self.objidfriendly = curobjid;
    
    if ( level.teambased )
    {
        if ( curobjid != -1 )
        {
            scripts\mp\objidpoolmanager::objective_teammask_single( curobjid, self.team );
        }
        
        box_seticon( self.team, var_86280fefb94b6b28.streakname, var_86280fefb94b6b28.headiconoffset );
        
        foreach ( player in level.players )
        {
            if ( self.team != player.team )
            {
                continue;
            }
            
            if ( isdefined( var_86280fefb94b6b28.canusecallback ) && !player [[ var_86280fefb94b6b28.canusecallback ]]( self ) )
            {
                if ( isdefined( self.boxiconid ) )
                {
                    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( self.boxiconid, player );
                }
            }
        }
    }
    else
    {
        if ( curobjid != -1 )
        {
            scripts\mp\objidpoolmanager::objective_playermask_single( curobjid, self.owner );
        }
        
        if ( !isdefined( var_86280fefb94b6b28.canusecallback ) || self.owner [[ var_86280fefb94b6b28.canusecallback ]]( self ) )
        {
            box_seticon( self.owner, var_86280fefb94b6b28.streakname, var_86280fefb94b6b28.headiconoffset );
        }
    }
    
    self makeusable();
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( var_86280fefb94b6b28.hintstring );
    self setusehideprogressbar( 1 );
    self.isusable = 1;
    self setcandamage( 1 );
    
    if ( isdefined( damagecallback ) )
    {
        self thread [[ damagecallback ]]();
    }
    else
    {
        thread box_handledamage();
    }
    
    if ( isdefined( deathcallback ) )
    {
        self thread [[ deathcallback ]]();
    }
    else
    {
        thread box_handledeath();
    }
    
    if ( isdefined( timeoutcallback ) )
    {
        self thread [[ timeoutcallback ]]();
    }
    else
    {
        thread box_timeout();
    }
    
    scripts\mp\sentientpoolmanager::registersentient( "Tactical_Ground", self.owner );
    
    if ( isdefined( self.owner ) )
    {
        self.owner notify( "new_deployable_box", self );
    }
    
    if ( level.teambased )
    {
        foreach ( player in level.participants )
        {
            if ( istrue( var_86280fefb94b6b28.isteamless ) )
            {
                _box_setactivehelper( player, 1, var_86280fefb94b6b28.canusecallback );
            }
            else
            {
                _box_setactivehelper( player, self.team == player.team, var_86280fefb94b6b28.canusecallback );
            }
            
            if ( !isai( player ) )
            {
                thread box_playerjoinedteam( player );
            }
        }
    }
    else
    {
        foreach ( player in level.participants )
        {
            _box_setactivehelper( player, isdefined( self.owner ) && self.owner == player, var_86280fefb94b6b28.canusecallback );
        }
    }
    
    thread box_playerconnected();
    thread box_agentconnected();
    
    if ( isdefined( var_86280fefb94b6b28.ondeploycallback ) )
    {
        self [[ var_86280fefb94b6b28.ondeploycallback ]]( var_86280fefb94b6b28 );
    }
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 3
// Checksum 0x0, Offset: 0xe36
// Size: 0x5e
function _box_setactivehelper( player, bactivate, canusefunc )
{
    if ( bactivate )
    {
        if ( !isdefined( canusefunc ) || player [[ canusefunc ]]( self ) )
        {
            box_enableplayeruse( player );
        }
        else
        {
            box_disableplayeruse( player );
            thread doubledip( player );
        }
        
        thread boxthink( player );
        return;
    }
    
    box_disableplayeruse( player );
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 0
// Checksum 0x0, Offset: 0xe9c
// Size: 0x2e
function box_playerconnected()
{
    self endon( "death" );
    
    while ( true )
    {
        level waittill( "connected", player );
        childthread box_waittill_player_spawn_and_add_box( player );
    }
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 0
// Checksum 0x0, Offset: 0xed2
// Size: 0x2d
function box_agentconnected()
{
    self endon( "death" );
    
    while ( true )
    {
        level waittill( "spawned_agent_player", agent );
        box_addboxforplayer( agent );
    }
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0xf07
// Size: 0x30
function box_waittill_player_spawn_and_add_box( player )
{
    player waittill( "spawned_player" );
    
    if ( level.teambased )
    {
        box_addboxforplayer( player );
        thread box_playerjoinedteam( player );
    }
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0xf3f
// Size: 0x3d
function box_playerjoinedteam( player )
{
    self endon( "death" );
    player endon( "disconnect" );
    
    while ( true )
    {
        player waittill( "joined_team" );
        
        if ( level.teambased )
        {
            box_addboxforplayer( player );
        }
    }
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0xf84
// Size: 0x7f
function box_addboxforplayer( player )
{
    if ( self.team == player.team || istrue( level.boxsettings[ self.boxtype ].isteamless ) )
    {
        box_enableplayeruse( player );
        thread boxthink( player );
        return;
    }
    
    box_disableplayeruse( player );
    
    if ( isdefined( self.boxiconid ) )
    {
        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( self.boxiconid, player );
    }
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 3
// Checksum 0x0, Offset: 0x100b
// Size: 0x85
function box_seticon( player, streakname, voffset )
{
    var_86280fefb94b6b28 = level.boxsettings[ self.boxtype ];
    headicon = getkillstreakoverheadicon( streakname );
    
    if ( isdefined( var_86280fefb94b6b28.headicon ) )
    {
        headicon = var_86280fefb94b6b28.headicon;
    }
    
    if ( !scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924() )
    {
        self.boxiconid = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage( player, headicon, voffset, 1 );
    }
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x1098
// Size: 0x2e
function box_enableplayeruse( player )
{
    if ( isplayer( player ) )
    {
        self enableplayeruse( player );
    }
    
    self.disabled_use_for[ player getentitynumber() ] = 0;
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x10ce
// Size: 0x2f
function box_disableplayeruse( player )
{
    if ( isplayer( player ) )
    {
        self disableplayeruse( player );
    }
    
    self.disabled_use_for[ player getentitynumber() ] = 1;
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 0
// Checksum 0x0, Offset: 0x1105
// Size: 0x30
function box_setinactive()
{
    self makeunusable();
    self.isusable = 0;
    
    if ( isdefined( self.objidfriendly ) )
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( self.objidfriendly );
    }
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 0
// Checksum 0x0, Offset: 0x113d
// Size: 0x4a
function box_handledamage()
{
    var_86280fefb94b6b28 = level.boxsettings[ self.boxtype ];
    scripts\mp\damage::monitordamage( var_86280fefb94b6b28.maxhealth, var_86280fefb94b6b28.damagefeedback, &box_handledeathdamage, &box_modifydamage, 1 );
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x118f
// Size: 0xdb
function box_modifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    modifieddamage = damage;
    var_86280fefb94b6b28 = level.boxsettings[ self.boxtype ];
    
    if ( var_86280fefb94b6b28.allowmeleedamage )
    {
        modifieddamage = utility::handlemeleedamage( objweapon, type, modifieddamage );
    }
    
    modifieddamage = scripts\mp\damage::handlemissiledamage( objweapon, type, modifieddamage );
    modifieddamage = scripts\mp\damage::handlegrenadedamage( objweapon, type, modifieddamage );
    modifieddamage = scripts\mp\damage::handleapdamage( objweapon, type, modifieddamage, attacker );
    return modifieddamage;
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x1273
// Size: 0xc4
function box_handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    self.destroyedbydamage = 1;
    var_86280fefb94b6b28 = level.boxsettings[ self.boxtype ];
    notifyattacker = scripts\mp\damage::onkillstreakkilled( "deployable_ammo", attacker, objweapon, type, damage, var_86280fefb94b6b28.scorepopup, var_86280fefb94b6b28.vodestroyed );
    
    if ( notifyattacker )
    {
        attacker notify( "destroyed_equipment" );
    }
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 0
// Checksum 0x0, Offset: 0x133f
// Size: 0x154
function box_handledeath()
{
    self waittill( "death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    box_setinactive();
    removeboxfromlevelarray();
    var_86280fefb94b6b28 = level.boxsettings[ self.boxtype ];
    
    if ( !istrue( self.destroyedbydamage ) )
    {
        playfx( var_86280fefb94b6b28.deathvfx, self.origin );
        self playsound( "mp_killstreak_disappear" );
    }
    else
    {
        damagespawnpos = self.origin + ( 0, 0, var_86280fefb94b6b28.headiconoffset );
        
        if ( isdefined( var_86280fefb94b6b28.deathdamagemax ) )
        {
            owner = undefined;
            
            if ( isdefined( self.owner ) )
            {
                owner = self.owner;
            }
            
            if ( isdefined( var_86280fefb94b6b28.explodevfx ) )
            {
                playfx( var_86280fefb94b6b28.explodevfx, self.origin );
                self playsound( "c4_expl_trans" );
            }
            
            radiusdamage( damagespawnpos, var_86280fefb94b6b28.deathdamageradius, var_86280fefb94b6b28.deathdamagemax, var_86280fefb94b6b28.deathdamagemin, owner, "MOD_EXPLOSIVE", "support_box_mp" );
            thread scripts\mp\shellshock::grenade_earthquakeatposition( self.origin, 1 );
        }
    }
    
    self notify( "deleting" );
    self delete();
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 0
// Checksum 0x0, Offset: 0x149b
// Size: 0x46
function box_handleownerdisconnect()
{
    self endon( "death" );
    level endon( "game_ended" );
    self notify( "box_handleOwner" );
    self endon( "box_handleOwner" );
    childthread box_watchownerstatus( "disconnect" );
    childthread box_watchownerstatus( "joined_team" );
    childthread box_watchownerstatus( "joined_spectators" );
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x14e9
// Size: 0x2a
function box_watchownerstatus( notifymsg )
{
    self.owner waittill( notifymsg );
    self.isdestroyed = 1;
    self notify( "death" );
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x151b
// Size: 0x22e
function boxthink( player )
{
    self endon( "death" );
    thread boxcapturethink( player );
    
    if ( !isdefined( player.boxes ) )
    {
        player.boxes = [];
    }
    
    player.boxes[ player.boxes.size ] = self;
    var_86280fefb94b6b28 = level.boxsettings[ self.boxtype ];
    
    for ( ;; )
    {
        self waittill( "captured", capturer );
        
        if ( capturer == player )
        {
            player playlocalsound( var_86280fefb94b6b28.onusesfx );
            
            if ( isdefined( var_86280fefb94b6b28.onusecallback ) )
            {
                player [[ var_86280fefb94b6b28.onusecallback ]]( self );
            }
            
            if ( isdefined( self.owner ) && player != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, player ) )
            {
                self.owner thread doscoreevent( #"support", undefined, var_86280fefb94b6b28.usexp );
            }
            
            if ( isdefined( self.usesremaining ) )
            {
                self.usesremaining--;
                
                if ( self.usesremaining == 0 )
                {
                    box_leave();
                    break;
                }
            }
            
            if ( isdefined( var_86280fefb94b6b28.canuseotherboxes ) && var_86280fefb94b6b28.canuseotherboxes )
            {
                foreach ( box in level.deployable_box[ var_86280fefb94b6b28.streakname ] )
                {
                    box scripts\mp\killstreaks\deployablebox::box_disableplayeruse( player );
                    
                    if ( isdefined( box.boxiconid ) )
                    {
                        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( box.boxiconid, player );
                    }
                    
                    box thread doubledip( player );
                }
                
                continue;
            }
            
            if ( istrue( var_86280fefb94b6b28.canreusebox ) )
            {
                continue;
            }
            
            if ( isdefined( self.boxiconid ) )
            {
                scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( self.boxiconid, player );
            }
            
            box_disableplayeruse( player );
            thread doubledip( player );
        }
    }
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x1751
// Size: 0xb0
function doubledip( player )
{
    self endon( "death" );
    player endon( "disconnect" );
    player waittill( "death" );
    
    if ( level.teambased )
    {
        if ( self.team == player.team )
        {
            if ( isdefined( self.boxiconid ) )
            {
                scripts\cp_mp\entityheadicons::setheadicon_addclienttomask( self.boxiconid, player );
            }
            
            box_enableplayeruse( player );
        }
        
        return;
    }
    
    if ( isdefined( self.owner ) && self.owner == player )
    {
        if ( isdefined( self.boxiconid ) )
        {
            scripts\cp_mp\entityheadicons::setheadicon_addclienttomask( self.boxiconid, player );
        }
        
        box_enableplayeruse( player );
    }
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x1809
// Size: 0xba
function boxcapturethink( player )
{
    level endon( "game_ended" );
    
    while ( isdefined( self ) )
    {
        self waittill( "trigger", triggerer );
        
        if ( isdefined( level.boxsettings[ self.boxtype ].nousekillstreak ) && level.boxsettings[ self.boxtype ].nousekillstreak && iskillstreakweapon( player getcurrentweapon() ) )
        {
            continue;
        }
        
        if ( triggerer == player && useholdthink( player, level.boxsettings[ self.boxtype ].usetime ) )
        {
            self notify( "captured", player );
        }
    }
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x18cb
// Size: 0x2d, Type: bool
function isfriendlytobox( box )
{
    return level.teambased && self.team == box.team;
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 0
// Checksum 0x0, Offset: 0x1901
// Size: 0x7e
function box_timeout()
{
    self endon( "death" );
    level endon( "game_ended" );
    var_86280fefb94b6b28 = level.boxsettings[ self.boxtype ];
    lifespan = var_86280fefb94b6b28.lifespan;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( lifespan );
    
    if ( isdefined( var_86280fefb94b6b28.vogone ) )
    {
        self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer( var_86280fefb94b6b28.vogone );
    }
    
    box_leave();
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 0
// Checksum 0x0, Offset: 0x1987
// Size: 0x16
function box_leave()
{
    waitframe();
    self.isdestroyed = 1;
    self notify( "death" );
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x19a5
// Size: 0x47
function deleteonownerdeath( owner )
{
    wait 0.25;
    self linkto( owner, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    owner waittill( "death" );
    box_leave();
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x19f4
// Size: 0xe9
function box_modelteamupdater( var_ef682a37eef48976 )
{
    self endon( "death" );
    self hide();
    
    foreach ( player in level.players )
    {
        if ( player.team == var_ef682a37eef48976 )
        {
            self showtoplayer( player );
        }
    }
    
    for ( ;; )
    {
        level waittill( "joined_team" );
        self hide();
        
        foreach ( player in level.players )
        {
            if ( player.team == var_ef682a37eef48976 )
            {
                self showtoplayer( player );
            }
        }
    }
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 2
// Checksum 0x0, Offset: 0x1ae5
// Size: 0x14e
function useholdthink( player, usetime )
{
    scripts\mp\movers::script_mover_link_to_use_object( player );
    player val::set( "useHold", "weapon", 0 );
    player.boxparams = spawnstruct();
    player.boxparams.curprogress = 0;
    player.boxparams.inuse = 1;
    player.boxparams.userate = 0;
    player.boxparams.id = self.id;
    
    if ( isdefined( usetime ) )
    {
        player.boxparams.usetime = usetime;
    }
    else
    {
        player.boxparams.usetime = 3000;
    }
    
    result = useholdthinkloop( player );
    assert( isdefined( result ) );
    
    if ( isalive( player ) )
    {
        player val::reset_all( "useHold" );
        scripts\mp\movers::script_mover_unlink_from_use_object( player );
    }
    
    if ( !isdefined( self ) )
    {
        return 0;
    }
    
    player.boxparams.inuse = 0;
    player.boxparams.curprogress = 0;
    return result;
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x1c3c
// Size: 0xf1
function useholdthinkloop( player )
{
    config = player.boxparams;
    
    while ( player isplayerusingbox( config ) )
    {
        if ( !player scripts\mp\movers::script_mover_use_can_link( self ) )
        {
            player scripts\mp\gameobjects::updateuiprogress( config, 0 );
            return 0;
        }
        
        config.curprogress += level.frameduration * config.userate;
        
        if ( isdefined( player.objectivescaler ) )
        {
            config.userate = 1 * player.objectivescaler;
        }
        else
        {
            config.userate = 1;
        }
        
        player scripts\mp\gameobjects::updateuiprogress( config, 1 );
        
        if ( config.curprogress >= config.usetime )
        {
            player scripts\mp\gameobjects::updateuiprogress( config, 0 );
            return isreallyalive( player );
        }
        
        waitframe();
    }
    
    player scripts\mp\gameobjects::updateuiprogress( config, 0 );
    return 0;
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 0
// Checksum 0x0, Offset: 0x1d36
// Size: 0x1e
function addboxtolevelarray()
{
    level.deployable_box[ self.boxtype ][ self getentitynumber() ] = self;
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 0
// Checksum 0x0, Offset: 0x1d5c
// Size: 0x1c
function removeboxfromlevelarray()
{
    level.deployable_box[ self.boxtype ][ self getentitynumber() ] = undefined;
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x1d80
// Size: 0x7b, Type: bool
function isplayerusingbox( box )
{
    return !level.gameended && isdefined( box ) && isreallyalive( self ) && self usebuttonpressed() && !self isonladder() && !self meleebuttonpressed() && box.curprogress < box.usetime && ( !isdefined( self.teleporting ) || !self.teleporting );
}

// Namespace deployablebox / scripts\mp\killstreaks\deployablebox
// Params 1
// Checksum 0x0, Offset: 0x1e04
// Size: 0x1c
function isgrenadedeployable( boxtype )
{
    isgrenade = 0;
    isgrenade = 0;
    return isgrenade;
}

