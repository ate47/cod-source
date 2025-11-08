#using scripts\common\utility;
#using scripts\cp\cp_accessories;
#using scripts\cp\cp_loadout;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\cp_powers;
#using scripts\cp\laststand;
#using scripts\cp\loadout;
#using scripts\cp\munitions;
#using scripts\cp\persistence;
#using scripts\cp\super;
#using scripts\cp\survival\survival_loadout;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\weapon;
#using scripts\cp_mp\gestures;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;

#namespace cp_loadout;

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x7de
// Size: 0x3de
function init()
{
    level.available_player_characters = [];
    level.player_character_info = [];
    level.move_speed_scale = &updatemovespeedscale;
    level.registerplayercharfunc = &registerplayercharacter;
    init_core_mp_perks();
    
    if ( !isdefined( level.loadoutsgroup ) )
    {
        level.loadoutsgroup = getplayerdataloadoutgroup();
    }
    
    scripts\cp\super::init_super();
    
    if ( !isdefined( level.classmap ) )
    {
        level.classmap = [];
    }
    
    level.classmap[ "class0" ] = 0;
    level.classmap[ "class1" ] = 1;
    level.classmap[ "class2" ] = 2;
    level.classmap[ "custom1" ] = 0;
    level.classmap[ "custom2" ] = 1;
    level.classmap[ "custom3" ] = 2;
    level.classmap[ "custom4" ] = 3;
    level.classmap[ "custom5" ] = 4;
    level.classmap[ "custom6" ] = 5;
    level.classmap[ "custom7" ] = 6;
    level.classmap[ "custom8" ] = 7;
    level.classmap[ "custom9" ] = 8;
    level.classmap[ "custom10" ] = 9;
    level.classmap[ "axis_recipe1" ] = 0;
    level.classmap[ "axis_recipe2" ] = 1;
    level.classmap[ "axis_recipe3" ] = 2;
    level.classmap[ "axis_recipe4" ] = 3;
    level.classmap[ "axis_recipe5" ] = 4;
    level.classmap[ "axis_recipe6" ] = 5;
    level.classmap[ "allies_recipe1" ] = 0;
    level.classmap[ "allies_recipe2" ] = 1;
    level.classmap[ "allies_recipe3" ] = 2;
    level.classmap[ "allies_recipe4" ] = 3;
    level.classmap[ "allies_recipe5" ] = 4;
    level.classmap[ "allies_recipe6" ] = 5;
    level.classmap[ "gamemode" ] = 0;
    level.classmap[ "callback" ] = 0;
    level.classmap[ "default1" ] = 0;
    level.classmap[ "default2" ] = 1;
    level.classmap[ "default3" ] = 2;
    level.classmap[ "default4" ] = 3;
    level.classmap[ "default5" ] = 4;
    level.classmap[ "default6" ] = 5;
    level.classmap[ "default7" ] = 6;
    level.classmap[ "default8" ] = 7;
    level.classmap[ "default9" ] = 8;
    level.classmap[ "default10" ] = 9;
    level.classmap[ "default11" ] = 10;
    level.classmap[ "juggernaut" ] = 0;
    
    /#
        level.var_4ab72a616f50b4c2 = [];
        level.var_4ab72a616f50b4c2[ 0 ] = "<dev string:x1c>";
        level.var_4ab72a616f50b4c2[ 1 ] = "<dev string:x1c>";
        level.var_4ab72a616f50b4c2[ 2 ] = "<dev string:x1c>";
        level.var_4ab72a616f50b4c2[ 3 ] = "<dev string:x1c>";
        level.var_4ab72a616f50b4c2[ 4 ] = "<dev string:x1c>";
        setdvarifuninitialized( @"scr_test_loadouts", 0 );
    #/
    
    level.defaultclass = "CLASS_ASSAULT";
    
    if ( getdvarint( @"scr_test_loadouts", 0 ) )
    {
        level.classtablename = "classtable:classtable_test";
        return;
    }
    
    level.classtablename = "classtable:classtable";
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0xbc4
// Size: 0x16
function getplayerbodymodel()
{
    customization = scripts\cp\survival\survival_loadout::getoperatorcustomization();
    return customization[ 0 ];
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 3
// Checksum 0x0, Offset: 0xbe3
// Size: 0x69
function return_wbk_version_of_weapon( player, var_ea6befbe838b7be0, objweapon )
{
    level endon( "game_ended" );
    player endon( "disconnect" );
    
    if ( !istrue( player.weaponkitinitialized ) )
    {
        player waittill( "player_weapon_build_kit_initialized" );
    }
    
    if ( isdefined( player.weapon_build_models[ var_ea6befbe838b7be0 ] ) )
    {
        return makeweaponfromstring( player.weapon_build_models[ var_ea6befbe838b7be0 ] );
    }
    
    return objweapon;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0xc54
// Size: 0xf9
function delayreturningperks( player )
{
    level endon( "game_ended" );
    player endon( "disconnect" );
    player waittill( "spawned_player" );
    wait 1;
    
    if ( istrue( player.keep_perks ) )
    {
        if ( isdefined( player.zombies_perks ) )
        {
            var_37d6720284e968a1 = getarraykeys( player.zombies_perks );
            
            foreach ( perk in var_37d6720284e968a1 )
            {
                if ( isdefined( level.coop_perk_callbacks ) && isdefined( level.coop_perk_callbacks[ perk ] ) && isdefined( level.coop_perk_callbacks[ perk ].set ) )
                {
                    player [[ level.coop_perk_callbacks[ perk ].set ]]();
                }
            }
        }
        
        player.keep_perks = undefined;
    }
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0xd55
// Size: 0x56
function release_character_number( player )
{
    character_number = player.player_character_num;
    
    if ( !array_contains( level.available_player_characters, character_number ) && character_number != 5 )
    {
        level.available_player_characters = array_add( level.available_player_characters, character_number );
    }
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0xdb3
// Size: 0x6f
function get_player_character_num()
{
    /#
        var_d22d0a192d3c62ad = getdvarint( @"hash_fc0849115db82d44", -1 );
        
        if ( var_d22d0a192d3c62ad != -1 )
        {
            self.player_character_num = var_d22d0a192d3c62ad;
            return var_d22d0a192d3c62ad;
        }
    #/
    
    if ( isdefined( self.player_character_num ) )
    {
        return self.player_character_num;
    }
    
    choice = random( level.available_player_characters );
    self.player_character_num = choice;
    return choice;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0xe2b
// Size: 0x199
function updatemovespeedscale()
{
    speedperc = undefined;
    
    if ( isdefined( self.playerstreakspeedscale ) )
    {
        speedperc = 1;
        speedperc += self.playerstreakspeedscale;
    }
    else
    {
        speedperc = getplayerspeedbyweapon( self );
        
        if ( isdefined( self.chargemode_speedscale ) )
        {
            speedperc = self.chargemode_speedscale;
        }
        else if ( isdefined( self.siege_speedscale ) )
        {
            speedperc = self.siege_speedscale;
        }
        
        chilldata = self.chill_data;
        
        if ( isdefined( chilldata ) && isdefined( chilldata.speedmod ) )
        {
            speedperc += chilldata.speedmod;
        }
        
        if ( isdefined( self.speedstripmod ) )
        {
            speedperc += self.speedstripmod;
        }
        
        if ( isdefined( self.phasespeedmod ) )
        {
            speedperc += self.phasespeedmod;
        }
        
        if ( isdefined( self.weaponaffinityspeedboost ) )
        {
            speedperc += self.weaponaffinityspeedboost;
        }
        
        if ( isdefined( self.weaponpassivespeedmod ) )
        {
            speedperc += self.weaponpassivespeedmod;
        }
        
        if ( isdefined( self.weaponpassivespeedonkillmod ) )
        {
            speedperc += self.weaponpassivespeedonkillmod;
        }
        
        speedperc = min( 1.5, speedperc );
    }
    
    self.weaponspeed = speedperc;
    assert( isdefined( self.weaponspeed ) );
    assert( isdefined( self.movespeedscaler ) );
    
    if ( !isdefined( self.combatspeedscalar ) )
    {
        self.combatspeedscalar = 1;
    }
    
    self setmovespeedscale( speedperc * self.movespeedscaler * self.combatspeedscalar );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0xfcc
// Size: 0x12b
function getplayerspeedbyweapon( player )
{
    weaponspeed = 1;
    self.weaponlist = self getweaponslistprimaries();
    
    if ( getdvar( @"hash_5cca8d7e65a3830b", "on" ) == "on" )
    {
        return 1;
    }
    
    if ( !self.weaponlist.size )
    {
        weaponspeed = 0.9;
    }
    else
    {
        weapon = self getcurrentweapon();
        
        if ( issuperweapon( weapon ) )
        {
            weaponspeed = level.superweapons[ getcompleteweaponname( weapon ) ].movespeed;
        }
        else
        {
            var_a6852f8e66761e58 = weaponinventorytype( weapon );
            
            if ( var_a6852f8e66761e58 != "primary" && var_a6852f8e66761e58 != "altmode" )
            {
                if ( isdefined( self.saved_lastweapon ) )
                {
                    weapon = self.saved_lastweapon;
                }
                else
                {
                    weapon = undefined;
                }
            }
            
            if ( !isdefined( weapon ) || !self hasweapon( weapon ) )
            {
                weaponspeed = getweaponspeedslowest();
            }
            else
            {
                weaponspeed = getweaponspeed( weapon );
                
                /#
                    if ( !isdefined( weaponspeed ) || weaponspeed == 0 )
                    {
                        weaponspeed = 1;
                    }
                #/
            }
        }
    }
    
    weaponspeed = clampweaponspeed( weaponspeed );
    return weaponspeed;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x1100
// Size: 0x50
function getweaponspeed( weapon )
{
    rootweapon = getbaseweaponname( weapon );
    assertex( isdefined( rootweapon ), "Invalid weapon passed to getWeaponSpeed(): " + rootweapon );
    weaponspeed = level.weaponmapdata[ rootweapon ].speed;
    return weaponspeed;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x1159
// Size: 0xca
function getweaponspeedslowest()
{
    var_6155ff1652d3374f = 2;
    self.weaponlist = self getweaponslistprimaries();
    
    if ( self.weaponlist.size )
    {
        foreach ( weapon in self.weaponlist )
        {
            weaponspeed = getweaponspeed( weapon );
            
            if ( weaponspeed == 0 )
            {
                continue;
            }
            
            if ( weaponspeed < var_6155ff1652d3374f )
            {
                var_6155ff1652d3374f = weaponspeed;
            }
        }
        
        /#
            if ( var_6155ff1652d3374f == 2 )
            {
                assertmsg( "<dev string:x23>" );
            }
        #/
    }
    else
    {
        var_6155ff1652d3374f = 0.9;
    }
    
    var_6155ff1652d3374f = clampweaponspeed( var_6155ff1652d3374f );
    return var_6155ff1652d3374f;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x122c
// Size: 0x3d
function clampweaponspeed( value )
{
    assertex( value >= 0 && value <= 1, "clampWeaponSpeed() passed invalid value: " + value );
    return clamp( value, 0, 1 );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x1272
// Size: 0x11c
function getweaponheaviestvalue()
{
    var_8a6f4e6a2246d381 = 1000;
    self.weaponlist = self getweaponslistprimaries();
    
    if ( self.weaponlist.size )
    {
        foreach ( weapon in self.weaponlist )
        {
            weaponweight = getweaponweight( weapon );
            
            if ( weaponweight == 0 )
            {
                continue;
            }
            
            if ( weaponweight < var_8a6f4e6a2246d381 )
            {
                var_8a6f4e6a2246d381 = weaponweight;
            }
        }
        
        /#
            if ( var_8a6f4e6a2246d381 == 1000 )
            {
                assertmsg( "<dev string:x23>" );
                
                foreach ( weapon in self.weaponlist )
                {
                    assertmsg( "<dev string:x40>" + getcompleteweaponname( weapon ) );
                }
            }
        #/
    }
    else
    {
        var_8a6f4e6a2246d381 = 8;
    }
    
    var_8a6f4e6a2246d381 = clampweaponweightvalue( var_8a6f4e6a2246d381 );
    return var_8a6f4e6a2246d381;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x1397
// Size: 0x73
function getweaponweight( weapon )
{
    baseweapon = getbaseweaponname( weapon );
    weaponspeed = scripts\cp_mp\weapon::function_b8811a0fc04e4b9d( baseweapon, #"speedscale" );
    
    if ( !isdefined( weaponspeed ) || weaponspeed < 1 )
    {
        weaponspeed = float( tablelookup( level.game_mode_statstable, 4, baseweapon, 8 ) );
    }
    
    if ( !isdefined( weaponspeed ) || weaponspeed < 1 )
    {
        weaponspeed = 10;
    }
    
    return weaponspeed;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x1413
// Size: 0x1b
function clampweaponweightvalue( value )
{
    return clamp( value, 0, 11 );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x1437
// Size: 0x42
function wait_and_force_weapon_switch( starting_weapon )
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    wait 0.5;
    
    if ( !self hasweapon( starting_weapon ) )
    {
        starting_weapon = self getweaponslistprimaries()[ 0 ];
    }
    
    self setspawnweapon( starting_weapon );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x1481
// Size: 0xe0
function init_core_mp_perks()
{
    /#
        println( "<dev string:x4d>" );
        println( "<dev string:x73>" );
        println( "<dev string:x4d>" );
    #/
    
    level.perksetfuncs = [];
    level.scriptperks = [];
    level.perkunsetfuncs = [];
    level.scriptperks[ "specialty_falldamage" ] = 1;
    level.scriptperks[ "specialty_armorpiercing" ] = 1;
    level.scriptperks[ "specialty_gung_ho" ] = 1;
    level.scriptperks[ "specialty_momentum" ] = 1;
    level.perksetfuncs[ "specialty_momentum" ] = &setmomentum;
    level.perkunsetfuncs[ "specialty_momentum" ] = &unsetmomentum;
    level.perksetfuncs[ "specialty_falldamage" ] = &setfreefall;
    level.perkunsetfuncs[ "specialty_falldamage" ] = &unsetfreefall;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x1569
// Size: 0xa
function setmomentum()
{
    thread runmomentum();
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x157b
// Size: 0x47
function runmomentum()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "momentum_unset" );
    
    while ( true )
    {
        if ( self issprinting() )
        {
            graduallyincreasespeed();
            self.movespeedscaler = 1;
            updatemovespeedscale();
        }
        
        wait 0.1;
    }
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x15ca
// Size: 0x9f
function graduallyincreasespeed()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "momentum_reset" );
    self endon( "momentum_unset" );
    thread momentum_monitormovement();
    thread momentum_monitordamage();
    var_51438b11657961cc = 0;
    
    while ( var_51438b11657961cc < 0.08 )
    {
        self.movespeedscaler += 0.01;
        updatemovespeedscale();
        wait 0.035 / 0.08;
        var_51438b11657961cc += 0.01;
    }
    
    self playlocalsound( "ftl_phase_in" );
    self notify( "momentum_max_speed" );
    thread momentum_endaftermax();
    self waittill( "momentum_reset" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x1671
// Size: 0x1d
function momentum_endaftermax()
{
    self endon( "momentum_unset" );
    self waittill( "momentum_reset" );
    self playlocalsound( "ftl_phase_out" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x1696
// Size: 0x81
function momentum_monitormovement()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "momentum_unset" );
    
    while ( true )
    {
        if ( !self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning() )
        {
            wait 0.25;
            
            if ( !self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning() )
            {
                self notify( "momentum_reset" );
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x171f
// Size: 0x20
function momentum_monitordamage()
{
    self endon( "death" );
    self endon( "disconnect" );
    self waittill( "damage" );
    self notify( "momentum_reset" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x1747
// Size: 0xa
function unsetmomentum()
{
    self notify( "momentum_unset" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x1759
// Size: 0x2
function setfreefall()
{
    
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x1763
// Size: 0x2
function unsetfreefall()
{
    
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x176d
// Size: 0x121
function set_player_perks()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "force_bleed_out" );
    self endon( "last_stand" );
    self endon( "death" );
    self endon( "revive_success" );
    
    if ( game[ "state" ] != "postgame" )
    {
        wait 0.1;
        move_slide = 4;
        moveid = 0;
        movemask = 0;
        movemask = move_slide;
        
        if ( isdefined( level.player_suit ) )
        {
            scripts\cp\utility\player::_setsuit( level.player_suit );
        }
        else
        {
            scripts\cp\utility\player::_setsuit( "iw9_suit_cp" );
        }
        
        self.suit = "iw9_suit_cp";
        self allowdoublejump( 0 );
        self allowslide( movemask & move_slide );
        self allowwallrun( 0 );
        self allowdodge( 0 );
    }
    
    self allowmantle( 1 );
    
    if ( !is_consumable_active( "grenade_cooldown" ) )
    {
        if ( isdefined( level.power_modifycooldownrate ) )
        {
            self [[ level.power_modifycooldownrate ]]( 0 );
        }
    }
    
    giveperk( "specialty_throwback" );
    self setscriptablepartstate( "CompassIcon", "defaultIcon" );
    self notify( "set_player_perks" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 17
// Checksum 0x0, Offset: 0x1896
// Size: 0x1b9
function registerplayercharacter( character_index, var_80d695139e2ad462, body_model, view_model, head_model, hair_model, vo_prefix, vo_suffix, pap_gesture, revive_gesture, photo_index, fate_card_weapon, intro_music, intro_gesture, melee_weapon, post_setup_func, starting_weapon )
{
    character_info = spawnstruct();
    character_info.body_model = body_model;
    character_info.view_model = view_model;
    character_info.head_model = head_model;
    character_info.hair_model = hair_model;
    character_info.vo_prefix = vo_prefix;
    character_info.vo_suffix = vo_suffix;
    character_info.pap_gesture = pap_gesture;
    character_info.revive_gesture = revive_gesture;
    character_info.photo_index = photo_index;
    character_info.fate_card_weapon = fate_card_weapon;
    character_info.intro_music = intro_music;
    character_info.intro_gesture = intro_gesture;
    character_info.melee_weapon = makeweaponfromstring( melee_weapon );
    character_info.starting_weapon = makeweaponfromstring( starting_weapon );
    character_info.post_setup_func = post_setup_func;
    level.player_character_info[ character_index ] = character_info;
    
    if ( !isdefined( level.available_player_characters ) )
    {
        level.available_player_characters = [];
    }
    
    if ( var_80d695139e2ad462 == "yes" )
    {
        level.available_player_characters[ level.available_player_characters.size ] = character_index;
    }
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x1a57
// Size: 0x2b5
function loadout_updateclasscustom( struct, class )
{
    classindex = class;
    self.class_num = classindex;
    struct.loadoutprimary = cac_getweapon( classindex, 0 );
    
    for ( attachmentindex = 0; attachmentindex < 5 ; attachmentindex++ )
    {
        struct.loadoutprimaryattachments[ attachmentindex ] = cac_getweaponattachment( classindex, 0, attachmentindex );
        struct.loadoutprimaryattachmentids[ attachmentindex ] = cac_getweaponattachmentid( classindex, 0, attachmentindex );
    }
    
    struct.loadoutprimarycamo = cac_getweaponcamo( classindex, 0 );
    struct.loadoutprimaryreticle = cac_getweaponreticle( classindex, 0 );
    struct.loadoutprimarylootitemid = cac_getweaponlootitemid( classindex, 0 );
    struct.loadoutprimaryvariantid = cac_getweaponvariantid( classindex, 0 );
    struct.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment( classindex, 0 );
    
    for ( var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 5 ; var_36d2abbdcbcb186c++ )
    {
        struct.loadoutprimarystickers[ var_36d2abbdcbcb186c ] = cac_getweaponsticker( classindex, 0, var_36d2abbdcbcb186c );
    }
    
    struct.loadoutsecondary = cac_getweapon( classindex, 1 );
    
    for ( attachmentindex = 0; attachmentindex < 5 ; attachmentindex++ )
    {
        struct.loadoutsecondaryattachments[ attachmentindex ] = cac_getweaponattachment( classindex, 1, attachmentindex );
        struct.loadoutsecondaryattachmentids[ attachmentindex ] = cac_getweaponattachmentid( classindex, 1, attachmentindex );
    }
    
    struct.loadoutsecondarycamo = cac_getweaponcamo( classindex, 1 );
    struct.loadoutsecondaryreticle = cac_getweaponreticle( classindex, 1 );
    struct.loadoutsecondarylootitemid = cac_getweaponlootitemid( classindex, 1 );
    struct.loadoutsecondaryvariantid = cac_getweaponvariantid( classindex, 1 );
    struct.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment( classindex, 1 );
    
    for ( var_36d2abbdcbcb186c = 0; var_36d2abbdcbcb186c < 4 ; var_36d2abbdcbcb186c++ )
    {
        struct.loadoutsecondarystickers[ var_36d2abbdcbcb186c ] = cac_getweaponsticker( classindex, 1, var_36d2abbdcbcb186c );
    }
    
    struct.loadoutequipmentprimary = cac_getequipmentprimary( classindex );
    struct.loadoutextraequipmentprimary = cac_getextraequipmentprimary( classindex );
    struct.loadoutequipmentsecondary = cac_getequipmentsecondary( classindex );
    struct.loadoutextraequipmentsecondary = cac_getextraequipmentsecondary( classindex );
    struct.loadoutgesture = cac_getgesture();
    struct.loadoutexecution = cac_getexecution();
    struct.loadoutaccessoryweapon = cac_getaccessoryweapon();
    struct.loadoutaccessorydata = cac_getaccessorydata();
    struct.loadoutaccessorylogic = cac_getaccessorylogic();
    scripts\cp\loadout::function_2dad855d27735128( struct );
    validateloadout( struct );
    return struct;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x1d15
// Size: 0x2b
function getclassindex( classname )
{
    assert( isdefined( level.classmap[ classname ] ) );
    return level.classmap[ classname ];
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x1d49
// Size: 0x458
function validateloadout( loadout )
{
    /#
        if ( getdvarint( @"hash_955ca650f9a9bdef", 0 ) == 1 )
        {
            return loadout;
        }
    #/
    
    replaceweapon = 0;
    
    if ( !function_89497fa763d431c0( loadout.loadoutprimary ) )
    {
        replaceweapon = 1;
    }
    else if ( isweaponuihidden( loadout.loadoutprimary ) )
    {
        replaceweapon = 1;
    }
    
    if ( weaponisrestricted( loadout.loadoutprimary ) )
    {
        replaceweapon = 1;
        var_bc72f32b1575d517 = 1;
    }
    
    if ( replaceweapon )
    {
        loadout.loadoutprimary = "iw8_ar_mike4";
        loadout.loadoutprimaryattachments = [];
        loadout.loadoutprimarycamo = "none";
        loadout.loadoutprimaryreticle = "none";
        loadout.loadoutprimaryvariantid = -1;
        loadout.loadoutprimaryattachmentids = [];
        loadout.loadoutprimarycosmeticattachment = "none";
        loadout.loadoutprimarystickers[ 0 ] = "none";
        loadout.loadoutprimarystickers[ 1 ] = "none";
        loadout.loadoutprimarystickers[ 2 ] = "none";
        loadout.loadoutprimarystickers[ 3 ] = "none";
        loadout.loadoutprimarystickers[ 4 ] = "none";
    }
    else
    {
        if ( isweaponvariantlocked( loadout.loadoutprimary, loadout.loadoutprimaryvariantid ) )
        {
            loadout.loadoutprimaryvariantid = -1;
        }
        
        for ( i = 0; i < loadout.loadoutprimaryattachments.size ; i++ )
        {
            attachment = loadout.loadoutprimaryattachments[ i ];
            var_e7ba2038935530db = loadout.loadoutprimaryattachmentids[ i ];
            
            if ( isattachmentvariantlocked( loadout.loadoutprimary, attachment, var_e7ba2038935530db ) )
            {
                loadout.loadoutprimaryattachmentids[ i ] = 0;
            }
            
            if ( attachment != "none" && ( attachmentisrestricted( attachment, loadout.loadoutprimary ) || !isvalidattachmentunlock( loadout.loadoutprimary, attachment ) ) )
            {
                loadout.loadoutprimaryattachments[ i ] = "none";
                var_e1388376a5be9b75 = 1;
            }
        }
    }
    
    replaceweapon = 0;
    
    if ( !function_89497fa763d431c0( loadout.loadoutsecondary ) )
    {
        replaceweapon = 1;
    }
    else if ( isweaponuihidden( loadout.loadoutsecondary ) )
    {
        replaceweapon = 1;
    }
    
    if ( weaponisrestricted( loadout.loadoutsecondary ) )
    {
        replaceweapon = 1;
        var_bc72f32b1575d517 = 1;
    }
    
    if ( replaceweapon )
    {
        loadout.loadoutsecondary = "iw8_pi_mike1911";
        loadout.loadoutsecondaryattachments = [];
        loadout.loadoutsecondarycamo = "none";
        loadout.loadoutsecondaryreticle = "none";
        loadout.loadoutsecondaryvariantid = -1;
        loadout.loadoutsecondaryattachmentids = [];
        loadout.loadoutsecondarycosmeticattachment = "none";
        loadout.loadoutsecondarystickers[ 0 ] = "none";
        loadout.loadoutsecondarystickers[ 1 ] = "none";
        loadout.loadoutsecondarystickers[ 2 ] = "none";
        loadout.loadoutsecondarystickers[ 3 ] = "none";
        loadout.loadoutsecondarystickers[ 4 ] = "none";
    }
    else
    {
        if ( isweaponvariantlocked( loadout.loadoutsecondary, loadout.loadoutsecondaryvariantid ) )
        {
            loadout.loadoutsecondaryvariantid = -1;
        }
        
        for ( i = 0; i < loadout.loadoutsecondaryattachments.size ; i++ )
        {
            attachment = loadout.loadoutsecondaryattachments[ i ];
            var_e7ba2038935530db = loadout.loadoutsecondaryattachmentids[ i ];
            
            if ( isattachmentvariantlocked( loadout.loadoutsecondary, attachment, var_e7ba2038935530db ) )
            {
                loadout.loadoutsecondaryattachmentids[ i ] = 0;
            }
            
            if ( attachment != "none" && ( attachmentisrestricted( attachment, loadout.loadoutsecondary ) || !isvalidattachmentunlock( loadout.loadoutsecondary, attachment ) ) )
            {
                loadout.loadoutsecondaryattachments[ i ] = "none";
                var_e1388376a5be9b75 = 1;
            }
        }
    }
    
    return loadout;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x21aa
// Size: 0x3f
function isvalidattachmentunlock( weaponrootname, attachmentbasename )
{
    var_338c04a2f19ba8b6 = getdvarint( @"scr_checkvalidattachmentunlock", 0 ) == 1;
    
    if ( var_338c04a2f19ba8b6 )
    {
        return attachmentisselectablerootname( weaponrootname, attachmentbasename );
    }
    
    return 1;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x21f2
// Size: 0x7d, Type: bool
function attachmentisselectablerootname( weaponrootname, attachment )
{
    if ( isdefined( level.weaponmapdata[ weaponrootname ] ) && isdefined( level.weaponmapdata[ weaponrootname ].assetname ) )
    {
        slot = getattachmentslotindex( level.weaponmapdata[ weaponrootname ].assetname, attachment );
        
        if ( isdefined( slot ) && slot != -1 )
        {
            return isdefined( level.weaponattachments[ attachment ] );
        }
    }
    
    return false;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x2278
// Size: 0x31, Type: bool
function isweaponuihidden( weaponrootname )
{
    return isdefined( level.weaponmapdata[ weaponrootname ] ) && istrue( level.weaponmapdata[ weaponrootname ].uihidden );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x22b2
// Size: 0x5c, Type: bool
function isweaponvariantlocked( weaponrootname, variantid )
{
    if ( !isdefined( variantid ) || variantid <= 0 )
    {
        return false;
    }
    
    variantkey = weaponrootname + "|" + variantid;
    return isdefined( level.weaponlootmapdata[ variantkey ] ) && istrue( level.weaponlootmapdata[ variantkey ].islocked );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 3
// Checksum 0x0, Offset: 0x2317
// Size: 0x128, Type: bool
function isattachmentvariantlocked( weaponrootname, attachment, attachmentvariantid )
{
    if ( !isdefined( attachmentvariantid ) || attachmentvariantid == 0 || attachment == "none" )
    {
        return false;
    }
    
    attachmentisvalid = 0;
    
    for ( variantindex = 1; true ; variantindex++ )
    {
        variantkey = weaponrootname + "|" + variantindex;
        
        if ( !isdefined( level.weaponlootmapdata[ variantkey ] ) )
        {
            break;
        }
        
        if ( !level.weaponlootmapdata[ variantkey ].islocked )
        {
            if ( isdefined( level.weaponlootmapdata[ variantkey ].attachcustomtoidmap ) )
            {
                foreach ( id in level.weaponlootmapdata[ variantkey ].attachcustomtoidmap )
                {
                    if ( attachmentvariantid == id && attachment == key )
                    {
                        attachmentisvalid = 1;
                        break;
                    }
                }
            }
            
            if ( attachmentisvalid )
            {
                break;
            }
        }
    }
    
    return !attachmentisvalid;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x2448
// Size: 0x238
function loadout_updateclassdefault( struct, classindex )
{
    self.class_num = classindex;
    struct.loadoutprimary = table_getweapon( level.classtablename, classindex, 0 );
    
    for ( attachmentindex = 0; attachmentindex < 5 ; attachmentindex++ )
    {
        struct.loadoutprimaryattachments[ attachmentindex ] = table_getweaponattachment( level.classtablename, classindex, 0, attachmentindex );
    }
    
    struct.loadoutprimarycamo = table_getweaponcamo( level.classtablename, classindex, 0 );
    struct.loadoutprimaryreticle = table_getweaponreticle( level.classtablename, classindex, 0 );
    struct.loadoutsecondary = table_getweapon( level.classtablename, classindex, 1 );
    
    for ( attachmentindex = 0; attachmentindex < 5 ; attachmentindex++ )
    {
        struct.loadoutsecondaryattachments[ attachmentindex ] = table_getweaponattachment( level.classtablename, classindex, 1, attachmentindex );
    }
    
    struct.loadoutsecondarycamo = table_getweaponcamo( level.classtablename, classindex, 1 );
    struct.loadoutsecondaryreticle = table_getweaponreticle( level.classtablename, classindex, 1 );
    struct.loadoutequipmentprimary = table_getequipmentprimary( level.classtablename, classindex );
    struct.loadoutextraequipmentprimary = table_getextraequipmentprimary( level.classtablename, classindex );
    struct.loadoutequipmentsecondary = table_getequipmentsecondary( level.classtablename, classindex );
    struct.loadoutextraequipmentsecondary = table_getextraequipmentsecondary( level.classtablename, classindex );
    struct.loadoutgesture = table_getgesture( level.classtablename, classindex );
    struct.loadoutexecution = cac_getexecution();
    scripts\cp\loadout::function_2dad855d27735128( struct );
    struct.loadoutaccessoryweapon = cac_getaccessoryweapon();
    struct.loadoutaccessorydata = cac_getaccessorydata();
    struct.loadoutaccessorylogic = cac_getaccessorylogic();
    
    if ( getdvarint( @"hash_cef27c8d9e5e0053", 0 ) )
    {
        struct.loadoutsuper = "super_bradley";
    }
    
    return struct;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x2689
// Size: 0x8d
function cac_getgesture()
{
    gestureid = "none";
    
    if ( isdefined( self.changedarchetypeinfo ) )
    {
        archetypeindex = level.archetypeids[ self.changedarchetypeinfo.archetype ];
        gestureid = self getplayerdata( level.loadoutsgroup, "squadMembers", "archetypePreferences", archetypeindex, "gesture" );
    }
    else
    {
        gestureid = self getplayerdata( level.loadoutsgroup, "squadMembers", "gesture" );
    }
    
    return scripts\cp_mp\gestures::getgesturedata( gestureid );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x271f
// Size: 0x2d
function cac_getaccessoryweapon()
{
    accessoryindex = self getplayerdata( level.loadoutsgroup, "customizationSetup", "operatorWatch" );
    return scripts\cp\cp_accessories::getaccessoryweaponbyindex( accessoryindex );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x2755
// Size: 0x2d
function cac_getaccessorydata()
{
    accessoryindex = self getplayerdata( level.loadoutsgroup, "customizationSetup", "operatorWatch" );
    return scripts\cp\cp_accessories::getaccessorydatabyindex( accessoryindex );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x278b
// Size: 0x2d
function cac_getaccessorylogic()
{
    accessoryindex = self getplayerdata( level.loadoutsgroup, "customizationSetup", "operatorWatch" );
    return scripts\cp\cp_accessories::getaccessorylogicbyindex( accessoryindex );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x27c1
// Size: 0x7
function cac_getexecution()
{
    return "neck_stab";
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 3
// Checksum 0x0, Offset: 0x27d1
// Size: 0x41
function cac_getweaponsticker( classindex, weaponindex, var_36d2abbdcbcb186c )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "sticker", var_36d2abbdcbcb186c );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x281b
// Size: 0x19c
function give_weapons_from_loadout( player, var_7cb3ce39e2414126 )
{
    struct = spawnstruct();
    var_d0ef877013d341af = spawnstruct();
    var_a52c671acca08378 = player cac_getloadoutselectedidx();
    
    if ( isdefined( var_7cb3ce39e2414126 ) )
    {
        var_d0ef877013d341af = loadout_updateclassdefault( struct, var_7cb3ce39e2414126 );
    }
    else
    {
        var_d0ef877013d341af = scripts\cp\cp_loadout::loadout_updateclasscustom( struct, var_a52c671acca08378 );
    }
    
    self.custom_loadout_index = var_a52c671acca08378;
    self.classstruct = var_d0ef877013d341af;
    assign_loadout_weapons( player, var_d0ef877013d341af );
    var_918c7d3ed87ea3e8 = get_num_of_charges_for_power( player, "primary" );
    primary_gren = get_grenade_from_struct( var_d0ef877013d341af.loadoutequipmentprimary );
    
    if ( !array_contains_key( level.powers, primary_gren ) )
    {
        primary_gren = "none";
    }
    
    var_dca226ee1d93a538 = get_num_of_charges_for_power( player, "secondary" );
    secondary_gren = get_grenade_from_struct( var_d0ef877013d341af.loadoutequipmentsecondary );
    
    if ( !array_contains_key( level.powers, secondary_gren ) )
    {
        secondary_gren = "none";
    }
    
    player scripts\cp\loadout::function_9743c56a4d2dc135( var_d0ef877013d341af );
    total_slots = self getplayerdata( "cp", "inventorySlots", "totalSlots" );
    
    if ( !istrue( self.changing_loadout ) )
    {
        player scripts\cp\munitions::reset_munitions( self, total_slots );
        player scripts\cp\munitions::assign_lowest_full_slot_to_active();
    }
    
    player thread scripts\cp\cp_powers::givepower( primary_gren, "primary", undefined, undefined, undefined, undefined, 1, var_918c7d3ed87ea3e8 );
    player thread scripts\cp\cp_powers::givepower( secondary_gren, "secondary", undefined, undefined, undefined, undefined, 1, var_dca226ee1d93a538 );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x29bf
// Size: 0xa1
function get_num_of_charges_for_power( player, slot_name )
{
    if ( isdefined( level.get_num_of_charges_for_power ) )
    {
        return [[ level.get_num_of_charges_for_power ]]( player );
    }
    
    if ( is_wave_gametype() )
    {
        perk = cac_getloadoutperk( undefined, 2 );
        
        if ( perk == "specialty_extra_shrapnel" )
        {
            giveperk( "specialty_extra_deadly" );
        }
    }
    
    if ( _hasperk( "specialty_extra_deadly" ) && slot_name == "primary" )
    {
        return 2;
    }
    
    if ( isdefined( self.perk_data[ "offhand_count" ] ) )
    {
        return self.perk_data[ "offhand_count" ];
    }
    
    return 1;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x2a69
// Size: 0x4, Type: bool
function get_default_num_equipment_charges()
{
    return true;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 3
// Checksum 0x0, Offset: 0x2a76
// Size: 0x17a
function give_equipment_from_loadout( player, equipmentslot, var_7cb3ce39e2414126 )
{
    struct = spawnstruct();
    var_a52c671acca08378 = player cac_getloadoutselectedidx();
    
    if ( isdefined( var_7cb3ce39e2414126 ) )
    {
        var_d0ef877013d341af = loadout_updateclassdefault( struct, var_7cb3ce39e2414126 );
    }
    else
    {
        var_d0ef877013d341af = scripts\cp\cp_loadout::loadout_updateclasscustom( struct, var_a52c671acca08378 );
    }
    
    var_918c7d3ed87ea3e8 = get_num_of_charges_for_power( player, "primary" );
    primary_gren = get_grenade_from_struct( var_d0ef877013d341af.loadoutequipmentprimary );
    
    if ( !array_contains_key( level.powers, primary_gren ) )
    {
        primary_gren = "none";
    }
    
    var_dca226ee1d93a538 = get_num_of_charges_for_power( player, "secondary" );
    secondary_gren = get_grenade_from_struct( var_d0ef877013d341af.loadoutequipmentsecondary );
    
    if ( !array_contains_key( level.powers, secondary_gren ) )
    {
        secondary_gren = "none";
    }
    
    if ( !isdefined( equipmentslot ) )
    {
        player thread scripts\cp\cp_powers::givepower( primary_gren, "primary", undefined, undefined, undefined, undefined, 1, var_918c7d3ed87ea3e8 );
        player thread scripts\cp\cp_powers::givepower( secondary_gren, "secondary", undefined, undefined, undefined, undefined, 1, var_dca226ee1d93a538 );
        return;
    }
    
    if ( equipmentslot == 0 )
    {
        player thread scripts\cp\cp_powers::givepower( primary_gren, "primary", undefined, undefined, undefined, undefined, 1, var_918c7d3ed87ea3e8 );
        return;
    }
    
    if ( equipmentslot == 1 )
    {
        player thread scripts\cp\cp_powers::givepower( secondary_gren, "secondary", undefined, undefined, undefined, undefined, 1, var_dca226ee1d93a538 );
    }
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x2bf8
// Size: 0xd5
function give_and_switch_to_primary_weapon( player )
{
    struct = spawnstruct();
    var_a52c671acca08378 = player cac_getloadoutselectedidx();
    var_d0ef877013d341af = scripts\cp\cp_loadout::loadout_updateclasscustom( struct, var_a52c671acca08378 );
    var_d0ef877013d341af.loadoutprimaryobject = player scripts\cp\cp_loadout::give_primary_weapon( player, var_d0ef877013d341af );
    clipcount = weaponclipsize( struct.loadoutprimaryobject );
    ammocount = weaponmaxammo( struct.loadoutprimaryobject );
    player giveweapon( struct.loadoutprimaryobject );
    player setweaponammoclip( struct.loadoutprimaryobject, clipcount );
    player setweaponammostock( struct.loadoutprimaryobject, ammocount );
    player switchtoweapon( struct.loadoutprimaryobject );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 3
// Checksum 0x0, Offset: 0x2cd5
// Size: 0xaf
function give_primary_attachments_only( player, clipammo, stockammo )
{
    struct = spawnstruct();
    var_a52c671acca08378 = player cac_getloadoutselectedidx();
    var_d0ef877013d341af = scripts\cp\cp_loadout::loadout_updateclasscustom( struct, var_a52c671acca08378 );
    var_d0ef877013d341af.loadoutprimaryobject = player scripts\cp\cp_loadout::give_primary_weapon( player, var_d0ef877013d341af );
    player giveweapon( struct.loadoutprimaryobject );
    player setweaponammoclip( struct.loadoutprimaryobject, clipammo );
    player setweaponammostock( struct.loadoutprimaryobject, stockammo );
    player switchtoweapon( struct.loadoutprimaryobject );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x2d8c
// Size: 0xd4
function give_and_switch_to_secondary_weapon( player, struct )
{
    struct = spawnstruct();
    var_a52c671acca08378 = player cac_getloadoutselectedidx();
    var_d0ef877013d341af = scripts\cp\cp_loadout::loadout_updateclasscustom( struct, var_a52c671acca08378 );
    var_d0ef877013d341af.loadoutsecondaryobject = player scripts\cp\cp_loadout::give_secondary_weapon( player, var_d0ef877013d341af );
    clipcount = weaponclipsize( var_d0ef877013d341af.loadoutsecondaryobject );
    ammocount = weaponmaxammo( var_d0ef877013d341af.loadoutsecondaryobject );
    player giveweapon( var_d0ef877013d341af.loadoutsecondaryobject );
    player setweaponammoclip( var_d0ef877013d341af.loadoutsecondaryobject, clipcount );
    player setweaponammostock( var_d0ef877013d341af.loadoutsecondaryobject, ammocount );
    player switchtoweaponimmediate( var_d0ef877013d341af.loadoutsecondaryobject );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 3
// Checksum 0x0, Offset: 0x2e68
// Size: 0xaf
function give_secondary_attachments_only( player, clipammo, stockammo )
{
    struct = spawnstruct();
    var_a52c671acca08378 = player cac_getloadoutselectedidx();
    var_d0ef877013d341af = scripts\cp\cp_loadout::loadout_updateclasscustom( struct, var_a52c671acca08378 );
    var_d0ef877013d341af.loadoutsecondaryobject = player scripts\cp\cp_loadout::give_secondary_weapon( player, var_d0ef877013d341af );
    player giveweapon( struct.loadoutsecondaryobject );
    player setweaponammoclip( struct.loadoutsecondaryobject, clipammo );
    player setweaponammostock( struct.loadoutsecondaryobject, stockammo );
    player switchtoweapon( struct.loadoutsecondaryobject );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x2f1f
// Size: 0x3e6
function change_loadout_watcher( player )
{
    level endon( "game_ended" );
    player endon( "disconnect" );
    
    while ( true )
    {
        self waittill( "luinotifyserver", channel, value );
        
        if ( channel == "class_select" || channel == "class_edit" || channel == "class_menu_closed" )
        {
            if ( is_player_carrying_special_item() )
            {
                self notify( "switched_from_core" );
            }
            
            if ( channel == "class_select" )
            {
                if ( value >= 100 )
                {
                    classindex = value - 100;
                }
                else
                {
                    classindex = undefined;
                }
                
                if ( scripts\cp\laststand::player_in_laststand( self ) )
                {
                    self notify( "loadout_menu_closed" );
                }
                else
                {
                    self.changing_loadout = 1;
                    self.defaultclassindex = classindex;
                    
                    if ( ent_flag_exist( "player_spawned_with_loadout" ) && ent_flag( "player_spawned_with_loadout" ) )
                    {
                        self [[ level.custom_giveloadout ]]( 0, undefined, classindex, 1 );
                    }
                    else
                    {
                        self [[ level.custom_giveloadout ]]( 0, undefined, classindex );
                    }
                }
                
                thread display_relics_splash( self, 5 );
            }
            
            if ( channel == "class_menu_closed" )
            {
                self notify( "loadout_menu_closed" );
                
                if ( is_wave_gametype() )
                {
                    thread buy_menu_closed();
                }
            }
            
            continue;
        }
        
        if ( channel == "update_super" )
        {
            scripts\cp\super::give_player_super();
            continue;
        }
        
        if ( channel == "munitions_updated" )
        {
            total_slots = self getplayerdata( "cp", "inventorySlots", "totalSlots" );
            scripts\cp\munitions::reset_munitions( self, total_slots );
            
            if ( is_wave_gametype() )
            {
                sync_currency();
                thread buy_menu_closed();
            }
            
            continue;
        }
        
        if ( channel == "weapon_purchased" && is_wave_gametype() )
        {
            sync_currency();
            
            if ( scripts\cp\laststand::player_in_laststand( player ) )
            {
                player waittill( "revive_success" );
                waitframe();
            }
            
            if ( self getweaponslistprimaries().size > 1 )
            {
                var_986cbcea81712875 = getvalidtakeweapon();
                self takeweapon( var_986cbcea81712875 );
            }
            
            if ( self.open_cac_slot == 0 )
            {
                give_and_switch_to_primary_weapon( self );
            }
            else if ( self.open_cac_slot == 1 )
            {
                give_and_switch_to_secondary_weapon( self );
            }
            
            continue;
        }
        
        if ( channel == "attachment_purchased" && is_wave_gametype() )
        {
            sync_currency();
            
            if ( scripts\cp\laststand::player_in_laststand( player ) )
            {
                player waittill( "revive_success" );
                waitframe();
            }
            
            var_986cbcea81712875 = getvalidtakeweapon();
            currentclipammo = self getweaponammoclip( var_986cbcea81712875 );
            currentstockammo = self getweaponammostock( var_986cbcea81712875 );
            self takeweapon( var_986cbcea81712875 );
            
            if ( self.open_cac_slot == 0 )
            {
                give_primary_attachments_only( self, currentclipammo, currentstockammo );
            }
            else if ( self.open_cac_slot == 1 )
            {
                give_secondary_attachments_only( self, currentclipammo, currentstockammo );
            }
            
            continue;
        }
        
        if ( channel == "tactical_purchased" && is_wave_gametype() )
        {
            sync_currency();
            
            if ( scripts\cp\laststand::player_in_laststand( player ) )
            {
                player waittill( "revive_success" );
                waitframe();
            }
            
            give_equipment_from_loadout( self, 1, undefined );
            continue;
        }
        
        if ( channel == "lethal_purchased" && is_wave_gametype() )
        {
            sync_currency();
            
            if ( scripts\cp\laststand::player_in_laststand( player ) )
            {
                player waittill( "revive_success" );
                waitframe();
            }
            
            give_equipment_from_loadout( self, 0, undefined );
            continue;
        }
        
        if ( channel == "shrapnel_perk_purchased" && is_wave_gametype() )
        {
            sync_currency();
            
            if ( scripts\cp\laststand::player_in_laststand( player ) )
            {
                player waittill( "revive_success" );
                waitframe();
            }
            
            give_equipment_from_loadout( self, 0, undefined );
            continue;
        }
        
        if ( channel == "ammo_purchased" && is_wave_gametype() )
        {
            var_986cbcea81712875 = getvalidtakeweapon();
            sync_currency();
            
            if ( scripts\cp\laststand::player_in_laststand( player ) )
            {
                player waittill( "revive_success" );
                waitframe();
            }
            
            self givemaxammo( var_986cbcea81712875 );
            self setweaponammoclip( var_986cbcea81712875, weaponclipsize( var_986cbcea81712875 ) );
            level thread scripts\cp\cp_player_battlechatter::trysaylocalsound( self, #"bc_combat_action_reloading", undefined, 0.2 );
        }
    }
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x330d
// Size: 0x45
function display_relics_splash( player, time )
{
    wait 1.5;
    
    if ( level.set_relics.size > 0 )
    {
        player setclientomnvar( "ui_match_start_countdown", time );
        wait time;
        player setclientomnvar( "ui_match_start_countdown", -1 );
    }
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x335a
// Size: 0x10
function buy_menu_closed()
{
    self clearsoundsubmix( "cp_store_duck", 1 );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x3372
// Size: 0x2e
function sync_currency()
{
    var_d7fe0f139d9ac266 = self getplayerdata( level.loadoutsgroup, "squadMembers", "currencyWaveMode" );
    scripts\cp\persistence::set_player_currency( var_d7fe0f139d9ac266 );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x33a8
// Size: 0xc
function get_grenade_from_struct( equipment_name )
{
    return equipment_name;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x33bd
// Size: 0x1b
function cac_getloadoutselectedidx()
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "cpLoadoutSel" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x33e1
// Size: 0x60
function cac_getloadoutperk( classindex, perkindex )
{
    if ( is_wave_gametype() )
    {
        return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "loadoutPerks", perkindex );
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", classindex, "loadoutPerks", perkindex );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x3449
// Size: 0x60
function cac_getloadoutextraperk( classindex, perkindex )
{
    if ( is_wave_gametype() )
    {
        return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "extraPerks", perkindex );
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", classindex, "extraPerks", perkindex );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x34b1
// Size: 0x6a
function cac_getweapon( classindex, weaponindex )
{
    if ( is_wave_gametype() )
    {
        return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", weaponindex, "weapon" );
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "weapon" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 3
// Checksum 0x0, Offset: 0x3523
// Size: 0xa8
function cac_getweaponattachment( classindex, weaponindex, attachmentindex )
{
    playerdatavalue = undefined;
    weapon = cac_getweapon( classindex, weaponindex );
    
    if ( is_wave_gametype() )
    {
        playerdatavalue = self getplayerdata( level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", weaponindex, "attachmentSetup", attachmentindex, "attachment" );
    }
    else
    {
        playerdatavalue = self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachmentindex, "attachment" );
    }
    
    scripts\cp_mp\weapon::function_6e7bc1b23afa0ea8( weapon, playerdatavalue );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 3
// Checksum 0x0, Offset: 0x35d3
// Size: 0x46
function cac_getweaponattachmentid( classindex, weaponindex, attachmentindex )
{
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachmentindex, "variantID" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x3622
// Size: 0x6a
function cac_getweaponlootitemid( classindex, weaponindex )
{
    if ( is_wave_gametype() )
    {
        return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", weaponindex, "lootItemID" );
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "lootItemID" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x3694
// Size: 0x6a
function cac_getweaponvariantid( classindex, weaponindex )
{
    if ( is_wave_gametype() )
    {
        return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", weaponindex, "variantID" );
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "variantID" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x3706
// Size: 0x6a
function cac_getweaponcamo( classindex, weaponindex )
{
    if ( is_wave_gametype() )
    {
        return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", weaponindex, "camo" );
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "camo" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x3778
// Size: 0x6a
function cac_getweaponreticle( classindex, weaponindex )
{
    if ( is_wave_gametype() )
    {
        return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", weaponindex, "reticle" );
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "reticle" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x37ea
// Size: 0x6a
function cac_getweaponcosmeticattachment( classindex, weaponindex )
{
    if ( is_wave_gametype() )
    {
        return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", weaponindex, "cosmeticAttachment" );
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "cosmeticAttachment" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x385c
// Size: 0x58
function cac_checkoverkillperk( classindex )
{
    if ( is_wave_gametype() )
    {
        return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "loadoutPerks", 0 );
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", classindex, "loadoutPerks", 0 );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x38bc
// Size: 0x62
function cac_getequipmentprimary( classindex )
{
    if ( is_wave_gametype() )
    {
        return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 0, "equipment" );
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", classindex, "equipmentSetups", 0, "equipment" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x3926
// Size: 0x62
function cac_getextraequipmentprimary( classindex )
{
    if ( is_wave_gametype() )
    {
        return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 0, "extraCharge" );
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", classindex, "equipmentSetups", 0, "extraCharge" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x3990
// Size: 0x64
function cac_getequipmentsecondary( classindex )
{
    if ( is_wave_gametype() )
    {
        return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 1, "equipment" );
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", classindex, "equipmentSetups", 1, "equipment" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x39fc
// Size: 0x64
function cac_getextraequipmentsecondary( classindex )
{
    if ( is_wave_gametype() )
    {
        return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 1, "extraCharge" );
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "loadouts", classindex, "equipmentSetups", 1, "extraCharge" );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x3a68
// Size: 0x235
function assign_loadout_weapons( player, struct )
{
    if ( struct.loadoutprimary == "none" )
    {
        struct.loadoutprimaryfullname = "none";
        struct.loadoutprimaryobject = undefined;
    }
    else
    {
        struct.loadoutprimaryobject = scripts\cp_mp\weapon::buildweapon( struct.loadoutprimary, struct.loadoutprimaryattachments, struct.loadoutprimarycamo, struct.loadoutprimaryreticle, struct.loadoutprimaryvariantid, struct.loadoutprimaryattachmentids, struct.loadoutprimarycosmeticattachment, struct.loadoutprimarystickers, istrue( struct.loadouthasnvg ) );
        struct.loadoutprimaryobject = give_weapon_alt_clip_ammo_hack( player, struct.loadoutprimaryobject );
        struct.loadoutprimaryfullname = getcompleteweaponname( struct.loadoutprimaryobject );
    }
    
    if ( struct.loadoutsecondary == "none" )
    {
        struct.loadoutsecondaryfullname = "none";
        struct.loadoutsecondaryobject = undefined;
    }
    else
    {
        struct.loadoutsecondaryobject = scripts\cp_mp\weapon::buildweapon( struct.loadoutsecondary, struct.loadoutsecondaryattachments, struct.loadoutsecondarycamo, struct.loadoutsecondaryreticle, struct.loadoutsecondaryvariantid, struct.loadoutsecondaryattachmentids, struct.loadoutsecondarycosmeticattachment, struct.loadoutsecondarystickers, istrue( struct.loadouthasnvg ) );
        struct.loadoutsecondaryobject = give_weapon_alt_clip_ammo_hack( player, struct.loadoutsecondaryobject );
        struct.loadoutsecondaryfullname = getcompleteweaponname( struct.loadoutsecondaryobject );
    }
    
    player.starting_weapon = struct.loadoutprimaryobject;
    player.primaryweaponobj = player.starting_weapon;
    player.default_starting_pistol = struct.loadoutsecondaryobject;
    player.secondaryweaponobj = player.default_starting_pistol;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x3ca5
// Size: 0x2f
function give_primary_weapon( player, struct )
{
    return scripts\cp_mp\weapon::buildweapon( struct.loadoutprimary, struct.loadoutprimaryattachments );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x3cdd
// Size: 0x2f
function give_secondary_weapon( player, struct )
{
    return scripts\cp_mp\weapon::buildweapon( struct.loadoutsecondary, struct.loadoutsecondaryattachments );
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x3d15
// Size: 0x62
function give_weapon_alt_clip_ammo_hack( player, weaponobj )
{
    weaponaltobj = weaponobj getaltweapon();
    
    if ( weaponaltobj.basename != "none" )
    {
        var_91093ef03654702c = weaponclass( weaponaltobj );
        
        if ( var_91093ef03654702c == "spread" )
        {
            player setweaponammoclip( weaponaltobj, weaponclipsize( weaponaltobj ) );
        }
    }
    
    return weaponobj;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x3d80
// Size: 0xaa
function function_acad491093697c6c( tablename )
{
    if ( !isdefined( level.var_f64740277f13e29b ) || level.var_f64740277f13e29b.id != tablename )
    {
        level.var_f64740277f13e29b = spawnstruct();
        level.var_f64740277f13e29b.id = tablename;
        level.var_f64740277f13e29b.classes = [];
        level.var_f64740277f13e29b.classtable = getscriptbundle( tablename );
        assert( isdefined( level.var_f64740277f13e29b.classtable ) );
    }
    
    return level.var_f64740277f13e29b;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x3e33
// Size: 0x94
function function_c7a0b640c398497( tablename, classindex )
{
    var_f64740277f13e29b = function_acad491093697c6c( tablename );
    
    if ( !isdefined( var_f64740277f13e29b.classes[ classindex ] ) )
    {
        classtableentry = var_f64740277f13e29b.classtable.classlist[ classindex ];
        assert( isdefined( classtableentry ) );
        var_f64740277f13e29b.classes[ classindex ] = getscriptbundle( "classtableentry:" + classtableentry.entry );
    }
    
    return var_f64740277f13e29b.classes[ classindex ];
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x3ed0
// Size: 0x33
function function_df2933f96d726d71( tablename )
{
    var_f64740277f13e29b = function_acad491093697c6c( tablename );
    return var_f64740277f13e29b.classtable.classlist.size;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 3
// Checksum 0x0, Offset: 0x3f0c
// Size: 0x5e
function table_getweapon( tablename, classindex, weaponindex )
{
    if ( weaponindex == 0 )
    {
        return function_c7a0b640c398497( tablename, classindex ).primaryweapon.weapon;
    }
    
    return function_c7a0b640c398497( tablename, classindex ).secondaryweapon.weapon;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 4
// Checksum 0x0, Offset: 0x3f72
// Size: 0x210
function table_getweaponattachment( tablename, classindex, weaponindex, attachmentindex )
{
    tempname = "none";
    classstruct = function_c7a0b640c398497( tablename, classindex );
    
    if ( !isdefined( classstruct.primaryweapon.attachments ) )
    {
        classstruct.primaryweapon.attachments = [ classstruct.primaryweapon.attachment1, classstruct.primaryweapon.attachment2, classstruct.primaryweapon.attachment3, classstruct.primaryweapon.attachment4, classstruct.primaryweapon.attachment5, classstruct.primaryweapon.attachment6 ];
    }
    
    if ( !isdefined( classstruct.secondaryweapon.attachments ) )
    {
        classstruct.secondaryweapon.attachments = [ classstruct.secondaryweapon.attachment1, classstruct.secondaryweapon.attachment2, classstruct.secondaryweapon.attachment3, classstruct.secondaryweapon.attachment4, classstruct.secondaryweapon.attachment5 ];
    }
    
    if ( weaponindex == 0 )
    {
        tempname = classstruct.primaryweapon.attachments[ attachmentindex ];
    }
    else
    {
        tempname = classstruct.secondaryweapon.attachments[ attachmentindex ];
    }
    
    if ( !isdefined( tempname ) || tempname == "" )
    {
        return "none";
    }
    
    return tempname;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 3
// Checksum 0x0, Offset: 0x418a
// Size: 0x5e
function table_getweaponcamo( tablename, classindex, weaponindex )
{
    if ( weaponindex == 0 )
    {
        return function_c7a0b640c398497( tablename, classindex ).primaryweapon.camo;
    }
    
    return function_c7a0b640c398497( tablename, classindex ).secondaryweapon.camo;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 3
// Checksum 0x0, Offset: 0x41f0
// Size: 0x5e
function table_getweaponreticle( tablename, classindex, weaponindex )
{
    if ( weaponindex == 0 )
    {
        return function_c7a0b640c398497( tablename, classindex ).primaryweapon.reticle;
    }
    
    return function_c7a0b640c398497( tablename, classindex ).secondaryweapon.reticle;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 3
// Checksum 0x0, Offset: 0x4256
// Size: 0xaf
function table_getperk( tablename, classindex, perkindex )
{
    assert( perkindex <= 3 );
    classstruct = function_c7a0b640c398497( tablename, classindex );
    
    if ( !isdefined( classstruct.perksarray ) )
    {
        classstruct.perksarray = [ classstruct.perks.perk1, classstruct.perks.perk2, classstruct.perks.perk3 ];
    }
    
    return classstruct.perksarray[ perkindex ];
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 3
// Checksum 0x0, Offset: 0x430e
// Size: 0xaf
function table_getextraperk( tablename, classindex, perkindex )
{
    assert( perkindex <= 3 );
    classstruct = function_c7a0b640c398497( tablename, classindex );
    
    if ( !isdefined( classstruct.var_9e0a050f0398edc3 ) )
    {
        classstruct.var_9e0a050f0398edc3 = [ classstruct.extraperks.perk1, classstruct.extraperks.perk2, classstruct.extraperks.perk3 ];
    }
    
    return classstruct.var_9e0a050f0398edc3[ perkindex ];
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x43c6
// Size: 0x2f
function table_getequipmentprimary( tablename, classindex )
{
    return function_c7a0b640c398497( tablename, classindex ).equipment.primary;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x43fe
// Size: 0x47, Type: bool
function table_getextraequipmentprimary( tablename, classindex )
{
    value = function_c7a0b640c398497( tablename, classindex ).extrapower.primary;
    return isdefined( value ) && value == "1";
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x444e
// Size: 0x2f
function table_getequipmentsecondary( tablename, classindex )
{
    return function_c7a0b640c398497( tablename, classindex ).equipment.secondary;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x4486
// Size: 0x44, Type: bool
function table_getextraequipmentsecondary( tablename, classindex )
{
    value = function_c7a0b640c398497( tablename, classindex ).extrapower.secondary;
    return isdefined( value ) && value == 1;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x44d3
// Size: 0x25
function table_getsuper( tablename, classindex )
{
    return function_c7a0b640c398497( tablename, classindex ).super;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x4501
// Size: 0x3a, Type: bool
function table_getspecialist( tablename, classindex )
{
    value = function_c7a0b640c398497( tablename, classindex ).specialist;
    return isdefined( value ) && value == 1;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x4544
// Size: 0x25
function table_getgesture( tablename, classindex )
{
    return function_c7a0b640c398497( tablename, classindex ).gesture;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x4572
// Size: 0x25
function table_getexecution( tablename, classindex )
{
    return function_c7a0b640c398497( tablename, classindex ).execution;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 2
// Checksum 0x0, Offset: 0x45a0
// Size: 0x25
function table_getrole( tablename, classindex )
{
    return function_c7a0b640c398497( tablename, classindex ).role;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 1
// Checksum 0x0, Offset: 0x45ce
// Size: 0x46
function getclasschoice( menuindex )
{
    menuindex++;
    newclasschoice = undefined;
    
    if ( menuindex > 100 )
    {
        classindex = menuindex - 100;
        newclasschoice = "default" + classindex;
    }
    else
    {
        newclasschoice = "custom" + menuindex;
    }
    
    return newclasschoice;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x461d
// Size: 0x36
function is_player_carrying_special_item()
{
    if ( isdefined( level.nuclear_core_carrier ) && level.nuclear_core_carrier == self )
    {
        return 1;
    }
    
    if ( scripts\cp\weapon::player_has_minigun( self ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace cp_loadout / scripts\cp\cp_loadout
// Params 0
// Checksum 0x0, Offset: 0x465b
// Size: 0x14
function drop_special_item()
{
    if ( scripts\cp\weapon::player_has_minigun( self ) )
    {
        scripts\cp\weapon::drop_minigun( self );
    }
}

