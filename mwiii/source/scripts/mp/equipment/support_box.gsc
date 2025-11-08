#using scripts\common\ae_utility;
#using scripts\common\elevators;
#using scripts\common\interactive;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\supers\supers;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\movers;
#using scripts\mp\supers;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;

#namespace support_box;

// Namespace support_box / scripts\mp\equipment\support_box
// Params 0
// Checksum 0x0, Offset: 0xa86
// Size: 0x1c0
function supportbox_init()
{
    level.allsupportboxes = [];
    scripts\common\interactive::interactive_addusedcallback( &supportbox_usedcallback, "super_ammo_drop" );
    scripts\common\interactive::interactive_addusedcallback( &supportbox_usedcallback, "equip_armorbox" );
    scripts\common\interactive::interactive_addusedcallback( &supportbox_usedcallback, "equip_utilitybox" );
    scripts\common\interactive::interactive_addusedcallback( &supportbox_usedcallback, "equip_blastshieldbox" );
    scripts\common\interactive::interactive_addusedcallback( &supportbox_usedcallback, "equip_leaderbox" );
    scripts\common\interactive::interactive_addusedcallback( &supportbox_usedcallback, "equip_self_revive_box" );
    scripts\common\interactive::interactive_addusedcallback( &supportbox_usedcallback, "equip_hauntedbox" );
    scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback( &supportbox_updateheadicononjointeam );
    var_cc0b794a12ecffd4 = level.superglobals.staticsuperdata[ "super_ammo_drop" ].bundle;
    var_5249bf270d77e3d6 = default_to( var_cc0b794a12ecffd4.var_eba192e71b949449, "vfx/iw9/fieldupgrades/ammobox/vfx_ammobox_timeout.vfx" );
    level.var_97e8a4fa1b27c25e = getdvarint( @"hash_cd6c28f6b1678c3f", 1 );
    level._effect[ var_5249bf270d77e3d6 ] = loadfx( var_5249bf270d77e3d6 );
    level._effect[ "vfx/iw9/fieldupgrades/ammobox/vfx_armorbox_timeout.vfx" ] = loadfx( "vfx/iw9/fieldupgrades/ammobox/vfx_armorbox_timeout.vfx" );
    level._effect[ "vfx/iw9/prop/scriptables/vfx_offhand_2h_vm_self_revive_box_v0_timeout.vfx" ] = loadfx( "vfx/iw9/prop/scriptables/vfx_offhand_2h_vm_self_revive_box_v0_timeout.vfx" );
    level._effect[ "vfx/jup/fieldupgrades/vfx_utilitybox_timeout.vfx" ] = loadfx( "vfx/jup/fieldupgrades/vfx_utilitybox_timeout.vfx" );
    level._effect[ "vfx/iw9_br/haunted_box/vfx_haunted_box_dest.vfx" ] = loadfx( "vfx/iw9_br/haunted_box/vfx_haunted_box_dest.vfx" );
    level._effect[ "vfx/iw9/fieldupgrades/ammobox/vfx_armorbox_timeout.vfx" ] = loadfx( "vfx/iw9/fieldupgrades/ammobox/vfx_armorbox_timeout.vfx" );
    
    if ( !isdefined( level.onarmorboxusedbyplayer ) && issharedfuncdefined( "armor_drop", "init" ) )
    {
        [[ getsharedfunc( "armor_drop", "init" ) ]]();
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0xc4e
// Size: 0x65
function supportbox_updateheadicononjointeam( player )
{
    foreach ( supportbox in level.allsupportboxes )
    {
        if ( isdefined( supportbox ) )
        {
            supportbox supportbox_updateheadicon( player );
        }
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 4
// Checksum 0x0, Offset: 0xcbb
// Size: 0x2f8
function box_used_common_setup( grenade, equipmentname, superid, headicon )
{
    grenade endon( "death" );
    grenade.issuper = 1;
    staticsuperdata = level.superglobals.staticsuperdata[ superid ];
    grenade.superid = staticsuperdata.id;
    grenade.lifetime = staticsuperdata.bundle.lifetime;
    
    if ( isdefined( grenade.lifetime ) && grenade.lifetime > 0 )
    {
        grenade thread supportbox_watchdisownedtimeout();
    }
    
    grenade thread supportbox_hideandshowaftertime();
    grenade waittill( "missile_stuck", stuckto );
    
    if ( isdefined( level.var_ca4e08767cbdae12 ) )
    {
        canplant = grenade [[ level.var_ca4e08767cbdae12 ]]();
        
        if ( !canplant )
        {
            scripts\mp\supers::refundsuper();
            scripts\mp\hud_message::showerrormessage( "EQUIPMENT/PLANT_FAILED" );
            grenade delete();
            return;
        }
    }
    
    grenade supportbox_handlemovingplatforms( stuckto );
    
    if ( true )
    {
        thread scripts\mp\weapons::outlineequipmentforowner( grenade );
    }
    
    grenade.bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3( superid );
    scripts\mp\weapons::onequipmentplanted( grenade, equipmentname, &supportbox_destroy );
    level.allsupportboxes[ grenade getentitynumber() ] = grenade;
    grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback( &supportbox_empapplied );
    
    if ( issharedfuncdefined( "emp", "setEMP_Applied_Callback" ) )
    {
        grenade [[ getsharedfunc( "emp", "setEMP_Applied_Callback" ) ]]( &supportbox_empapplied );
    }
    
    grenade scripts\cp_mp\equipment\haywire::function_172d848d58051fdf( &function_f7bd40787418df02 );
    grenade function_49197cd063a740ea( &supportbox_destroy );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread scripts\common\elevators::isentitytouchingdoortrigger( grenade );
        }
    }
    
    if ( !istrue( grenade.madedamageable ) )
    {
        grenade supportbox_makedamageable();
    }
    
    grenade.makedamageable = undefined;
    grenade setscriptablepartstate( "visibility", "show", 0 );
    
    if ( !istrue( level.var_97e8a4fa1b27c25e ) )
    {
        wait 0;
    }
    
    if ( !scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924() )
    {
        grenade supportbox_addheadicon( headicon );
    }
    
    if ( !istrue( level.var_97e8a4fa1b27c25e ) )
    {
        wait 0.75;
        grenade setscriptablepartstate( "effects", "plant", 0 );
        grenade setscriptablepartstate( "anims", "open", 0 );
        wait grenade supportbox_getdeployanimduration();
    }
    
    grenade setscriptablepartstate( "beacon", "active", 0 );
    grenade setscriptablepartstate( "anims", "openIdle", 0 );
    thread monitordisownedequipment( self, grenade );
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0xfbb
// Size: 0x9e, Type: bool
function is_train_ent( hitent )
{
    if ( isdefined( level.wztrain_info ) )
    {
        foreach ( ent in level.wztrain_info.train_array )
        {
            if ( ent == hitent )
            {
                return true;
            }
            
            if ( isdefined( ent.linked_model ) && ent.linked_model == hitent )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x1062
// Size: 0x2c4
function supportbox_used( grenade )
{
    grenade endon( "death" );
    var_cc0b794a12ecffd4 = level.superglobals.staticsuperdata[ "super_ammo_drop" ].bundle;
    vfxtimeout = default_to( var_cc0b794a12ecffd4.var_eba192e71b949449, "vfx/iw9/fieldupgrades/ammobox/vfx_ammobox_timeout.vfx" );
    var_1cb365d92187987b = "mp_equip_box_destroyed";
    equipname = "super_ammo_drop";
    supername = "super_ammo_drop";
    headicon = "hud_icon_fieldupgrade_ammo_box";
    usehint = &"EQUIPMENT_HINTS/SUPPORT_BOX_USE";
    
    if ( isdefined( grenade.equipmentref ) )
    {
        switch ( grenade.equipmentref )
        {
            case #"hash_91076f076ee682f4":
                vfxtimeout = "vfx/iw9/fieldupgrades/ammobox/vfx_armorbox_timeout.vfx";
                equipname = "equip_armorbox";
                supername = "super_armor_drop";
                headicon = "hud_icon_fieldupgrade_armor_box";
                usehint = &"EQUIPMENT_HINTS/ARMOR_BOX_USE";
                break;
            case #"hash_b3d0752364b0193d":
                vfxtimeout = "vfx/jup/fieldupgrades/vfx_utilitybox_timeout.vfx";
                equipname = "equip_utilitybox";
                supername = "super_utility_drop";
                headicon = "hud_icon_fieldupgrade_utility_box";
                usehint = &"EQUIPMENT_HINTS/UTILITY_BOX_USE";
                break;
            case #"hash_5bb446fe7b2c92da":
                vfxtimeout = "vfx/iw9_br/haunted_box/vfx_haunted_box_dest.vfx";
                var_1cb365d92187987b = "eqp_haunted_box_destroy";
                equipname = "equip_hauntedbox";
                supername = "super_haunted_drop";
                headicon = "hud_icon_fieldupgrade_haunted_box";
                usehint = &"EQUIPMENT_HINTS/HAUNTED_BOX_USE";
                break;
            case #"hash_187c7d31342c1d7c":
                vfxtimeout = "vfx/iw9/fieldupgrades/ammobox/vfx_armorbox_timeout.vfx";
                equipname = "equip_blastshieldbox";
                supername = "super_blastshield_drop";
                headicon = "hud_icon_equipment_blastshield_box";
                usehint = &"EQUIPMENT_HINTS/BLASTSHIELD_BOX_USE";
                break;
            case #"hash_cf0bf67369c3ff42":
                vfxtimeout = "vfx/iw9/fieldupgrades/ammobox/vfx_armorbox_timeout.vfx";
                equipname = "equip_leaderbox";
                supername = "super_leader_drop";
                headicon = "hud_icon_fieldupgrade_armor_box";
                usehint = &"EQUIPMENT_HINTS/SELF_REVIVE_BOX_USE";
                self setclientomnvar( "ui_squad_leader_pack_dropped", 1 );
                playersquad = scripts\mp\utility\teams::getfriendlyplayers( self.team, 0 );
                
                foreach ( teammate in playersquad )
                {
                    teammate setclientomnvar( "ui_squad_leader_pack_dropped", 1 );
                }
                
                break;
            case #"hash_bdd285c401cf9498":
                vfxtimeout = "vfx/iw9/prop/scriptables/vfx_offhand_2h_vm_self_revive_box_v0_timeout.vfx";
                equipname = "equip_self_revive_box";
                supername = "super_self_revive_box";
                headicon = "hud_icon_fieldupgrade_self_revive_box";
                usehint = &"EQUIPMENT_HINTS/SELF_REVIVE_BOX_USE";
                break;
        }
    }
    
    grenade.timeoutvfxname = vfxtimeout;
    box_used_common_setup( grenade, equipname, supername, headicon );
    grenade thread supportbox_makeusable( equipname, usehint );
    scripts\cp_mp\challenges::function_d997435895422ecc( supername, function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"use" ) );
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x132e
// Size: 0x6c
function supportbox_hideandshowaftertime( time )
{
    self endon( "death" );
    self endon( "missile_stuck" );
    hideduration = getdvarfloat( @"hash_ed9a51db36904e30", 0 );
    self setscriptablepartstate( "visibility", "hide", 0 );
    wait hideduration;
    self.madedamageable = 1;
    supportbox_makedamageable();
    self setscriptablepartstate( "visibility", "show", 0 );
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 0
// Checksum 0x0, Offset: 0x13a2
// Size: 0xa3
function supportbox_unset()
{
    if ( false )
    {
        foreach ( superequip in self.plantedsuperequip )
        {
            if ( superequip.equipmentref == "super_ammo_drop" || superequip.equipmentref == "equip_armorbox" || superequip.equipmentref == "equip_leaderbox" )
            {
                superequip thread supportbox_destroy( 1 );
                scripts\mp\weapons::removeequip( superequip );
            }
        }
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 3
// Checksum 0x0, Offset: 0x144d
// Size: 0x231
function supportbox_destroy( immediate, wasdestroyed, var_d3f5ceb48370a22a )
{
    if ( !isdefined( immediate ) )
    {
        immediate = !istrue( self.planted );
    }
    
    var_cc0b794a12ecffd4 = level.superglobals.staticsuperdata[ "super_ammo_drop" ].bundle;
    timeoutvfxname = default_to( var_cc0b794a12ecffd4.var_eba192e71b949449, "vfx/iw9/fieldupgrades/ammobox/vfx_ammobox_timeout.vfx" );
    
    if ( isdefined( self.timeoutvfxname ) )
    {
        timeoutvfxname = self.timeoutvfxname;
    }
    
    var_f4556363afb52110 = "mp_equip_box_destroyed";
    
    if ( isdefined( self.var_f4556363afb52110 ) )
    {
        var_f4556363afb52110 = self.var_f4556363afb52110;
    }
    
    closetime = 0;
    
    if ( istrue( var_d3f5ceb48370a22a ) )
    {
        closetime = supportbox_getcloseanimduration();
    }
    
    deletiondelay = 0;
    
    if ( !istrue( immediate ) )
    {
        deletiondelay = 0.1;
    }
    
    thread supportbox_delete( deletiondelay, wasdestroyed );
    moving_platform = undefined;
    fxoriginoffset = undefined;
    
    if ( isdefined( self ) )
    {
        fxorigin = self.origin;
        fxforward = anglestoforward( self.angles );
        fxup = anglestoup( self.angles );
        var_dfdfaa4e665b31fc = self getlinkedparent();
        
        if ( isdefined( var_dfdfaa4e665b31fc ) )
        {
            moving_platform = var_dfdfaa4e665b31fc;
            fxoriginoffset = moving_platform.origin - fxorigin;
        }
        
        self setscriptablepartstate( "beacon", "neutral", 0 );
        self setscriptablepartstate( "hacked", "neutral", 0 );
        
        if ( istrue( var_d3f5ceb48370a22a ) )
        {
            self setscriptablepartstate( "anims", "close", 0 );
            wait closetime;
            self setscriptablepartstate( "anims", "closedIdle", 0 );
            wait 1;
        }
        
        if ( isdefined( moving_platform ) && isent( moving_platform ) )
        {
            fxorigin = moving_platform.origin - fxoriginoffset;
        }
        
        if ( self.equipmentref == "super_ammo_drop" )
        {
            self setscriptablepartstate( "effects", "destroy", 0 );
            return;
        }
        
        playfx( scripts\engine\utility::getfx( timeoutvfxname ), fxorigin, fxforward, fxup );
        playsoundatpos( fxorigin, var_f4556363afb52110 );
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 2
// Checksum 0x0, Offset: 0x1686
// Size: 0x1b8
function supportbox_delete( deletiondelay, wasdestroyed )
{
    self notify( "death" );
    self.isdestroyed = 1;
    self setcandamage( 0 );
    
    if ( isdefined( self.owner ) )
    {
        self.owner removeequip( self );
    }
    
    supportbox_removeheadicon();
    supportbox_makeunusable();
    supername = "super_ammo_drop";
    
    if ( isdefined( self.equipmentref ) && self.equipmentref == "equip_armorbox" )
    {
        supername = "super_armor_drop";
    }
    else if ( isdefined( self.equipmentref ) && self.equipmentref == "equip_utilitybox" )
    {
        supername = "super_utility_drop";
    }
    else if ( isdefined( self.equipmentref ) && self.equipmentref == "equip_hauntedbox" )
    {
        supername = "super_haunted_drop";
    }
    else if ( isdefined( self.equipmentref ) && self.equipmentref == "equip_blastshieldbox" )
    {
        supername = "super_blastshield_drop";
    }
    else if ( isdefined( self.equipmentref ) && self.equipmentref == "equip_leaderbox" )
    {
        supername = "super_leader_drop";
    }
    
    if ( supername == "super_armor_drop" || supername == "super_ammo_drop" )
    {
        self.owner scripts\cp_mp\challenges::function_d997435895422ecc( supername, function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"end" ), self.usedcount );
    }
    
    scripts\mp\analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, self.usedcount, istrue( wasdestroyed ) );
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 2
// Checksum 0x0, Offset: 0x1846
// Size: 0x8d
function supportbox_makeusable( equipmentname, hintstring )
{
    scripts\common\interactive::interactive_addusedcallbacktoentity( equipmentname );
    self.playersused = [];
    self.usedcount = 0;
    self makeusable();
    self setusepriority( -1 );
    self enablemissilehint( 1 );
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( hintstring );
    self setuserange( 128 );
    self setuseholdduration( "duration_short" );
    self sethintrequiresholding( 0 );
    self sethinttag( "tag_use" );
    thread supportbox_watchallplayeruse();
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 0
// Checksum 0x0, Offset: 0x18db
// Size: 0x22
function supportbox_makeunusable()
{
    self notify( "supportBox_makeUnusable" );
    scripts\common\interactive::interactive_removeusedcallbackfromentity();
    self makeunusable();
    self.playersused = undefined;
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 0
// Checksum 0x0, Offset: 0x1905
// Size: 0x4c
function supportbox_watchallplayeruse()
{
    self endon( "death" );
    self endon( "supportBox_makeUnusable" );
    var_47facc6abff4fd71 = gettime();
    
    while ( true )
    {
        supportbox_updateplayersused();
        
        if ( gettime() >= var_47facc6abff4fd71 )
        {
            supportbox_updateplayerusevisibility();
            var_47facc6abff4fd71 = gettime() + 150;
        }
        
        waitframe();
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 0
// Checksum 0x0, Offset: 0x1959
// Size: 0x84
function supportbox_updateplayerusevisibility()
{
    nearplayers = utility::playersnear( self.origin, 300 );
    
    foreach ( player in nearplayers )
    {
        if ( isdefined( player ) )
        {
            if ( !supportbox_playercanuse( player ) )
            {
                self disableplayeruse( player );
                continue;
            }
            
            self enableplayeruse( player );
        }
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 0
// Checksum 0x0, Offset: 0x19e5
// Size: 0x91
function supportbox_updateplayersused()
{
    foreach ( player in self.playersused )
    {
        if ( isdefined( player ) )
        {
            entnum = player getentitynumber();
            
            if ( !scripts\mp\utility\player::isreallyalive( player ) && isdefined( self.playersused[ entnum ] ) )
            {
                self.playersused[ entnum ] = undefined;
                supportbox_updateheadicon( player );
            }
        }
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x1a7e
// Size: 0x55, Type: bool
function supportbox_playercanuse( player )
{
    if ( !scripts\mp\utility\player::isreallyalive( player ) )
    {
        return false;
    }
    
    if ( !player val::get( "crate_use" ) )
    {
        return false;
    }
    
    if ( isdefined( self.playersused[ player getentitynumber() ] ) )
    {
        return false;
    }
    
    if ( scripts\cp_mp\utility\player_utility::playersareenemies( player, self.owner ) )
    {
        return false;
    }
    
    return true;
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x1adc
// Size: 0x316
function supportbox_onplayeruse( player )
{
    if ( !isdefined( self.equipmentref ) )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    if ( self.equipmentref == "equip_blastshieldbox" )
    {
        player scripts\mp\utility\perk::giveperk( "specialty_blastshield" );
        player hudicontype( "blastshield_box" );
    }
    else
    {
        var_12a372e8caa042bb = player.primaryweapons;
        
        foreach ( weaponobj in var_12a372e8caa042bb )
        {
            if ( scripts\mp\utility\weapon::ismeleeonly( weaponobj ) || scripts\mp\utility\weapon::issuperweapon( weaponobj ) || scripts\cp_mp\weapon::iskillstreakweapon( weaponobj ) || scripts\mp\utility\weapon::isgamemodeweapon( weaponobj ) )
            {
                continue;
            }
            
            weapongroup = scripts\mp\utility\weapon::getweapongroup( weaponobj );
            clipnum = undefined;
            
            if ( scripts\mp\utility\weapon::issinglehitweapon( weaponobj ) )
            {
                clipnum = 1;
            }
            else if ( weapongroup == "weapon_sniper" )
            {
                clipnum = 1.5;
            }
            else
            {
                clipnum = 3;
            }
            
            if ( istrue( weaponobj.hasalternate ) && !isaxeweapon( weaponobj ) )
            {
                weaponaltobj = weaponobj getaltweapon();
                var_91093ef03654702c = weaponclass( weaponaltobj );
                
                if ( var_91093ef03654702c == "grenade" )
                {
                    addammo = scripts\mp\weapons::getammooverride( weaponaltobj );
                    stockammo = player getweaponammostock( weaponaltobj );
                    newammo = int( stockammo + addammo );
                    player setweaponammostock( weaponaltobj, newammo );
                }
                else if ( weaponaltobj.type == "bullet" )
                {
                    if ( var_91093ef03654702c == "spread" )
                    {
                        addammo = scripts\mp\weapons::getammooverride( weaponaltobj );
                        stockammo = player getweaponammostock( weaponaltobj );
                        newammo = int( stockammo + addammo );
                        player setweaponammostock( weaponaltobj, newammo );
                    }
                }
                else
                {
                    addammo = scripts\mp\weapons::getammooverride( weaponaltobj );
                    stockammo = player getweaponammostock( weaponaltobj );
                    newammo = int( stockammo + addammo );
                    player setweaponammostock( weaponaltobj, newammo );
                }
            }
            
            var_2be3302e3767cc7d = weaponclipsize( weaponobj );
            addammo = scripts\mp\weapons::getammooverride( weaponobj ) * clipnum;
            addammo = max( var_2be3302e3767cc7d, addammo );
            stockammo = player getweaponammostock( weaponobj );
            newammo = int( stockammo + addammo );
            
            if ( weaponmaxammo( weaponobj ) <= player getweaponammostock( weaponobj ) )
            {
                continue;
            }
            
            player setweaponammostock( weaponobj, newammo );
        }
        
        primary = player scripts\mp\equipment::getcurrentequipment( "primary" );
        
        if ( isdefined( primary ) )
        {
            player scripts\mp\equipment::incrementequipmentammo( primary, function_bea6f988c3fbb7a1( primary ) );
        }
        
        secondary = player scripts\mp\equipment::getcurrentequipment( "secondary" );
        
        if ( isdefined( secondary ) )
        {
            player scripts\mp\equipment::incrementequipmentammo( secondary, function_bea6f988c3fbb7a1( secondary ) );
        }
        
        player hudicontype( "ammobox" );
    }
    
    supportbox_playusesound( player );
    thread supportbox_onplayeruseanim();
    self.var_ee55bd57abd7930b = 1;
    return 1;
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x1dfb
// Size: 0x45
function function_bea6f988c3fbb7a1( equipref )
{
    var_930290d7f474a0ae = 1;
    
    switch ( equipref )
    {
        case #"hash_61206775eae1c854":
            var_930290d7f474a0ae = 3;
            break;
        default:
            break;
    }
    
    return var_930290d7f474a0ae;
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x1e49
// Size: 0x90
function supportbox_playusesound( player )
{
    if ( isdefined( player ) )
    {
        if ( isdefined( self.equipmentref ) && self.equipmentref == "equip_armorbox" || self.equipmentref == "equip_blastshieldbox" )
        {
            player playsoundtoplayer( "iw9_armor_crate_use", player );
            return;
        }
        
        if ( isdefined( self.equipmentref ) && self.equipmentref == "equip_leaderbox" )
        {
            player playsoundtoplayer( "iw9_armor_crate_use", player );
            return;
        }
        
        player playsoundtoplayer( "ammo_crate_use", player );
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 0
// Checksum 0x0, Offset: 0x1ee1
// Size: 0x57
function supportbox_onplayeruseanim()
{
    self endon( "death" );
    
    if ( istrue( self.onuseanimplaying ) )
    {
        return;
    }
    
    self setscriptablepartstate( "anims", "openUse", 0 );
    self.onuseanimplaying = 1;
    wait supportbox_getuseanimduration();
    self setscriptablepartstate( "anims", "openIdle", 0 );
    self.onuseanimplaying = undefined;
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 0
// Checksum 0x0, Offset: 0x1f40
// Size: 0x75
function supportbox_makedamageable()
{
    if ( isdefined( self.equipmentref ) )
    {
        if ( self.equipmentref == "equip_leaderbox" )
        {
            return;
        }
    }
    
    bundle = self.bundle;
    boxmaxhealth = 100;
    
    if ( isdefined( bundle ) )
    {
        boxmaxhealth = default_to( bundle.var_e53ecfd9f4fef4fa, 100 );
    }
    
    thread scripts\mp\damage::monitordamage( boxmaxhealth, "hitequip", &supportbox_handlefataldamage, &supportbox_handledamage );
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x1fbd
// Size: 0x174
function supportbox_handledamage( data )
{
    if ( data.meansofdeath == "MOD_IMPACT" && !( isdefined( data.objweapon ) && isdefined( data.objweapon.classname ) && data.objweapon.classname == "throwingknife" && istrue( self.bundle.var_9fad1cca12275e17 ) ) )
    {
        return 0;
    }
    
    isenemydamage = !isdefined( self.owner ) || scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, data.attacker );
    hits = undefined;
    
    if ( isexplosivedamagemod( data.meansofdeath ) )
    {
        hits = supportbox_explosivedamagetohits( data, isenemydamage );
    }
    else if ( isbulletdamage( data.meansofdeath ) )
    {
        hits = supportbox_bulletdamagetohits( data, isenemydamage );
    }
    
    if ( isdefined( hits ) )
    {
        hitstokill = default_to( self.bundle.var_3b2a936a383dc038, 5 );
        
        if ( isenemydamage )
        {
            hitstokill = default_to( self.bundle.var_363b330e28b6e214, 5 );
        }
        
        return int( ceil( min( 1, hits / hitstokill ) * self.maxhealth ) );
    }
    
    return data.damage;
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x213a
// Size: 0x3c
function supportbox_handlefataldamage( data )
{
    self notify( "enemy_destroyed_equipment", data.attacker );
    supportbox_givepointsfordeath( data.attacker );
    thread supportbox_destroy( 0, 1, 0 );
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 2
// Checksum 0x0, Offset: 0x217e
// Size: 0x96
function supportbox_bulletdamagetohits( data, isenemydamage )
{
    basehits = ter_op( scripts\mp\utility\damage::isfmjdamage( data.objweapon, data.meansofdeath ) && isenemydamage, 2, 0 );
    
    if ( data.damage > 150 )
    {
        return ( basehits + 10 );
    }
    
    if ( data.damage >= 80 )
    {
        return ( basehits + 5 );
    }
    
    if ( data.damage >= 30 )
    {
        return ( basehits + 2 );
    }
    
    return basehits + 1;
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 2
// Checksum 0x0, Offset: 0x221c
// Size: 0x58
function supportbox_explosivedamagetohits( data, isenemydamage )
{
    if ( data.damage > 200 )
    {
        return 20;
    }
    
    if ( data.damage > 70 )
    {
        return 10;
    }
    
    if ( data.damage > 30 )
    {
        return 7;
    }
    
    return 2;
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 0
// Checksum 0x0, Offset: 0x227c
// Size: 0x20
function supportbox_removeowneroutline()
{
    if ( isdefined( self.outlineid ) )
    {
        scripts\mp\utility\outline::outlinedisable( self.outlineid, self );
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x22a4
// Size: 0x47
function supportbox_addheadicon( headicon )
{
    self.headiconbox = scripts\cp_mp\entityheadicons::setheadicon_singleimage( [], headicon, 20, 1, 1000, 100, undefined, 1 );
    self.headiconfaction = scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, 20, undefined, undefined, undefined, undefined, 1 );
    supportbox_updateheadiconallplayers();
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 0
// Checksum 0x0, Offset: 0x22f3
// Size: 0x50
function supportbox_removeheadicon()
{
    if ( isdefined( self.headiconbox ) )
    {
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon( self.headiconbox );
        self.headiconbox = undefined;
    }
    
    if ( isdefined( self.headiconfaction ) )
    {
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon( self.headiconfaction );
        self.headiconfaction = undefined;
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x234b
// Size: 0x8e
function supportbox_givepointsfordeath( attacker )
{
    if ( !isdefined( self.owner ) || istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) ) )
    {
        attacker notify( "destroyed_equipment" );
        attacker thread scripts\mp\utility\points::doscoreevent( #"destroyed_equipment" );
        
        if ( isdefined( self.weapon_name ) )
        {
            if ( self.weapon_name == "ammo_box_mp" )
            {
                attacker thread scripts\mp\battlechatter_mp::onfieldupgradedestroy( #"bc_fieldupgrade_killfirm_ammobox" );
                return;
            }
            
            attacker thread scripts\mp\battlechatter_mp::onfieldupgradedestroy( #"bc_fieldupgrade_killfirm_armorbox" );
        }
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 4
// Checksum 0x0, Offset: 0x23e1
// Size: 0x92
function supportbox_givexpforuse( player, eventname, persstat, supername )
{
    if ( isdefined( self.owner ) && !scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, player ) )
    {
        if ( self.owner != player )
        {
            self.owner thread scripts\mp\utility\points::doscoreevent( eventname );
        }
        
        self.owner scripts\mp\utility\stats::incpersstat( persstat, 1 );
        self.owner scripts\mp\supers::combatrecordsupermisc( supername );
        self.usedcount++;
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x247b
// Size: 0x14
function supportbox_onmovingplatformdeath( data )
{
    supportbox_destroy( 1 );
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x2497
// Size: 0x7c
function function_ab33fbbbb68ea535( data )
{
    owner = self.owner;
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    superinfo = owner scripts\mp\supers::getcurrentsuper();
    
    if ( isdefined( superinfo ) && level.allowsupers )
    {
        if ( !istrue( self.var_ee55bd57abd7930b ) )
        {
            superinfo.wasrefunded = 1;
            owner scripts\mp\supers::setsuperbasepoints( owner scripts\mp\supers::getsuperpointsneeded() );
        }
    }
    
    supportbox_destroy( 1 );
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 6
// Checksum 0x0, Offset: 0x251b
// Size: 0xb6
function function_225b99924f316bc1( dropstruct, player, scriptablename, var_416102a18fc1fd69, weaponobj, var_6d6f8d51a1b7b6cd )
{
    if ( !isdefined( self.var_74a4e2fa253c5be8 ) )
    {
        self.var_74a4e2fa253c5be8 = 50;
    }
    
    offsetangles = ( 0, randomfloatrange( 60, 90 ), 0 );
    
    if ( isdefined( var_6d6f8d51a1b7b6cd ) )
    {
        offsetangles = var_6d6f8d51a1b7b6cd;
    }
    
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles + offsetangles, player, undefined, self.var_74a4e2fa253c5be8 );
    item = scripts\mp\gametypes\br_pickups::spawnpickup( scriptablename, dropinfo, var_416102a18fc1fd69, 1, weaponobj, 1 );
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x25d9
// Size: 0x9a
function supportbox_handlemovingplatforms( stuckto )
{
    data = spawnstruct();
    data.linkparent = stuckto;
    data.deathoverridecallback = &supportbox_onmovingplatformdeath;
    data.invalidparentoverridecallback = &function_ab33fbbbb68ea535;
    data.endonstring = "death";
    data.validateaccuratetouching = 1;
    
    if ( isdefined( stuckto ) && scripts\cp_mp\utility\train_utility::is_train_ent( stuckto ) )
    {
        data.plantedontrain = 1;
        self setmissileantilagged( 1 );
    }
    
    thread scripts\mp\movers::handle_moving_platforms( data );
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 0
// Checksum 0x0, Offset: 0x267b
// Size: 0x2d
function supportbox_watchdisownedtimeout()
{
    self endon( "death" );
    supportbox_watchdisownedtimeoutinternal();
    
    if ( isdefined( self ) && !istrue( self.isdestroyed ) )
    {
        thread supportbox_destroy( 1 );
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 0
// Checksum 0x0, Offset: 0x26b0
// Size: 0x62
function supportbox_watchdisownedtimeoutinternal()
{
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    level endon( "game_ended" );
    
    if ( isdefined( self.lifetime ) && self.lifetime > 0 )
    {
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( self.lifetime );
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x271a
// Size: 0x34
function supportbox_empapplied( data )
{
    attacker = data.attacker;
    supportbox_givepointsfordeath( attacker );
    thread supportbox_destroy( 1 );
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x2756
// Size: 0x34
function function_f7bd40787418df02( data )
{
    attacker = data.attacker;
    supportbox_givepointsfordeath( attacker );
    thread supportbox_destroy( 1 );
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 0
// Checksum 0x0, Offset: 0x2792
// Size: 0x5c
function supportbox_updateheadiconallplayers()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        supportbox_updateheadicon( player );
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x27f6
// Size: 0xef
function supportbox_updateheadicon( player )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    idbox = self.headiconbox;
    
    if ( !isdefined( idbox ) )
    {
        return;
    }
    
    idfaction = self.headiconfaction;
    
    if ( !isdefined( idfaction ) )
    {
        return;
    }
    
    isfriendly = scripts\cp_mp\utility\player_utility::isfriendly( self.owner.team, player );
    isused = isdefined( self.playersused ) && isdefined( self.playersused[ player getentitynumber() ] );
    
    if ( isfriendly && !isused )
    {
        scripts\cp_mp\entityheadicons::setheadicon_addclienttomask( idbox, player );
        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( idfaction, player );
        return;
    }
    
    if ( isfriendly )
    {
        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( idbox, player );
        scripts\cp_mp\entityheadicons::setheadicon_addclienttomask( idfaction, player );
        return;
    }
    
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( idbox, player );
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( idfaction, player );
}

#using_animtree( "scriptables" );

// Namespace support_box / scripts\mp\equipment\support_box
// Params 0
// Checksum 0x0, Offset: 0x28ed
// Size: 0x7f
function supportbox_getdeployanimduration()
{
    switch ( self.equipmentref )
    {
        case #"hash_91076f076ee682f4":
            return getanimlength( %wm_armor_box_ground_open );
        case #"hash_b3d0752364b0193d":
            return getanimlength( %wm_hbox_ground_open );
        case #"hash_5bb446fe7b2c92da":
            return getanimlength( %wm_hbox_ground_idle_open_use );
        default:
            return getanimlength( %wm_support_box_ground_open );
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 0
// Checksum 0x0, Offset: 0x2974
// Size: 0x55
function supportbox_getuseanimduration()
{
    switch ( self.equipmentref )
    {
        case #"hash_5bb446fe7b2c92da":
        case #"hash_b3d0752364b0193d":
            return getanimlength( %wm_support_box_ground_idle_open_use );
        default:
            return getanimlength( %wm_support_box_ground_idle_open_use );
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 0
// Checksum 0x0, Offset: 0x29d1
// Size: 0x70
function supportbox_getcloseanimduration()
{
    switch ( self.equipmentref )
    {
        case #"hash_91076f076ee682f4":
            return getanimlength( %wm_armor_box_ground_close );
        case #"hash_5bb446fe7b2c92da":
        case #"hash_b3d0752364b0193d":
            return getanimlength( %wm_hbox_ground_close );
        default:
            return getanimlength( %wm_support_box_ground_close );
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 2
// Checksum 0x0, Offset: 0x2a49
// Size: 0x412
function supportbox_usedcallback( entity, player )
{
    if ( istrue( player.isjuggernaut ) && !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        if ( scripts\engine\utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            player [[ scripts\engine\utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/JUGG_CANNOT_BE_USED" );
        }
        
        return;
    }
    
    if ( entity supportbox_playercanuse( player ) )
    {
        usesuccessful = 0;
        eventname = undefined;
        persstat = undefined;
        supername = undefined;
        
        if ( isdefined( entity.equipmentref ) )
        {
            switch ( entity.equipmentref )
            {
                case #"hash_29972969a98220a1":
                    eventname = #"munitions_box_teammate_used";
                    persstat = "munitionsBoxUsed";
                    supername = "super_ammo_drop";
                    
                    if ( isdefined( level.onsupportboxusedbyplayer ) )
                    {
                        usesuccessful = entity [[ level.onsupportboxusedbyplayer ]]( player );
                    }
                    else
                    {
                        usesuccessful = entity supportbox_onplayeruse( player );
                    }
                    
                    break;
                case #"hash_91076f076ee682f4":
                    eventname = #"hash_511c5e7cabbce4d";
                    persstat = "armorBoxUsed";
                    supername = "super_armor_drop";
                    
                    if ( isdefined( level.onarmorboxusedbyplayer ) )
                    {
                        usesuccessful = entity [[ level.onarmorboxusedbyplayer ]]( player );
                    }
                    
                    break;
                case #"hash_b3d0752364b0193d":
                    eventname = #"hash_9f4eefc129360272";
                    persstat = "utilityBoxUsed";
                    supername = "super_utility_drop";
                    var_8467caaa6fe5fe32 = undefined;
                    var_ae6d0dfe3a2dba21 = undefined;
                    var_297b1c676daeacb3 = undefined;
                    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
                    
                    if ( isdefined( level.onarmorboxusedbyplayer ) )
                    {
                        var_8467caaa6fe5fe32 = entity [[ level.onarmorboxusedbyplayer ]]( player, dropstruct );
                    }
                    
                    if ( isdefined( level.onsupportboxusedbyplayer ) )
                    {
                        var_ae6d0dfe3a2dba21 = entity [[ level.onsupportboxusedbyplayer ]]( player, dropstruct );
                    }
                    
                    if ( isdefined( level.var_f41d94b42b42e948 ) )
                    {
                        var_297b1c676daeacb3 = entity [[ level.var_f41d94b42b42e948 ]]( player );
                    }
                    
                    usesuccessful = istrue( var_8467caaa6fe5fe32 ) && istrue( var_ae6d0dfe3a2dba21 ) && istrue( var_297b1c676daeacb3 );
                    break;
                case #"hash_5bb446fe7b2c92da":
                    eventname = #"hash_c58ed46ec4e4b357";
                    persstat = "hauntedBoxUsed";
                    supername = "super_haunted_drop";
                    var_8467caaa6fe5fe32 = undefined;
                    var_ae6d0dfe3a2dba21 = undefined;
                    var_4f91ae66bddb86b4 = undefined;
                    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
                    
                    if ( isdefined( level.onarmorboxusedbyplayer ) )
                    {
                        var_8467caaa6fe5fe32 = entity [[ level.onarmorboxusedbyplayer ]]( player, dropstruct );
                    }
                    
                    if ( isdefined( level.onsupportboxusedbyplayer ) )
                    {
                        var_ae6d0dfe3a2dba21 = entity [[ level.onsupportboxusedbyplayer ]]( player, dropstruct );
                    }
                    
                    if ( isdefined( level.var_82dfe148ced1f477 ) )
                    {
                        var_4f91ae66bddb86b4 = entity [[ level.var_82dfe148ced1f477 ]]( player );
                    }
                    
                    usesuccessful = istrue( var_8467caaa6fe5fe32 ) && istrue( var_ae6d0dfe3a2dba21 ) && istrue( var_4f91ae66bddb86b4 );
                    break;
                case #"hash_187c7d31342c1d7c":
                    eventname = #"hash_54106ec746cc7885";
                    persstat = "blastshieldBoxUsed";
                    supername = "super_blastshield_drop";
                    usesuccessful = entity supportbox_onplayeruse( player );
                    break;
                case #"hash_cf0bf67369c3ff42":
                    eventname = #"hash_7986e8dccdee31d";
                    persstat = "leaderBoxUsed";
                    supername = "super_leader_drop";
                    
                    if ( isdefined( level.var_f24ae0993efca48f ) )
                    {
                        usesuccessful = entity [[ level.var_f24ae0993efca48f ]]( player );
                    }
                    
                    break;
                case #"hash_bdd285c401cf9498":
                    eventname = #"hash_dd967db653b981b4";
                    persstat = "selfReviveBoxUsed";
                    supername = "super_self_revive_box";
                    
                    if ( isdefined( level.var_130bc3f5f33bb97d ) )
                    {
                        usesuccessful = entity [[ level.var_130bc3f5f33bb97d ]]( player );
                    }
                    
                    break;
                default:
                    assertmsg( "<dev string:x6e>" + entity.equipmentref + "<dev string:x81>" );
                    break;
            }
            
            if ( usesuccessful )
            {
                entity.playersused[ player getentitynumber() ] = player;
                entity supportbox_updateheadicon( player );
                entity supportbox_givexpforuse( player, eventname, persstat, supername );
                
                if ( isdefined( entity.var_74a4e2fa253c5be8 ) )
                {
                    entity.var_74a4e2fa253c5be8 += 10;
                }
            }
        }
    }
}

// Namespace support_box / scripts\mp\equipment\support_box
// Params 1
// Checksum 0x0, Offset: 0x2e63
// Size: 0x15
function function_49197cd063a740ea( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

