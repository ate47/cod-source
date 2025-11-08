#using script_16ea1b94f0f381b3;
#using script_77be8cd2b6610d5;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\utility\damage;

#namespace mp_damage;

// Namespace mp_damage / namespace_cf210e742224b7bb
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x2a3
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_damage", undefined, undefined, &init );
}

// Namespace mp_damage / namespace_cf210e742224b7bb
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2c4
// Size: 0x66
function private init()
{
    level callback::add( "on_zombie_ai_spawned", &function_6078f3e8c682a36 );
    level callback::add( "on_agent_spawned", &function_edf4c2f3f7732c67 );
    level callback::add( "on_zombie_ai_killed", &on_zombie_ai_killed );
    level callback::add( "on_ai_killed", &function_e5ea18b76842725f );
    callback::get_template( "zombie" ) callback::add( "on_zombie_ai_damaged", &on_zombie_ai_damaged );
}

// Namespace mp_damage / namespace_cf210e742224b7bb
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x332
// Size: 0x67
function private function_edf4c2f3f7732c67( params )
{
    agent = params.agent;
    
    if ( agent.unittype != "soldier" )
    {
        return;
    }
    
    agent.var_970170ffd4b081ac = &soldier_damage;
    agent.var_21a8839dd03e31cd = [];
    agent callback::add( "on_soldier_ai_damaged", &on_soldier_ai_damaged );
}

// Namespace mp_damage / namespace_cf210e742224b7bb
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3a1
// Size: 0x19
function private function_6078f3e8c682a36( params )
{
    self.var_970170ffd4b081ac = &function_d88acf085f34a24f;
}

// Namespace mp_damage / namespace_cf210e742224b7bb
// Params 13
// Checksum 0x0, Offset: 0x3c2
// Size: 0x4a7
function function_d88acf085f34a24f( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon )
{
    dmg_struct = function_34e78cbd2dfff6df( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon );
    
    if ( isdefined( self.var_d37b75616f7c2ee ) )
    {
        dmg_struct.num_hits = self.var_d37b75616f7c2ee.num_hits;
    }
    else
    {
        dmg_struct.num_hits = 0;
    }
    
    dmg_struct.num_hits++;
    
    if ( function_b8fd1823ea584538( eattacker, objweapon, smeansofdeath ) )
    {
        if ( isplayer( eattacker ) && self.team != eattacker.team )
        {
            eattacker scripts\cp_mp\damagefeedback::updatedamagefeedback( "standard", 0 );
        }
        
        return 0;
    }
    
    dmg_struct.idamage = function_942afcb4f4e24091( dmg_struct );
    dmg_struct.idamage = function_89cc24cfc33e2693( dmg_struct );
    dmg_struct.idamage = function_ba2823ac0204930c( dmg_struct );
    dmg_struct.idamage = function_f9c444fcf6bb992b( dmg_struct );
    assert( isdefined( dmg_struct.idamage ) && dmg_struct.idamage > 0 && int( dmg_struct.idamage ) > 0 );
    dmg_struct.idamage = function_4948d7eacb9f12be( dmg_struct );
    
    if ( isdefined( dmg_struct.eattacker ) && isplayer( dmg_struct.eattacker.owner ) )
    {
        dmg_struct.eattacker = dmg_struct.eattacker.owner;
    }
    
    if ( isexplosivedamagemod( smeansofdeath ) )
    {
        if ( issharedfuncdefined( "thermobaric_grenade", "thermobaric_additional_explosive_damage" ) )
        {
            dmg_struct.idamage += [[ getsharedfunc( "thermobaric_grenade", "thermobaric_additional_explosive_damage" ) ]]( self, eattacker, dmg_struct.idamage );
        }
    }
    
    zombie_damage::function_6b8e5b333b2b3e43( dmg_struct );
    thread namespace_28253c2ed4569abd::function_5c8a92a87ae9751b( dmg_struct.eattacker, dmg_struct.var_feef4b237a6beb07, dmg_struct.metabonename, "hitarmorlight" );
    zombie_damage::function_63e1cb89f73d0ad8( dmg_struct );
    zombie_damage::function_71a411d4b5466318( dmg_struct );
    zombie_damage::function_10a52a9d2dcaf262( dmg_struct );
    
    if ( istrue( self.killondamage ) )
    {
        dmg_struct.idamage = self.health;
    }
    
    if ( isdefined( eattacker ) && ( isplayer( eattacker ) || isplayer( eattacker.owner ) ) )
    {
        eplayer = eattacker;
        var_cb5826a84ea1330c = undefined;
        elementfeedback = undefined;
        
        if ( isplayer( eattacker.owner ) )
        {
            eplayer = eattacker.owner;
        }
        
        if ( isdefined( level.gamemodebundle ) && istrue( level.gamemodebundle.var_fe33630e0f09e5df ) || getdvarint( @"hash_1661f35e34f544eb", 0 ) )
        {
            scripts\mp\mp_agent_damage::function_c54b2cc2e762c201( eplayer, self, shitloc, smeansofdeath, objweapon, int( dmg_struct.idamage ), vpoint, 0, undefined, dmg_struct.biscritical, dmg_struct.var_feef4b237a6beb07 );
        }
        
        if ( isplayer( eattacker ) && dmg_struct.idamage > 0 && ( !isdefined( shitloc ) || shitloc != "shield" ) && !isdefined( elementfeedback ) )
        {
            eattacker scripts\cp_mp\damagefeedback::updatedamagefeedback( "standard", dmg_struct.idamage >= self.health, dmg_struct.biscritical );
        }
    }
    
    self.var_d37b75616f7c2ee = dmg_struct;
    callback::callback( "on_zombie_ai_damaged", dmg_struct );
    
    if ( isdefined( eattacker ) && isdefined( eattacker.var_69b049cf4b18c73b ) )
    {
        n_multiplier = 200;
        
        if ( isdefined( dmg_struct ) && isdefined( dmg_struct.idamage ) )
        {
            dmg_struct.idamage *= n_multiplier;
        }
    }
    
    idamagenew = int( dmg_struct.idamage );
    
    if ( !isdefined( idamagenew ) || idamagenew < 0 )
    {
        assert( 0 );
        idamagenew = 0;
    }
    
    return idamagenew;
}

