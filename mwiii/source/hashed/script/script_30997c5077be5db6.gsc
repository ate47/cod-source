#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
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

#namespace br_damage;

// Namespace br_damage / namespace_68973652cca2f4b4
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x3de
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"br_damage", undefined, undefined, &init );
}

// Namespace br_damage / namespace_68973652cca2f4b4
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3ff
// Size: 0x66
function private init()
{
    level callback::add( "on_zombie_ai_spawned", &function_6078f3e8c682a36 );
    level callback::add( "on_agent_spawned", &function_edf4c2f3f7732c67 );
    level callback::add( "on_zombie_ai_killed", &on_zombie_ai_killed );
    level callback::add( "on_ai_killed", &function_e5ea18b76842725f );
    callback::get_template( "zombie" ) callback::add( "on_zombie_ai_damaged", &on_zombie_ai_damaged );
}

// Namespace br_damage / namespace_68973652cca2f4b4
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x46d
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

// Namespace br_damage / namespace_68973652cca2f4b4
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4dc
// Size: 0x19
function private function_6078f3e8c682a36( params )
{
    self.var_970170ffd4b081ac = &function_d88acf085f34a24f;
}

// Namespace br_damage / namespace_68973652cca2f4b4
// Params 13
// Checksum 0x0, Offset: 0x4fd
// Size: 0x698
function function_d88acf085f34a24f( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon )
{
    params = { #objweapon:objweapon, #partname:partname, #modelindex:modelindex, #timeoffset:timeoffset, #shitloc:shitloc, #vdir:vdir, #vpoint:vpoint, #sweapon:sweapon, #smeansofdeath:smeansofdeath, #idflags:idflags, #idamage:idamage, #eattacker:eattacker, #einflictor:einflictor };
    
    if ( utility::issharedfuncdefined( "zombie_damage", "buildDamageStruct" ) )
    {
        dmg_struct = utility::callsharedfunc( "zombie_damage", "buildDamageStruct", params );
    }
    
    if ( isdefined( self.var_d37b75616f7c2ee ) )
    {
        dmg_struct.num_hits = self.var_d37b75616f7c2ee.num_hits;
    }
    else
    {
        dmg_struct.num_hits = 0;
    }
    
    dmg_struct.num_hits++;
    
    if ( utility::issharedfuncdefined( "zombie_damage", "shouldSkipDamage" ) )
    {
        if ( utility::callsharedfunc( "zombie_damage", "shouldSkipDamage", eattacker, objweapon, smeansofdeath ) )
        {
            if ( isplayer( eattacker ) && self.team != eattacker.team )
            {
                eattacker scripts\cp_mp\damagefeedback::updatedamagefeedback( "standard", 0 );
            }
            
            return 0;
        }
    }
    
    if ( utility::issharedfuncdefined( "zombie_damage", "adjustDamageUnderbarrel" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( "zombie_damage", "adjustDamageUnderbarrel", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( "zombie_damage", "adjustDamageRarity" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( "zombie_damage", "adjustDamageRarity", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( "zombie_damage", "adjustDamageSpecific" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( "zombie_damage", "adjustDamageSpecific", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( "zombie_damage", "adjustDamageMercs" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( "zombie_damage", "adjustDamageMercs", dmg_struct );
    }
    
    dmg_struct.idamage = function_67bb3f6dfc69c5f8( dmg_struct );
    assert( isdefined( dmg_struct.idamage ) && dmg_struct.idamage > 0 && int( dmg_struct.idamage ) > 0 );
    
    if ( utility::issharedfuncdefined( "zombie_damage", "adjustDamageKillCallbacks" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( "zombie_damage", "adjustDamageKillCallbacks", dmg_struct );
    }
    
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
    
    if ( utility::issharedfuncdefined( "zombie_damage", "checkDamagedArmor" ) )
    {
        utility::callsharedfunc( "zombie_damage", "checkDamagedArmor", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( "zombie_damage", "checkArmorHitmarker" ) )
    {
        thread utility::callsharedfunc( "zombie_damage", "checkArmorHitmarker", dmg_struct.eattacker, dmg_struct.var_feef4b237a6beb07, dmg_struct.metabonename, "hitarmorlight" );
    }
    
    if ( utility::issharedfuncdefined( "zombie_damage", "adjustDamageExposedHead" ) )
    {
        utility::callsharedfunc( "zombie_damage", "adjustDamageExposedHead", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( "zombie_damage", "damageMetabone" ) )
    {
        utility::callsharedfunc( "zombie_damage", "damageMetabone", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( "zombie_damage", "adjustDamageArmor" ) )
    {
        utility::callsharedfunc( "zombie_damage", "adjustDamageArmor", dmg_struct );
    }
    
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

// Namespace br_damage / namespace_68973652cca2f4b4
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xb9e
// Size: 0x164
function private on_zombie_ai_damaged( dmg_struct )
{
    if ( isplayer( dmg_struct.eattacker ) && isdefined( self.var_21a8839dd03e31cd ) )
    {
        self.var_21a8839dd03e31cd = function_6d6af8144a5131f1( self.var_21a8839dd03e31cd, dmg_struct.eattacker );
    }
    
    if ( utility::issharedfuncdefined( "zombie_damage", "checkArmorBreakHitmarker" ) )
    {
        thread utility::callsharedfunc( "zombie_damage", "checkArmorBreakHitmarker", dmg_struct.eattacker, dmg_struct.var_feef4b237a6beb07, dmg_struct.metabonename, "hitarmorlightbreak" );
    }
    
    if ( isdefined( dmg_struct.einflictor ) && dmg_struct.einflictor scripts\cp_mp\vehicles\vehicle::isvehicle() && !istrue( dmg_struct.einflictor.var_aa4804cc1bc59e93 ) && !istrue( self.var_a5adada1db5eeb97 ) && isdefined( dmg_struct.smeansofdeath ) && dmg_struct.smeansofdeath == "MOD_CRUSH" )
    {
        vehicle = dmg_struct.einflictor;
        player = dmg_struct.eattacker;
        vehicle.var_7fff3293eab0f7b8 = 1;
        
        if ( isdefined( dmg_struct.idamage ) && isdefined( self ) )
        {
            vehicle thread function_743e37eebd6ba8e2( 0 );
        }
    }
}

// Namespace br_damage / namespace_68973652cca2f4b4
// Params 1
// Checksum 0x0, Offset: 0xd0a
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

// Namespace br_damage / namespace_68973652cca2f4b4
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xdb5
// Size: 0x49
function private function_3c80d46239ce0a0e( dmg_struct, shitloc, n_pap_level )
{
    if ( shitloc == "head" || shitloc == "neck" )
    {
        dmg_struct.biscritical = 1;
    }
    
    return dmg_struct.idamage;
}

// Namespace br_damage / namespace_68973652cca2f4b4
// Params 13
// Checksum 0x0, Offset: 0xe07
// Size: 0x42f
function soldier_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon )
{
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

// Namespace br_damage / namespace_68973652cca2f4b4
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x123f
// Size: 0x13c
function private on_soldier_ai_damaged( dmg_struct )
{
    if ( isplayer( dmg_struct.eattacker ) && isdefined( self.var_21a8839dd03e31cd ) )
    {
        self.var_21a8839dd03e31cd = function_6d6af8144a5131f1( self.var_21a8839dd03e31cd, dmg_struct.eattacker );
    }
    
    if ( isdefined( dmg_struct.einflictor ) && dmg_struct.einflictor scripts\cp_mp\vehicles\vehicle::isvehicle() && !isdefined( dmg_struct.einflictor.var_1cb92917037d8996 ) && isdefined( dmg_struct.smeansofdeath ) && dmg_struct.smeansofdeath == "MOD_CRUSH" && !isdefined( dmg_struct.einflictor.var_7fff3293eab0f7b8 ) )
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

// Namespace br_damage / namespace_68973652cca2f4b4
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1383
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

// Namespace br_damage / namespace_68973652cca2f4b4
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1406
// Size: 0x12
function private function_e5ea18b76842725f( params )
{
    scripts\cp_mp\utility\game_utility::removefromcharactersarray();
}

// Namespace br_damage / namespace_68973652cca2f4b4
// Params 1
// Checksum 0x0, Offset: 0x1420
// Size: 0xef
function function_67bb3f6dfc69c5f8( dmg_struct )
{
    attackent = undefined;
    
    if ( isdefined( dmg_struct.eattacker ) )
    {
        attackent = dmg_struct.eattacker;
    }
    else
    {
        attackent = dmg_struct.einflictor;
    }
    
    if ( isdefined( dmg_struct.smeansofdeath ) )
    {
        if ( dmg_struct.smeansofdeath == "MOD_CRUSH" )
        {
            if ( isdefined( attackent ) && attackent scripts\common\vehicle::isvehicle() )
            {
                if ( attackent vehicle_getspeed() > 5 )
                {
                    if ( issubstr( self.subclass, "armored" ) || issubstr( self.subclass, "hellhound" ) || issubstr( self.subclass, "mimic" ) )
                    {
                        return ( self.maxhealth / 30 );
                    }
                    else
                    {
                        return self.health;
                    }
                }
            }
        }
    }
    
    return dmg_struct.idamage;
}

