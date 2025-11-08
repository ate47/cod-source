#using script_15eddb0fac236a22;
#using script_2d9d24f7c63ac143;
#using script_436add9de781cdfb;
#using script_b7a9ce0a2282b79;
#using scripts\common\utility;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\support_box;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_extract_quest;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_respawn;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\utility\equipment;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;

#namespace br_weapons;

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 3
// Checksum 0x0, Offset: 0xe8b
// Size: 0xbd
function createspawnweaponatpos( pos, ori, fullweaponobj )
{
    trace = trace::ray_trace( pos, ( pos[ 0 ], pos[ 1 ], pos[ 2 ] - 60 ) );
    snappos = pos;
    
    if ( trace[ "fraction" ] < 1 )
    {
        snappos = trace[ "position" ] + ( 0, 0, 2 );
    }
    
    if ( !isdefined( ori ) )
    {
        ori = ( 0, 0, 90 );
    }
    
    pos = snappos;
    
    if ( isdefined( ori ) )
    {
        ori = ori;
    }
    else
    {
        ori = ( 0, 0, 90 );
    }
    
    dropinfo = br_pickups::getitemdropinfo( pos, ori );
    return weaponspawn( fullweaponobj, undefined, dropinfo, 1 );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0xf51
// Size: 0xa0
function createspawnweaponatposfromname( pos, completeweaponname )
{
    snappos = pos;
    trace = trace::ray_trace( pos, ( pos[ 0 ], pos[ 1 ], pos[ 2 ] - 60 ) );
    
    if ( trace[ "fraction" ] < 1 )
    {
        snappos = trace[ "position" ] + ( 0, 0, 2 );
    }
    
    dropinfo = br_pickups::getitemdropinfo( pos, ( 0, 0, 90 ) );
    weaponobj = makeweaponfromstring( completeweaponname );
    return weaponspawn( weaponobj, undefined, dropinfo, 1 );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0xffa
// Size: 0x1db
function stripweaponsfromplayer()
{
    primaryweapon = undefined;
    secondaryweapon = undefined;
    
    foreach ( weapon in self.equippedweapons )
    {
        classname = weapon.classname;
        basename = weapon::getweaponrootname( weapon.basename );
        
        if ( basename != "iw9_me_fists" && basename != "iw9_knifestab" && basename != "iw8_gunless" && basename != "iw9_pi_golf17" && classname != "fist" )
        {
            if ( isweapon( weapon ) && weapon.inventorytype == "primary" )
            {
                primarybasename = weapon::getweaponrootname( self.currentprimaryweapon );
                var_4bc5e453cc450f3e = primarybasename;
                
                if ( isdefined( self.laststandoldweaponobj ) && !iskillstreakweapon( self.laststandoldweaponobj ) )
                {
                    var_4bc5e453cc450f3e = getweaponrootname( self.laststandoldweaponobj );
                }
                
                if ( basename == primarybasename || basename == var_4bc5e453cc450f3e )
                {
                    primaryweapon = weapon;
                    continue;
                }
                
                secondaryweapon = weapon;
            }
        }
    }
    
    if ( isdefined( primaryweapon ) )
    {
        primaryweaponname = weapon::getweaponrootname( primaryweapon.basename );
    }
    
    if ( isdefined( secondaryweapon ) )
    {
        secondaryweaponname = weapon::getweaponrootname( secondaryweapon.basename );
    }
    
    if ( isdefined( primaryweapon ) || isdefined( secondaryweapon ) )
    {
        if ( isdefined( primaryweapon ) )
        {
            inventory_utility::_takeweapon( primaryweapon );
        }
        
        if ( isdefined( secondaryweapon ) )
        {
            inventory_utility::_takeweapon( secondaryweapon );
        }
        
        inventory_utility::_giveweapon( "iw9_me_fists_mp" );
        inventory_utility::_switchtoweaponimmediate( "iw9_me_fists_mp" );
    }
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x11dd
// Size: 0x234
function playerdropweaponfrominventory( itemtype )
{
    primaryweapon = undefined;
    secondaryweapon = undefined;
    
    foreach ( weapon in self.equippedweapons )
    {
        basename = weapon::getweaponrootname( weapon.basename );
        
        if ( basename != "iw9_me_fists" && basename != "iw9_knifestab" )
        {
            if ( isweapon( weapon ) && weapon.inventorytype == "primary" )
            {
                primarybasename = weapon::getweaponrootname( self.currentprimaryweapon );
                
                if ( basename == primarybasename )
                {
                    iprintln( "PRIMARY IS " + basename );
                    primaryweapon = weapon;
                    continue;
                }
                
                secondaryweapon = weapon;
            }
        }
    }
    
    var_ec22a950f210e39 = undefined;
    otherweapon = undefined;
    primaryweaponname = "";
    secondaryweaponname = "";
    
    if ( isdefined( primaryweapon ) )
    {
        primaryweaponname = weapon::getweaponrootname( primaryweapon.basename );
    }
    
    if ( isdefined( secondaryweapon ) )
    {
        secondaryweaponname = weapon::getweaponrootname( secondaryweapon.basename );
    }
    
    if ( itemtype == primaryweaponname )
    {
        var_ec22a950f210e39 = primaryweapon;
        otherweapon = secondaryweapon;
    }
    else if ( itemtype == secondaryweaponname )
    {
        var_ec22a950f210e39 = secondaryweapon;
        otherweapon = primaryweapon;
    }
    
    var_6584a71f9705dc0a = 0;
    
    if ( isdefined( var_ec22a950f210e39 ) )
    {
        ammoclip = self getweaponammoclip( var_ec22a950f210e39 );
        dropstruct = br_pickups::function_7b9f3966a7a42003();
        dropinfo = br_pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self );
        item = weaponspawn( var_ec22a950f210e39, self, dropinfo, 0 );
        item.count = ammoclip;
        inventory_utility::_takeweapon( var_ec22a950f210e39 );
        
        if ( isdefined( otherweapon ) )
        {
            inventory_utility::_switchtoweaponimmediate( otherweapon );
        }
        else
        {
            inventory_utility::_giveweapon( "iw9_me_fists_mp" );
            inventory_utility::_switchtoweaponimmediate( "iw9_me_fists_mp" );
        }
        
        br_ammo_update_weapons( self );
    }
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 5
// Checksum 0x0, Offset: 0x1419
// Size: 0x6c
function weaponspawn( weaponobj, droppingplayer, dropinfo, firstspawn, showtrail )
{
    completeweaponname = getcompleteweaponname( weaponobj );
    weaponpickup = br_pickups::spawnpickup( completeweaponname, dropinfo, 0, showtrail, weaponobj, undefined, undefined, undefined );
    level.onweapondropcreated callback_group::callback_trigger( weaponpickup, droppingplayer, weaponobj );
    return weaponpickup;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x148e
// Size: 0xfe
function function_55c5d35c8c76a95b( pickupent )
{
    if ( !isdefined( pickupent.weapon ) )
    {
        attachments = [];
        newweapon = undefined;
        
        if ( isdefined( pickupent.customweaponname ) )
        {
            completeweaponname = pickupent.customweaponname;
            newweapon = makeweaponfromstring( completeweaponname );
        }
        else if ( !isdefined( pickupent.completeweapon ) )
        {
            newweapon = br_pickups::getfullweaponobjforpickup( pickupent );
            completeweaponname = getcompleteweaponname( newweapon );
        }
        else
        {
            newweapon = weapon::buildweapon( pickupent.loadoutprimaryfullname, attachments, "none", "none", -1 );
            completeweaponname = pickupent.loadoutprimaryfullname;
        }
        
        newweaponbasename = weapon::getweaponrootname( completeweaponname );
        weaponname = completeweaponname;
    }
    else
    {
        newweapon = pickupent.weapon;
        weaponname = getcompleteweaponname( newweapon );
        newweaponbasename = weapon::getweaponrootname( weaponname );
    }
    
    return [ newweapon, newweaponbasename, weaponname ];
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x1595
// Size: 0x48
function function_5a80dba504420037( index )
{
    if ( !isdefined( level.br_ammo_types ) )
    {
        return;
    }
    
    if ( isdefined( level.br_ammo_types[ index ] ) )
    {
        return level.br_ammo_types[ index ];
    }
    
    assert( 0, "<dev string:x1c>" + index );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x15e5
// Size: 0x48
function function_2bf8eaf550fbe399( ammotype )
{
    if ( !isdefined( level.br_ammo_clipsize ) )
    {
        return;
    }
    
    if ( isdefined( level.br_ammo_clipsize[ ammotype ] ) )
    {
        return level.br_ammo_clipsize[ ammotype ];
    }
    
    assert( 0, "<dev string:x4b>" + ammotype );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x1635
// Size: 0x5d
function function_1352197e2482f1cf( player, ammotype )
{
    if ( !isdefined( player ) || !isdefined( player.br_ammo ) )
    {
        return;
    }
    
    if ( isdefined( player.br_ammo[ ammotype ] ) )
    {
        return player.br_ammo[ ammotype ];
    }
    
    assert( 0, "<dev string:x7e>" + ammotype );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x169a
// Size: 0x53
function function_88d62a65ff69eac( player, ammotype )
{
    newweaponstock = player.br_ammo[ ammotype ];
    
    if ( br_public::function_6b531c76815d77f3( ammotype ) )
    {
        lootid = loot::function_fae5e1d3de32d3f7( ammotype );
        newweaponstock += namespace_e50e624d9af51c8c::gettotalitemcountinbag( lootid );
    }
    
    return newweaponstock;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x16f6
// Size: 0x60
function private function_64f6ebff728689ab( player, weapon )
{
    if ( weapon_utility::isriotshield( weapon ) )
    {
        return;
    }
    
    clipammo = player getweaponammoclip( weapon );
    weaponammotype = br_ammo_type_for_weapon( weapon );
    
    if ( isdefined( weaponammotype ) )
    {
        self.br_ammo[ weaponammotype ] += clipammo;
    }
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x175e
// Size: 0x7e
function function_2ab3bda08c595a32( player, weapon )
{
    if ( isdefined( player.primaryweapons[ 0 ] ) && issameweapon( weapon, player.primaryweapons[ 0 ] ) )
    {
        return 0;
    }
    
    if ( isdefined( player.primaryweapons[ 1 ] ) && issameweapon( weapon, player.primaryweapons[ 1 ] ) )
    {
        return 1;
    }
    
    if ( issameweapon( weapon, namespace_e50e624d9af51c8c::function_2985254128b1c262( player ) ) )
    {
        return 2;
    }
    
    return undefined;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x17e5
// Size: 0x62
function function_a41d365900f73302( player, weapon )
{
    heavyweapons = player.heavyweapons;
    
    for ( heavyweaponindex = 0; heavyweaponindex < heavyweapons.size ; heavyweaponindex++ )
    {
        heavyweapon = heavyweapons[ heavyweaponindex ];
        
        if ( isdefined( heavyweapon ) && issameweapon( heavyweapon, weapon ) )
        {
            return heavyweaponindex;
        }
    }
    
    return undefined;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x1850
// Size: 0x6e
function function_86a5c7670325346b( player, index )
{
    if ( !isdefined( player.trackedweapons ) )
    {
        player.trackedweapons = [];
    }
    
    if ( !isdefined( index ) )
    {
        return player.team;
    }
    
    if ( !isdefined( player.trackedweapons[ index ] ) )
    {
        return player.team;
    }
    
    return player.trackedweapons[ index ];
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x18c6
// Size: 0x3a
function function_9db6a7e1567bb1f9( player, weaponindex )
{
    team = player.team;
    
    if ( isdefined( weaponindex ) )
    {
        team = function_86a5c7670325346b( player, weaponindex );
    }
    
    return team;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x1909
// Size: 0x2f
function function_1a561e5ef2eca63a( player, weapon )
{
    index = function_2ab3bda08c595a32( player, weapon );
    return function_9db6a7e1567bb1f9( player, index );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 3
// Checksum 0x0, Offset: 0x1941
// Size: 0x46
function function_ae30366a2d519a57( player, index, team )
{
    if ( !isdefined( player.trackedweapons ) )
    {
        player.trackedweapons = [];
    }
    
    player.trackedweapons[ index ] = team;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 6
// Checksum 0x0, Offset: 0x198f
// Size: 0x108b
function takeweaponpickup( pickupent, var_db943473454f6ea6, weaponstowed, backpackequip, fromkiosk, var_b4b637b07f3f9f25 )
{
    var_7b9de6db6a90dbe7 = 0;
    numprimaries = self.primaryweapons.size;
    newweaponinfo = function_55c5d35c8c76a95b( pickupent );
    newweapon = newweaponinfo[ 0 ];
    weaponname = newweaponinfo[ 2 ];
    assert( isdefined( newweapon ) );
    assert( isdefined( weaponname ) );
    var_7dc30386b50647a1 = 0;
    var_ec22a950f210e39 = undefined;
    tobackpack = 0;
    activeweapon = function_27ef2c36eb95d796();
    var_7e67cc008aa22631 = scripts\mp\gametypes\br::function_f32857a938336f2b( self, activeweapon );
    reloading = self isreloading();
    
    foreach ( weap in self.primaryweapons )
    {
        if ( isnullweapon( weap ) || istrue( scripts\cp_mp\weapon::issuperuseweapon( weap ) ) )
        {
            numprimaries--;
            continue;
        }
        
        if ( issameweapon( weap, newweapon ) )
        {
            var_7dc30386b50647a1 = 1;
            var_ec22a950f210e39 = weap;
            continue;
        }
        
        if ( scripts\cp_mp\weapon::isbackuppistol( weap ) )
        {
            numprimaries--;
        }
    }
    
    if ( numprimaries > 1 && !var_7dc30386b50647a1 )
    {
        if ( !self hasweapon( "iw9_me_fists_mp" ) )
        {
            var_7dc30386b50647a1 = 1;
        }
        else if ( !isdefined( weaponstowed ) && ( !isdefined( pickupent ) || isdefined( pickupent ) && !istrue( pickupent.var_4a08890fd43d6bc7 ) ) )
        {
            if ( istrue( pickupent.isautouse ) )
            {
                foreach ( weap in self.primaryweapons )
                {
                    if ( weap.basename == "iw9_me_fists_mp" )
                    {
                        var_7b9de6db6a90dbe7 = function_8dabe5259e6844e9( weap, newweapon );
                    }
                }
            }
            
            if ( var_7e67cc008aa22631 || reloading )
            {
                var_7b9de6db6a90dbe7 = 1;
            }
            
            self takeweapon( "iw9_me_fists_mp" );
        }
    }
    
    if ( var_7dc30386b50647a1 || isdefined( weaponstowed ) || istrue( pickupent.var_4a08890fd43d6bc7 ) )
    {
        if ( istrue( pickupent.isautouse ) && !isdefined( var_ec22a950f210e39 ) )
        {
            var_ec22a950f210e39 = function_823964aa15b30575();
            var_7b9de6db6a90dbe7 = function_8dabe5259e6844e9( var_ec22a950f210e39, newweapon );
        }
        
        if ( !isdefined( var_ec22a950f210e39 ) )
        {
            var_ec22a950f210e39 = function_27ef2c36eb95d796();
        }
        
        if ( !isdefined( var_ec22a950f210e39 ) && isdefined( weaponstowed ) )
        {
            var_ec22a950f210e39 = weaponstowed;
        }
        
        assert( var_ec22a950f210e39.basename != "<dev string:xac>" );
        
        if ( var_ec22a950f210e39.basename != "none" )
        {
            var_28aebe3dd6733ed3 = undefined;
            var_1af8fe94ee02a80f = undefined;
            var_961012dd15fa29ee = undefined;
            dirtoitem = pickupent.origin - self.origin;
            yaw = vectortoyaw( dirtoitem );
            var_c02997b2deff6e69 = !br_extract_quest::extract_ismissionweapon( var_ec22a950f210e39 );
            
            if ( istrue( level.var_f478c1f94caa7e9 ) && !namespace_e50e624d9af51c8c::function_efab78b72d131d76( self ) && ( isdefined( weaponstowed ) || istrue( backpackequip ) ) )
            {
                if ( isdefined( weaponstowed ) )
                {
                    var_ec22a950f210e39 = weaponstowed;
                }
                
                if ( isdefined( var_ec22a950f210e39 ) && var_ec22a950f210e39.basename != "iw9_me_fists_mp" && var_ec22a950f210e39.basename != "none" )
                {
                    pastteam = function_1a561e5ef2eca63a( self, var_ec22a950f210e39 );
                    namespace_e50e624d9af51c8c::function_8107fe0feec27866( self, var_ec22a950f210e39 );
                    tobackpack = 1;
                    var_c02997b2deff6e69 = 0;
                    function_ae30366a2d519a57( self, 2, pastteam );
                }
            }
            else if ( istrue( pickupent.var_4a08890fd43d6bc7 ) )
            {
                var_ec22a950f210e39 = newweapon;
                ammoclip = utility::ter_op( isdefined( pickupent.count ), pickupent.count, 0 );
                ammocliplefthand = utility::ter_op( isdefined( pickupent.countlefthand ), pickupent.countlefthand, 0 );
                self.weaponslotclip = ammoclip;
                self.var_ad7897ecdbcb63 = ammocliplefthand;
                
                if ( var_ec22a950f210e39.hasalternate )
                {
                    var_9bfd50804dd2553c = utility::ter_op( isdefined( pickupent.countalt ), pickupent.countalt, 0 );
                    self.var_86b32aff94b5714e = var_9bfd50804dd2553c;
                }
                
                namespace_e50e624d9af51c8c::function_e35a7cb7e7c8c17e( self, var_ec22a950f210e39, istrue( pickupent.var_f51bbb191526dfa4 ), pickupent.metadata, 1 );
                function_ae30366a2d519a57( self, 2, pickupent.pastteam );
                var_ac9a77a44c7739e9 = undefined;
                
                if ( isdefined( activeweapon ) )
                {
                    var_ac9a77a44c7739e9 = br_ammo_type_for_weapon( activeweapon );
                }
                
                ammotype = br_ammo_type_for_weapon( var_ec22a950f210e39 );
                var_4be638dab99c2ed5 = isdefined( ammotype ) && isdefined( var_ac9a77a44c7739e9 ) && var_ac9a77a44c7739e9 == ammotype;
                var_32c6e6f4fcb57314 = var_4be638dab99c2ed5 && var_7e67cc008aa22631;
                
                if ( isdefined( ammotype ) && !var_32c6e6f4fcb57314 )
                {
                    br_ammo_update_ammotype_weapons( self, ammotype, self.br_ammo[ ammotype ] );
                }
                
                return;
            }
            else if ( isdefined( var_db943473454f6ea6 ) && namespace_e50e624d9af51c8c::function_3ab0a87eeaa203bf() )
            {
                function_64f6ebff728689ab( self, var_ec22a950f210e39 );
                rootname = weapon::getweaponrootname( var_ec22a950f210e39 );
                variantid = var_ec22a950f210e39.variantid;
                
                if ( !isdefined( var_ec22a950f210e39.variantid ) )
                {
                    variantid = 0;
                }
                
                lootid = weapon::function_79d6e6c22245687a( rootname, variantid );
                namespace_e50e624d9af51c8c::function_11f48ae5b87b4525( self, var_db943473454f6ea6, lootid, 1 );
                var_c02997b2deff6e69 = 0;
            }
            else
            {
                var_28aebe3dd6733ed3 = self getweaponammoclip( var_ec22a950f210e39 );
                var_1af8fe94ee02a80f = self getweaponammoclip( var_ec22a950f210e39, "left" );
                var_961012dd15fa29ee = 0;
                
                if ( var_ec22a950f210e39.hasalternate )
                {
                    var_5d9b5b689a1846c8 = var_ec22a950f210e39 getaltweapon();
                    
                    if ( br_ammo_type_for_weapon( var_5d9b5b689a1846c8 ) != br_ammo_type_for_weapon( var_ec22a950f210e39 ) )
                    {
                        var_961012dd15fa29ee = self getweaponammoclip( var_5d9b5b689a1846c8 );
                    }
                }
                
                if ( isexcludedweapon( var_ec22a950f210e39 ) )
                {
                    var_1af8fe94ee02a80f = self getweaponammostock( var_ec22a950f210e39 );
                }
                
                if ( !weapon_utility::isriotshield( var_ec22a950f210e39 ) )
                {
                    ammostock = self getweaponammostock( var_ec22a950f210e39 );
                    weaponammotype = br_ammo_type_for_weapon( var_ec22a950f210e39 );
                    
                    if ( isdefined( weaponammotype ) )
                    {
                        self.br_ammo[ weaponammotype ] = ammostock;
                    }
                }
                
                if ( var_c02997b2deff6e69 )
                {
                    droporigin = pickupent.origin;
                    
                    if ( getdvarint( @"hash_d46305f139655da", 0 ) )
                    {
                        droporigin = self.origin - anglestoforward( self.angles ) * getdvarint( @"hash_6a09f2a33e5367ce", 50 );
                    }
                    
                    dropstruct = br_pickups::function_7b9f3966a7a42003();
                    showtrail = 1;
                    baseorigin = self.origin;
                    baseangles = self.angles;
                    overrideorigin = pickupent.origin;
                    
                    if ( istrue( fromkiosk ) && isdefined( self.br_kiosk ) && isdefined( self.br_kiosk.dropstruct ) )
                    {
                        slotindex = self.br_kiosk br_pickups::function_4f4d537c794b2bf5();
                        self.br_kiosk.dropstruct.dropidx = slotindex;
                        dropstruct = self.br_kiosk.dropstruct;
                        baseorigin = utility::default_to( self.br_kiosk.centerbottom, self.br_kiosk.origin );
                        baseangles = self.br_kiosk.angles;
                        overrideorigin = undefined;
                    }
                    
                    if ( istrue( level.var_34906263684780b7 ) && getdvarint( @"hash_752eeed3ddcbd04b", 0 ) == 0 )
                    {
                        dropinfo = br_pickups::getitemdroporiginandangles( dropstruct, baseorigin, baseangles, self, undefined, undefined, undefined, undefined, overrideorigin );
                        ammotypedrop = br_ammo_type_for_weapon( var_ec22a950f210e39 );
                        ammotypepickup = "";
                        
                        if ( isdefined( newweapon ) )
                        {
                            ammotypepickup = br_ammo_type_for_weapon( newweapon );
                        }
                        
                        ammotypepickup = utility::ter_op( isdefined( ammotypepickup ), ammotypepickup, "" );
                        
                        if ( function_ad972c1d0f29841c( self, var_ec22a950f210e39 ) && self.br_ammo[ ammotypedrop ] > 0 && ammotypedrop != ammotypepickup )
                        {
                            var_660523cff419f0b = getdvarint( @"hash_3c4edd0a748e4053", 1 );
                            dirvec = dropinfo.origin - baseorigin;
                            upvec = anglestoup( dropinfo.angles );
                            var_5a060c381dce3622 = vectorcross( vectornormalize( dirvec ), upvec );
                            var_5a060c381dce3622 = rotatepointaroundvector( upvec, var_5a060c381dce3622, getdvarint( @"hash_51cb230bbd599b71", 20 ) );
                            var_9edc776840baff95 = dropinfo.origin + var_5a060c381dce3622 * getdvarint( @"hash_16e74796df75b8d0", 20 );
                            var_cc9974fdf39f6cca = br_pickups::getitemdroporiginandangles( dropstruct, baseorigin, baseangles, self, undefined, undefined, undefined, undefined, var_9edc776840baff95 );
                            ammopickup = br_pickups::spawnpickup( ammotypedrop, var_cc9974fdf39f6cca, self.br_ammo[ ammotypedrop ], 1, undefined, var_660523cff419f0b );
                            br_ammo_take_type( self, ammotypedrop, self.br_ammo[ ammotypedrop ] );
                        }
                    }
                    else if ( getdvarint( @"hash_625378754c018440", 1 ) && isdefined( self.br_kiosk ) )
                    {
                        dropinfo = scripts\mp\gametypes\br_armory_kiosk::function_345964aeab85e020( self.br_kiosk, dropstruct );
                        showtrail = 0;
                    }
                    else
                    {
                        baseangles = ( 0, yaw, 0 );
                        dropinfo = br_pickups::getitemdroporiginandangles( dropstruct, droporigin, baseangles, self, 0, 10 );
                        showtrail = 0;
                    }
                    
                    item = weaponspawn( var_ec22a950f210e39, self, dropinfo, 0, showtrail );
                    
                    if ( isdefined( item ) )
                    {
                        assert( isdefined( var_28aebe3dd6733ed3 ) );
                        assert( isdefined( var_1af8fe94ee02a80f ) );
                        assert( isdefined( var_961012dd15fa29ee ) );
                        item setscriptablepartstate( item.type, "dropped" );
                        br_pickups::loot_setitemcount( item, var_28aebe3dd6733ed3, var_1af8fe94ee02a80f, var_961012dd15fa29ee );
                        
                        if ( function_b1dd9dcae2f63965() )
                        {
                            function_8e7e1da48d7746e5( self, item );
                        }
                        
                        var_e637ee4faed5d14d = 1;
                        br_analytics::branalytics_lootdrop( self, var_ec22a950f210e39.basename, var_e637ee4faed5d14d, var_28aebe3dd6733ed3 );
                        weaponindex = function_2ab3bda08c595a32( self, var_ec22a950f210e39 );
                        
                        if ( isdefined( weaponindex ) )
                        {
                            item.pastteam = function_86a5c7670325346b( self, weaponindex );
                        }
                        
                        if ( namespace_b16531563568eaba::function_e0fc1230452cf4e7() )
                        {
                            for ( i = 0; i < 3 ; i++ )
                            {
                                weapontocheck = br_pickups::function_13ecf3644442a3e7( self, i );
                                
                                if ( isdefined( weapontocheck ) && weapontocheck == var_ec22a950f210e39 )
                                {
                                    weaponmetadata = namespace_b16531563568eaba::function_74031e3249a6f69e( self, i );
                                    
                                    if ( isdefined( weaponmetadata ) )
                                    {
                                        item.metadata = weaponmetadata;
                                        break;
                                    }
                                }
                            }
                        }
                        
                        self notify( "dropped_weapon_scriptable", item, undefined, dropinfo.origin );
                    }
                }
            }
            
            inventory_utility::_takeweapon( var_ec22a950f210e39 );
        }
    }
    else if ( isdefined( var_db943473454f6ea6 ) )
    {
        [ lootid, quantity ] = namespace_e50e624d9af51c8c::function_6738846da50730f1( var_db943473454f6ea6 );
        namespace_e50e624d9af51c8c::function_e900e7e66383ad97( self, var_db943473454f6ea6, 0 );
    }
    
    self giveweapon( newweapon );
    scripts\cp_mp\challenges::onpickupweapon( newweapon );
    heavyweaponindex = function_a41d365900f73302( self, newweapon );
    
    if ( isdefined( heavyweaponindex ) )
    {
        self assignweaponprimaryslot( weaponname );
    }
    
    self notify( "pickedupweapon", weaponname );
    weaponindex = function_2ab3bda08c595a32( self, newweapon );
    
    if ( !isdefined( weaponindex ) )
    {
        logstring( "Log this in IW9-536838: weaponIndex is undefined. weaponName = " + weaponname );
    }
    
    weaponteam = pickupent.pastteam;
    
    if ( !isdefined( weaponteam ) )
    {
        weaponteam = self.team;
    }
    
    if ( isdefined( weaponindex ) )
    {
        function_ae30366a2d519a57( self, weaponindex, weaponteam );
    }
    
    if ( getdvarint( @"hash_218b826f84233424", 0 ) )
    {
        br_pickups::function_5ef33bffaeda4fa9( newweapon, !istrue( pickupent.isautouse ) );
    }
    
    var_c1192c297bbf292f = pickupent.count;
    var_7b7b94efe2e96d4b = pickupent.countlefthand;
    var_7b7b94efe2e96d4b = default_to( var_7b7b94efe2e96d4b, 0 );
    
    if ( isexcludedweapon( newweapon ) )
    {
        self setweaponammoclip( newweapon, var_c1192c297bbf292f );
        self setweaponammostock( newweapon, var_7b7b94efe2e96d4b );
    }
    else
    {
        clipsize = weaponclipsize( newweapon );
        var_31b36738ff4eacd = 0;
        
        if ( var_c1192c297bbf292f > clipsize )
        {
            var_31b36738ff4eacd += var_c1192c297bbf292f - clipsize;
            var_c1192c297bbf292f = clipsize;
        }
        
        if ( var_7b7b94efe2e96d4b > clipsize )
        {
            var_31b36738ff4eacd += var_7b7b94efe2e96d4b - clipsize;
            var_7b7b94efe2e96d4b = clipsize;
        }
        
        self setweaponammoclip( weaponname, var_c1192c297bbf292f );
        self setweaponammoclip( weaponname, var_7b7b94efe2e96d4b, "left" );
        
        if ( var_31b36738ff4eacd > 0 )
        {
            ammotype = br_ammo_type_for_weapon( newweapon );
            
            if ( isdefined( ammotype ) )
            {
                br_ammo_give_type( self, ammotype, var_31b36738ff4eacd );
            }
        }
        
        if ( newweapon.hasalternate )
        {
            var_dfd1fd5d26dd4e12 = pickupent.countalt;
            var_84c947974132a108 = newweapon getaltweapon();
            var_26f2db792005350e = default_to( br_ammo_type_for_weapon( var_84c947974132a108 ), "" );
            weaponammotype = default_to( br_ammo_type_for_weapon( newweapon ), "" );
            
            if ( var_26f2db792005350e != weaponammotype )
            {
                altclipsize = weaponclipsize( var_84c947974132a108 );
                
                if ( !isdefined( var_dfd1fd5d26dd4e12 ) || var_dfd1fd5d26dd4e12 > altclipsize )
                {
                    var_dfd1fd5d26dd4e12 = altclipsize;
                }
                
                self setweaponammoclip( var_84c947974132a108, var_dfd1fd5d26dd4e12 );
                br_ammo_player_hud_update_ammotype( var_26f2db792005350e );
                br_ammo_update_weapons( self );
            }
        }
    }
    
    ammotype = undefined;
    
    if ( isdefined( newweapon ) )
    {
        ammotype = br_ammo_type_for_weapon( newweapon );
    }
    
    var_32c6e6f4fcb57314 = 0;
    
    if ( isdefined( activeweapon ) )
    {
        var_ac9a77a44c7739e9 = br_ammo_type_for_weapon( activeweapon );
        var_4be638dab99c2ed5 = isdefined( ammotype ) && isdefined( var_ac9a77a44c7739e9 ) && var_ac9a77a44c7739e9 == ammotype;
        var_32c6e6f4fcb57314 = var_4be638dab99c2ed5 && var_7e67cc008aa22631;
    }
    
    if ( isdefined( ammotype ) && !var_32c6e6f4fcb57314 )
    {
        br_ammo_update_ammotype_weapons( self, ammotype, self.br_ammo[ ammotype ] );
    }
    
    if ( !istrue( var_7b9de6db6a90dbe7 ) && !istrue( var_b4b637b07f3f9f25 ) )
    {
        self assignweaponprimaryslot( weaponname );
        inventory_utility::_switchtoweaponimmediate( weaponname );
        weapon::fixupplayerweapons( self, weaponname );
        namespace_6b49ddb858f34366::function_adcb155953291ec7( undefined, 0 );
        weapons::updatelastweaponobj( newweapon );
    }
    
    if ( isdefined( pickupent.weapon ) && isent( pickupent.weapon ) )
    {
        pickupent.weapon delete();
    }
    
    newweaponobj = undefined;
    
    foreach ( weapon in self.equippedweapons )
    {
        if ( isweapon( weapon ) && weapon.inventorytype == "primary" )
        {
            completeweaponname = getcompleteweaponname( weapon );
            
            if ( completeweaponname == weaponname )
            {
                newweaponobj = weapon;
                break;
            }
        }
    }
    
    if ( !isdefined( newweaponobj ) )
    {
        debugweaponname = default_to( weaponname, "undefined weapon name" );
        message = "newWeaponObj is undefined in takeWeaponPickup is br_weapons.gsc with a weaponname of: " + debugweaponname;
        scripts\mp\utility\script::demoforcesre( message );
        return;
    }
    
    thread br_respawn::giveweaponpickup( weaponname );
    
    if ( isdefined( pickupent.instance ) )
    {
        level.onweapondroppickedup callback_group::callback_trigger( pickupent.instance, self, newweapon );
    }
    
    if ( namespace_b16531563568eaba::function_e0fc1230452cf4e7() )
    {
        metadata = undefined;
        
        if ( isdefined( pickupent.instance ) && isdefined( pickupent.instance.metadata ) )
        {
            metadata = pickupent.instance.metadata;
        }
        else if ( isdefined( pickupent.metadata ) )
        {
            metadata = pickupent.metadata;
        }
        
        namespace_b16531563568eaba::equipweapon( self, newweaponobj, var_ec22a950f210e39, tobackpack, backpackequip, metadata );
    }
    
    customweaponname = getcompleteweaponname( newweaponobj );
    self.tookweaponfrom[ customweaponname ] = undefined;
    
    if ( isdefined( pickupent.instance ) && isdefined( pickupent.instance.owner ) )
    {
        self.tookweaponfrom[ customweaponname ] = pickupent.instance.owner;
    }
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x2a22
// Size: 0x99
function function_27ef2c36eb95d796()
{
    var_b8f96bd12748f572 = self function_b2ed366433a3d074();
    var_49100fd322777e39 = 0;
    
    if ( isdefined( var_b8f96bd12748f572 ) && scripts\mp\weapons::isdroppableweapon( var_b8f96bd12748f572 ) )
    {
        foreach ( weap in self.primaryweapons )
        {
            if ( issameweapon( weap, var_b8f96bd12748f572 ) )
            {
                var_49100fd322777e39 = 1;
                break;
            }
        }
    }
    
    if ( var_49100fd322777e39 )
    {
        return var_b8f96bd12748f572;
    }
    
    return self.lastdroppableweaponobj;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x2ac4
// Size: 0x31
function function_9c602bfca5626687( pickupent )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    while ( self isreloading() )
    {
        waitframe();
    }
    
    waitframe();
    takeammopickup( pickupent, 1 );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x2afd
// Size: 0x11b
function takeammopickup( pickupent, fromdelay )
{
    if ( !istrue( fromdelay ) && self isreloading() )
    {
        thread function_9c602bfca5626687( pickupent );
        return 0;
    }
    
    var_c240d5bbb6b43a32 = 0;
    
    if ( pickupent.scriptablename == "Ammo_Crate" )
    {
        weaponbasename = self getcurrentweapon().basename;
        weaponrootname = weapon::getweaponrootname( weaponbasename );
        clipsize = weaponclipsize( weaponbasename );
        ammotype = br_ammo_type_for_weapon( weaponbasename );
        
        if ( isdefined( ammotype ) )
        {
            var_c240d5bbb6b43a32 = br_ammo_give_type( self, ammotype, clipsize );
        }
    }
    else
    {
        var_ef37464796f8ed = level.var_3ea6ceb7358d49df && !istrue( pickupent.isautouse );
        var_c240d5bbb6b43a32 = br_ammo_give_type( self, pickupent.scriptablename, pickupent.count, 1, var_ef37464796f8ed );
    }
    
    if ( var_c240d5bbb6b43a32 )
    {
        pickupent.count = var_c240d5bbb6b43a32;
        pickupremains = var_c240d5bbb6b43a32;
    }
    else
    {
        pickupremains = 0;
    }
    
    return pickupremains;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 3
// Checksum 0x0, Offset: 0x2c21
// Size: 0xae
function br_forcegiveweapon( weaponname, player, completeweapon )
{
    if ( !utility::array_contains( level.br_pickups.br_lootguns, weaponname ) )
    {
        weaponname = br_getrandomlootweapon();
    }
    
    var_ce75c5b27952f765 = spawnstruct();
    var_ce75c5b27952f765.loadoutprimaryfullname = weaponname;
    var_ce75c5b27952f765.scriptablename = weapon::getweaponrootname( weaponname );
    var_ce75c5b27952f765.completeweapon = completeweapon;
    var_ce75c5b27952f765.count = 0;
    var_ce75c5b27952f765.countlefthand = 0;
    var_ce75c5b27952f765.countalt = 0;
    player takeweaponpickup( var_ce75c5b27952f765 );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x2cd7
// Size: 0x101
function br_getrandomlootweapon( weapontype, rarity )
{
    assertex( isdefined( level.br_pickups ) || isdefined( level.br_pickups.br_lootguns ), "<dev string:xb4>" );
    
    if ( !isdefined( weapontype ) )
    {
        weapontype = "ar";
    }
    
    if ( !isdefined( rarity ) )
    {
        rarity = "comm";
    }
    
    weaponarray = [];
    
    foreach ( weapon in level.br_pickups.br_lootguns )
    {
        if ( issubstr( weapon, "_" + weapontype + "_" ) )
        {
            if ( issubstr( weapon, "_" + rarity ) )
            {
                weaponarray[ weaponarray.size ] = weapon;
            }
        }
    }
    
    assertex( weaponarray.size, "<dev string:xe1>" );
    return weaponarray[ randomint( weaponarray.size ) ];
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x2de1
// Size: 0x23
function br_getweaponstartingclipammo( weaponobj )
{
    clipsize = weaponclipsize( weaponobj );
    return int( clipsize );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 9
// Checksum 0x0, Offset: 0x2e0d
// Size: 0x2eb, Type: bool
function br_forcegivecustomweapon( player, weaponobj, weaponfullname, weaponbasename, var_bde57922cf2180d3, var_eaac92793f70b7df, overrideorigin, metadata, pastteam )
{
    if ( player hasweapon( weaponobj ) )
    {
        player hud_message::showerrormessage( "MP/BR_ALREADY_HOLDING_WEAPON" );
        return false;
    }
    
    hasmaxammo = weaponobj hasattachment( "maxammo" );
    fakepickup = spawnstruct();
    fakepickup.weapon = weaponobj;
    fakepickup.loadoutprimaryfullname = weaponfullname;
    fakepickup.scriptablename = weaponbasename;
    fakepickup.origin = utility::ter_op( isdefined( overrideorigin ), overrideorigin, player.origin + ( 0, 0, 24 ) );
    fakepickup.count = br_getweaponstartingclipammo( weaponobj );
    fakepickup.countlefthand = 0;
    fakepickup.countalt = 0;
    fakepickup.metadata = metadata;
    fakepickup.pastteam = pastteam;
    
    if ( hasmaxammo )
    {
        fakepickup.count = 999;
    }
    
    if ( isdefined( var_bde57922cf2180d3 ) && isdefined( var_eaac92793f70b7df ) )
    {
        ammoclip = weaponclipsize( weaponobj );
        var_4429cfcff681b936 = int( ceil( ammoclip * var_bde57922cf2180d3 ) );
        fakepickup.count = int( min( var_4429cfcff681b936, var_eaac92793f70b7df ) );
    }
    
    if ( weapon::isakimbo( weaponobj ) )
    {
        fakepickup.countlefthand = fakepickup.count;
    }
    
    if ( weaponobj.hasalternate )
    {
        altweaponobj = weaponobj getaltweapon();
        
        if ( br_ammo_type_for_weapon( altweaponobj ) != br_ammo_type_for_weapon( weaponobj ) )
        {
            var_6664d64b7cb8a858 = weaponclipsize( altweaponobj );
            fakepickup.countalt = var_6664d64b7cb8a858;
            
            if ( hasmaxammo )
            {
                fakepickup.countalt = 999;
            }
        }
    }
    
    if ( getdvarint( @"hash_c8896a161aebda74", 0 ) > 0 )
    {
        player loadweaponsforplayer( [ fakepickup.loadoutprimaryfullname ] );
    }
    
    player takeweaponpickup( fakepickup );
    
    if ( isaxeweapon( weaponobj ) || weaponobj.hasalternate )
    {
        var_a3272cd1d2e586c0 = weaponobj;
        var_fe3a087a8923aea3 = 1;
        
        if ( !isaxeweapon( weaponobj ) )
        {
            var_a3272cd1d2e586c0 = weaponobj getaltweapon();
            var_fe3a087a8923aea3 = var_a3272cd1d2e586c0.isalternate && weapon::function_de04e13ab01e1a10( var_a3272cd1d2e586c0.underbarrel );
        }
        
        if ( var_fe3a087a8923aea3 )
        {
            clipammo = weaponclipsize( var_a3272cd1d2e586c0 );
            newammo = int( clipammo );
            player setweaponammoclip( var_a3272cd1d2e586c0, newammo );
        }
    }
    
    return true;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x3101
// Size: 0x308
function br_ammo_init()
{
    if ( istrue( level.var_fcd1ae93f5209b41 ) )
    {
        return;
    }
    
    level.br_ammo_types = [];
    level.br_ammo_types[ 0 ] = "brloot_ammo_919";
    level.br_ammo_types[ 1 ] = "brloot_ammo_12g";
    level.br_ammo_types[ 2 ] = "brloot_ammo_762";
    level.br_ammo_types[ 3 ] = "brloot_ammo_50cal";
    level.br_ammo_types[ 4 ] = "brloot_ammo_rocket";
    level.br_ammo_clipsize[ "brloot_ammo_919" ] = 60;
    level.br_ammo_clipsize[ "brloot_ammo_12g" ] = 16;
    level.br_ammo_clipsize[ "brloot_ammo_762" ] = 60;
    level.br_ammo_clipsize[ "brloot_ammo_50cal" ] = 16;
    level.br_ammo_clipsize[ "brloot_ammo_rocket" ] = 1;
    level.br_ammo_max = [];
    level.br_ammo_omnvars = [];
    level.br_ammo_omnvars[ "brloot_ammo_919" ] = "ui_br_smallarms_ammo";
    level.br_ammo_omnvars[ "brloot_ammo_12g" ] = "ui_br_shotgun_ammo";
    level.br_ammo_omnvars[ "brloot_ammo_762" ] = "ui_br_assault_ammo";
    level.br_ammo_omnvars[ "brloot_ammo_50cal" ] = "ui_br_sniper_ammo";
    level.br_ammo_omnvars[ "brloot_ammo_rocket" ] = "ui_br_rocket_ammo";
    level.var_e6ea72fc5e3fcd00 = [];
    level.var_e6ea72fc5e3fcd00[ "brloot_ammo_919" ] = 150;
    level.var_e6ea72fc5e3fcd00[ "brloot_ammo_12g" ] = 40;
    level.var_e6ea72fc5e3fcd00[ "brloot_ammo_762" ] = 210;
    level.var_e6ea72fc5e3fcd00[ "brloot_ammo_50cal" ] = 40;
    level.var_e6ea72fc5e3fcd00[ "brloot_ammo_rocket" ] = 6;
    level.var_1540c43d84650140 = [];
    level.var_1540c43d84650140[ "weapon_machine_pistol" ] = "brloot_ammo_919";
    level.var_1540c43d84650140[ "weapon_pistol" ] = "brloot_ammo_919";
    level.var_1540c43d84650140[ "weapon_smg" ] = "brloot_ammo_919";
    level.var_1540c43d84650140[ "weapon_shotgun" ] = "brloot_ammo_12g";
    level.var_1540c43d84650140[ "weapon_assault" ] = "brloot_ammo_762";
    level.var_1540c43d84650140[ "weapon_battle" ] = "brloot_ammo_762";
    level.var_1540c43d84650140[ "weapon_lmg" ] = "brloot_ammo_762";
    level.var_1540c43d84650140[ "weapon_dmr" ] = "brloot_ammo_50cal";
    level.var_1540c43d84650140[ "weapon_sniper" ] = "brloot_ammo_50cal";
    level.var_1540c43d84650140[ "weapon_projectile" ] = "brloot_ammo_rocket";
    level.var_e00c53ff08aa5fdb = getdvarint( @"hash_7f141e09afdd4e95", 1 );
    level.var_1aa4ff5576b74b2 = getdvarint( @"hash_a6f8ca984f2d9f90", 1 ) == 1;
    level.var_783fe165885ab6dd = [];
    level.var_783fe165885ab6dd[ 0 ] = "weapon_wonder";
    
    if ( !isdefined( level.var_58ffe6a7ac9f8fd4 ) )
    {
        level.var_58ffe6a7ac9f8fd4 = [];
    }
    
    namespace_d9d9691c846bdad7::function_3a363ae38f309166( &function_801f575ba3157258 );
    level.var_fcd1ae93f5209b41 = 1;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x3411
// Size: 0x236
function br_ammo_player_init()
{
    self endon( "disconnect" );
    thread br_ammo_player_hud_monitor();
    
    if ( getdvarint( @"hash_7a52196ce3c53c73", 0 ) )
    {
        thread function_6681a5284fd5fad1();
        thread br_pickups::function_6ff4fee4f07a3392();
    }
    
    while ( true )
    {
        self waittill( "br_spawned" );
        
        if ( !flags::gameflag( "prematch_done" ) )
        {
            var_509d86412c9d7426 = self getweaponslistprimaries();
            
            foreach ( weap in var_509d86412c9d7426 )
            {
                ammoclipsize = weaponclipsize( weap );
                
                if ( isdefined( ammoclipsize ) )
                {
                    if ( weapon::isakimbo( weap ) )
                    {
                        self setweaponammoclip( weap, ammoclipsize, "left" );
                        self setweaponammoclip( weap, ammoclipsize, "right" );
                        continue;
                    }
                    
                    self setweaponammoclip( weap, ammoclipsize );
                }
            }
        }
        
        foreach ( ammotype in level.br_ammo_types )
        {
            if ( istrue( level.var_11525426feeb297a ) || istrue( self.var_11525426feeb297a ) )
            {
                if ( isdefined( self.pers[ "br_ammo" ] ) && isdefined( self.pers[ "br_ammo" ] ) )
                {
                    self.br_ammo[ ammotype ] = self.pers[ "br_ammo" ][ ammotype ];
                }
                else
                {
                    self.br_ammo[ ammotype ] = 0;
                }
                
                continue;
            }
            
            if ( !flags::gameflag( "prematch_done" ) && !istrue( level.var_376762409014cc8e ) )
            {
                self.br_ammo[ ammotype ] = level.var_e6ea72fc5e3fcd00[ ammotype ];
                continue;
            }
            
            self.br_ammo[ ammotype ] = 0;
        }
        
        br_ammo_update_weapons( self );
        br_ammo_player_hud_update_ammotype( "brloot_ammo_919" );
        br_ammo_player_hud_update_ammotype( "brloot_ammo_12g" );
        br_ammo_player_hud_update_ammotype( "brloot_ammo_762" );
        br_ammo_player_hud_update_ammotype( "brloot_ammo_50cal" );
        br_ammo_player_hud_update_ammotype( "brloot_ammo_rocket" );
    }
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x364f
// Size: 0x5a8
function function_6681a5284fd5fad1()
{
    self endon( "disconnect" );
    logstring( "br_watch_mobile_cheat_weapon finished setup." );
    
    while ( true )
    {
        self waittill( "luinotifyserver", message, var_2150015540242e9e );
        weapid = "";
        var_14004b68ddacb781 = "";
        weapattachments = [];
        
        if ( message == "mobile_debug_give_weapon_augolf" )
        {
            weapid = "iw9_ar_augolf_mp";
            
            switch ( var_2150015540242e9e )
            {
                case 0:
                    var_14004b68ddacb781 = "brloot_weapon_ar_augolf_comm";
                    break;
                case 1:
                    var_14004b68ddacb781 = "brloot_weapon_ar_augolf_unco";
                    break;
                case 2:
                    var_14004b68ddacb781 = "brloot_weapon_ar_augolf_rare";
                    break;
                case 3:
                    var_14004b68ddacb781 = "brloot_weapon_ar_augolf_epic";
                    break;
                case 4:
                    var_14004b68ddacb781 = "brloot_weapon_ar_augolf_lege";
                    break;
            }
        }
        else if ( message == "mobile_debug_give_weapon_mike4" )
        {
            weapid = "iw9_ar_mike4_mp";
            
            switch ( var_2150015540242e9e )
            {
                case 0:
                    var_14004b68ddacb781 = "brloot_weapon_ar_mike4_comm";
                    break;
                case 1:
                    var_14004b68ddacb781 = "brloot_weapon_ar_mike4_unco";
                    break;
                case 2:
                    var_14004b68ddacb781 = "brloot_weapon_ar_mike4_rare";
                    break;
                case 3:
                    var_14004b68ddacb781 = "brloot_weapon_ar_mike4_epic";
                    break;
                case 4:
                    var_14004b68ddacb781 = "brloot_weapon_ar_mike4_lege";
                    break;
            }
        }
        else if ( message == "mobile_debug_give_weapon_mpapa5" )
        {
            weapid = "iw9_sm_mpapa5_mp";
            
            switch ( var_2150015540242e9e )
            {
                case 0:
                    var_14004b68ddacb781 = "brloot_weapon_sm_mpapa5_comm";
                    break;
                case 1:
                    var_14004b68ddacb781 = "brloot_weapon_sm_mpapa5_unco";
                    break;
                case 2:
                    var_14004b68ddacb781 = "brloot_weapon_sm_mpapa5_rare";
                    break;
                case 3:
                    var_14004b68ddacb781 = "brloot_weapon_sm_mpapa5_epic";
                    break;
                case 4:
                    var_14004b68ddacb781 = "brloot_weapon_sm_mpapa5_lege";
                    break;
            }
        }
        else if ( message == "mobile_debug_give_weapon_mbravo" )
        {
            weapid = "iw9_sh_mbravo_mp";
            
            switch ( var_2150015540242e9e )
            {
                case 0:
                    var_14004b68ddacb781 = "brloot_weapon_sh_mbravo_comm";
                    break;
                case 1:
                    var_14004b68ddacb781 = "brloot_weapon_sh_mbravo_unco";
                    break;
                case 2:
                    var_14004b68ddacb781 = "brloot_weapon_sh_mbravo_rare";
                    break;
            }
        }
        else if ( message == "mobile_debug_give_weapon_golf17" )
        {
            weapid = "iw9_pi_golf17_mp";
            
            switch ( var_2150015540242e9e )
            {
                case 0:
                    var_14004b68ddacb781 = "brloot_weapon_pi_golf17_comm";
                    break;
                case 1:
                    var_14004b68ddacb781 = "brloot_weapon_pi_golf17_unco";
                    break;
                case 2:
                    var_14004b68ddacb781 = "brloot_weapon_pi_golf17_rare";
                    break;
                case 3:
                    var_14004b68ddacb781 = "brloot_weapon_pi_golf17_epic";
                    break;
                case 4:
                    var_14004b68ddacb781 = "brloot_weapon_pi_golf17_lege";
                    break;
            }
        }
        else if ( message == "mobile_debug_give_weapon_pgolf" )
        {
            weapid = "iw9_dm_pgolf1_mp";
            
            switch ( var_2150015540242e9e )
            {
                case 0:
                    var_14004b68ddacb781 = "brloot_weapon_dm_pgolf1_comm";
                    break;
                case 1:
                    var_14004b68ddacb781 = "brloot_weapon_dm_pgolf1_unco";
                    break;
                case 2:
                    var_14004b68ddacb781 = "brloot_weapon_dm_pgolf1_rare";
                    break;
                case 3:
                    var_14004b68ddacb781 = "brloot_weapon_dm_pgolf1_epic";
                    break;
            }
        }
        else if ( message == "mobile_debug_give_weapon_ax50" )
        {
            weapid = "iw9_sn_alpha50_mp";
            
            switch ( var_2150015540242e9e )
            {
                case 1:
                    var_14004b68ddacb781 = "brloot_weapon_sn_alpha50_unco";
                    break;
            }
        }
        else if ( message == "mobile_debug_give_weapon_slima" )
        {
            weapid = "iw9_lm_slima_mp";
            
            switch ( var_2150015540242e9e )
            {
                case 0:
                    var_14004b68ddacb781 = "brloot_weapon_lm_slima_comm";
                    break;
                case 1:
                    var_14004b68ddacb781 = "brloot_weapon_lm_slima_unco";
                    break;
                case 2:
                    var_14004b68ddacb781 = "brloot_weapon_lm_slima_rare";
                    break;
            }
        }
        else if ( message == "mobile_debug_give_weapon" )
        {
            weapid = "iw9_me_knife";
            
            switch ( var_2150015540242e9e )
            {
                case 0:
                    weapid = "iw9_me_knife";
                    var_14004b68ddacb781 = "brloot_weapon_me_tactical_knife_comm";
                    break;
                case 1:
                    weapid = "iw9_la_rpapa7_mp";
                    var_14004b68ddacb781 = "brloot_weapon_la_rpapa7_comm";
                    break;
            }
        }
        
        if ( weapid != "" )
        {
            assertex( isdefined( level.br_pickups ) || isdefined( level.br_pickups.br_itemrow ), "<dev string:xb4>" );
            rootname = weapon::getweaponrootname( weapid );
            
            if ( var_14004b68ddacb781 != "" )
            {
                attachmentsstring = tablelookupbyrow( level.brloottablename, level.br_pickups.br_itemrow[ var_14004b68ddacb781 ], 9 );
                
                if ( isdefined( attachmentsstring ) && attachmentsstring.size )
                {
                    weapattachments = strtok( attachmentsstring, "+" );
                }
            }
            
            var_c88b10f789adf8eb = weapon::buildweapon( weapid, weapattachments, undefined, undefined, -1, undefined, undefined, undefined, 0 );
            dropinfo = spawnstruct();
            dropinfo.origin = self.origin;
            dropinfo.angles = self.angles;
            dropinfo.payload = 0;
            pickupent = br_pickups::spawnpickup( var_14004b68ddacb781, dropinfo, weaponclipsize( var_c88b10f789adf8eb ), 0, var_c88b10f789adf8eb, 1 );
            
            if ( !isdefined( pickupent ) )
            {
                return;
            }
            
            pickupent.countlefthand = weaponclipsize( var_c88b10f789adf8eb );
            takeweaponpickup( pickupent );
            br_pickups::deregisterscriptableinstance( pickupent );
            pickupent freescriptable();
        }
    }
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x3bff
// Size: 0x21
function br_give_starting_ammo()
{
    if ( br_gametypes::isfeaturedisabled( "weapons" ) )
    {
        return;
    }
    
    br_ammo_give_type( self, "brloot_ammo_919", 60, 0 );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x3c28
// Size: 0x72
function br_ammo_player_clear()
{
    if ( br_gametypes::isfeaturedisabled( "weapons" ) )
    {
        return;
    }
    
    foreach ( ammotype in level.br_ammo_types )
    {
        self.br_ammo[ ammotype ] = 0;
    }
    
    self notify( "ammo_update" );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x3ca2
// Size: 0xe9, Type: bool
function br_ammo_player_is_maxed_out()
{
    player = self;
    var_509d86412c9d7426 = player getweaponslistprimaries();
    
    foreach ( weap in var_509d86412c9d7426 )
    {
        ammotype = br_ammo_type_for_weapon( weap );
        
        if ( isdefined( ammotype ) )
        {
            ammoclipright = player getweaponammoclip( weap, "right" );
            ammoclipsize = weaponclipsize( weap );
            
            if ( ammoclipright < ammoclipsize )
            {
                return false;
            }
            
            if ( weap.isdualwield )
            {
                ammoclipleft = player getweaponammoclip( weap, "left" );
                
                if ( ammoclipleft < ammoclipsize )
                {
                    return false;
                }
            }
            
            if ( !br_ammo_type_player_full( player, ammotype ) )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x3d94
// Size: 0x111
function br_ammo_player_max_out()
{
    player = self;
    var_f32522625b3c7cf9 = [];
    var_509d86412c9d7426 = player getweaponslistprimaries();
    
    foreach ( weap in var_509d86412c9d7426 )
    {
        ammotype = br_ammo_type_for_weapon( weap );
        
        if ( isdefined( ammotype ) )
        {
            var_f32522625b3c7cf9[ ammotype ] = "dummy_value";
            ammoclipsize = weaponclipsize( weap );
            player setweaponammoclip( weap, ammoclipsize );
        }
    }
    
    foreach ( ammotype, unused in var_f32522625b3c7cf9 )
    {
        player.br_ammo[ ammotype ] = level.var_e6ea72fc5e3fcd00[ ammotype ];
        player br_ammo_player_hud_update_ammotype( ammotype );
    }
    
    br_ammo_update_weapons( player );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x3ead
// Size: 0xaf, Type: bool
function br_ammo_type_player_full( player, ammotype )
{
    if ( !isdefined( player.br_ammo ) || !isdefined( player.br_ammo[ ammotype ] ) )
    {
        return false;
    }
    
    if ( !isdefined( level.var_e6ea72fc5e3fcd00[ ammotype ] ) )
    {
        assert( "<dev string:x112>" + ammotype + "<dev string:x121>" );
        return false;
    }
    
    if ( namespace_e50e624d9af51c8c::function_7e103028c464ab9a( ammotype ) )
    {
        lootid = loot::function_fae5e1d3de32d3f7( ammotype );
        
        if ( isdefined( lootid ) && player namespace_e50e624d9af51c8c::canitemfitinbackpack( lootid, 1 ) )
        {
            return false;
        }
    }
    
    return utility::get_int_or_0( player.br_ammo[ ammotype ] ) >= level.var_e6ea72fc5e3fcd00[ ammotype ];
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 5
// Checksum 0x0, Offset: 0x3f65
// Size: 0x246
function br_ammo_give_type( player, ammotype, amount, dropleftovers, var_ef37464796f8ed )
{
    var_ef37464796f8ed = default_to( var_ef37464796f8ed, 1 );
    
    if ( br_ammo_type_player_full( player, ammotype ) )
    {
        return amount;
    }
    
    if ( !isdefined( dropleftovers ) )
    {
        dropleftovers = 0;
    }
    
    if ( !isdefined( ammotype ) )
    {
        scripts\mp\utility\script::demoforcesre( "br_ammo_give_type - ammoType undefined" );
        return;
    }
    
    if ( !isdefined( player.br_ammo ) )
    {
        message = "br_ammo_give_type - player.br_ammo undefined";
        message += "; ammoType: " + ammotype;
        message += "; isPrematchDone: " + scripts\mp\flags::gameflag( "prematch_done" );
        message += "; isCodcaster: " + player iscodcaster();
        message += "; isSpectating: " + player function_e69d7896fa6e5d23();
        message += "; playerName: " + player.name;
        scripts\mp\utility\script::demoforcesre( message );
        return;
    }
    
    if ( !isdefined( player.br_ammo[ ammotype ] ) )
    {
        scripts\mp\utility\script::demoforcesre( "br_ammo_give_type - player.br_ammo[ ammoType ] undefined for " + ammotype );
        return;
    }
    
    var_2c86af91e7e20602 = 0;
    player.br_ammo[ ammotype ] += amount;
    
    if ( player.br_ammo[ ammotype ] > level.br_ammo_max[ ammotype ] )
    {
        var_2c86af91e7e20602 = player.br_ammo[ ammotype ] - level.br_ammo_max[ ammotype ];
        
        if ( namespace_e50e624d9af51c8c::function_7e103028c464ab9a( ammotype ) )
        {
            var_be740b7d6b79253a = var_2c86af91e7e20602;
            
            if ( !var_ef37464796f8ed )
            {
                var_a29ff2ee96b284c1 = player namespace_e50e624d9af51c8c::function_9e76c59021bbf021( ammotype );
                var_be740b7d6b79253a = int( min( var_2c86af91e7e20602, var_a29ff2ee96b284c1 ) );
            }
            
            var_bada25504e8844d7 = spawnstruct();
            var_bada25504e8844d7.scriptablename = ammotype;
            var_bada25504e8844d7.count = var_be740b7d6b79253a;
            lootid = loot::function_fae5e1d3de32d3f7( ammotype );
            player namespace_e50e624d9af51c8c::additemtobackpack( lootid, var_bada25504e8844d7, !dropleftovers );
            var_2c86af91e7e20602 -= var_be740b7d6b79253a;
        }
        else if ( !dropleftovers && var_2c86af91e7e20602 < level.br_ammo_clipsize[ ammotype ] )
        {
            var_2c86af91e7e20602 = 0;
        }
        
        player.br_ammo[ ammotype ] = level.br_ammo_max[ ammotype ];
    }
    
    player br_ammo_player_hud_update_ammotype( ammotype );
    br_ammo_update_weapons( player );
    return var_2c86af91e7e20602;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 3
// Checksum 0x0, Offset: 0x41b4
// Size: 0x80, Type: bool
function br_ammo_take_type( player, ammotype, amount )
{
    if ( player.br_ammo[ ammotype ] <= 0 )
    {
        return false;
    }
    
    player.br_ammo[ ammotype ] -= amount;
    
    if ( player.br_ammo[ ammotype ] < 0 )
    {
        player.br_ammo[ ammotype ] = 0;
    }
    
    player br_ammo_player_hud_update_ammotype( ammotype );
    br_ammo_update_weapons( player );
    return true;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x423d
// Size: 0x74
function br_ammo_player_hud_monitor()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    while ( true )
    {
        utility::waittill_any_5( "ammo_update", "pickedupweapon", "weapon_switch_done", "weapon_change", "weapon_change_complete" );
        br_ammo_player_hud_update_ammotype( "brloot_ammo_919" );
        br_ammo_player_hud_update_ammotype( "brloot_ammo_12g" );
        br_ammo_player_hud_update_ammotype( "brloot_ammo_762" );
        br_ammo_player_hud_update_ammotype( "brloot_ammo_50cal" );
        br_ammo_player_hud_update_ammotype( "brloot_ammo_rocket" );
    }
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x42b9
// Size: 0x82
function br_ammo_player_hud_update_ammotype( ammotype, bpulse )
{
    extraammo = 0;
    
    if ( namespace_e50e624d9af51c8c::function_7e103028c464ab9a( ammotype ) )
    {
        lootid = loot::function_fae5e1d3de32d3f7( ammotype );
        namespace_e50e624d9af51c8c::function_5baaa0ce73d6fe84( self, ammotype );
    }
    
    if ( isdefined( level.br_ammo_omnvars[ ammotype ] ) && isdefined( self.br_ammo[ ammotype ] ) )
    {
        self setclientomnvar( level.br_ammo_omnvars[ ammotype ], self.br_ammo[ ammotype ] + extraammo );
    }
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x4343
// Size: 0xb8
function br_ammo_update_weapons( player )
{
    if ( br_gametypes::isfeaturedisabled( "weapons" ) )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( istrue( level.var_3ea6ceb7358d49df ) )
    {
        var_9ecb8be52ee02c6d = [];
        
        foreach ( ammotype in level.br_ammo_types )
        {
            if ( isdefined( ammotype ) && !istrue( var_9ecb8be52ee02c6d[ ammotype ] ) )
            {
                br_ammo_update_ammotype_weapons( player, ammotype, player.br_ammo[ ammotype ] );
                var_9ecb8be52ee02c6d[ ammotype ] = 1;
            }
        }
        
        return;
    }
    
    player thread function_b91fb4a74bcae056( player );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x4403
// Size: 0xd2
function function_b91fb4a74bcae056( player )
{
    player br_wait_for_complete_reload();
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    var_509d86412c9d7426 = player getweaponslistprimaries();
    
    foreach ( weap in var_509d86412c9d7426 )
    {
        wammotype = br_ammo_type_for_weapon( weap );
        
        if ( isdefined( wammotype ) )
        {
            newstockammo = utility::get_int_or_0( player.br_ammo[ wammotype ] );
            
            if ( istrue( self.overridemaxammo ) )
            {
                player setweaponammostock( weap, newstockammo, 1 );
                continue;
            }
            
            player setweaponammostock( weap, newstockammo );
        }
    }
    
    player notify( "ammo_update" );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x44dd
// Size: 0xfa
function function_5143c54fb8c3c4fd( player, ammotype )
{
    if ( !isdefined( player ) || !isdefined( ammotype ) )
    {
        return;
    }
    
    var_509d86412c9d7426 = self getweaponslistprimaries();
    var_a9bc5314d494806d = 0;
    
    foreach ( weap in var_509d86412c9d7426 )
    {
        ammotypecomparison = br_ammo_type_for_weapon( weap );
        
        if ( isdefined( ammotypecomparison ) && ammotype == ammotypecomparison )
        {
            newstockammo = self.br_ammo[ ammotype ];
            
            if ( br_public::function_6b531c76815d77f3( ammotype ) )
            {
                lootid = loot::function_fae5e1d3de32d3f7( ammotype );
                newstockammo += namespace_e50e624d9af51c8c::gettotalitemcountinbag( lootid );
            }
            
            newstockammo = utility::get_int_or_0( newstockammo );
            player setweaponammostock( weap, newstockammo );
        }
    }
    
    player notify( "ammo_update" );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 3
// Checksum 0x0, Offset: 0x45df
// Size: 0x267
function br_ammo_update_ammotype_weapons( player, ammotype, newweaponstock )
{
    if ( !isdefined( player ) || !isdefined( ammotype ) )
    {
        return;
    }
    
    if ( player br_public::function_6b531c76815d77f3( ammotype ) )
    {
        var_efb882bf4f27ee85 = level.var_e6ea72fc5e3fcd00[ ammotype ] - newweaponstock;
        lootid = loot::function_fae5e1d3de32d3f7( ammotype );
        var_750fcc188317845a = [];
        
        for ( i = 0; i < player namespace_e50e624d9af51c8c::getplayerbackpacksize( player ) ; i++ )
        {
            if ( player namespace_e50e624d9af51c8c::getlootidatbackpackindex( i ) == lootid )
            {
                var_750fcc188317845a[ i ] = player namespace_e50e624d9af51c8c::getQuantityAtBackpackIndex( i );
            }
        }
        
        var_2c20ea06f37f490a = tablesort( var_750fcc188317845a, "up" );
        
        foreach ( index in var_2c20ea06f37f490a )
        {
            slotquantity = player namespace_e50e624d9af51c8c::getQuantityAtBackpackIndex( index );
            
            if ( var_efb882bf4f27ee85 <= slotquantity )
            {
                player namespace_e50e624d9af51c8c::function_db1dd76061352e5b( index, var_efb882bf4f27ee85 );
                var_efb882bf4f27ee85 = 0;
                break;
            }
            
            var_efb882bf4f27ee85 -= slotquantity;
            player namespace_e50e624d9af51c8c::function_db1dd76061352e5b( index, slotquantity );
        }
        
        newweaponstock += level.var_e6ea72fc5e3fcd00[ ammotype ] - newweaponstock - var_efb882bf4f27ee85;
    }
    
    var_509d86412c9d7426 = player getweaponslistprimaries();
    
    if ( player namespace_e50e624d9af51c8c::function_efab78b72d131d76( player ) )
    {
        var_9ac5e72784815708 = player namespace_e50e624d9af51c8c::function_2985254128b1c262( player );
        var_509d86412c9d7426[ var_509d86412c9d7426.size ] = var_9ac5e72784815708;
    }
    
    foreach ( weap in var_509d86412c9d7426 )
    {
        newweaponstock = utility::get_int_or_0( newweaponstock );
        ammotypecomparison = br_ammo_type_for_weapon( weap );
        
        if ( isdefined( ammotypecomparison ) && ammotype == ammotypecomparison )
        {
            if ( !isaxeweapon( weap ) )
            {
                player setweaponammostock( weap, newweaponstock );
            }
        }
        
        player.br_ammo[ ammotype ] = min( newweaponstock, level.var_e6ea72fc5e3fcd00[ ammotype ] );
        player.br_ammo[ ammotype ] = utility::get_int_or_0( player.br_ammo[ ammotype ] );
    }
    
    player notify( "ammo_update" );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x484e
// Size: 0x51, Type: bool
function function_d132e8c198bedadb( weapon )
{
    underbarrel = weapon.underbarrel;
    return isdefined( underbarrel ) && ( issubstr( underbarrel, "selectsemi" ) || issubstr( underbarrel, "selectauto" ) || issubstr( underbarrel, "selectburst" ) );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x48a8
// Size: 0xcb
function function_32e653f0d47413ae( weapclass )
{
    switch ( weapclass )
    {
        case #"hash_8cdaf2e4ecfe5b51":
            return "weapon_assault";
        case #"hash_900cb96c552c5e8e":
            return "weapon_smg";
        case #"hash_690c0d6a821b42e":
            return "weapon_shotgun";
        case #"hash_fa24dff6bd60a12d":
            return "weapon_lmg";
        case #"hash_6191aaef9f922f96":
            return "weapon_sniper";
        case #"hash_61e969dacaaf9881":
            return "weapon_projectile";
        case #"hash_719417cb1de832b6":
            return "weapon_pistol";
        default:
            message = "weapon class not found: " + weapclass;
            assertmsg( message );
            scripts\mp\utility\script::demoforcesre( message );
            break;
    }
    
    return "weapon_assault";
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x497c
// Size: 0x32, Type: bool
function function_e659ea94b8de314d( weapon )
{
    weapclass = function_5b5009e9b863f073( weapon );
    var_19fa3f93a6b62f59 = function_96133dbb3bbead33( weapon );
    return weapclass != var_19fa3f93a6b62f59;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x49b7
// Size: 0x3a
function function_96133dbb3bbead33( weapon )
{
    if ( istrue( weapon.isalternate ) )
    {
        weapon = weapon getnoaltweapon();
    }
    
    var_19fa3f93a6b62f59 = function_5ad4f829896cf2e9( weapon getbaseweapon() );
    return var_19fa3f93a6b62f59;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x49fa
// Size: 0x35
function function_5b5009e9b863f073( weapon )
{
    if ( istrue( weapon.isalternate ) )
    {
        weapon = weapon getnoaltweapon();
    }
    
    weapclass = function_5ad4f829896cf2e9( weapon );
    return weapclass;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x4a38
// Size: 0xd2
function br_ammo_type_for_weapon( weapon )
{
    weapclass = undefined;
    
    if ( isaxeweapon( weapon ) )
    {
        return undefined;
    }
    else if ( weapon.isalternate && !function_d132e8c198bedadb( weapon ) )
    {
        underbarrel = weapon.underbarrel;
        
        if ( isdefined( underbarrel ) && ( issubstr( underbarrel, "ubshtgn" ) || issubstr( underbarrel, "ub_sh" ) ) )
        {
            return "brloot_ammo_12g";
        }
        else
        {
            weapclass = "weapon_projectile";
        }
    }
    else if ( istrue( weapon::issuperuseweapon( weapon ) ) )
    {
        return undefined;
    }
    else if ( function_e659ea94b8de314d( weapon ) )
    {
        weapclass = function_32e653f0d47413ae( function_5b5009e9b863f073( weapon ) );
    }
    else
    {
        weapclass = weapon::getbaseweapongroup( weapon );
        
        if ( !isdefined( weapclass ) )
        {
            return undefined;
        }
    }
    
    return level.var_1540c43d84650140[ weapclass ];
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x4b13
// Size: 0x16
function function_a2fa56c4e1c77ba9( weapclass )
{
    return level.var_1540c43d84650140[ weapclass ];
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x4b32
// Size: 0x54, Type: bool
function function_9e44f8d2e11ef1a( var_73d33f45a70bfc9f )
{
    switch ( var_73d33f45a70bfc9f )
    {
        case #"hash_1cd9ffa488237604":
        case #"hash_57e5eda4a702c559":
        case #"hash_672892a4af1e94cc":
        case #"hash_755a9bafcd63b343":
        case #"hash_f1734c15f85881ca":
            return true;
    }
    
    return false;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x4b8f
// Size: 0x1a
function function_801f575ba3157258()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( scripts\mp\gametypes\br_public::isplayeringulag() )
    {
        return;
    }
    
    thread function_c0848667d62ed371();
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x4bb1
// Size: 0x1dd
function function_c0848667d62ed371()
{
    objweapon = self getcurrentweapon();
    weaponammotype = br_ammo_type_for_weapon( objweapon );
    
    if ( !isdefined( weaponammotype ) )
    {
        return;
    }
    
    self.var_55562bd5eb6065e5 = self getweaponammoclip( objweapon );
    br_wait_for_complete_reload();
    
    if ( !isdefined( self ) )
    {
        self.var_55562bd5eb6065e5 = undefined;
        return;
    }
    
    if ( objweapon != self getcurrentweapon() && !scripts\mp\gametypes\br::function_f32857a938336f2b( self, objweapon ) )
    {
        self.var_55562bd5eb6065e5 = undefined;
        return;
    }
    
    var_7ff630bfbca7b961 = self.br_ammo[ weaponammotype ];
    
    if ( !getdvarint( @"hash_59a26f9bd4367b8d", istrue( level.prematchinfinitammo ) ) || flags::gameflag( "prematch_done" ) )
    {
        if ( !self hasweapon( objweapon ) && scripts\mp\gametypes\br::function_f32857a938336f2b( self, objweapon ) )
        {
            var_7ff630bfbca7b961 = self.br_ammo[ weaponammotype ];
        }
        else
        {
            var_7ff630bfbca7b961 = self getweaponammostock( objweapon );
        }
    }
    
    br_ammo_update_ammotype_weapons( self, weaponammotype, var_7ff630bfbca7b961 );
    
    if ( isdefined( self.br_ammo[ weaponammotype ] ) && self.br_ammo[ weaponammotype ] <= 0 )
    {
        var_54a24336cc9a143d = istrue( objweapon.isalternate ) && ( weaponclass( objweapon ) == "grenade" || weaponclass( objweapon ) == "spread" );
        var_38497ce38042adf7 = 0;
        
        switch ( getweaponrootname( objweapon ) )
        {
            case #"hash_607145e68712971c":
            case #"hash_8d9ae5e5dd390b4b":
            case #"hash_d2d2f2854b7d8b7d":
            case #"hash_ec99e7d11ddb9eea":
                var_38497ce38042adf7 = 1;
                break;
        }
        
        var_da66af6058340796 = var_38497ce38042adf7 || var_54a24336cc9a143d;
        
        if ( !var_da66af6058340796 )
        {
            lootid = loot::function_fae5e1d3de32d3f7( weaponammotype );
            
            if ( isdefined( lootid ) )
            {
                calloutmarkerping::function_1ced737a22161a49( 22, lootid );
            }
        }
    }
    
    self.var_55562bd5eb6065e5 = undefined;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x4d96
// Size: 0x24
function br_wait_for_complete_reload()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "weapon_fired" );
    
    while ( self isreloading() )
    {
        waitframe();
    }
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 3
// Checksum 0x0, Offset: 0x4dc2
// Size: 0x15b
function function_c668c8660ab99773( objweapon, player, dropstruct )
{
    box = self;
    ammotype = br_ammo_type_for_weapon( objweapon );
    
    if ( isdefined( ammotype ) )
    {
        currentammo = player.br_ammo[ ammotype ];
        player.br_ammo[ ammotype ] = level.var_e6ea72fc5e3fcd00[ ammotype ];
        
        if ( currentammo > 0 && istrue( level.var_e00c53ff08aa5fdb ) )
        {
            var_78bdcc21e4751868 = 0;
            
            if ( isdefined( player.primaryweaponobj ) && objweapon == player.primaryweaponobj )
            {
                var_78bdcc21e4751868 = 1;
            }
            else if ( isdefined( player.secondaryweaponobj ) && objweapon == player.secondaryweaponobj )
            {
                var_78bdcc21e4751868 = 1;
            }
            
            if ( var_78bdcc21e4751868 )
            {
                if ( level.var_1aa4ff5576b74b2 && isdefined( dropstruct ) )
                {
                    scripts\mp\equipment\support_box::function_225b99924f316bc1( dropstruct, player, ammotype, currentammo );
                }
                else
                {
                    backpackammo = currentammo;
                    backpackpickup = spawnstruct();
                    backpackpickup.scriptablename = ammotype;
                    backpackpickup.count = backpackammo;
                    lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7( ammotype );
                    player namespace_aead94004cf4c147::additemtobackpack( lootid, backpackpickup );
                }
            }
        }
        
        br_ammo_update_weapons( player );
    }
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x4f25
// Size: 0x103
function br_give_weapon_clip( objweapon, numclips )
{
    player = self;
    
    if ( !isdefined( numclips ) )
    {
        numclips = 1;
    }
    
    ammotype = br_ammo_type_for_weapon( objweapon );
    
    if ( isdefined( ammotype ) )
    {
        var_c1192c297bbf292f = int( level.br_ammo_clipsize[ ammotype ] * numclips );
        
        if ( function_d75b73c443421047() && objweapon.basename == "jup_cp01_sh_aromeo410_mp" && objweapon hasattachment( "jup_ammo_410g_vortex" ) )
        {
            var_c1192c297bbf292f = objweapon.clipsize;
        }
        
        maxammostock = level.var_e6ea72fc5e3fcd00[ ammotype ];
        
        if ( br_public::function_6b531c76815d77f3( ammotype ) )
        {
            lootid = loot::function_fae5e1d3de32d3f7( ammotype );
            maxammostock += namespace_e50e624d9af51c8c::gettotalitemcountinbag( lootid );
        }
        
        var_7ff630bfbca7b961 = int( clamp( player.br_ammo[ ammotype ] + var_c1192c297bbf292f, 0, maxammostock ) );
        br_ammo_update_ammotype_weapons( player, ammotype, var_7ff630bfbca7b961 );
    }
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x5030
// Size: 0xa1
function br_give_weapon_ammo( objweapon, ammo )
{
    player = self;
    ammotype = br_ammo_type_for_weapon( objweapon );
    
    if ( isdefined( ammotype ) )
    {
        maxammostock = level.var_e6ea72fc5e3fcd00[ ammotype ];
        
        if ( br_public::function_6b531c76815d77f3( ammotype ) )
        {
            lootid = loot::function_fae5e1d3de32d3f7( ammotype );
            maxammostock += namespace_e50e624d9af51c8c::gettotalitemcountinbag( lootid );
        }
        
        var_7ff630bfbca7b961 = int( clamp( player.br_ammo[ ammotype ] + ammo, 0, maxammostock ) );
        br_ammo_update_ammotype_weapons( player, ammotype, var_7ff630bfbca7b961 );
    }
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x50d9
// Size: 0x4c, Type: bool
function isvalidcustomweapon( weaponobj )
{
    if ( !isdefined( weaponobj ) )
    {
        return false;
    }
    
    if ( !isweapon( weaponobj ) )
    {
        return false;
    }
    
    if ( isnullweapon( weaponobj ) )
    {
        return false;
    }
    
    if ( scripts\mp\weapons::isfistweapon( weaponobj ) || weapon::isgunlessweapon( weaponobj ) || weapon::ismeleeoverrideweapon( weaponobj ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x512e
// Size: 0x1c
function brallowclasschoicefunc()
{
    if ( istrue( level.br_allowloadout ) && !br_public::function_d6ae35e0ce14bbaf() )
    {
        return 1;
    }
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x5152
// Size: 0x62
function brloadoutupdateammo( loadoutweapons )
{
    foreach ( weapon in loadoutweapons )
    {
        loadout_updatebrammo( weapon, weapon hasattachment( "maxammo" ) );
    }
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x51bc
// Size: 0x127
function loadout_updatebrammo( weapon, hasmaxammo )
{
    ammotype = br_ammo_type_for_weapon( weapon );
    startammo = weaponstartammo( weapon );
    clipsize = weaponclipsize( weapon );
    maxammo = weaponmaxammo( weapon );
    var_bcda1f3ba70d2035 = undefined;
    
    if ( hasmaxammo )
    {
        var_bcda1f3ba70d2035 = maxammo;
    }
    else
    {
        var_bcda1f3ba70d2035 = startammo - clipsize;
    }
    
    if ( isdefined( ammotype ) )
    {
        subgametype = game_utility::getsubgametype();
        
        if ( subgametype == "rumble_mgl" || subgametype == "champion" )
        {
            self.br_ammo[ ammotype ] = 0;
        }
        
        if ( getdvarint( @"hash_1b973cfdbc2aabec", 1 ) )
        {
            if ( scripts\mp\flags::gameflagexists( "prematch_done" ) && !scripts\mp\flags::gameflag( "prematch_done" ) )
            {
                if ( isdefined( level.br_ammo_max[ ammotype ] ) )
                {
                    var_bcda1f3ba70d2035 = int( min( level.br_ammo_max[ ammotype ], var_bcda1f3ba70d2035 ) );
                }
            }
        }
        
        if ( istrue( level.var_376762409014cc8e ) )
        {
            br_ammo_give_type( self, ammotype, maxammo );
            return;
        }
        
        br_ammo_give_type( self, ammotype, var_bcda1f3ba70d2035 );
    }
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x52eb
// Size: 0xc1, Type: bool
function function_d885e66811ee3a4d( var_4ce224053f650637 )
{
    var_509d86412c9d7426 = self getweaponslistprimaries();
    var_2ca75f603de25b76 = 0;
    
    foreach ( weap in var_509d86412c9d7426 )
    {
        ammotypecomparison = br_ammo_type_for_weapon( weap );
        
        if ( isdefined( ammotypecomparison ) && var_4ce224053f650637 == ammotypecomparison )
        {
            return true;
        }
    }
    
    if ( namespace_e50e624d9af51c8c::function_efab78b72d131d76( self ) )
    {
        var_9ac5e72784815708 = namespace_e50e624d9af51c8c::function_2985254128b1c262( self );
        ammotypecomparison = br_ammo_type_for_weapon( var_9ac5e72784815708 );
        
        if ( isdefined( ammotypecomparison ) && var_4ce224053f650637 == ammotypecomparison )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x53b5
// Size: 0x2b
function function_937acc181cfc6285()
{
    if ( getdvarint( @"hash_f84e49a704687827", 0 ) )
    {
        return !self isdiscardunequippedweaponenabled();
    }
    
    return getdvarint( @"hash_8c2f43c3816349fa", 0 );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x53e9
// Size: 0x1ff
function function_823964aa15b30575()
{
    var_6fb2d8460bbfeabe = undefined;
    
    if ( self function_c3a5505bc8f25a14() )
    {
        foreach ( weap in self.primaryweapons )
        {
            if ( function_aaffa8afa2d9c195( weap ) )
            {
                var_6fb2d8460bbfeabe = weap;
                break;
            }
        }
    }
    else if ( self isautograbweaponsbyclassenabled() )
    {
        var_aa84da7b844edaa5 = 8;
        
        for ( i = 0; i < self.primaryweapons.size ; i++ )
        {
            primaryweaponobj = self.primaryweapons[ i ];
            
            if ( !isnullweapon( primaryweaponobj ) && !br_pickups::function_af4aefc234671c2f( i ) )
            {
                var_83106f206ae5a450 = level.var_81369e82645391f0[ weaponclass( primaryweaponobj.basename ) ];
                weaponclasspriority = self getweaponclassprioritytoautograb( var_83106f206ae5a450 );
                
                if ( weaponclasspriority < var_aa84da7b844edaa5 )
                {
                    var_6fb2d8460bbfeabe = primaryweaponobj;
                    var_aa84da7b844edaa5 = weaponclasspriority;
                }
            }
        }
    }
    
    if ( !isdefined( var_6fb2d8460bbfeabe ) )
    {
        if ( self isdiscardsecondaryweaponenabled() )
        {
            foreach ( weap in self.primaryweapons )
            {
                if ( !weapon::iscacsecondaryweapon( weap ) )
                {
                    continue;
                }
                
                if ( !isdefined( var_6fb2d8460bbfeabe ) )
                {
                    var_6fb2d8460bbfeabe = weap;
                    continue;
                }
                
                var_6fb2d8460bbfeabe = undefined;
                break;
            }
        }
        
        if ( self isdiscardunequippedweaponenabled() )
        {
            currentweapon = self getcurrentweapon();
            
            foreach ( weap in self.primaryweapons )
            {
                if ( !issameweapon( currentweapon, weap ) )
                {
                    var_6fb2d8460bbfeabe = weap;
                    break;
                }
            }
        }
    }
    
    return var_6fb2d8460bbfeabe;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x55f1
// Size: 0x107
function function_744e28ebe63c0358( pickupweapon )
{
    dropcurrentweapon = 1;
    var_ec22a950f210e39 = undefined;
    numprimaries = self.primaryweapons.size;
    var_7dc30386b50647a1 = 0;
    
    foreach ( weap in self.primaryweapons )
    {
        if ( isnullweapon( weap ) )
        {
            numprimaries--;
            continue;
        }
        
        if ( issameweapon( weap, pickupweapon ) )
        {
            var_ec22a950f210e39 = weap;
            var_7dc30386b50647a1 = 1;
        }
    }
    
    if ( numprimaries > 1 && !var_7dc30386b50647a1 )
    {
        if ( !self hasweapon( "iw9_me_fists_mp" ) )
        {
            if ( !isdefined( var_ec22a950f210e39 ) )
            {
                var_ec22a950f210e39 = function_823964aa15b30575();
            }
            
            dropcurrentweapon = issameweapon( var_ec22a950f210e39, self getcurrentweapon() );
        }
        else
        {
            dropcurrentweapon = scripts\mp\weapons::isfistweapon( self getcurrentweapon() );
        }
    }
    else
    {
        dropcurrentweapon = issameweapon( var_ec22a950f210e39, self getcurrentweapon() );
    }
    
    return dropcurrentweapon;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x5701
// Size: 0x57
function function_8dabe5259e6844e9( var_ec22a950f210e39, newweapon )
{
    var_7b9de6db6a90dbe7 = 0;
    
    if ( isdefined( var_ec22a950f210e39 ) )
    {
        var_7b9de6db6a90dbe7 = function_671df7651500ea08( newweapon );
        
        if ( !var_7b9de6db6a90dbe7 && ( self isdiscardsecondaryweaponenabled() || self isdiscardunequippedweaponenabled() ) )
        {
            var_7b9de6db6a90dbe7 = !issameweapon( var_ec22a950f210e39, self getcurrentweapon() );
        }
    }
    
    return var_7b9de6db6a90dbe7;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x5761
// Size: 0xab
function function_671df7651500ea08( newweapon )
{
    var_7b9de6db6a90dbe7 = 0;
    
    if ( function_937acc181cfc6285() && self isautograbweaponsbyclassenabled() )
    {
        currentweaponobj = self getcurrentweapon();
        var_185d0d5e6e0be607 = level.var_81369e82645391f0[ weaponclass( currentweaponobj.basename ) ];
        var_96adefe344d42a2 = self getweaponclassprioritytoautograb( var_185d0d5e6e0be607 );
        var_a97d475bd039e5ec = level.var_81369e82645391f0[ weaponclass( newweapon.basename ) ];
        var_9aee8300fd6e45eb = self getweaponclassprioritytoautograb( var_a97d475bd039e5ec );
        var_7b9de6db6a90dbe7 = var_9aee8300fd6e45eb < var_96adefe344d42a2;
    }
    
    return var_7b9de6db6a90dbe7;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x5815
// Size: 0x11
function function_b1dd9dcae2f63965()
{
    return getdvarint( @"hash_1445bea2674012b9", 0 );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x582f
// Size: 0x39
function function_b9da718e50063452()
{
    if ( isdefined( level.br_pickups.var_c9015f26f73062a0 ) )
    {
        return;
    }
    
    level.br_pickups.var_c9015f26f73062a0 = [];
    thread function_a856fc2139eef0c( 15 );
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x5870
// Size: 0xb1, Type: bool
function function_ac3ec31be7aad7a7( weaponinstance )
{
    function_b9da718e50063452();
    weaponshandler = level.br_pickups.var_c9015f26f73062a0[ self.guid ];
    
    if ( isdefined( weaponshandler ) )
    {
        foreach ( weapidx in weaponshandler.array )
        {
            if ( weapidx == weaponinstance.index )
            {
                weaponshandler.var_52fcfe909c72db5b = gettime();
                return true;
            }
        }
    }
    
    return false;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x592a
// Size: 0x12a
function function_8e7e1da48d7746e5( player, weaponpickup )
{
    assert( isdefined( weaponpickup.type ) );
    assert( br_pickups::isweaponpickup( weaponpickup.type ) );
    assert( -1 );
    function_b9da718e50063452();
    weaponshandler = level.br_pickups.var_c9015f26f73062a0[ player.guid ];
    
    if ( !isdefined( weaponshandler ) )
    {
        weaponshandler = spawnstruct();
        weaponshandler.array = [];
        weaponshandler.curindex = 0;
        weaponshandler.var_52fcfe909c72db5b = 0;
        level.br_pickups.var_c9015f26f73062a0[ player.guid ] = weaponshandler;
    }
    
    weaponshandler.array[ weaponshandler.curindex ] = weaponpickup.index;
    weaponshandler.curindex = math::wrap( 0, 4, weaponshandler.curindex + 1 );
    weaponshandler.var_52fcfe909c72db5b = gettime();
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x5a5c
// Size: 0xdc
function function_a856fc2139eef0c( tickinterval )
{
    level endon( "game_ended" );
    
    while ( true )
    {
        curtime = gettime();
        maxtimekeeping = getdvarint( @"hash_5eff4677b208a6b8", 45000 );
        
        foreach ( key, weaponshandler in level.br_pickups.var_c9015f26f73062a0 )
        {
            if ( curtime - weaponshandler.var_52fcfe909c72db5b >= maxtimekeeping )
            {
                level.br_pickups.var_c9015f26f73062a0[ key ] = undefined;
            }
        }
        
        if ( getdvarint( @"hash_9723d1b7ab64df07", 0 ) )
        {
            function_c50d56273471bf54();
        }
        
        wait tickinterval;
    }
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 0
// Checksum 0x0, Offset: 0x5b40
// Size: 0xc4
function function_c50d56273471bf54()
{
    var_c215e2a76b873506 = 0;
    structscount = 0;
    
    foreach ( weaponhandler in level.br_pickups.var_c9015f26f73062a0 )
    {
        if ( isdefined( weaponhandler ) )
        {
            structscount++;
            var_c215e2a76b873506 += weaponhandler.array.size;
        }
    }
    
    /#
        println( "<dev string:x172>" );
        println( "<dev string:x1e6>" );
        println( "<dev string:x21d>" + structscount );
        println( "<dev string:x24e>" + var_c215e2a76b873506 );
        println( "<dev string:x1e6>" );
    #/
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 2
// Checksum 0x0, Offset: 0x5c0c
// Size: 0x109, Type: bool
function function_ad972c1d0f29841c( player, weapon )
{
    ammotype = br_ammo_type_for_weapon( weapon );
    
    if ( !isdefined( ammotype ) )
    {
        return false;
    }
    
    foreach ( weap in player.primaryweapons )
    {
        var_3c8e002031cebe5b = undefined;
        
        if ( !isnullweapon( weap ) && !issameweapon( weap, weapon ) )
        {
            var_3c8e002031cebe5b = br_ammo_type_for_weapon( weap );
        }
        
        if ( isdefined( var_3c8e002031cebe5b ) && var_3c8e002031cebe5b == ammotype )
        {
            return false;
        }
    }
    
    if ( namespace_e50e624d9af51c8c::function_efab78b72d131d76( player ) )
    {
        weap = namespace_e50e624d9af51c8c::function_f2849dae62f7444e( player );
        
        if ( !isdefined( weap ) )
        {
            return true;
        }
        
        var_7908d034a3f457b = undefined;
        
        if ( !isnullweapon( weap ) && !issameweapon( weap, weapon ) )
        {
            var_7908d034a3f457b = br_ammo_type_for_weapon( weap );
        }
        
        if ( isdefined( var_7908d034a3f457b ) && var_7908d034a3f457b == ammotype )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_weapons / scripts\mp\gametypes\br_weapons
// Params 1
// Checksum 0x0, Offset: 0x5d1e
// Size: 0x3b
function isexcludedweapon( weapon )
{
    ammotype = br_ammo_type_for_weapon( weapon );
    
    if ( isdefined( ammotype ) )
    {
        return 0;
    }
    
    return utility::array_contains( level.var_783fe165885ab6dd, weapon::getweapongroup( weapon ) );
}