// Namespace mp_damage / namespace_cf210e742224b7bb
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x872
// Size: 0x159
function private on_zombie_ai_damaged( dmg_struct )
{
    if ( isplayer( dmg_struct.eattacker ) && isdefined( self.var_21a8839dd03e31cd ) )
    {
        self.var_21a8839dd03e31cd = function_6d6af8144a5131f1( self.var_21a8839dd03e31cd, dmg_struct.eattacker );
    }
    
    thread namespace_28253c2ed4569abd::function_45500125495e46a6( dmg_struct.eattacker, dmg_struct.var_feef4b237a6beb07, dmg_struct.metabonename, "hitarmorlightbreak" );
    
    if ( isdefined( dmg_struct.einflictor ) && dmg_struct.einflictor scripts\cp_mp\vehicles\vehicle::isvehicle() && !istrue( dmg_struct.einflictor.var_aa4804cc1bc59e93 ) && isdefined( dmg_struct.smeansofdeath ) && dmg_struct.smeansofdeath == "MOD_CRUSH" )
    {
        vehicle = dmg_struct.einflictor;
        player = dmg_struct.eattacker;
        vehicle.var_7fff3293eab0f7b8 = 1;
        
        if ( isdefined( dmg_struct.idamage ) && isdefined( self ) )
        {
            n_damage = int( dmg_struct.idamage * 0.1 );
            vehicle thread function_743e37eebd6ba8e2( n_damage );
        }
    }
}

// Namespace mp_damage / namespace_cf210e742224b7bb
// Params 1
// Checksum 0x0, Offset: 0x9d3
// Size: 0xa3
function function_743e37eebd6ba8e2( n_damage )
{
    self endon( "death" );
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( self, 0 );
    
    if ( isdefined( occupants ) )
    {
        foreach ( occupant in occupants )
        {
            if ( isplayer( occupant ) )
            {
                occupant playrumbleonpositionforclient( "artillery_rumble_heavy", self.origin );
            }
        }
    }
    
    scripts\common\vehicle::vehicle_damage( n_damage );
    wait 0.1;
    self.var_7fff3293eab0f7b8 = undefined;
}

// Namespace mp_damage / namespace_cf210e742224b7bb
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xa7e
// Size: 0x49
function private function_3c80d46239ce0a0e( dmg_struct, shitloc, n_pap_level )
{
    if ( shitloc == "head" || shitloc == "neck" )
    {
        dmg_struct.biscritical = 1;
    }
    
    return dmg_struct.idamage;
}

