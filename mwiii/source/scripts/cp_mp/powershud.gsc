#using scripts\common\utility;
#using scripts\engine\utility;

#namespace powershud;

// Namespace powershud / scripts\cp_mp\powershud
// Params 0
// Checksum 0x0, Offset: 0x238
// Size: 0x1a6
function powershud_init()
{
    power_hud_info = spawnstruct();
    level.power_hud_info = power_hud_info;
    power_hud_info.omnvarnames = [ "primary", "secondary" ];
    power_hud_info.omnvarnames[ "primary" ][ 0 ] = "ui_power_num_charges";
    power_hud_info.omnvarnames[ "primary" ][ 1 ] = "ui_power_max_charges";
    power_hud_info.omnvarnames[ "primary" ][ 2 ] = "ui_power_recharge";
    power_hud_info.omnvarnames[ "primary" ][ 3 ] = "ui_power_id";
    power_hud_info.omnvarnames[ "primary" ][ 4 ] = "ui_power_consume";
    power_hud_info.omnvarnames[ "primary" ][ 5 ] = "ui_power_disabled";
    power_hud_info.omnvarnames[ "primary" ][ 6 ] = "ui_power_state";
    power_hud_info.omnvarnames[ "secondary" ][ 0 ] = "ui_power_secondary_num_charges";
    power_hud_info.omnvarnames[ "secondary" ][ 1 ] = "ui_power_secondary_max_charges";
    power_hud_info.omnvarnames[ "secondary" ][ 2 ] = "ui_power_secondary_recharge";
    power_hud_info.omnvarnames[ "secondary" ][ 3 ] = "ui_power_id_secondary";
    power_hud_info.omnvarnames[ "secondary" ][ 4 ] = "ui_power_secondary_consume";
    power_hud_info.omnvarnames[ "secondary" ][ 5 ] = "ui_power_secondary_disabled";
    power_hud_info.omnvarnames[ "secondary" ][ 6 ] = "ui_power_secondary_state";
}

// Namespace powershud / scripts\cp_mp\powershud
// Params 4
// Checksum 0x0, Offset: 0x3e6
// Size: 0x90
function powershud_assignpower( slot, power_id, fill_meter, charges )
{
    if ( slot == "scripted" )
    {
        return;
    }
    
    self setclientomnvar( powershud_getslotomnvar( slot, 3 ), power_id );
    meter_value = ter_op( fill_meter, 1000, 0 );
    self setclientomnvar( powershud_getslotomnvar( slot, 2 ), meter_value );
    
    if ( !isdefined( charges ) )
    {
        charges = 0;
    }
    
    self setclientomnvar( powershud_getslotomnvar( slot, 0 ), charges );
    self setclientomnvar( powershud_getslotomnvar( slot, 4 ), 0 );
}

// Namespace powershud / scripts\cp_mp\powershud
// Params 1
// Checksum 0x0, Offset: 0x47e
// Size: 0x5c
function powershud_clearpower( slot )
{
    if ( slot == "scripted" )
    {
        return;
    }
    
    self setclientomnvar( powershud_getslotomnvar( slot, 3 ), -1 );
    self setclientomnvar( powershud_getslotomnvar( slot, 2 ), -1 );
    self setclientomnvar( powershud_getslotomnvar( slot, 0 ), 0 );
    self setclientomnvar( powershud_getslotomnvar( slot, 4 ), -1 );
}

// Namespace powershud / scripts\cp_mp\powershud
// Params 2
// Checksum 0x0, Offset: 0x4e2
// Size: 0x28
function powershud_updatepowercharges( slot, charges )
{
    self setclientomnvar( powershud_getslotomnvar( slot, 0 ), int( charges ) );
}

// Namespace powershud / scripts\cp_mp\powershud
// Params 2
// Checksum 0x0, Offset: 0x512
// Size: 0x29
function powershud_updatepowermaxcharges( slot, maxcharges )
{
    self setclientomnvar( powershud_getslotomnvar( slot, 1 ), int( maxcharges ) );
}

// Namespace powershud / scripts\cp_mp\powershud
// Params 2
// Checksum 0x0, Offset: 0x543
// Size: 0x24
function powershud_updatepowerdrain( slot, var_bc08c87c9773ae0 )
{
    self setclientomnvar( powershud_getslotomnvar( slot, 4 ), var_bc08c87c9773ae0 );
}

