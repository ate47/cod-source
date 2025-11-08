#using scripts\common\utility;
#using scripts\cp\armor;
#using scripts\cp\cp_hud_message;
#using scripts\cp\perks;
#using scripts\cp\persistence;
#using scripts\cp\utility;
#using scripts\cp_mp\armor;
#using scripts\engine\utility;

#namespace perk_packs;

// Namespace perk_packs / scripts\cp\perk_packs
// Params 0
// Checksum 0x0, Offset: 0x34c
// Size: 0x9a
function function_9de497922ea1a6bf()
{
    level.var_b3cbb613d49ff5a3 = [];
    level.var_e23f2a9c37c8597c = [];
    function_b3c5ba25a66d7ce9( "perk_pack_speedy", &function_fa0bb7d172f87c23, &function_494742bebd999d7a );
    function_b3c5ba25a66d7ce9( "perk_pack_buff", &function_b206a39197180c92, &function_9f0bac6bdea9712f );
    function_b3c5ba25a66d7ce9( "perk_pack_mule", &function_581e926068ad6972, &function_e772d952ad274643 );
    function_b3c5ba25a66d7ce9( "perk_pack_medic", &function_a7ac939f2c1d839, &function_ed6749412e69fe02 );
    function_b3c5ba25a66d7ce9( "perk_pack_ammo_buff", &function_f4e87426380be51, &function_54f94ddcc1f58996 );
    function_b3c5ba25a66d7ce9( "perk_pack_armor_buff", &function_448cea0f7c6fbf36, &function_77eb1d81d0f5e81f );
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 0
// Checksum 0x0, Offset: 0x3ee
// Size: 0x2b
function function_645eb4e3639de90d()
{
    if ( !isdefined( self.perk_packs ) )
    {
        self.perk_packs = [];
        self.var_c50870864fd5fa67 = 4;
        function_10be613f34ff473a();
    }
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 3
// Checksum 0x0, Offset: 0x421
// Size: 0x7e
function function_b3c5ba25a66d7ce9( var_42695dc3bf559617, setfunc, unsetfunc )
{
    assert( isdefined( var_42695dc3bf559617 ) );
    assert( isdefined( setfunc ) );
    assert( isdefined( unsetfunc ) );
    
    if ( isdefined( setfunc ) )
    {
        assert( isfunction( setfunc ) );
        level.var_b3cbb613d49ff5a3[ var_42695dc3bf559617 ] = setfunc;
    }
    
    if ( isdefined( unsetfunc ) )
    {
        assert( isfunction( unsetfunc ) );
        level.var_e23f2a9c37c8597c[ var_42695dc3bf559617 ] = unsetfunc;
    }
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 0
// Checksum 0x0, Offset: 0x4a7
// Size: 0x5f
function function_10be613f34ff473a()
{
    for ( i = 1; i < 5 ; i++ )
    {
        self.perk_packs[ i ] = spawnstruct();
        self.perk_packs[ i ].pack_level = 0;
        self.perk_packs[ i ].pack_name = "none";
    }
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 0
// Checksum 0x0, Offset: 0x50e
// Size: 0x47
function function_eb542c381f315290()
{
    for ( i = 1; i < self.var_c50870864fd5fa67 + 1 ; i++ )
    {
        if ( self.perk_packs[ i ].pack_name == "none" )
        {
            return i;
        }
    }
    
    return 0;
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 2
// Checksum 0x0, Offset: 0x55e
// Size: 0x2f
function function_e752c81048e56e3c( slot, pack_level )
{
    if ( isdefined( pack_level ) )
    {
        self.perk_packs[ slot ].pack_level = pack_level;
    }
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0x595
// Size: 0x6e
function function_dfceffb521d7d4cb( perkname )
{
    switch ( perkname )
    {
        case #"hash_4666fbb263cf581b":
            return "perk_pack_mule";
        case #"hash_5d3f25d7f9aa109":
            return "perk_pack_medic";
        case #"hash_46e6f0dbb1fb728c":
            return "perk_pack_buff";
        case #"hash_de9b5c91d811f203":
            return "perk_pack_mule";
        default:
            return "perk_pack_speed";
    }
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 3
// Checksum 0x0, Offset: 0x60b
// Size: 0x92
function function_7184b43950d947ea( perk_pack, slot, pack_level )
{
    var_5dc06b0667135c87 = "ui_spawn_perk_";
    omnvarindex = slot - 1;
    omnvar = var_5dc06b0667135c87 + omnvarindex;
    
    if ( perk_pack != "none" )
    {
        if ( isdefined( omnvar ) )
        {
            omnvar_value = int( tablelookup( "cp/perk_pack_table.csv", 1, perk_pack, 0 ) );
            
            if ( isdefined( omnvar_value ) )
            {
                self setclientomnvar( omnvar, omnvar_value );
            }
        }
        
        return;
    }
    
    self setclientomnvar( omnvar, -1 );
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0x6a5
// Size: 0x60
function function_74320e884b9a3fd8( pack_name )
{
    for ( i = 1; i < self.var_c50870864fd5fa67 + 1 ; i++ )
    {
        if ( self.perk_packs[ i ].pack_name == pack_name )
        {
            return self.perk_packs[ i ].pack_level;
        }
    }
    
    return 0;
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0x70e
// Size: 0x4d, Type: bool
function function_8f03acc557e2b610( pack_name )
{
    for ( i = 1; i < self.var_c50870864fd5fa67 + 1 ; i++ )
    {
        if ( self.perk_packs[ i ].pack_name == pack_name )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 0
// Checksum 0x0, Offset: 0x764
// Size: 0x48, Type: bool
function function_f82e41138806e225()
{
    for ( i = 1; i < self.var_c50870864fd5fa67 + 1 ; i++ )
    {
        if ( self.perk_packs[ i ].pack_name == "none" )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0x7b5
// Size: 0x4c
function function_de2c47c49e185540( pack_name )
{
    for ( i = 1; i < self.var_c50870864fd5fa67 + 1 ; i++ )
    {
        if ( self.perk_packs[ i ].pack_name == pack_name )
        {
            return i;
        }
    }
    
    return 0;
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 0
// Checksum 0x0, Offset: 0x80a
// Size: 0x54
function function_9ab372b1dc1a8e3()
{
    slot = 0;
    
    for ( i = 1; i < self.var_c50870864fd5fa67 + 1 ; i++ )
    {
        if ( self.perk_packs[ i ].pack_name == "none" )
        {
            slot = i;
        }
    }
    
    return slot;
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0x867
// Size: 0x20
function function_7f62b61fc20b6540( slot_num )
{
    return self.perk_packs[ slot_num ].pack_name;
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 2
// Checksum 0x0, Offset: 0x890
// Size: 0x37
function function_47ae9e67fafc2fc4( slot_num, var_d1fc596f54becc5a )
{
    var_efbe3cb0d8d22512 = function_7f62b61fc20b6540( slot_num );
    function_7175c0fbce3fed06( var_efbe3cb0d8d22512 );
    function_9dfbc3169c4fb507( var_d1fc596f54becc5a, 3 );
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 2
// Checksum 0x0, Offset: 0x8cf
// Size: 0x4d
function function_6906dab2c6805a25( pack_name, pack_level )
{
    slot = function_de2c47c49e185540( pack_name );
    
    if ( slot > 0 )
    {
        current_level = function_74320e884b9a3fd8( pack_name );
        
        if ( current_level < 2 )
        {
            function_e752c81048e56e3c( slot, pack_level );
        }
    }
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 2
// Checksum 0x0, Offset: 0x924
// Size: 0x64
function function_9dfbc3169c4fb507( pack_name, pack_level )
{
    slot = function_eb542c381f315290();
    
    if ( slot != 0 )
    {
        self.perk_packs[ slot ].pack_name = pack_name;
        function_e752c81048e56e3c( slot, pack_level );
        function_7184b43950d947ea( pack_name, slot, pack_level );
        self [[ level.var_b3cbb613d49ff5a3[ pack_name ] ]]( pack_level );
    }
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 0
// Checksum 0x0, Offset: 0x990
// Size: 0x39
function function_83829cdb2347c8f()
{
    function_7175c0fbce3fed06( "perk_pack_speedy" );
    function_7175c0fbce3fed06( "perk_pack_buff" );
    function_7175c0fbce3fed06( "perk_pack_medic" );
    function_7175c0fbce3fed06( "perk_pack_mule" );
    function_a201dbdaec933ae6();
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0x9d1
// Size: 0x99
function function_7175c0fbce3fed06( pack_name )
{
    for ( slot = 1; slot < self.var_c50870864fd5fa67 + 1 ; slot++ )
    {
        if ( self.perk_packs[ slot ].pack_name == pack_name )
        {
            self.perk_packs[ slot ].pack_name = "none";
            self.perk_packs[ slot ].pack_level = 0;
            function_7184b43950d947ea( "none", slot, 0 );
            self [[ level.var_e23f2a9c37c8597c[ pack_name ] ]]( 0 );
        }
    }
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 0
// Checksum 0x0, Offset: 0xa72
// Size: 0xd
function function_ed49c972daeb7575()
{
    self.var_c50870864fd5fa67 = 2;
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 0
// Checksum 0x0, Offset: 0xa87
// Size: 0xd
function function_a201dbdaec933ae6()
{
    self.var_c50870864fd5fa67 = 4;
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 0
// Checksum 0x0, Offset: 0xa9c
// Size: 0x15, Type: bool
function function_3cf76f4dab9dc93c()
{
    if ( self.var_c50870864fd5fa67 == 2 )
    {
        return true;
    }
    
    return false;
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0xaba
// Size: 0x53
function function_fa0bb7d172f87c23( pack_level )
{
    giveperk( "specialty_hustle" );
    giveperk( "specialty_fastcrouchmovement" );
    giveperk( "specialty_stalker" );
    giveperk( "specialty_fastreload" );
    giveperk( "specialty_tactical_recon" );
    giveperk( "specialty_warhead" );
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0xb15
// Size: 0x53
function function_494742bebd999d7a( pack_level )
{
    takeperk( "specialty_hustle" );
    takeperk( "specialty_fastcrouchmovement" );
    takeperk( "specialty_stalker" );
    takeperk( "specialty_fastreload" );
    takeperk( "specialty_tactical_recon" );
    takeperk( "specialty_warhead" );
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0xb70
// Size: 0x23
function function_a7ac939f2c1d839( pack_level )
{
    giveperk( "specialty_fast_health_regen" );
    giveperk( "specialty_quick_revive" );
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0xb9b
// Size: 0x23
function function_ed6749412e69fe02( pack_level )
{
    takeperk( "specialty_fast_health_regen" );
    takeperk( "specialty_quick_revive" );
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0xbc6
// Size: 0x42
function function_f4e87426380be51( pack_level )
{
    splash = "cp_super_ammo_used";
    scripts\cp\cp_hud_message::showsplash( splash, undefined, self );
    self setclientomnvar( "ui_ammo_class_power_on", gettime() );
    giveperk( "specialty_bulletdamage" );
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0xc10
// Size: 0x28
function function_54f94ddcc1f58996( pack_level )
{
    takeperk( "specialty_bulletdamage" );
    self setclientomnvar( "ui_ammo_class_power_off", gettime() );
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0xc40
// Size: 0x78
function function_448cea0f7c6fbf36( pack_level )
{
    splash = "cp_super_armor_used";
    full_armor = self.var_4cb4a6ebd0885ffd;
    scripts\cp_mp\armor::function_9c6e9a6643b6c9a6( full_armor );
    self.old_armor_scalar = scripts\cp\perks::get_perk( "enemy_damage_to_player_armor_scalar" );
    scripts\cp\perks::set_perk( "enemy_damage_to_player_armor_scalar", self.old_armor_scalar * 1.5 );
    self.armorhardened = 1;
    scripts\cp\armor::function_e0d47de3df5f23ea();
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0xcc0
// Size: 0x31
function function_77eb1d81d0f5e81f( pack_level )
{
    scripts\cp\perks::set_perk( "enemy_damage_to_player_armor_scalar", self.old_armor_scalar );
    self.armorhardened = 0;
    scripts\cp\armor::function_e0d47de3df5f23ea();
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0xcf9
// Size: 0x34
function function_b206a39197180c92( pack_level )
{
    giveperk( "specialty_extra_armor" );
    scripts\cp\armor::function_8ce284d6441202b8( pack_level );
    function_79287cc290242a2( self, pack_level );
    giveperk( "specialty_eod" );
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0xd35
// Size: 0x34
function function_9f0bac6bdea9712f( pack_level )
{
    takeperk( "specialty_extra_armor" );
    scripts\cp\armor::function_8ce284d6441202b8( 0 );
    function_79287cc290242a2( self, 0 );
    takeperk( "specialty_eod" );
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 2
// Checksum 0x0, Offset: 0xd71
// Size: 0x37
function function_79287cc290242a2( player, pack_level )
{
    entity_num = player getentitynumber();
    scripts\cp\persistence::setcoopplayerdata_for_everyone( "EoGPlayer", entity_num, "hivesdestroyed", pack_level );
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0xdb0
// Size: 0x3d
function function_581e926068ad6972( pack_level )
{
    giveperk( "specialty_extra_weapon" );
    giveperk( "specialty_armor_satchel" );
    self setclientomnvar( "ui_br_has_plate_pouch", 1 );
    giveperk( "specialty_extra_shrapnel" );
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0xdf5
// Size: 0x43
function function_e772d952ad274643( pack_level )
{
    takeperk( "specialty_extra_weapon" );
    takeperk( "specialty_armor_satchel" );
    self setclientomnvar( "ui_br_has_plate_pouch", 0 );
    takeperk( "specialty_extra_shrapnel" );
    function_3e9ce650ebb5cee();
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 0
// Checksum 0x0, Offset: 0xe40
// Size: 0xbf
function function_3e9ce650ebb5cee()
{
    primaries = self getweaponslistprimaries();
    weapon_count = 0;
    self.mule_weaponlist = [];
    
    foreach ( weapon in primaries )
    {
        if ( weapon.inventorytype == "primary" )
        {
            self.mule_weaponlist[ weapon_count ] = weapon;
            weapon_count += 1;
        }
    }
    
    if ( weapon_count >= 3 )
    {
        var_cca6009e1acb40ed = random( self.mule_weaponlist );
        
        if ( isdefined( var_cca6009e1acb40ed ) )
        {
            self takeweapon( var_cca6009e1acb40ed );
        }
    }
}

// Namespace perk_packs / scripts\cp\perk_packs
// Params 1
// Checksum 0x0, Offset: 0xf07
// Size: 0x29
function function_e5ea666722be9cd0( num )
{
    if ( !isdefined( num ) )
    {
        num = 4;
    }
    
    if ( _hasperk( "specialty_extra_shrapnel" ) )
    {
        num += 2;
    }
    
    return num;
}

