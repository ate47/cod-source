#using scripts\cp\damage;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;

#namespace damagefeedback;

// Namespace damagefeedback / scripts\cp\damagefeedback
// Params 0
// Checksum 0x0, Offset: 0x453
// Size: 0x42
function init()
{
    level.hitmarkerpriorities = [];
    level.hitmarkerpriorities[ "standard" ] = 40;
    level.hitmarkerpriorities[ "standardspread" ] = 50;
    level.hitmarkerpriorities[ "hitequip" ] = 30;
}

// Namespace damagefeedback / scripts\cp\damagefeedback
// Params 1
// Checksum 0x0, Offset: 0x49d
// Size: 0x27
function gethitmarkerpriority( hitmarkertype )
{
    if ( !isdefined( level.hitmarkerpriorities[ hitmarkertype ] ) )
    {
        return 0;
    }
    
    return level.hitmarkerpriorities[ hitmarkertype ];
}

// Namespace damagefeedback / scripts\cp\damagefeedback
// Params 1
// Checksum 0x0, Offset: 0x4cd
// Size: 0xdc
function hudicontype( typehit )
{
    nosound = 0;
    
    if ( isdefined( level.damagefeedbacknosound ) && level.damagefeedbacknosound )
    {
        nosound = 1;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    switch ( typehit )
    {
        case #"hash_1d28d8c7a5e03548":
        case #"hash_2ab98cab4066a74e":
        case #"hash_5c57b61aa79410db":
        case #"hash_b8d1ac6e6b8e3230":
        case #"hash_d6a7d182fd397b0a":
            if ( !nosound )
            {
                self playlocalsound( "scavenger_pack_pickup" );
            }
            
            self setclientomnvar( "damage_feedback_other", typehit );
            break;
        case #"hash_d5a97a795c2da79a":
            self setclientomnvar( "damage_feedback_other", typehit );
            break;
        case #"hash_1041aa27487b00f8":
            self setclientomnvar( "damage_feedback_other", typehit );
            break;
    }
}

// Namespace damagefeedback / scripts\cp\damagefeedback
// Params 11
// Checksum 0x0, Offset: 0x5b1
// Size: 0x72
function function_4e514dcd8e549d1( einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, lightarmordamage, heavyarmordamage, var_708152dedbc0117 )
{
    process_damage_feedback( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, undefined, undefined, shitloc, undefined, victim );
}

// Namespace damagefeedback / scripts\cp\damagefeedback
// Params 11
// Checksum 0x0, Offset: 0x62b
// Size: 0x54c
function process_damage_feedback( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, victim )
{
    var_168973eaf883aea1 = isdefined( eattacker ) && isdefined( eattacker.classname ) && isdefined( eattacker.classname ) && !isdefined( eattacker.gunner ) && ( eattacker.classname == "script_vehicle" || eattacker.classname == "misc_turret" || eattacker.classname == "script_model" );
    damager = undefined;
    
    if ( var_168973eaf883aea1 && isdefined( eattacker.gunner ) )
    {
        damager = eattacker.gunner;
    }
    else if ( isdefined( eattacker ) && isdefined( eattacker.owner ) )
    {
        damager = eattacker.owner;
    }
    else
    {
        damager = eattacker;
    }
    
    isbulletdamage = isbulletdamage( smeansofdeath );
    
    if ( isdefined( sweapon ) )
    {
        typehit = ter_op( isbulletdamage && isprimaryweapon( sweapon ), "standardspread", "standard" );
    }
    else
    {
        typehit = "standard";
    }
    
    var_59ad6a29257c9f49 = 0;
    
    if ( isdefined( damager ) && damager != victim && ( !isdefined( shitloc ) || shitloc != "shield" ) )
    {
        waskilled = !victim scripts\cp_mp\utility\player_utility::_isalive() || isagent( victim ) && idamage >= victim.health;
        
        if ( isdefined( victim.var_689d46e1e37cc5ad ) )
        {
            waskilled = [[ victim.var_689d46e1e37cc5ad ]]( idamage );
        }
        
        isspreadweapon = 0;
        
        if ( isdefined( sweapon ) )
        {
            weapclass = weaponclass( sweapon );
            isspreadweapon = weapclass == "spread";
        }
        
        headshot = !isspreadweapon && isheadshot( sweapon, shitloc, smeansofdeath, eattacker );
        
        if ( istrue( victim scripts\cp\spawning::is_specified_unittype( "juggernaut" ) ) )
        {
            typehit = "hitarmorheavy";
        }
        else if ( idflags & 16 )
        {
            typehit = "stun";
        }
        else if ( istacticaldamage( sweapon, smeansofdeath ) && victim _hasperk( "specialty_stun_resistance" ) )
        {
            typehit = "hittacresist";
        }
        else if ( isexplosivedamagemod( smeansofdeath ) && victim _hasperk( "specialty_blastshield" ) && !damage_should_ignore_blast_shield( eattacker, victim, sweapon, smeansofdeath, einflictor, shitloc ) )
        {
            typehit = "hitblastshield";
        }
        else if ( !var_59ad6a29257c9f49 && scripts\cp\spawning::is_armored() )
        {
            if ( istrue( headshot ) )
            {
                if ( isdefined( self.helmethealth ) && self.helmethealth > 0 )
                {
                    typehit = "hithelmetheavy";
                }
                else if ( !istrue( self.helmet_broken ) && isplayer( damager ) )
                {
                    typehit = "hithelmetheavybreak";
                    self.helmet_broken = 1;
                }
            }
            else if ( isdefined( self.armorhealth ) && self.armorhealth > 0 )
            {
                typehit = "hitarmorheavy";
            }
            else if ( !istrue( self.armor_broken ) && isplayer( damager ) )
            {
                typehit = "hitarmorheavybreak";
                self.armor_broken = 1;
            }
        }
        else if ( victim _hasperk( "specialty_pistoldeath" ) && istrue( victim.inlaststand ) && !victim.hasshownlaststandicon )
        {
            victim.hasshownlaststandicon = 1;
            typehit = "hitlaststand";
        }
        
        if ( isdefined( victim.focus_fire_attackers ) && victim.focus_fire_attackers.size > 1 )
        {
            typehit = "cp_relic_buff";
        }
        
        allowdamagefeedback = 1;
        suppressaudio = smeansofdeath == "MOD_MELEE";
        timestring = "" + gettime();
        
        if ( !suppressaudio && isspreadweapon && isdefined( damager.pelletdmg ) && isdefined( damager.pelletdmg[ timestring ] ) && isdefined( damager.pelletdmg[ timestring ][ victim.guid ] ) && damager.pelletdmg[ timestring ][ victim.guid ] > 1 )
        {
            if ( waskilled )
            {
                suppressaudio = 1;
            }
            else
            {
                allowdamagefeedback = 0;
            }
        }
        
        killingblow = undefined;
        
        if ( victim.health <= idamage )
        {
            killingblow = 1;
        }
        
        headshot = isheadshot( sweapon, shitloc, smeansofdeath, eattacker );
        
        if ( istrue( self.var_61bfafe53cf69323 ) )
        {
            allowdamagefeedback = 0;
        }
        
        if ( allowdamagefeedback )
        {
            if ( isdefined( eattacker ) )
            {
                if ( isdefined( eattacker.owner ) )
                {
                    eattacker.owner thread updatedamagefeedback( typehit, killingblow, idamage, headshot, 0, eattacker, einflictor, eattacker, 0 );
                    return;
                }
                
                eattacker thread updatedamagefeedback( typehit, killingblow, idamage, headshot, 0, eattacker, einflictor, eattacker, 0 );
            }
        }
    }
}

// Namespace damagefeedback / scripts\cp\damagefeedback
// Params 9
// Checksum 0x0, Offset: 0xb7f
// Size: 0x35e
function updatedamagefeedback( hitmarkertype, killingblow, damage, headshot, armorhit, agent, inflictor, attacker, suppressaudio )
{
    if ( isdefined( level.friendly_damage_check ) && [[ level.friendly_damage_check ]]( agent, inflictor, attacker ) )
    {
        return;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( hitmarkertype ) )
    {
        hitmarkertype = "standard";
    }
    
    if ( getdvarint( @"hash_553350ce7343ff76", 0 ) == 1 )
    {
        suppressaudio = 1;
    }
    
    if ( !isdefined( suppressaudio ) )
    {
        suppressaudio = 0;
    }
    
    if ( ( !isdefined( level.damagefeedbacknosound ) || !level.damagefeedbacknosound ) && !suppressaudio )
    {
        if ( !isdefined( self.hitmarkeraudioevents ) )
        {
            self.hitmarkeraudioevents = 0;
        }
        
        self.hitmarkeraudioevents++;
        self setclientomnvar( "ui_hitmarker_audio_events", self.hitmarkeraudioevents % 16 );
    }
    
    if ( getdvarint( @"scr_nohitmarker", 1 ) != 0 && hitmarkertype != "hittrophysystem" && hitmarkertype != "hitveharmor" && hitmarkertype != "hitvehstandard" && hitmarkertype != "hitveharmorbreak" && hitmarkertype != "hitarmorheavy" && hitmarkertype != "hitarmorheavybreak" && hitmarkertype != "hitarmorlightbreak" && hitmarkertype != "hithelmetlightbreak" && hitmarkertype != "hithelmetheavybreak" && hitmarkertype != "hitvehcritical" && hitmarkertype != "hitnobulletdamage" && hitmarkertype != "hitlaststand_stimpistol" && hitmarkertype != "hitjuggernaut" && hitmarkertype != "hitjuggernautrecon" )
    {
        return;
    }
    
    switch ( hitmarkertype )
    {
        case #"hash_db653a4972b3c13b":
            break;
        case #"hash_83eadc5c16357f57":
        case #"hash_856ee6fdc18a0b94":
            hitmarkertype = "standard";
            headshot = 1;
            break;
        case #"hash_61959c2fc4a90fd4":
            hitmarkertype = "standard";
            headshot = 0;
        case #"hash_18392ddb8b61cb4":
        case #"hash_21506e0eab793b6d":
        case #"hash_251e2c7ad46ab2a1":
        case #"hash_286b270eeb92acab":
        case #"hash_2fc100f2b74f0620":
        case #"hash_350f19f266bbb791":
        case #"hash_3c687341f7275bb2":
        case #"hash_3dfff68d08667b7e":
        case #"hash_4bdab969a8904cac":
        case #"hash_5b770c686e85a82a":
        case #"hash_6145e54d4160575d":
        case #"hash_635a3ba72a0e2577":
        case #"hash_645b9186bb9ba5b1":
        case #"hash_7bee0512ecd80819":
        case #"hash_93712eceeb1ff510":
        case #"hash_a1c8ae5eec4e0bc2":
        case #"hash_a54ca25c946c6e33":
        case #"hash_ab41a90fc8743bb8":
        case #"hash_c1715405ce8d27ea":
        case #"hash_c58cc85ba9fb86d4":
        case #"hash_cbc78f7c7ad72ad1":
        case #"hash_ee12fcbe8afdf751":
            if ( !istrue( killingblow ) )
            {
                self setclientomnvar( "damage_feedback_icon", hitmarkertype );
                self setclientomnvar( "damage_feedback_icon_notify", gettime() );
            }
            
            break;
        default:
            break;
    }
    
    updatehitmarker( hitmarkertype, headshot, damage, armorhit, killingblow, 0 );
}

// Namespace damagefeedback / scripts\cp\damagefeedback
// Params 6
// Checksum 0x0, Offset: 0xee5
// Size: 0x18b
function updatehitmarker( markertype, headshot, damage, armorhit, killingblow, nonplayer )
{
    if ( scripts\cp_mp\damagefeedback::function_fa167eb35ec0eeea() )
    {
        return;
    }
    
    if ( !isdefined( markertype ) )
    {
        return;
    }
    
    if ( markertype == "" )
    {
        markertype = "standard";
    }
    
    if ( !isdefined( markertype ) )
    {
        return;
    }
    
    if ( !isdefined( killingblow ) )
    {
        killingblow = 0;
    }
    
    if ( !isdefined( headshot ) )
    {
        headshot = 0;
    }
    
    if ( !isdefined( armorhit ) )
    {
        armorhit = 0;
    }
    
    if ( !isdefined( nonplayer ) )
    {
        nonplayer = 0;
    }
    
    if ( !isplayer( self ) )
    {
        if ( isdefined( self.owner ) && isplayer( self.owner ) )
        {
            return;
        }
    }
    
    priority = gethitmarkerpriority( markertype );
    
    if ( isdefined( self.lasthitmarkertime ) && self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !killingblow )
    {
        return;
    }
    
    self.lasthitmarkertime = gettime();
    self.lasthitmarkerpriority = priority;
    self setclientomnvar( "damage_feedback", markertype );
    self setclientomnvar( "damage_feedback_notify", gettime() );
    
    if ( killingblow )
    {
        self setclientomnvar( "damage_feedback_kill", 1 );
    }
    else
    {
        self setclientomnvar( "damage_feedback_kill", 0 );
    }
    
    if ( headshot )
    {
        self setclientomnvar( "damage_feedback_headshot", 1 );
    }
    else
    {
        self setclientomnvar( "damage_feedback_headshot", 0 );
    }
    
    if ( nonplayer )
    {
        self setclientomnvar( "damage_feedback_nonplayer", 1 );
        return;
    }
    
    self setclientomnvar( "damage_feedback_nonplayer", 0 );
}

// Namespace damagefeedback / scripts\cp\damagefeedback
// Params 2
// Checksum 0x0, Offset: 0x1078
// Size: 0x55
function function_cb98b2b16c183664( vehicle, damagedata )
{
    if ( !isdefined( damagedata ) || !isdefined( damagedata.attacker ) || !isplayer( damagedata.attacker ) )
    {
        return;
    }
    
    damagedata.attacker updatedamagefeedback( "hitveharmor" );
}

// Namespace damagefeedback / scripts\cp\damagefeedback
// Params 2
// Checksum 0x0, Offset: 0x10d5
// Size: 0xc0
function function_974320dd370c5572( vehicle, damagedata )
{
    if ( !isdefined( damagedata ) || !isdefined( damagedata.attacker ) || !isplayer( damagedata.attacker ) )
    {
        return;
    }
    
    if ( isdefined( damagedata.attacker ) && isplayer( damagedata.attacker ) )
    {
        damagedata.attacker thread updatedamagefeedback( "hitveharmorbreak" );
    }
    
    if ( isdefined( self.aidriver ) )
    {
        level notify( "armorplate_broken", damagedata.attacker );
    }
    
    if ( scripts\engine\utility::issharedfuncdefined( "veh9_techo_rebel_armor", "launchArmorPlate" ) )
    {
        [[ getsharedfunc( "veh9_techo_rebel_armor", "launchArmorPlate" ) ]]( damagedata );
    }
}