// Namespace powershud / scripts\cp_mp\powershud
// Params 2
// Checksum 0x0, Offset: 0x56f
// Size: 0x29
function powershud_updatepowermeter( slot, meter_value )
{
    self setclientomnvar( powershud_getslotomnvar( slot, 2 ), int( meter_value ) );
}

// Namespace powershud / scripts\cp_mp\powershud
// Params 2
// Checksum 0x0, Offset: 0x5a0
// Size: 0x24
function powershud_updatepowerdisabled( slot, disabled )
{
    self setclientomnvar( powershud_getslotomnvar( slot, 5 ), disabled );
}

// Namespace powershud / scripts\cp_mp\powershud
// Params 2
// Checksum 0x0, Offset: 0x5cc
// Size: 0x3a
function powershud_updatepoweroffcooldown( slot, oncooldown )
{
    omnvarval = ter_op( oncooldown, 1, 0 );
    self setclientomnvar( powershud_getslotomnvar( slot, 6 ), omnvarval );
}

// Namespace powershud / scripts\cp_mp\powershud
// Params 2
// Checksum 0x0, Offset: 0x60e
// Size: 0x24
function powershud_updatepowerstate( slot, state )
{
    self setclientomnvar( powershud_getslotomnvar( slot, 6 ), state );
}

// Namespace powershud / scripts\cp_mp\powershud
// Params 1
// Checksum 0x0, Offset: 0x63a
// Size: 0x15
function powershud_beginpowerdrain( slot )
{
    powershud_updatepowerdrain( slot, 1 );
}

// Namespace powershud / scripts\cp_mp\powershud
// Params 1
// Checksum 0x0, Offset: 0x657
// Size: 0x14
function powershud_endpowerdrain( slot )
{
    powershud_updatepowerdrain( slot, 0 );
}

// Namespace powershud / scripts\cp_mp\powershud
// Params 2
// Checksum 0x0, Offset: 0x673
// Size: 0x3a
function powershud_beginpowercooldown( slot, var_df05da7990d6888f )
{
    powershud_updatepowermeter( slot, 0 );
    
    if ( isdefined( var_df05da7990d6888f ) && var_df05da7990d6888f )
    {
        powershud_updatepowerdisabled( slot, 1 );
    }
    
    powershud_updatepowerstate( slot, 1 );
}

// Namespace powershud / scripts\cp_mp\powershud
// Params 2
// Checksum 0x0, Offset: 0x6b5
// Size: 0x5f
function powershud_finishpowercooldown( slot, var_df05da7990d6888f )
{
    powershud_updatepowermeter( slot, 1000 );
    
    if ( isdefined( var_df05da7990d6888f ) && var_df05da7990d6888f )
    {
        powershud_updatepowerdisabled( slot, 0 );
    }
    
    if ( slot == "primary" )
    {
        self playlocalsound( "iw8_new_objective_sfx" );
    }
    else
    {
        self playlocalsound( "iw8_new_objective_sfx" );
    }
    
    powershud_updatepowerstate( slot, 0 );
}

// Namespace powershud / scripts\cp_mp\powershud
// Params 2
// Checksum 0x0, Offset: 0x71c
// Size: 0x20
function powershud_updatepowercooldown( slot, percent )
{
    powershud_updatepowermeter( slot, 1000 * percent );
}

// Namespace powershud / scripts\cp_mp\powershud
// Params 2
// Checksum 0x0, Offset: 0x744
// Size: 0x20
function powershud_updatepowerdrainprogress( slot, percent )
{
    powershud_updatepowermeter( slot, 1000 * percent );
}

// Namespace powershud / scripts\cp_mp\powershud
// Params 2
// Checksum 0x0, Offset: 0x76c
// Size: 0x84
function powershud_getslotomnvar( slot, omnvar_ref )
{
    if ( slot == "scripted" )
    {
        return;
    }
    
    assert( isdefined( level.power_hud_info ) );
    assert( isdefined( level.power_hud_info.omnvarnames ) );
    assert( isdefined( level.power_hud_info.omnvarnames[ slot ] ) );
    return level.power_hud_info.omnvarnames[ slot ][ omnvar_ref ];
}

