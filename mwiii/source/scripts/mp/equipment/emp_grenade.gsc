#using script_608c50392df8c7d1;
#using script_74b851b7aa1ef32d;
#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\gamescore;
#using scripts\mp\perks\perkfunctions;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;

#namespace emp_grenade;

// Namespace emp_grenade / scripts\mp\equipment\emp_grenade
// Params 1
// Checksum 0x0, Offset: 0x193
// Size: 0x274
function emp_grenade_used( grenade )
{
    self endon( "disconnect" );
    grenade endon( "explode_end" );
    grenade thread notifyafterframeend( "death", "explode_end" );
    
    if ( !isdefined( level.empgrenadesettings ) )
    {
        ref = function_7f245729fcb6414d( grenade.weapon_name );
        grenade.tableinfo = getequipmenttableinfo( ref );
        bundle = grenade.tableinfo.bundle;
        damageradius = getgrenadedamageradius( "t10_emp_grenade_mp" );
        level.empgrenadesettings = spawnstruct();
        level.empgrenadesettings.detonation_radius = damageradius;
        level.empgrenadesettings.var_41621f8c94cfd912 = bundle.var_aff232b5f0f11c3e;
        level.empgrenadesettings.var_909c6082a847d955 = bundle.var_d0a989cb2841fa49;
    }
    
    grenade waittill( "explode", position );
    ents = empdebuff_get_emp_ents( position, level.empgrenadesettings.detonation_radius );
    objweapon = makeweapon( "t10_emp_grenade_mp" );
    
    foreach ( ent in ents )
    {
        entowner = ent.owner;
        
        if ( isdefined( entowner ) )
        {
            if ( !playersareenemies( self, entowner ) )
            {
                continue;
            }
        }
        
        data = packdamagedata( self, ent, 1, objweapon, "MOD_EXPLOSIVE", grenade, position );
        thread function_9be39ebfae2ac6be( data );
    }
    
    players = getplayersinradius( position, level.empgrenadesettings.detonation_radius );
    
    foreach ( player in players )
    {
        if ( !player can_be_empd() )
        {
            continue;
        }
        
        data = packdamagedata( self, player, 1, objweapon, "MOD_EXPLOSIVE", grenade, position );
        thread _emp_grenade_apply_player( data );
    }
}

// Namespace emp_grenade / scripts\mp\equipment\emp_grenade
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x40f
// Size: 0x76
function private function_9be39ebfae2ac6be( data )
{
    if ( data.attacker != data.victim )
    {
        doonactionscoreevent( 0, "emp_grenade" );
    }
    
    apply_emp_struct( data );
    _emp_grenade_end_early( data, level.empgrenadesettings.var_41621f8c94cfd912 );
    
    if ( isdefined( data.victim ) )
    {
        data.victim remove_emp();
    }
}

// Namespace emp_grenade / scripts\mp\equipment\emp_grenade
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x48d
// Size: 0x157
function private _emp_grenade_apply_player( data )
{
    if ( data.attacker != data.victim )
    {
        doonactionscoreevent( 0, "emp_grenade" );
    }
    
    apply_emp_struct( data );
    trackdebuffassist( data.attacker, data.victim, data.objweapon.basename );
    data.victim scripts\cp_mp\emp_debuff::play_emp_scramble( 5 );
    data.victim _shellshock( "emp", "stun", level.empgrenadesettings.var_909c6082a847d955, 1 );
    _emp_grenade_end_early( data, level.empgrenadesettings.var_909c6082a847d955 );
    
    if ( isdefined( data.victim ) )
    {
        data.victim remove_emp();
        data.victim scripts\cp_mp\emp_debuff::stop_emp_scramble( 5 );
        
        if ( isdefined( data.attacker ) && isreallyalive( data.attacker ) )
        {
            untrackdebuffassist( data.attacker, data.victim, data.objweapon.basename );
        }
    }
}

// Namespace emp_grenade / scripts\mp\equipment\emp_grenade
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x5ec
// Size: 0x2d
function private _emp_grenade_end_early( data, duration )
{
    data.victim endon( "death_or_disconnect" );
    level endon( "game_ended" );
    wait duration;
}

