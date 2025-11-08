#using scripts\common\utility;
#using scripts\cp\agent_damage;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_loadout;
#using scripts\cp\cp_outline_utility;
#using scripts\cp\cp_powers;
#using scripts\cp\loot_system;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace cp_perks;

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x1283
// Size: 0x9
function initperks()
{
    init_core_mp_perks();
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x1294
// Size: 0x2b6
function init_each_perk()
{
    if ( !isdefined( level.health_scalar ) )
    {
        level.health_scalar = 1;
    }
    
    if ( level.gametype != "incursion" )
    {
        level.extra_charge_func = &should_give_extra_charge;
    }
    
    self.perk_data = [];
    self.perk_data[ "max_health" ] = 100 * level.health_scalar;
    self.perk_data[ "regen_time_scalar" ] = 1;
    self.perk_data[ "melee_scalar" ] = 1;
    self.perk_data[ "melee_stun_radius" ] = 0;
    self.perk_data[ "revive_time_scalar" ] = 1;
    self.perk_data[ "move_speed_scalar" ] = 1;
    self.perk_data[ "revive_damage_scalar" ] = 1;
    self.perk_data[ "explosive_damage_scalar" ] = 1;
    self.perk_data[ "offhand_count" ] = 1;
    self.perk_data[ "launcher_ammo" ] = 4;
    self.perk_data[ "friendly_explosive_damage_reduction" ] = 1;
    self.perk_data[ "enemy_explosive_damage_reduction" ] = 1;
    self.perk_data[ "bullet_damage_scalar" ] = 1;
    self.perk_data[ "stealth_dist_scalar" ] = 1;
    self.perk_data[ "stealth_velocity_override" ] = 0;
    self.perk_data[ "stealth_weapon_noise_scalar" ] = 1;
    self.perk_data[ "short_range_damage_scalar" ] = 1;
    self.perk_data[ "hipfire_damage_scalar" ] = 1;
    self.perk_data[ "sprint_damage_scalar" ] = 1;
    self.perk_data[ "carrying_melee_damage_scalar" ] = 1;
    self.perk_data[ "increased_materials" ] = 0;
    self.perk_data[ "increased_materials_wallet" ] = 0;
    self.perk_data[ "additional_crafting_items" ] = 0;
    self.perk_data[ "cheap_crafting_recipe" ] = 0;
    self.perk_data[ "increased_materials" ] = 0;
    self.perk_data[ "increased_materials_wallet" ] = 0;
    self.perk_data[ "additional_crafting_items" ] = 0;
    self.perk_data[ "cheap_crafting_recipe" ] = 0;
    self.perk_data[ "super_fill_scalar" ] = 1;
    self.perk_data[ "weapons_have_full_ammo" ] = 1;
    self.perk_data[ "enemy_damage_to_player_armor_scalar" ] = 1;
    self.perk_data[ "damage_to_enemy_armor_scalar" ] = 1;
    self.perk_data[ "hack_speed_boost" ] = 0;
    thread scripts\cp\agent_damage::track_consecutive_kills();
    init_class_changed_values();
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x1552
// Size: 0x5d
function init_class_changed_values()
{
    self setaimspreadmovementscale( 1 );
    self notify( "end_medic_health_regen" );
    
    if ( isdefined( self.old_view_kick ) )
    {
        self setviewkickscale( self.old_view_kick );
        self.old_view_kick = undefined;
    }
    
    if ( isdefined( self.old_recoil_scale ) )
    {
        self player_recoilscaleon( 100 );
        self.old_recoil_scale = undefined;
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x15b7
// Size: 0x26
function get_perk( string_key )
{
    if ( isdefined( self.perk_data[ string_key ] ) )
    {
        return self.perk_data[ string_key ];
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 2
// Checksum 0x0, Offset: 0x15e5
// Size: 0x2f
function set_perk( string_key, value )
{
    if ( isdefined( self.perk_data[ string_key ] ) )
    {
        self.perk_data[ string_key ] = value;
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x161c
// Size: 0x2
function blank()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x1626
// Size: 0x2d
function medic_speed_buff()
{
    self.perk_data[ "move_speed_scalar" ] = 1.12;
    self.movespeedscaler = 1.12;
    thread scripts\cp\cp_loadout::updatemovespeedscale();
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x165b
// Size: 0xd0
function medic_health_regen( dist_sqr )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "end_medic_health_regen" );
    self endon( "giving_class" );
    var_55edbc76cb692e0a = dist_sqr > 0;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player scripts\cp_mp\utility\player_utility::_isalive() && !isdefined( player.medic_regeneration ) )
            {
                if ( var_55edbc76cb692e0a && distancesquared( self.origin, player.origin ) > dist_sqr )
                {
                }
            }
        }
        
        wait 1;
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x1733
// Size: 0x56
function medic_regenerate_health_once()
{
    self endon( "death" );
    self endon( "disconnect" );
    self.medic_regeneration = 1;
    wait 1;
    self.health = int( min( self.maxhealth, self.health + 5 ) );
    self.medic_regeneration = undefined;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x1791
// Size: 0xc9
function should_give_extra_charge( power )
{
    if ( isdefined( power ) )
    {
        switch ( power )
        {
            case #"hash_329e33b158e9e263":
            case #"hash_497754f33560ac77":
            case #"hash_6644827d8700e5b4":
            case #"hash_79b8269b3b1d0fd3":
            case #"hash_80b21713df2fc1fb":
            case #"hash_8db6bf9ca54eb15b":
            case #"hash_a4bbe9e5a19b54c9":
            case #"hash_ae10efa2fe15642a":
            case #"hash_bf0fd8e6fe2267bb":
            case #"hash_c2475ed52898d56d":
            case #"hash_e327543aa379d322":
            case #"hash_e380bc2838d9b190":
                return self.perk_data[ "offhand_count" ];
            default:
                break;
        }
    }
    
    return undefined;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x1863
// Size: 0x77
function reload_on_kill()
{
    while ( true )
    {
        self waittill( "kill_score" );
        curweap = self getcurrentprimaryweapon();
        total_ammo = self getammocount( curweap );
        clip_size = int( min( total_ammo, weaponclipsize( curweap ) ) );
        remaining_stock = total_ammo - clip_size;
        self setweaponammoclip( curweap, clip_size );
        self setweaponammostock( curweap, remaining_stock );
        wait 0.1;
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x18e2
// Size: 0x44
function reduce_recoil()
{
    self.old_view_kick = self getviewkickscale();
    self.overchargeviewkickscale = 0;
    self.old_recoil_scale = self player_getrecoilscale();
    self player_recoilscaleon( 0 );
    self.onhelisniper = 1;
    scripts\cp\weapon::updateviewkickscale();
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x192e
// Size: 0x5f
function remove_reduce_recoil()
{
    if ( isdefined( self.old_recoil_scale ) )
    {
        if ( self.old_recoil_scale != -1 )
        {
            self player_recoilscaleon( self.old_recoil_scale );
        }
        else
        {
            self player_recoilscaleon( 100 );
        }
        
        self.old_recoil_scale = undefined;
    }
    
    self.overchargeviewkickscale = undefined;
    self.onhelisniper = undefined;
    scripts\cp\weapon::updateviewkickscale();
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x1995
// Size: 0x1a
function reduce_bullet_spread()
{
    giveperk( "specialty_bulletaccuracy" );
    self setaimspreadmovementscale( 0.1 );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x19b7
// Size: 0xaf
function run_deadeye_charge_watcher()
{
    self endon( "disconnect" );
    self endon( "end_deadeye_charge_watcher" );
    self endon( "giving_class" );
    self.deadeye_charge = undefined;
    var_f45f84783a1cc4d2 = undefined;
    var_bc4b686e2f1d19e2 = undefined;
    var_5c36fc93f90947f5 = 500;
    
    while ( true )
    {
        if ( self adsbuttonpressed() )
        {
            cur_time = gettime();
            
            if ( !isdefined( var_f45f84783a1cc4d2 ) )
            {
                var_f45f84783a1cc4d2 = cur_time;
                var_bc4b686e2f1d19e2 = cur_time + var_5c36fc93f90947f5;
            }
            else if ( cur_time > var_bc4b686e2f1d19e2 )
            {
                if ( istrue( self.deadeye_charge ) )
                {
                }
                
                self.deadeye_charge = 1;
            }
        }
        else
        {
            self.deadeye_charge = undefined;
            var_f45f84783a1cc4d2 = undefined;
            var_bc4b686e2f1d19e2 = undefined;
        }
        
        wait 0.05;
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x1a6e
// Size: 0x67f
function init_core_mp_perks()
{
    level.perksetfuncs = [];
    level.scriptperks = [];
    level.perksetfuncs = [];
    level.perkunsetfuncs = [];
    level.scriptperks[ "specialty_falldamage" ] = 1;
    level.scriptperks[ "specialty_armorpiercing" ] = 1;
    level.scriptperks[ "specialty_gung_ho" ] = 1;
    level.scriptperks[ "specialty_momentum" ] = 1;
    level.scriptperks[ "specialty_remote_defuse" ] = 1;
    level.perksetfuncs[ "specialty_momentum" ] = &setmomentum;
    level.perkunsetfuncs[ "specialty_momentum" ] = &unsetmomentum;
    level.perksetfuncs[ "specialty_falldamage" ] = &setfreefall;
    level.perkunsetfuncs[ "specialty_falldamage" ] = &unsetfreefall;
    level.perksetfuncs[ "specialty_remote_defuse" ] = &setremotedefuse;
    level.perkunsetfuncs[ "specialty_remote_defuse" ] = &unsetremotedefuse;
    level.scriptperks[ "specialty_hustle" ] = 1;
    level.extraperkmap[ "specialty_hustle" ] = [ "specialty_supersprint_enhanced", "specialty_fastcrouchmovement" ];
    level.scriptperks[ "specialty_bulletdamage" ] = 1;
    level.extraperkmap[ "specialty_bulletdamage" ] = [ "specialty_overcharge" ];
    level.perksetfuncs[ "specialty_overcharge" ] = &setovercharge;
    level.perkunsetfuncs[ "specialty_overcharge" ] = &unsetovercharge;
    registerscriptperk( "specialty_restock", undefined, undefined, [ "specialty_recharge_equipment" ] );
    registerscriptperk( "specialty_recharge_equipment", &give_restock, &take_restock );
    registerscriptperk( "specialty_tune_up", undefined, undefined, [ "specialty_improved_field_upgrades", "specialty_faster_field_upgrade" ] );
    registerscriptperk( "specialty_improved_field_upgrades" );
    registerscriptperk( "specialty_faster_field_upgrade", &give_tune_up, &take_tune_up );
    registerscriptperk( "specialty_quick_fix", undefined, undefined, [ "specialty_reduce_regen_delay_on_kill", "specialty_reduce_regen_delay_on_objective" ] );
    registerscriptperk( "specialty_reduce_regen_delay_on_kill", &setreduceregendelayonkills, &unsetreduceregendelayonkills );
    registerscriptperk( "specialty_reduce_regen_delay_on_objective", &setreduceregendelayonobjective, &unsetreduceregendelayonobjective );
    registerscriptperk( "specialty_hardline", &sethardline, &unsethardline );
    registerscriptperk( "specialty_warhead", &give_amped, &take_amped, [ "specialty_fastreload_launchers" ] );
    registerscriptperk( "specialty_fastreload_launchers", &setfastreloadlaunchers, &unsetfastreloadlaunchers );
    registerscriptperk( "specialty_munitions_2", undefined, undefined, [ "specialty_twoprimaries" ] );
    registerscriptperk( "specialty_twoprimaries", &setoverkill, &unsetoverkill, [] );
    registerscriptperk( "specialty_strategist", undefined, undefined, [ "specialty_killstreak_to_scorestreak" ] );
    registerscriptperk( "specialty_killstreak_to_scorestreak", &setkillstreaktoscorestreak, &unsetkillstreaktoscorestreak );
    registerscriptperk( "specialty_surveillance", undefined, undefined, [ "specialty_sixth_sense" ] );
    registerscriptperk( "specialty_sixth_sense", &setsixthsense, &unsetsixthsense );
    level thread sixthsense_think();
    registerscriptperk( "specialty_extra_shrapnel", undefined, undefined, [ "specialty_extra_deadly", "specialty_shrapnel" ] );
    registerscriptperk( "specialty_extra_deadly", &give_shrapnel, &take_shrapnel );
    registerscriptperk( "specialty_shrapnel" );
    registerscriptperk( "specialty_scavenger_plus", undefined, undefined, [ "specialty_scavenger" ] );
    registerscriptperk( "specialty_guerrilla", undefined, undefined, [ "specialty_ghost", "specialty_silentkill", "specialty_sixth_sense_immune", "specialty_heartbreaker" ] );
    registerscriptperk( "specialty_ghost", &setghost, &unsetghost, [ "specialty_gpsjammer" ] );
    registerscriptperk( "specialty_silentkill" );
    registerscriptperk( "specialty_sixth_sense_immune" );
    registerscriptperk( "specialty_tac_resist", undefined, undefined, [ "specialty_stun_resistance", "specialty_emp_resist", "specialty_gas_grenade_resist", "specialty_scrambler_resist" ] );
    registerscriptperk( "specialty_stun_resistance", &setstunresistance, &unsetstunresistance, [ "specialty_hard_shell" ] );
    registerscriptperk( "specialty_emp_resist" );
    registerscriptperk( "specialty_hard_shell", &sethardshell, &unsethardshell );
    registerscriptperk( "specialty_gas_grenade_resist", &setgasgrenaderesist, &unsetgasgrenaderesist );
    registerscriptperk( "specialty_scrambler_resist" );
    registerscriptperk( "specialty_covert_ops", undefined, undefined, [ "specialty_noscopeoutline", "specialty_coldblooded", "specialty_noplayertarget", "specialty_snapshot_immunity" ] );
    registercodeperkinfo( "specialty_blindeye", &setblindeye, &unsetblindeye );
    registerscriptperk( "specialty_noscopeoutline", &setnoscopeoutline, &unsetnoscopeoutline );
    registerscriptperk( "specialty_snapshot_immunity" );
    registerscriptperk( "specialty_heavy_metal", undefined, undefined, [ "specialty_chain_killstreaks" ] );
    registerscriptperk( "specialty_chain_killstreaks" );
    registerscriptperk( "specialty_tactical_recon", undefined, undefined, [ "specialty_engineer", "specialty_markequipment" ] );
    registerscriptperk( "specialty_engineer", &setengineer, &unsetengineer, [ "specialty_outlinekillstreaks" ] );
    registerscriptperk( "specialty_markequipment", &setmarkequipment, &unsetmarkequipment );
    registerscriptperk( "specialty_outlinekillstreaks", &setoutlinekillstreaks, &unsetoutlinekillstreaks );
    level thread set_mark_distances();
    registerscriptperk( "specialty_eod", undefined, undefined, [ "specialty_blastshield", "specialty_hack", "specialty_throwback", "specialty_shrapnel_resist" ] );
    registerscriptperk( "specialty_blastshield", &setblastshield, &unsetblastshield );
    registerscriptperk( "specialty_hack" );
    registerscriptperk( "specialty_shrapnel_resist" );
    registerscriptperk( "specialty_huntmaster", undefined, undefined, [ "specialty_tracker", "specialty_kill_report" ] );
    registerscriptperk( "specialty_tracker", &settracker, &unsettracker, [ "specialty_tracker_pro" ] );
    registerscriptperk( "specialty_kill_report" );
    registerscriptperk( "specialty_ammo_disabling" );
    registerscriptperk( "specialty_viewkickoverride", &setviewkickoverride, &unsetviewkickoverride );
    registerscriptperk( "specialty_delayhealing" );
    registerscriptperk( "specialty_hardmelee", &set_heavy_hitter, &unset_heavy_hitter );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 4
// Checksum 0x0, Offset: 0x20f5
// Size: 0x30
function registerscriptperk( perkname, setfunc, unsetfunc, extraperkmap )
{
    registerperk( perkname, 1, setfunc, unsetfunc, extraperkmap );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 4
// Checksum 0x0, Offset: 0x212d
// Size: 0x2f
function registercodeperkinfo( perkname, setfunc, unsetfunc, extraperkmap )
{
    registerperk( perkname, 0, setfunc, unsetfunc, extraperkmap );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 5
// Checksum 0x0, Offset: 0x2164
// Size: 0xc9
function registerperk( perkname, var_9aa715f8120f5692, setfunc, unsetfunc, extraperkmap )
{
    assert( isdefined( perkname ) );
    assert( !isdefined( level.scriptperks[ perkname ] ), "Cannot register two perks to the name: " + perkname );
    
    if ( istrue( var_9aa715f8120f5692 ) )
    {
        level.scriptperks[ perkname ] = 1;
    }
    
    if ( isdefined( setfunc ) )
    {
        assert( isfunction( setfunc ) );
        level.perksetfuncs[ perkname ] = setfunc;
    }
    
    if ( isdefined( unsetfunc ) )
    {
        assert( isfunction( unsetfunc ) );
        level.perkunsetfuncs[ perkname ] = unsetfunc;
    }
    
    if ( isdefined( extraperkmap ) )
    {
        assert( isarray( extraperkmap ) );
        level.extraperkmap[ perkname ] = extraperkmap;
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2235
// Size: 0x10
function setovercharge()
{
    self setclientomnvar( "ui_overcharge", 1 );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x224d
// Size: 0xf
function unsetovercharge()
{
    self setclientomnvar( "ui_overcharge", 0 );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2264
// Size: 0x2
function setfreefall()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x226e
// Size: 0x2
function unsetfreefall()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2278
// Size: 0x2
function setremotedefuse()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2282
// Size: 0x2
function unsetremotedefuse()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x228c
// Size: 0x10
function sethardshell()
{
    self.shellshockreduction = 0.25;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x22a4
// Size: 0xc
function unsethardshell()
{
    self.shellshockreduction = 0;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x22b8
// Size: 0xc
function setgasgrenaderesist()
{
    if ( scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return;
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x22cc
// Size: 0xc
function unsetgasgrenaderesist()
{
    if ( scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return;
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x22e0
// Size: 0x2
function setreduceregendelayonkills()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x22ea
// Size: 0x2
function unsetreduceregendelayonkills()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x22f4
// Size: 0x2
function setreduceregendelayonobjective()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x22fe
// Size: 0x2
function unsetreduceregendelayonobjective()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2308
// Size: 0x33
function sethardline()
{
    self endon( "death_or_disconnect" );
    self endon( "perk_end_hardline" );
    
    if ( is_specops_gametype() )
    {
        return;
    }
    
    thread run_kill_watcher();
    self.hardlineactive[ "assists" ] = 0;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2343
// Size: 0x14
function unsethardline()
{
    self.hardlineactive = undefined;
    self notify( "perk_end_hardline" );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x235f
// Size: 0x50
function run_kill_watcher()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "perk_end_hardline" );
    var_6d85d0102fd52796 = 7;
    
    while ( true )
    {
        if ( isdefined( self.consecutive_kills ) && self.consecutive_kills > var_6d85d0102fd52796 )
        {
            give_random_munition();
        }
        
        waitframe();
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x23b7
// Size: 0x4a
function give_random_munition()
{
    types = undefined;
    types = [ "brloot_munition_ammo", "brloot_munition_grenade_crate", "brloot_munition_armor" ];
    loot_type = random( types );
    scripts\cp\loot_system::give_munition( loot_type, self );
    wait 10;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2409
// Size: 0x2
function setfastreloadlaunchers()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2413
// Size: 0x2
function unsetfastreloadlaunchers()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x241d
// Size: 0x2
function setoverkill()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2427
// Size: 0x2
function unsetoverkill()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2431
// Size: 0x2
function setkillstreaktoscorestreak()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x243b
// Size: 0x2
function unsetkillstreaktoscorestreak()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2445
// Size: 0x36e
function sixthsense_think_internal()
{
    tracecontents = scripts\engine\trace::create_default_contents( 1 );
    sixthsensedebug = 0;
    
    /#
        sixthsensedebug = getdvarint( @"hash_3a87475a75de0350" ) == 1;
    #/
    
    process = 0;
    tootherplayer = undefined;
    var_746071ab06f38fd = undefined;
    time = getsystemtimeinmicroseconds();
    
    foreach ( num, player in level.sixth_sense_players )
    {
        if ( !isdefined( player ) )
        {
            level.sixth_sense_players[ num ] = undefined;
            break;
        }
        
        sightmask = 0;
        playerpos = player geteye();
        playerteam = player.team;
        playeraim = anglestoforward( player getplayerangles() );
        
        if ( istrue( player.ignoreme ) || istrue( player.notarget ) )
        {
            continue;
        }
        
        foreach ( otherplayer in level.spawned_enemies )
        {
            if ( process >= 25 )
            {
                process = 0;
                waitframe();
            }
            
            if ( !isdefined( player ) )
            {
                level.sixth_sense_players[ num ] = undefined;
                break;
            }
            
            if ( !player _hasperk( "specialty_sixth_sense" ) )
            {
                continue;
            }
            
            if ( istrue( player.ignoreme ) || istrue( player.notarget ) )
            {
                continue;
            }
            
            if ( !player scripts\cp_mp\utility\player_utility::_isalive() )
            {
                continue;
            }
            
            if ( !isdefined( otherplayer ) )
            {
                continue;
            }
            
            if ( !otherplayer scripts\cp_mp\utility\player_utility::_isalive() )
            {
                continue;
            }
            
            if ( istrue( otherplayer.ignoreall ) )
            {
                continue;
            }
            
            if ( otherplayer.team == playerteam )
            {
                continue;
            }
            
            if ( distancesquared( otherplayer.origin, playerpos ) > 16000000 )
            {
                continue;
            }
            
            if ( !otherplayer is_enemy_dangerous( player ) )
            {
                continue;
            }
            
            if ( isdefined( otherplayer.vehicle ) )
            {
                continue;
            }
            
            process++;
            otherplayerpos = otherplayer geteye();
            var_ed6e173aa5e562a5 = anglestoforward( otherplayer getplayerangles() );
            fromotherplayer = playerpos - otherplayerpos;
            tootherplayer = otherplayerpos - playerpos;
            dot = vectordot( fromotherplayer, var_ed6e173aa5e562a5 );
            
            if ( dot <= 0 )
            {
                continue;
            }
            
            var_97f0985016aa48cb = 0.984808;
            var_33e2af87c7b68ce8 = length( fromotherplayer );
            
            if ( dot < var_97f0985016aa48cb * var_33e2af87c7b68ce8 )
            {
                continue;
            }
            
            dot = vectordot( playeraim, vectornormalize( tootherplayer ) );
            
            if ( dot < 0.382683 )
            {
                process += 2;
                
                if ( scripts\engine\trace::ray_trace_detail_passed( otherplayerpos, playerpos, player, tracecontents ) )
                {
                    /#
                        if ( sixthsensedebug )
                        {
                            thread draw_line_for_time( otherplayerpos, playerpos, 0, 0, 1, 0.2 );
                        }
                    #/
                    
                    sightmask |= player getsixthsensedirection( otherplayer );
                    break;
                }
            }
            
            /#
                if ( sixthsensedebug )
                {
                    thread draw_line_for_time( otherplayerpos, playerpos, 1, 0, 0, 0.2 );
                }
            #/
        }
        
        player updatesixthsensevfx( sightmask );
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x27bb
// Size: 0xc9, Type: bool
function is_enemy_dangerous( player )
{
    if ( istrue( self.juggernaut ) )
    {
        return true;
    }
    
    if ( isdefined( self.unittype ) && self.unittype == "suicidebomber" )
    {
        return true;
    }
    
    objweapon = self.weapon;
    weapongroup = scripts\cp\weapon::getweapongroup( objweapon );
    
    switch ( weapongroup )
    {
        case #"hash_47368bc0d2ef1565":
        case #"hash_9d18adab1b65a661":
        case #"hash_c095d67337b1f5a1":
            return true;
        case #"hash_16cf6289ab06bd30":
            if ( distancesquared( self.origin, player.origin ) > 160000 )
            {
                return true;
            }
            
            break;
    }
    
    return false;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x288d
// Size: 0x1c
function sixthsense_think()
{
    level.sixth_sense_players = [];
    
    while ( true )
    {
        waitframe();
        sixthsense_think_internal();
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x28b1
// Size: 0x3c
function setsixthsense()
{
    self.sixthsenselastactivetime = 0;
    self.sixthsensestate = 0;
    updatesixthsensevfx( 0 );
    playernum = self getentitynumber();
    level.sixth_sense_players[ playernum ] = self;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x28f5
// Size: 0x4c
function unsetsixthsense()
{
    updatesixthsensevfx( 0 );
    self.sixthsenselastactivetime = undefined;
    self.sixthsensestate = undefined;
    self.sixthsensesource = undefined;
    self notify( "removeSixthSense" );
    playernum = self getentitynumber();
    level.sixth_sense_players[ playernum ] = undefined;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x2949
// Size: 0xb
function updatesixthsensevfx( sightmask )
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x295c
// Size: 0x13d
function getsixthsensedirection( enemy )
{
    forward = anglestoforward( self getplayerangles() );
    forward2d = ( forward[ 0 ], forward[ 1 ], forward[ 2 ] );
    forward2d = vectornormalize( forward2d );
    toenemy = enemy.origin - self.origin;
    toenemy2d = ( toenemy[ 0 ], toenemy[ 1 ], toenemy[ 2 ] );
    toenemy2d = vectornormalize( toenemy2d );
    dot = vectordot( forward2d, toenemy2d );
    
    if ( dot >= 0.92388 )
    {
        return 2;
    }
    
    if ( dot >= 0.5 )
    {
        return ter_op( utility::isleft2d( self.origin, forward2d, enemy.origin ), 4, 1 );
    }
    
    if ( dot >= 0.5 )
    {
        return ter_op( utility::isleft2d( self.origin, forward2d, enemy.origin ), 128, 64 );
    }
    
    if ( dot >= -0.707107 )
    {
        return ter_op( utility::isleft2d( self.origin, forward2d, enemy.origin ), 32, 8 );
    }
    
    return 16;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2aa1
// Size: 0x17
function setghost()
{
    self.perk_data[ "stealth_dist_scalar" ] = 0.5;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2ac0
// Size: 0x14
function unsetghost()
{
    self.perk_data[ "stealth_dist_scalar" ] = 1;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x2adc
// Size: 0x3d
function setstunresistance( power )
{
    if ( !isdefined( power ) )
    {
        power = 4;
    }
    
    power = int( power );
    
    if ( power == 10 )
    {
        self.stunscalar = 0;
        return;
    }
    
    self.stunscalar = power / 10;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2b21
// Size: 0xd
function unsetstunresistance()
{
    self.stunscalar = 1;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2b36
// Size: 0x2
function setblindeye()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2b40
// Size: 0x2
function unsetblindeye()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2b4a
// Size: 0x2
function setnoscopeoutline()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2b54
// Size: 0x2
function unsetnoscopeoutline()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2b5e
// Size: 0xa
function setengineer()
{
    thread engineer_enablemarksafterprematch();
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2b70
// Size: 0x2d
function engineer_enablemarksafterprematch()
{
    self endon( "unsetEngineer" );
    self enableentitymarks( "equipment", 1000000 );
    self.perkengineerset = 1;
    thread markedentities_think();
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2ba5
// Size: 0x2d
function unsetengineer()
{
    if ( istrue( self.perkengineerset ) )
    {
        self disableentitymarks( "equipment" );
        self.perkengineerset = undefined;
    }
    
    self notify( "unsetEngineer" );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2bda
// Size: 0x178
function allow_br_loot_to_br_marked()
{
    if ( !isdefined( level.teamdata ) )
    {
        level.teamdata = [];
    }
    
    if ( !isdefined( level.teamdata[ "allies" ] ) )
    {
        level.teamdata[ "allies" ] = [];
    }
    
    if ( !isdefined( level.teamdata[ "allies" ][ "players" ] ) )
    {
        level.teamdata[ "allies" ][ "players" ] = level.players;
    }
    
    var_792740c4c87cf9fa = getentitylessscriptablearray( undefined, undefined, self.origin, 2000 );
    
    foreach ( thing in var_792740c4c87cf9fa )
    {
        if ( issubstr( thing.type, "brloot_munition" ) )
        {
            thing.fake_model = spawn( "script_model", thing.origin );
            thing.fake_model.angles = thing.angles;
            thing.fake_model setmodel( "container_ammo_box_01_nophysics_cp" );
            thing.fake_model enableplayermarks( "equipment" );
            scripts\cp\cp_outline_utility::outlineenableforplayer( thing.fake_model, self, "spotter_notarget_equipment", "perk" );
        }
        
        waitframe();
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2d5a
// Size: 0x179
function make_sure_loot_is_visible()
{
    var_7507f409fee2b657 = [ "brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos" ];
    
    foreach ( name in var_7507f409fee2b657 )
    {
        var_792740c4c87cf9fa = getentitylessscriptablearray( undefined, undefined, undefined, undefined, name );
        count = 0;
        
        foreach ( br_loot in var_792740c4c87cf9fa )
        {
            br_loot setscriptablepartstate( name, "visible" );
            count++;
            
            if ( count % 20 )
            {
                wait 0.1;
            }
        }
        
        wait 0.1;
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2edb
// Size: 0xb5
function make_outline_ents()
{
    var_58a11d31a3c59e82 = 10;
    level.outline_ents = [];
    level.outline_ent_index = [];
    
    for ( i = 0; i < var_58a11d31a3c59e82 ; i++ )
    {
        level.outline_ents[ i ] = spawn( "script_model", ( 0, 0, 0 ) );
        level.outline_ents[ i ].angles = ( 0, 0, 0 );
        level.outline_ents[ i ] setmodel( "container_ammo_box_01_nophysics_cp" );
        level.outline_ents[ i ] enableplayermarks( "equipment" );
    }
    
    thread monitor_outline_ents();
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2f98
// Size: 0x2c
function monitor_outline_ents()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        if ( _hasperk( "specialty_engineer" ) )
        {
            get_closest_munitions();
        }
        
        wait 0.1;
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x2fcc
// Size: 0x339
function get_closest_munitions()
{
    var_b69312781edc9ea6 = 1000;
    var_58a11d31a3c59e82 = 10;
    var_7507f409fee2b657 = [ "brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos" ];
    var_1d88cbbb14926330 = [];
    
    foreach ( name in var_7507f409fee2b657 )
    {
        var_792740c4c87cf9fa = getentitylessscriptablearray( undefined, undefined, self.origin, var_b69312781edc9ea6, name );
        
        foreach ( br_loot in var_792740c4c87cf9fa )
        {
            var_1d88cbbb14926330[ var_1d88cbbb14926330.size ] = br_loot;
        }
    }
    
    var_1d88cbbb14926330 = sortbydistance( var_1d88cbbb14926330, self.origin );
    var_93dff4684377d4c0 = level.outline_ents;
    skip_list = [];
    new_list = [];
    
    for ( i = 0; i < var_1d88cbbb14926330.size ; i++ )
    {
        if ( !isdefined( level.outline_ent_index[ var_1d88cbbb14926330[ i ].index ] ) )
        {
            new_list[ new_list.size ] = var_1d88cbbb14926330[ i ];
        }
    }
    
    if ( new_list.size > 0 )
    {
        outline_ent_index = 0;
        
        for ( i = 0; i < min( new_list.size, var_58a11d31a3c59e82 ) ; i++ )
        {
            for ( j = 0; j < level.outline_ents.size ; j++ )
            {
                if ( isdefined( skip_list[ j ] ) )
                {
                    continue;
                }
                
                if ( isdefined( level.outline_ents[ j ] ) )
                {
                    level.outline_ents[ j ] dontinterpolate();
                }
                
                level.outline_ents[ j ].origin = new_list[ i ].origin;
                level.outline_ents[ j ].angles = new_list[ i ].angles;
                level.outline_ents[ j ].index = new_list[ i ].index;
                level.outline_ent_index[ level.outline_ents[ j ].index ] = undefined;
                level.outline_ent_index[ new_list[ i ].index ] = level.outline_ents[ j ];
                unmarkent( level.outline_ents[ j ] );
                skip_list[ j ] = new_list[ i ];
                break;
            }
        }
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x330d
// Size: 0x50
function unmarkent( markedent )
{
    markedent filterinplayermarks( undefined );
    self.markequipmentstate.markedents = array_remove( self.markequipmentstate.markedents, markedent );
    markedent notify( "unmarkEnt_" + self getentitynumber() );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x3365
// Size: 0x11
function setmarkequipment()
{
    self enabletargetmarks();
    thread markequipment_monitorlook();
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x337e
// Size: 0x88
function unsetmarkequipment()
{
    if ( isdefined( self.markequipmentstate ) )
    {
        foreach ( ent in self.markequipmentstate.markedents )
        {
            if ( isdefined( ent ) )
            {
                unmarkent( ent );
            }
        }
    }
    
    self.markequipmentstate = undefined;
    self disabletargetmarks();
    self notify( "mark_equip_ended" );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x340e
// Size: 0x124
function markequipment_monitorlook()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "mark_equip_ended" );
    
    if ( !isdefined( self.markequipmentstate ) )
    {
        self.markequipmentstate = spawnstruct();
        self.markequipmentstate.markingtime = 0;
        self.markequipmentstate.markingent = undefined;
        self.markequipmentstate.markedents = [];
        self.markequipmentstate.markedentindex = 0;
        self.markequipmentstate.pastmarkedents = [];
        self.markequipmentstate.pastmarkedentindex = 0;
    }
    
    while ( true )
    {
        self waittill( "marks_target_changed", ent );
        startmarking = isdefined( ent ) && !isdefined( self.markequipmentstate.markingent );
        self.markequipmentstate.markingent = ent;
        self.markequipmentstate.markingtime = 0;
        
        if ( startmarking )
        {
            thread markequipment_updatestate();
        }
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x353a
// Size: 0x26
function set_mark_distances()
{
    level.see_air_killstreak_dist = 6000;
    level.see_killstreak_dist = 1500;
    level.see_equipment_dist = 1000;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x3568
// Size: 0x3db
function markequipment_updatestate()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "mark_equip_ended" );
    lasttime = gettime();
    maxdist = 0;
    
    if ( self entityhasmark( "air_killstreak", self.markequipmentstate.markingent ) )
    {
        maxdist = level.see_air_killstreak_dist;
    }
    else if ( self entityhasmark( "killstreak", self.markequipmentstate.markingent ) )
    {
        maxdist = level.see_killstreak_dist;
    }
    else if ( self entityhasmark( "equipment", self.markequipmentstate.markingent ) )
    {
        maxdist = level.see_equipment_dist;
    }
    else
    {
        assert( 0, "Marking Ent did not belong to one of these mark groups. Are we not taking one into account?" );
    }
    
    maxdistsqrd = maxdist * maxdist;
    
    while ( isdefined( self.markequipmentstate.markingent ) && !istrue( self.ishacking ) )
    {
        if ( self entitymarkfilteredin( self.markequipmentstate.markingent ) )
        {
            break;
        }
        
        if ( isdefined( self.vehicle ) && self.vehicle == self.markequipmentstate.markingent )
        {
            break;
        }
        
        if ( scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver( self ) )
        {
            break;
        }
        
        if ( distancesquared( self.origin, self.markequipmentstate.markingent.origin ) > maxdistsqrd )
        {
            break;
        }
        
        currenttime = gettime();
        deltatime = currenttime - lasttime;
        self.markequipmentstate.markingtime += deltatime;
        
        if ( !array_contains( self.markequipmentstate.markedents, self.markequipmentstate.markingent ) )
        {
            if ( isplayerads() )
            {
                markindex = self.markequipmentstate.markedentindex;
                ent = self.markequipmentstate.markedents[ markindex ];
                
                if ( isdefined( ent ) )
                {
                    ent filterinplayermarks( undefined );
                    outlinehelper_updateentityoutline( ent );
                }
                
                self.markequipmentstate.markingent filterinplayermarks( self.team );
                outlinehelper_updateentityoutline( self.markequipmentstate.markingent );
                self.markequipmentstate.markedents[ markindex ] = self.markequipmentstate.markingent;
                self.markequipmentstate.markedentindex = ( markindex + 1 ) % 999;
                
                if ( !array_contains( self.markequipmentstate.pastmarkedents, self.markequipmentstate.markingent ) )
                {
                    self.markequipmentstate.pastmarkedents[ self.markequipmentstate.pastmarkedentindex ] = self.markequipmentstate.markingent;
                    self.markequipmentstate.pastmarkedentindex++;
                }
                
                thread unmarkafterduration( self.markequipmentstate.markingent );
                break;
            }
        }
        
        lasttime = currenttime;
        waitframe();
    }
    
    if ( !istrue( self.ishacking ) )
    {
        self setclientomnvar( "ui_securing", 0 );
        self setclientomnvar( "ui_securing_progress", 0 );
    }
    
    self.markequipmentstate.markingent = undefined;
    self.markequipmentstate.markingtime = 0;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x394b
// Size: 0x50
function unmarkafterduration( markedent )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "mark_equip_ended" );
    self endon( "unmarkEnt_" + self getentitynumber() );
    wait getdvarint( @"hash_6a381b8385734e4e" );
    
    if ( isdefined( markedent ) && isdefined( self ) )
    {
        unmarkent( markedent );
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x39a3
// Size: 0x3c
function unmarkonownershipchange( markedent )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "mark_equip_ended" );
    self endon( "unmarkEnt_" + self getentitynumber() );
    
    while ( true )
    {
        wait 0.5;
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x39e7
// Size: 0x31
function outlinehelper_updateentityoutline( ent )
{
    if ( isdefined( ent ) )
    {
        entitynum = ent getentitynumber();
        outlinehelper_disableentityoutline( entitynum );
        outlinehelper_enableentityoutline( ent );
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x3a20
// Size: 0x32c
function outlinehelper_enableentityoutline( ent )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    entitynum = ent getentitynumber();
    entitydata = self.entityoutlines[ entitynum ];
    
    if ( isdefined( entitydata ) )
    {
        return;
    }
    
    outlinedata = undefined;
    
    if ( self entitymarkfilteredin( ent ) )
    {
        outlinedata = spawnstruct();
        outlinedata.prioritygroup = "perk_superior";
        outlinedata.hudoutlineassetname = "spotter_target";
        outlinehelper_verifydata( outlinedata );
    }
    
    ismarked = self entitymarkfilteredin( ent );
    
    if ( self entityhasmark( "air_killstreak", ent ) )
    {
        if ( !isdefined( ent.model ) )
        {
            return;
        }
        
        outlinedata = spawnstruct();
        
        if ( ismarked )
        {
            outlinedata.prioritygroup = "perk_superior";
            outlinedata.hudoutlineassetname = "spotter_target_killstreak_air";
        }
        else
        {
            outlinedata.prioritygroup = "perk";
            outlinedata.hudoutlineassetname = "spotter_notarget_killstreak_air";
        }
        
        outlinehelper_verifydata( outlinedata );
    }
    else if ( self entityhasmark( "killstreak", ent ) )
    {
        if ( !isdefined( ent.model ) )
        {
            return;
        }
        
        outlinedata = spawnstruct();
        
        if ( ismarked )
        {
            outlinedata.prioritygroup = "perk_superior";
            outlinedata.hudoutlineassetname = "spotter_target_killstreak";
        }
        else
        {
            outlinedata.prioritygroup = "perk";
            outlinedata.hudoutlineassetname = "spotter_notarget_killstreak";
        }
        
        outlinehelper_verifydata( outlinedata );
    }
    else if ( self entityhasmark( "equipment", ent ) )
    {
        if ( isdefined( ent.equipmentref ) && ent.equipmentref == "equip_tac_cover" )
        {
            return;
        }
        
        outlinedata = spawnstruct();
        
        if ( ismarked )
        {
            outlinedata.prioritygroup = "perk_superior";
            outlinedata.hudoutlineassetname = "spotter_target_equipment";
        }
        else
        {
            outlinedata.prioritygroup = "perk";
            outlinedata.hudoutlineassetname = "spotter_notarget_equipment";
        }
        
        outlinehelper_verifydata( outlinedata );
    }
    
    if ( isdefined( outlinedata ) )
    {
        entitydata = spawnstruct();
        self.entityoutlines[ entitynum ] = entitydata;
        entitydata.list = [];
        entitydata.ent = ent;
        childents = getchildoutlineents( ent );
        
        foreach ( child in childents )
        {
            entoutlineid = scripts\cp\cp_outline_utility::outlineenableforplayer( child, self, outlinedata.hudoutlineassetname, outlinedata.prioritygroup );
            outline = spawnstruct();
            outline.ent = child;
            outline.id = entoutlineid;
            childnum = child getentitynumber();
            entitydata.list[ childnum ] = outline;
        }
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x3d54
// Size: 0x33
function getchildoutlineents( ent )
{
    if ( !isdefined( ent ) )
    {
        return [];
    }
    
    if ( !isdefined( ent.childoutlineents ) )
    {
        return [ ent ];
    }
    
    return ent.childoutlineents;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x3d90
// Size: 0xb6
function outlinehelper_verifydata( outlinedata )
{
    assert( isdefined( outlinedata ) );
    
    if ( !isdefined( outlinedata.getplayers ) )
    {
        outlinedata.getplayers = &outlinehelper_getallplayers;
    }
    
    if ( !isdefined( outlinedata.validplayer ) )
    {
        outlinedata.validplayer = &outlinehelper_validplayer;
    }
    
    if ( !isdefined( outlinedata.hudoutlineassetname ) )
    {
        outlinedata.hudoutlineassetname = "spotter_notarget";
    }
    
    if ( !isdefined( outlinedata.prioritygroup ) )
    {
        outlinedata.prioritygroup = "perk";
    }
    
    if ( !isdefined( outlinedata.waittime ) )
    {
        outlinedata.waittime = 0.1;
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 2
// Checksum 0x0, Offset: 0x3e4e
// Size: 0x1c
function outlinehelper_getallplayers( ent, outlinedata )
{
    return level.players;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x3e73
// Size: 0xd, Type: bool
function outlinehelper_validplayer( player )
{
    return true;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x3e89
// Size: 0x9e
function outlinehelper_disableentityoutline( entnum )
{
    if ( isdefined( entnum ) )
    {
        entitydata = self.entityoutlines[ entnum ];
        
        if ( isdefined( entitydata ) )
        {
            foreach ( outline in entitydata.list )
            {
                scripts\cp\cp_outline_utility::outlinedisable( outline.id, outline.ent );
            }
            
            self.entityoutlines[ entnum ] = undefined;
        }
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x3f2f
// Size: 0xa
function setoutlinekillstreaks()
{
    thread outlinekillstreaks_enablemarksafterprematch();
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x3f41
// Size: 0x36
function outlinekillstreaks_enablemarksafterprematch()
{
    self endon( "unsetOutlineKillstreak" );
    self enableentitymarks( "killstreak", 1000000 );
    self enableentitymarks( "air_killstreak", 1000000 );
    self.perkoutlinekillstreaksset = 1;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x3f7f
// Size: 0x39
function unsetoutlinekillstreaks()
{
    if ( istrue( self.perkoutlinekillstreaksset ) )
    {
        self disableentitymarks( "killstreak" );
        self disableentitymarks( "air_killstreak" );
        self.perkoutlinekillstreaksset = undefined;
    }
    
    self notify( "unsetOutlineKillstreak" );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 2
// Checksum 0x0, Offset: 0x3fc0
// Size: 0x84
function markedentities_removeentsbyindex( entarray, var_223829bbefc81935 )
{
    resultarray = [];
    
    foreach ( ent in entarray )
    {
        entnum = ent getentitynumber();
        
        if ( !array_contains( var_223829bbefc81935, entnum ) )
        {
            resultarray[ resultarray.size ] = ent;
        }
    }
    
    return resultarray;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x404d
// Size: 0x1cb
function markedentities_think()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self.entityoutlines = [];
    
    while ( true )
    {
        self waittill( "marks_changed", var_b56ac8b012f37095, var_7b50cc9c94be9505, var_c5dda6b7a37d4129 );
        
        if ( isdefined( var_b56ac8b012f37095 ) )
        {
            foreach ( var_e0abeaa6ef08e178 in var_b56ac8b012f37095 )
            {
                outlinehelper_disableentityoutline( var_e0abeaa6ef08e178 );
            }
            
            if ( isdefined( self.markequipmentstate ) )
            {
                self.markequipmentstate.markedents = markedentities_removeentsbyindex( self.markequipmentstate.markedents, var_b56ac8b012f37095 );
                
                if ( self.markequipmentstate.markedentindex > self.markequipmentstate.markedents.size )
                {
                    self.markequipmentstate.markedentindex = self.markequipmentstate.markedents.size;
                }
            }
        }
        
        if ( isdefined( var_7b50cc9c94be9505 ) )
        {
            foreach ( var_4905d157180507c8 in var_7b50cc9c94be9505 )
            {
                outlinehelper_disableentityoutline( var_4905d157180507c8 );
            }
        }
        
        if ( isdefined( var_c5dda6b7a37d4129 ) )
        {
            foreach ( addedent in var_c5dda6b7a37d4129 )
            {
                outlinehelper_enableentityoutline( addedent );
            }
        }
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x4220
// Size: 0x13
function setblastshield()
{
    set_perk( "enemy_explosive_damage_reduction", 0.5 );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x423b
// Size: 0x10
function unsetblastshield()
{
    set_perk( "enemy_explosive_damage_reduction", 1 );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x4253
// Size: 0x12
function settracker()
{
    thread runtrackkillstreakuse();
    thread run_track_enemy_patrollers();
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x426d
// Size: 0xa
function unsettracker()
{
    self notify( "tracker_removed" );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x427f
// Size: 0x4b
function runtrackkillstreakuse()
{
    self endon( "death_or_disconnect" );
    self endon( "track_killstreak_end" );
    
    while ( true )
    {
        if ( isusingremote() )
        {
            waitframe();
            takeperk( "specialty_tracker" );
            
            while ( isusingremote() )
            {
                waitframe();
            }
            
            giveperk( "specialty_tracker" );
            break;
        }
        
        waitframe();
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x42d2
// Size: 0x222
function run_track_enemy_patrollers()
{
    self endon( "death_or_disconnect" );
    self endon( "tracker_removed" );
    tracker_fov = cos( 70 );
    var_820e590cb5620371 = 0;
    self.view_list = [];
    self.outlineids = [];
    var_2ab4eb5f9bf4dd77 = 5000;
    
    while ( true )
    {
        enemy_list = level.spawned_enemies;
        
        foreach ( guy in enemy_list )
        {
            if ( var_820e590cb5620371 >= 20 )
            {
                var_820e590cb5620371 = 0;
                waitframe();
            }
            
            if ( !isdefined( guy ) )
            {
                continue;
            }
            
            if ( guy scripts\cp\coop_stealth::should_run_sp_stealth() )
            {
                if ( isdefined( guy.fnisinstealthcombat ) && guy [[ guy.fnisinstealthcombat ]]() )
                {
                    continue;
                }
            }
            else if ( isdefined( guy.current_stealth_state ) )
            {
                if ( guy.current_stealth_state != "casual" && guy.current_stealth_state != "alert" )
                {
                    continue;
                }
            }
            else
            {
                continue;
            }
            
            var_820e590cb5620371++;
            entnum = guy getentitynumber();
            var_25ab57d46f5f99f9 = within_fov( self geteye(), self getplayerangles(), guy.origin, tracker_fov );
            
            if ( !var_25ab57d46f5f99f9 )
            {
                continue;
            }
            
            passed = sighttracepassed( self geteye(), guy geteye(), 0, undefined );
            
            if ( !passed )
            {
                if ( isdefined( self.view_list[ entnum ] ) )
                {
                    cur_time = gettime();
                    var_77c5b5dd30fc2909 = cur_time - var_2ab4eb5f9bf4dd77;
                    
                    if ( self.view_list[ entnum ] < var_77c5b5dd30fc2909 )
                    {
                    }
                    else
                    {
                        guy add_outline( entnum, self );
                        guy thread untrack_enemy( self, 5 );
                    }
                }
                
                continue;
            }
            
            cur_time = gettime();
            self.view_list[ entnum ] = cur_time;
            guy remove_outline( entnum, self );
        }
        
        var_820e590cb5620371 = 0;
        waitframe();
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 2
// Checksum 0x0, Offset: 0x44fc
// Size: 0x44
function add_outline( entnum, player )
{
    if ( !isdefined( player.outlineids[ entnum ] ) )
    {
        player.outlineids[ entnum ] = scripts\cp\cp_outline_utility::outlineenableforplayer( self, player, "snapshotgrenade", "equipment" );
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 2
// Checksum 0x0, Offset: 0x4548
// Size: 0x36
function untrack_enemy( player, timer )
{
    self endon( "track_enemy" );
    entnum = self getentitynumber();
    wait timer;
    remove_outline( entnum, player );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 2
// Checksum 0x0, Offset: 0x4586
// Size: 0x4e
function remove_outline( entnum, player )
{
    outlineid = player.outlineids[ entnum ];
    
    if ( isdefined( outlineid ) )
    {
        scripts\cp\cp_outline_utility::outlinedisable( outlineid, self );
        player.outlineids[ entnum ] = undefined;
    }
    
    self notify( "track_enemy" );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x45dc
// Size: 0x41
function setviewkickoverride()
{
    self.overrideviewkickscale = 0.5;
    self.overrideviewkickscaledmr = 0.5;
    self.overrideviewkickscalesniper = 0.5;
    self.overrideviewkickscalepistol = 0.5;
    scripts\cp\weapon::updateviewkickscale();
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x4625
// Size: 0x31
function unsetviewkickoverride()
{
    self.overrideviewkickscale = undefined;
    self.overrideviewkickscaledmr = undefined;
    self.overrideviewkickscalesniper = undefined;
    self.overrideviewkickscalepistol = undefined;
    scripts\cp\weapon::updateviewkickscale();
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x465e
// Size: 0x14
function set_heavy_hitter()
{
    self.perk_data[ "melee_scalar" ] = 2;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x467a
// Size: 0x14
function unset_heavy_hitter()
{
    self.perk_data[ "melee_scalar" ] = 1;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x4696
// Size: 0x13
function give_tune_up()
{
    set_perk( "super_fill_scalar", 1.3 );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x46b1
// Size: 0x10
function take_tune_up()
{
    set_perk( "super_fill_scalar", 1 );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x46c9
// Size: 0xc
function give_restock()
{
    thread recharge_lethals_over_time( 60 );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x46dd
// Size: 0xa
function take_restock()
{
    self notify( "take_restock" );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x46ef
// Size: 0xd0
function recharge_lethals_over_time( timer )
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "take_restock" );
    thread reset_restock_flag();
    thread reset_recharge_after_respawn();
    
    while ( true )
    {
        self waittill( "grenade_fire", grenade, objweapon, tickpercent, originalowner );
        var_d690ef8fdb341e60 = get_weapon_in_power_slot( self, "primary" );
        
        if ( objweapon.basename == var_d690ef8fdb341e60 )
        {
            thread delay_give_lethal_grenade( self, timer );
        }
        
        var_ddca460ea9f6d6c5 = get_weapon_in_power_slot( self, "secondary" );
        
        if ( objweapon.basename == var_ddca460ea9f6d6c5 )
        {
            thread delay_give_tactical_grenade( self, timer );
        }
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x47c7
// Size: 0x4d
function reset_restock_flag()
{
    level endon( "game_ended" );
    self waittill( "take_restock" );
    self.waiting_for_tactical_restock = 0;
    self.waiting_for_lethal_restock = 0;
    self setclientomnvar( "ui_recharge_notify", -1 );
    self setclientomnvar( "ui_lethal_recharge_progress", 0 );
    self setclientomnvar( "ui_tactical_recharge_progress", 0 );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x481c
// Size: 0x71
function reset_recharge_after_respawn()
{
    level endon( "game_ended" );
    self endon( "take_restock" );
    timer = 60;
    self waittill( "landed_after_respawn" );
    
    if ( get_power_charges_in_slot( self, "primary" ) < get_power_max_charge_in_slot( self, "primary" ) )
    {
        thread delay_give_lethal_grenade( self, timer );
    }
    
    if ( get_power_charges_in_slot( self, "secondary" ) < get_power_max_charge_in_slot( self, "secondary" ) )
    {
        thread delay_give_tactical_grenade( self, timer );
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 2
// Checksum 0x0, Offset: 0x4895
// Size: 0xc2
function delay_give_lethal_grenade( player, timer )
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "take_restock" );
    self endon( "stop_restock_recharge" );
    
    if ( istrue( player.waiting_for_lethal_restock ) )
    {
        return;
    }
    
    thread stop_restock_recharge( "ui_lethal_recharge_progress", "primary" );
    player.waiting_for_lethal_restock = 1;
    update_restock_ui( "ui_lethal_recharge_progress", timer, 0 );
    player.waiting_for_lethal_restock = 0;
    player scripts\cp\cp_powers::power_addammo( get_power_name_in_slot( player, "primary" ), 1 );
    
    if ( get_power_charges_in_slot( player, "primary" ) < get_power_max_charge_in_slot( player, "primary" ) )
    {
        player thread delay_give_lethal_grenade( self, timer );
        return;
    }
    
    player notify( "restock_done" );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 2
// Checksum 0x0, Offset: 0x495f
// Size: 0xc3
function delay_give_tactical_grenade( player, timer )
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "take_restock" );
    self endon( "stop_restock_recharge" );
    
    if ( istrue( player.waiting_for_tactical_restock ) )
    {
        return;
    }
    
    thread stop_restock_recharge( "ui_tactical_recharge_progress", "secondary" );
    player.waiting_for_tactical_restock = 1;
    update_restock_ui( "ui_tactical_recharge_progress", timer, 1 );
    player.waiting_for_tactical_restock = 0;
    player scripts\cp\cp_powers::power_addammo( get_power_name_in_slot( player, "secondary" ), 1 );
    
    if ( get_power_charges_in_slot( player, "secondary" ) < get_power_max_charge_in_slot( player, "secondary" ) )
    {
        player thread delay_give_tactical_grenade( self, timer );
        return;
    }
    
    player notify( "restock_done" );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 3
// Checksum 0x0, Offset: 0x4a2a
// Size: 0xcd
function update_restock_ui( omnvar, timer, slot )
{
    self setclientomnvar( "ui_recharge_notify", -1 );
    start_time = gettime();
    end_time = start_time + timer * 1000;
    cur_time = gettime();
    
    while ( cur_time < end_time )
    {
        while ( istrue( self.inlaststand ) )
        {
            self setclientomnvar( "ui_recharge_notify", -1 );
            self setclientomnvar( omnvar, 0 );
            waitframe();
        }
        
        cur_time = gettime();
        progress = ( cur_time - start_time ) / ( end_time - start_time );
        self setclientomnvar( omnvar, progress );
        wait 0.1;
    }
    
    self setclientomnvar( "ui_recharge_notify", slot );
    self setclientomnvar( omnvar, 0 );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 2
// Checksum 0x0, Offset: 0x4aff
// Size: 0x95
function stop_restock_recharge( omnvar, slot_name )
{
    self endon( "death" );
    level endon( "game_ended" );
    self endon( "take_restock" );
    self endon( "restock_done" );
    
    while ( istrue( self.inlaststand ) || get_power_charges_in_slot( self, slot_name ) < get_power_max_charge_in_slot( self, slot_name ) )
    {
        waitframe();
    }
    
    self notify( "stop_restock_recharge" );
    
    if ( slot_name == "primary" )
    {
        self.waiting_for_lethal_restock = 0;
    }
    else
    {
        self.waiting_for_tactical_restock = 0;
    }
    
    self setclientomnvar( "ui_recharge_notify", -1 );
    self setclientomnvar( omnvar, 0 );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 2
// Checksum 0x0, Offset: 0x4b9c
// Size: 0x7a
function get_weapon_in_power_slot( player, slot )
{
    foreach ( power in player.powers )
    {
        if ( power.slot == slot )
        {
            return power.weaponuse;
        }
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 2
// Checksum 0x0, Offset: 0x4c1e
// Size: 0x70
function get_power_name_in_slot( player, slot )
{
    foreach ( power in player.powers )
    {
        if ( power.slot == slot )
        {
            return power_name;
        }
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 2
// Checksum 0x0, Offset: 0x4c96
// Size: 0x7a
function get_power_charges_in_slot( player, slot )
{
    foreach ( power in player.powers )
    {
        if ( power.slot == slot )
        {
            return power.charges;
        }
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 2
// Checksum 0x0, Offset: 0x4d18
// Size: 0x7a
function get_power_max_charge_in_slot( player, slot )
{
    foreach ( power in player.powers )
    {
        if ( power.slot == slot )
        {
            return power.maxcharges;
        }
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x4d9a
// Size: 0x32
function give_amped()
{
    scripts\cp\utility::giveperk( "specialty_quickdraw" );
    scripts\cp\utility::giveperk( "specialty_quickswap" );
    scripts\cp\utility::giveperk( "specialty_fastoffhand" );
    scripts\cp\utility::giveperk( "specialty_fastsprintrecovery" );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x4dd4
// Size: 0x2
function take_amped()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x4dde
// Size: 0x2
function give_shrapnel()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x4de8
// Size: 0x2
function take_shrapnel()
{
    
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x4df2
// Size: 0xa
function setmomentum()
{
    thread runmomentum();
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x4e04
// Size: 0x5a
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
            
            if ( isdefined( level.move_speed_scale ) )
            {
                self [[ level.move_speed_scale ]]();
            }
        }
        
        wait 0.1;
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x4e66
// Size: 0xb2
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
        
        if ( isdefined( level.move_speed_scale ) )
        {
            self [[ level.move_speed_scale ]]();
        }
        
        wait 0.035 / 0.08;
        var_51438b11657961cc += 0.01;
    }
    
    self playlocalsound( "ftl_phase_in" );
    self notify( "momentum_max_speed" );
    thread momentum_endaftermax();
    self waittill( "momentum_reset" );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x4f20
// Size: 0x1d
function momentum_endaftermax()
{
    self endon( "momentum_unset" );
    self waittill( "momentum_reset" );
    self playlocalsound( "ftl_phase_out" );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x4f45
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

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x4fce
// Size: 0x20
function momentum_monitordamage()
{
    self endon( "death" );
    self endon( "disconnect" );
    self waittill( "damage" );
    self notify( "momentum_reset" );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x4ff6
// Size: 0xa
function unsetmomentum()
{
    self notify( "momentum_unset" );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x5008
// Size: 0xf9
function watchcombatspeedscaler()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "last_stand" );
    self.pistolcombatspeedscalar = 1;
    self.aliensnarespeedscalar = 1;
    self.aliensnarecount = 0;
    self.combatspeedscalar = getcombatspeedscalar();
    self [[ level.move_speed_scale ]]();
    
    while ( true )
    {
        self waittill( "weapon_change", objweapon );
        currentweapon = self getcurrentweapon();
        baseweapon = getrawbaseweaponname( currentweapon );
        
        if ( isdefined( baseweapon ) )
        {
            if ( baseweapon == "nrg" || baseweapon == "zmagnum" || baseweapon == "zg18" || baseweapon == "emc" )
            {
                self.pistolcombatspeedscalar = 1.1;
            }
            else
            {
                self.pistolcombatspeedscalar = 1;
            }
            
            wait 0.05;
            updatecombatspeedscalar();
        }
        
        wait 0.05;
    }
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x5109
// Size: 0x1e
function updatecombatspeedscalar()
{
    self.combatspeedscalar = getcombatspeedscalar();
    self [[ level.move_speed_scale ]]();
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 0
// Checksum 0x0, Offset: 0x512f
// Size: 0x15
function getcombatspeedscalar()
{
    return self.pistolcombatspeedscalar * self.aliensnarespeedscalar;
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x514d
// Size: 0x55
function removeperk( perkname )
{
    assertex( isdefined( perkname ), "removePerk perkName not defined and should be" );
    assertex( perkname != "specialty_null", "removePerk perkName shouldn't be specialty_null" );
    assertex( perkname != "none", "removePerk perkName shouldn't be none" );
    scripts\cp\utility::_unsetperk( perkname );
    scripts\cp\utility::_unsetextraperks( perkname );
}

// Namespace cp_perks / scripts\cp\perks\cp_perks
// Params 1
// Checksum 0x0, Offset: 0x51aa
// Size: 0x29
function activateperk( perkref )
{
    self setclientomnvar( "ui_perk_activation", perkref );
    self setclientomnvar( "ui_perk_activation_notify", gettime() );
}

