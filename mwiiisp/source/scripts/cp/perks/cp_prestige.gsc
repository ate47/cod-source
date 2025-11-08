#using scripts\engine\utility;

#namespace cp_prestige;

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x172
// Size: 0x115
function initprestige()
{
    nerf_func = [];
    nerf_func[ "none" ] = &empty;
    nerf_func[ "nerf_take_more_damage" ] = &increase_damage_scalar;
    nerf_func[ "nerf_higher_threatbias" ] = &increase_threatbias;
    nerf_func[ "nerf_smaller_wallet" ] = &reduce_wallet_size_and_money_earned;
    nerf_func[ "nerf_lower_weapon_damage" ] = &lower_weapon_damage;
    nerf_func[ "nerf_no_class" ] = &no_class;
    nerf_func[ "nerf_pistols_only" ] = &pistols_only;
    nerf_func[ "nerf_fragile" ] = &slow_health_regen;
    nerf_func[ "nerf_move_slower" ] = &move_slower;
    nerf_func[ "nerf_no_abilities" ] = &no_abilities;
    nerf_func[ "nerf_min_ammo" ] = &min_ammo;
    nerf_func[ "nerf_no_deployables" ] = &no_deployables;
    level.prestige_nerf_func = nerf_func;
    table_list = [];
    
    for ( i = 0; i < 10 ; i++ )
    {
        var_6e8c4a470d8ac8b5 = tablelookupbyrow( "cp/alien/prestige_nerf.csv", i, 1 );
        
        if ( !isdefined( var_6e8c4a470d8ac8b5 ) || var_6e8c4a470d8ac8b5 == "" )
        {
            break;
        }
        
        table_list[ table_list.size ] = var_6e8c4a470d8ac8b5;
    }
    
    level.nerf_list = table_list;
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x28f
// Size: 0x9
function initplayerprestige()
{
    init_nerf_scalar();
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x2a0
// Size: 0xaa
function init_nerf_scalar()
{
    nerf_scalars = [];
    nerf_scalars[ "nerf_take_more_damage" ] = 1;
    nerf_scalars[ "nerf_higher_threatbias" ] = 0;
    nerf_scalars[ "nerf_smaller_wallet" ] = 1;
    nerf_scalars[ "nerf_earn_less_money" ] = 1;
    nerf_scalars[ "nerf_lower_weapon_damage" ] = 1;
    nerf_scalars[ "nerf_no_class" ] = 0;
    nerf_scalars[ "nerf_pistols_only" ] = 0;
    nerf_scalars[ "nerf_fragile" ] = 1;
    nerf_scalars[ "nerf_move_slower" ] = 1;
    nerf_scalars[ "nerf_no_abilities" ] = 0;
    nerf_scalars[ "nerf_min_ammo" ] = 1;
    nerf_scalars[ "nerf_no_deployables" ] = 0;
    self.nerf_scalars = nerf_scalars;
    self.activated_nerfs = [];
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x352
// Size: 0x35
function nerf_based_on_selection()
{
    for ( var_7851cd80e78da43b = 0; var_7851cd80e78da43b < 10 ; var_7851cd80e78da43b++ )
    {
        selected_nerf = get_selected_nerf( var_7851cd80e78da43b );
        activate_nerf( selected_nerf );
    }
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 1
// Checksum 0x0, Offset: 0x38f
// Size: 0x37
function activate_nerf( reference )
{
    if ( is_no_nerf( reference ) )
    {
        return;
    }
    
    if ( nerf_already_activated( reference ) )
    {
        return;
    }
    
    register_nerf_activated( reference );
    [[ level.prestige_nerf_func[ reference ] ]]();
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 1
// Checksum 0x0, Offset: 0x3ce
// Size: 0x1b
function nerf_already_activated( reference )
{
    return scripts\engine\utility::array_contains( self.activated_nerfs, reference );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 1
// Checksum 0x0, Offset: 0x3f2
// Size: 0x21
function register_nerf_activated( reference )
{
    self.activated_nerfs[ self.activated_nerfs.size ] = reference;
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x41b
// Size: 0x10
function reduce_wallet_size_and_money_earned()
{
    reduce_wallet_size();
    reduce_money_earned();
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x433
// Size: 0x4, Type: bool
function is_relics_enabled()
{
    return true;
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 1
// Checksum 0x0, Offset: 0x440
// Size: 0x12, Type: bool
function is_no_nerf( reference )
{
    return reference == "none";
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x45b
// Size: 0xc
function get_num_nerf_selected()
{
    return self.activated_nerfs.size;
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x470
// Size: 0x2
function empty()
{
    
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x47a
// Size: 0x13
function increase_damage_scalar()
{
    set_nerf_scalar( "nerf_take_more_damage", 1.33 );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x495
// Size: 0x11
function increase_threatbias()
{
    set_nerf_scalar( "nerf_higher_threatbias", 500 );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x4ae
// Size: 0x13
function reduce_wallet_size()
{
    set_nerf_scalar( "nerf_smaller_wallet", 0.5 );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x4c9
// Size: 0x13
function reduce_money_earned()
{
    set_nerf_scalar( "nerf_earn_less_money", 0.75 );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x4e4
// Size: 0x13
function lower_weapon_damage()
{
    set_nerf_scalar( "nerf_lower_weapon_damage", 0.66 );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x4ff
// Size: 0x13
function no_class()
{
    set_nerf_scalar( "nerf_no_class", 1 );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x51a
// Size: 0x13
function pistols_only()
{
    set_nerf_scalar( "nerf_pistols_only", 1 );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x535
// Size: 0x13
function slow_health_regen()
{
    set_nerf_scalar( "nerf_fragile", 1.5 );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x550
// Size: 0x13
function move_slower()
{
    set_nerf_scalar( "nerf_move_slower", 0.7 );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x56b
// Size: 0x13
function no_abilities()
{
    set_nerf_scalar( "nerf_no_abilities", 1 );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x586
// Size: 0x13
function min_ammo()
{
    set_nerf_scalar( "nerf_min_ammo", 0.25 );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x5a1
// Size: 0x13
function no_deployables()
{
    set_nerf_scalar( "nerf_no_deployables", 1 );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 2
// Checksum 0x0, Offset: 0x5bc
// Size: 0x20
function set_nerf_scalar( field, value )
{
    self.nerf_scalars[ field ] = value;
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 1
// Checksum 0x0, Offset: 0x5e4
// Size: 0x16
function get_nerf_scalar( field )
{
    return self.nerf_scalars[ field ];
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 1
// Checksum 0x0, Offset: 0x603
// Size: 0xb
function get_selected_nerf( index )
{
    
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x616
// Size: 0xd
function prestige_getdamagetakenscalar()
{
    return get_nerf_scalar( "nerf_take_more_damage" );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x62c
// Size: 0xd
function prestige_getthreatbiasscalar()
{
    return get_nerf_scalar( "nerf_higher_threatbias" );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x642
// Size: 0xd
function prestige_getwalletsizescalar()
{
    return get_nerf_scalar( "nerf_smaller_wallet" );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x658
// Size: 0xd
function prestige_getmoneyearnedscalar()
{
    return get_nerf_scalar( "nerf_earn_less_money" );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x66e
// Size: 0xd
function prestige_getweapondamagescalar()
{
    return get_nerf_scalar( "nerf_lower_weapon_damage" );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x684
// Size: 0xd
function prestige_getnoclassallowed()
{
    return get_nerf_scalar( "nerf_no_class" );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x69a
// Size: 0xd
function prestige_getpistolsonly()
{
    return get_nerf_scalar( "nerf_pistols_only" );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x6b0
// Size: 0xd
function prestige_getslowhealthregenscalar()
{
    return get_nerf_scalar( "nerf_fragile" );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x6c6
// Size: 0xd
function prestige_getmoveslowscalar()
{
    return get_nerf_scalar( "nerf_move_slower" );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x6dc
// Size: 0xd
function prestige_getnoabilities()
{
    return get_nerf_scalar( "nerf_no_abilities" );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x6f2
// Size: 0xd
function prestige_getminammo()
{
    return get_nerf_scalar( "nerf_min_ammo" );
}

// Namespace cp_prestige / scripts\cp\perks\cp_prestige
// Params 0
// Checksum 0x0, Offset: 0x708
// Size: 0xd
function prestige_getnodeployables()
{
    return get_nerf_scalar( "nerf_no_deployables" );
}