// Namespace mp_damage / namespace_cf210e742224b7bb
// Params 13
// Checksum 0x0, Offset: 0xad0
// Size: 0x465
function soldier_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon )
{
    if ( getdvar( @"ui_gametype", "" ) == "gwtdm" )
    {
        attackerishittingteammate = scripts\mp\utility\damage::attackerishittingteam( self, eattacker );
        
        if ( attackerishittingteammate )
        {
            return 0;
        }
    }
    
    if ( istrue( self.var_f327ed481efe4857 ) )
    {
        return 0;
    }
    
    dmg_struct = spawnstruct();
    dmg_struct.einflictor = einflictor;
    dmg_struct.eattacker = eattacker;
    dmg_struct.idamage = idamage;
    dmg_struct.idflags = idflags;
    dmg_struct.smeansofdeath = smeansofdeath;
    dmg_struct.sweapon = sweapon;
    dmg_struct.vpoint = vpoint;
    dmg_struct.vdir = vdir;
    dmg_struct.shitloc = shitloc;
    dmg_struct.timeoffset = timeoffset;
    dmg_struct.modelindex = modelindex;
    dmg_struct.partname = partname;
    dmg_struct.objweapon = objweapon;
    dmg_struct.biscritical = 0;
    dmg_struct.var_feef4b237a6beb07 = 0;
    
    if ( isdefined( self.var_d37b75616f7c2ee ) )
    {
        dmg_struct.num_hits = self.var_d37b75616f7c2ee.num_hits;
    }
    else
    {
        dmg_struct.num_hits = 0;
    }
    
    dmg_struct.num_hits++;
    n_pap_level = 0;
    
    if ( issharedfuncdefined( "zombie", "get_pap_level" ) && isplayer( dmg_struct.eattacker ) )
    {
        n_pap_level = dmg_struct.eattacker callsharedfunc( "zombie", "get_pap_level", dmg_struct.objweapon );
    }
    
    if ( n_pap_level >= 1 )
    {
        dmg_struct.idamage /= 2;
    }
    
    dmg_struct.idamage = function_3c80d46239ce0a0e( dmg_struct, shitloc, n_pap_level );
    
    if ( isplayer( eattacker ) && issharedfuncdefined( "player", "onHumanGunPowerupDamage" ) )
    {
        adjusted_damage = eattacker [[ getsharedfunc( "player", "onHumanGunPowerupDamage" ) ]]( dmg_struct );
        
        if ( adjusted_damage != -1 )
        {
            dmg_struct.idamage = adjusted_damage;
        }
    }
    
    final_damage = dmg_struct.idamage;
    
    if ( isarray( level.var_8c2b0fd37157f872 ) )
    {
        foreach ( func in level.var_8c2b0fd37157f872 )
        {
            new_damage = self [[ func ]]( dmg_struct );
            
            if ( new_damage != -1 )
            {
                final_damage = new_damage;
            }
        }
    }
    
    if ( isdefined( eattacker ) && ( isplayer( eattacker ) || isplayer( eattacker.owner ) ) )
    {
        eplayer = eattacker;
        weaponelementtype = undefined;
        
        if ( isplayer( eattacker.owner ) )
        {
            eplayer = eattacker.owner;
        }
        
        if ( isdefined( level.gamemodebundle ) && istrue( level.gamemodebundle.var_34f596a1ce19ca ) || getdvarint( @"hash_5e1b3bfc576b756", 0 ) )
        {
            scripts\mp\mp_agent_damage::function_c54b2cc2e762c201( eplayer, self, shitloc, smeansofdeath, sweapon, int( final_damage ), vpoint, 0, weaponelementtype, dmg_struct.biscritical, 0 );
        }
        
        if ( isplayer( eattacker ) && final_damage > 0 && ( !isdefined( shitloc ) || shitloc != "shield" ) )
        {
            eattacker scripts\cp_mp\damagefeedback::updatedamagefeedback( "standard", final_damage >= self.health );
        }
    }
    
    self.var_d37b75616f7c2ee = dmg_struct;
    callback::callback( "on_soldier_ai_damaged", dmg_struct );
    return int( final_damage );
}

// Namespace mp_damage / namespace_cf210e742224b7bb
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xf3e
// Size: 0x14a
function private on_soldier_ai_damaged( dmg_struct )
{
    if ( isplayer( dmg_struct.eattacker ) && isdefined( self.var_21a8839dd03e31cd ) )
    {
        self.var_21a8839dd03e31cd = function_6d6af8144a5131f1( self.var_21a8839dd03e31cd, dmg_struct.eattacker );
    }
    
    if ( isdefined( dmg_struct.einflictor ) && dmg_struct.einflictor scripts\cp_mp\vehicles\vehicle::isvehicle() && !isdefined( dmg_struct.einflictor.var_1cb92917037d8996 ) && isdefined( dmg_struct.smeansofdeath ) && dmg_struct.smeansofdeath == "MOD_CRUSH" && !isdefined( dmg_struct.einflictor.var_7fff3293eab0f7b8 ) && !istrue( level.var_75c758bc51605c7b ) )
    {
        vehicle = dmg_struct.einflictor;
        vehicle.var_7fff3293eab0f7b8 = 1;
        vehicle playrumbleonentity( "artillery_rumble_heavy" );
        
        if ( isdefined( dmg_struct.idamage ) && isdefined( self ) )
        {
            n_damage = int( dmg_struct.idamage * 0.1 );
            vehicle thread function_743e37eebd6ba8e2( n_damage );
        }
    }
}

// Namespace mp_damage / namespace_cf210e742224b7bb
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1090
// Size: 0x7b
function private on_zombie_ai_killed( params )
{
    playerattacker = params.eattacker;
    
    if ( isdefined( playerattacker ) && !isplayer( playerattacker ) && isplayer( playerattacker.owner ) )
    {
        playerattacker = playerattacker.owner;
    }
    
    if ( isplayer( playerattacker ) )
    {
        playerattacker thread scripts\mp\mp_agent_damage::updaterecentagentkills( self, params.einflictor, params.objweapon );
    }
}

// Namespace mp_damage / namespace_cf210e742224b7bb
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1113
// Size: 0x12
function private function_e5ea18b76842725f( params )
{
    scripts\cp_mp\utility\game_utility::removefromcharactersarray();
}

