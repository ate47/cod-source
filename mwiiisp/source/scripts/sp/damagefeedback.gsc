#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\sp\debug;
#using scripts\sp\hud_util;

#namespace damagefeedback;

// Namespace damagefeedback / scripts\sp\damagefeedback
// Params 0
// Checksum 0x0, Offset: 0x337
// Size: 0x83
function init()
{
    function_abfcdee8fda20a4();
    
    if ( getdvarint( @"hash_f07ae454d79d2299" ) )
    {
        return;
    }
    
    level.hitmarkerpriorities = [];
    level.hitmarkerpriorities[ "low_damage" ] = 35;
    level.hitmarkerpriorities[ "standard" ] = 50;
    level.hitmarkerpriorities[ "standard_cp" ] = 50;
    level.hitmarkerpriorities[ "high_damage" ] = 85;
    registersharedfunc( "hitmarker", "updateDamageFeedback_SharedFunc", &updatedamagefeedback );
}

// Namespace damagefeedback / scripts\sp\damagefeedback
// Params 10
// Checksum 0x0, Offset: 0x3c2
// Size: 0x120
function damagefeedback_took_damage( damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon )
{
    if ( getdvarint( @"hash_f07ae454d79d2299" ) )
    {
        return;
    }
    
    if ( !isdefined( attacker ) || !isplayer( attacker ) || attacker == self || damage <= 0 )
    {
        return;
    }
    
    typehit = "standard";
    hitmarkertype = "standard";
    
    if ( isdefined( objweapon ) )
    {
        if ( damage <= weapongetdamagemin( objweapon ) )
        {
            hitmarkertype = "low_damage";
        }
        else if ( damage >= weapongetdamagemax( objweapon ) )
        {
            hitmarkertype = "high_damage";
        }
    }
    
    waskilled = 0;
    headshot = 0;
    
    if ( isai( self ) )
    {
        waskilled = !isalive( self );
        headshot = isheadshot( partname );
    }
    
    level.player thread updatedamagefeedback( typehit, waskilled, headshot, hitmarkertype, self );
}

// Namespace damagefeedback / scripts\sp\damagefeedback
// Params 5
// Checksum 0x0, Offset: 0x4ea
// Size: 0x12d
function updatedamagefeedback( icontype, killingblow, headshot, hitmarkertype, victim )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( hitmarkertype ) )
    {
        hitmarkertype = "standard";
    }
    
    switch ( icontype )
    {
        case #"hash_b7211051d1c74da":
        case #"hash_251e2c7ad46ab2a1":
        case #"hash_2f87b65a1756fbc1":
        case #"hash_2fc100f2b74f0620":
        case #"hash_37478a6383bb736d":
        case #"hash_5f73db46ecb712e5":
        case #"hash_83eadc5c16357f57":
        case #"hash_a1c8ae5eec4e0bc2":
        case #"hash_a38fa9efabd2c0a4":
        case #"hash_eafcd4d14551921f":
        case #"hash_f3a481e6812a61ae":
        case #"hash_ff2b6c8c33ed9959":
            setomnvar( "damage_feedback_icon", icontype );
            self setclientomnvar( "damage_feedback_icon_notify", gettime() );
            updatehitmarker( hitmarkertype, killingblow, headshot );
            break;
        case #"hash_db653a4972b3c13b":
            break;
        default:
            updatehitmarker( hitmarkertype, killingblow, headshot, victim );
            break;
    }
}

// Namespace damagefeedback / scripts\sp\damagefeedback
// Params 4
// Checksum 0x0, Offset: 0x61f
// Size: 0x132
function updatehitmarker( markertype, killingblow, headshot, victim )
{
    if ( getdvarint( @"hash_2fb5684532ad1a80" ) )
    {
        return;
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
    
    if ( isdefined( victim ) && isdefined( victim.team ) && victim.team == "allies" )
    {
        return;
    }
    
    priority = gethitmarkerpriority( markertype );
    
    if ( isdefined( self.lasthitmarkertime ) && self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !killingblow )
    {
        return;
    }
    
    self.lasthitmarkertime = gettime();
    self.lasthitmarkerpriority = priority;
    setomnvar( "damage_feedback", markertype );
    self setclientomnvar( "damage_feedback_notify", gettime() );
    
    if ( killingblow )
    {
        setomnvar( "damage_feedback_kill", 1 );
    }
    else
    {
        setomnvar( "damage_feedback_kill", 0 );
    }
    
    if ( headshot )
    {
        setomnvar( "damage_feedback_headshot", 1 );
        return;
    }
    
    setomnvar( "damage_feedback_headshot", 0 );
}

// Namespace damagefeedback / scripts\sp\damagefeedback
// Params 1
// Checksum 0x0, Offset: 0x759
// Size: 0x27
function gethitmarkerpriority( hitmarkertype )
{
    if ( !isdefined( level.hitmarkerpriorities[ hitmarkertype ] ) )
    {
        return 0;
    }
    
    return level.hitmarkerpriorities[ hitmarkertype ];
}

// Namespace damagefeedback / scripts\sp\damagefeedback
// Params 1
// Checksum 0x0, Offset: 0x789
// Size: 0x5d, Type: bool
function isheadshot( partname )
{
    if ( !isdefined( partname ) )
    {
        return false;
    }
    
    switch ( partname )
    {
        case #"hash_402665c8637b5f05":
        case #"hash_81f205214676388c":
        case #"hash_957ea3718a588bda":
        case #"hash_de9ffaed3aaf2f50":
            return true;
        default:
            return false;
    }
    
    return false;
}

// Namespace damagefeedback / scripts\sp\damagefeedback
// Params 0
// Checksum 0x0, Offset: 0x7ef
// Size: 0x12d
function function_abfcdee8fda20a4()
{
    if ( !isdefined( level.var_d43e78e513933216 ) )
    {
        level.var_d43e78e513933216 = [];
    }
    
    function_8bba4c474cb4043a( "j_head" );
    function_8bba4c474cb4043a( "j_helmet" );
    function_8bba4c474cb4043a( "j_neck" );
    function_8bba4c474cb4043a( "tag_eye" );
    function_8bba4c474cb4043a( "j_chest" );
    function_8bba4c474cb4043a( "j_spineupper" );
    function_8bba4c474cb4043a( "j_spine4" );
    function_8bba4c474cb4043a( "j_spinelower" );
    function_8bba4c474cb4043a( "j_spinelower2" );
    function_8bba4c474cb4043a( "j_clavicle_ri" );
    function_8bba4c474cb4043a( "j_clavicle_le" );
    function_8bba4c474cb4043a( "j_shoulder_ri" );
    function_8bba4c474cb4043a( "j_shoulder_le" );
    function_8bba4c474cb4043a( "j_elbow_le" );
    function_8bba4c474cb4043a( "j_elbow_ri" );
    function_8bba4c474cb4043a( "j_wrist_le" );
    function_8bba4c474cb4043a( "j_wrist_ri" );
    function_8bba4c474cb4043a( "j_hip_ri" );
    function_8bba4c474cb4043a( "j_hip_le" );
    function_8bba4c474cb4043a( "j_knee_ri" );
    function_8bba4c474cb4043a( "j_knee_le" );
    function_8bba4c474cb4043a( "j_ankle_ri" );
    function_8bba4c474cb4043a( "j_ankle_le" );
}

// Namespace damagefeedback / scripts\sp\damagefeedback
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x924
// Size: 0x1d
function private function_8bba4c474cb4043a( str )
{
    level.var_d43e78e513933216[ function_3db00f01cdba4538( str ) ] = str;
}

