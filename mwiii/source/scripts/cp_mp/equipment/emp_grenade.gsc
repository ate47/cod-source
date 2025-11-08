#using script_608c50392df8c7d1;
#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
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

// Namespace emp_grenade / scripts\cp_mp\equipment\emp_grenade
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x20b
// Size: 0x2e
function autoexec main()
{
    registersharedfunc( "emp_grenade", "emp_grenade_init", &emp_grenade_init );
    registersharedfunc( "emp_grenade", "emp_grenade_used", &emp_grenade_used );
}

// Namespace emp_grenade / scripts\cp_mp\equipment\emp_grenade
// Params 0
// Checksum 0x0, Offset: 0x241
// Size: 0xde
function emp_grenade_init()
{
    if ( !isdefined( level.equipment.table[ "equip_emp_grenade" ] ) )
    {
        return;
    }
    
    equipmenttable = scripts\cp_mp\equipment::getequipmenttableinfo( "equip_emp_grenade" );
    effectduration = isdefined( equipmenttable.bundle.var_89f3713a59df7bfd ) ? equipmenttable.bundle.var_89f3713a59df7bfd : 6;
    damageradius = getgrenadedamageradius( equipmenttable.bundle.useweapon );
    level.empgrenadesettings = spawnstruct();
    level.empgrenadesettings.detonation_radius = damageradius;
    level.empgrenadesettings.effectduration = getdvarfloat( @"hash_13567d77b711c7ff", effectduration );
}

// Namespace emp_grenade / scripts\cp_mp\equipment\emp_grenade
// Params 1
// Checksum 0x0, Offset: 0x327
// Size: 0x20c
function emp_grenade_used( grenade )
{
    self endon( "disconnect" );
    grenade endon( "explode_end" );
    grenade thread notifyafterframeend( "death", "explode_end" );
    scripts\cp_mp\challenges::function_b0f754c8a379154e( "equip_emp_grenade", self, undefined, scripts\common\ae_utility::function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"use" ) );
    grenade waittill( "explode", position );
    ents = empdebuff_get_emp_ents( position, level.empgrenadesettings.detonation_radius );
    objweapon = makeweapon( grenade.bundle.useweapon );
    
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
        thread function_9be39ebfae2ac6be( data, grenade.bundle );
    }
    
    players = getplayersinradius( position, level.empgrenadesettings.detonation_radius );
    
    foreach ( player in players )
    {
        if ( !player can_be_empd() )
        {
            continue;
        }
        
        if ( !player_utility::playersareenemies( self, player ) && !istrue( level.friendlyfire ) )
        {
            continue;
        }
        
        data = packdamagedata( self, player, 1, objweapon, "MOD_EXPLOSIVE", grenade, position );
        thread _emp_grenade_apply_player( data, grenade.bundle );
    }
}

// Namespace emp_grenade / scripts\cp_mp\equipment\emp_grenade
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x53b
// Size: 0xae
function private function_9be39ebfae2ac6be( data, bundle )
{
    if ( data.attacker != data.victim )
    {
        doonactionscoreevent( 0, "emp_grenade" );
        scripts\cp_mp\challenges::function_b0f754c8a379154e( "equip_emp_grenade", data.attacker, undefined, function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"hit" ) );
    }
    
    apply_emp_struct( data );
    function_e334f478af660150( data, level.empgrenadesettings.effectduration );
    
    if ( isdefined( data.victim ) )
    {
        data.victim remove_emp();
    }
}

// Namespace emp_grenade / scripts\cp_mp\equipment\emp_grenade
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x5f1
// Size: 0x271
function private _emp_grenade_apply_player( data, bundle )
{
    if ( data.attacker != data.victim )
    {
        doonactionscoreevent( 0, "emp_grenade" );
        scripts\cp_mp\challenges::function_b0f754c8a379154e( "equip_emp_grenade", data.attacker, undefined, function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"hit" ) );
    }
    
    apply_emp_struct( data );
    trackdebuffassist( data.attacker, data.victim, data.objweapon.basename );
    data.victim scripts\cp_mp\emp_debuff::play_emp_scramble( 5 );
    data.victim playsoundtoplayer( "eqp_emp_grenade_hud_scramble", data.victim );
    
    if ( istrue( bundle.var_734d93370835f5c5 ) )
    {
        data.victim _shellshock( "emp", "stun", level.empgrenadesettings.effectduration, 1 );
    }
    
    if ( istrue( bundle.var_f65b11a99301bdbf ) )
    {
        data.victim val::set( "emp", "killstreaks", 0 );
    }
    
    if ( istrue( bundle.var_463c800f6539107c ) )
    {
        data.victim val::set( "emp", "supers", 0 );
    }
    
    function_e334f478af660150( data, level.empgrenadesettings.effectduration );
    
    if ( isdefined( data.victim ) )
    {
        data.victim remove_emp();
        data.victim scripts\cp_mp\emp_debuff::stop_emp_scramble( 5 );
        
        if ( istrue( bundle.var_f65b11a99301bdbf ) )
        {
            data.victim val::set( "emp", "killstreaks", 1 );
        }
        
        if ( istrue( bundle.var_463c800f6539107c ) )
        {
            data.victim val::set( "emp", "supers", 1 );
        }
        
        if ( isdefined( data.attacker ) && isreallyalive( data.attacker ) )
        {
            untrackdebuffassist( data.attacker, data.victim, data.objweapon.basename );
        }
    }
}

// Namespace emp_grenade / scripts\cp_mp\equipment\emp_grenade
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x86a
// Size: 0x2d
function private function_e334f478af660150( data, duration )
{
    data.victim endon( "death_or_disconnect" );
    level endon( "game_ended" );
    wait duration;
}

