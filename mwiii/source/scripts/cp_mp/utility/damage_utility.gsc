#using scripts\common\utility;
#using scripts\engine\utility;

#namespace damage_utility;

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 4
// Checksum 0x0, Offset: 0x47f
// Size: 0xcd
function adddamagemodifier( id, modifier, additive, ignorefunc )
{
    if ( !isdefined( additive ) )
    {
        additive = 1;
    }
    
    if ( additive )
    {
        if ( !isdefined( self.additivedamagemodifiers ) )
        {
            self.additivedamagemodifiers = [];
        }
        
        self.additivedamagemodifiers[ id ] = modifier;
        
        if ( isdefined( ignorefunc ) )
        {
            if ( !isdefined( self.additivedamagemodifierignorefuncs ) )
            {
                self.additivedamagemodifierignorefuncs = [];
            }
            
            self.additivedamagemodifierignorefuncs[ id ] = ignorefunc;
        }
        
        return;
    }
    
    if ( !isdefined( self.multiplicativedamagemodifiers ) )
    {
        self.multiplicativedamagemodifiers = [];
    }
    
    self.multiplicativedamagemodifiers[ id ] = modifier;
    
    if ( isdefined( ignorefunc ) )
    {
        if ( !isdefined( self.multiplicativedamagemodifierignorefuncs ) )
        {
            self.multiplicativedamagemodifierignorefuncs = [];
        }
        
        self.multiplicativedamagemodifierignorefuncs[ id ] = ignorefunc;
    }
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 2
// Checksum 0x0, Offset: 0x554
// Size: 0x87
function removedamagemodifier( id, additive )
{
    if ( !isdefined( additive ) )
    {
        additive = 1;
    }
    
    if ( additive )
    {
        if ( !isdefined( self.additivedamagemodifiers ) )
        {
            return;
        }
        
        self.additivedamagemodifiers[ id ] = undefined;
        
        if ( !isdefined( self.additivedamagemodifierignorefuncs ) )
        {
            return;
        }
        
        self.additivedamagemodifierignorefuncs[ id ] = undefined;
        return;
    }
    
    if ( !isdefined( self.multiplicativedamagemodifiers ) )
    {
        return;
    }
    
    self.multiplicativedamagemodifiers[ id ] = undefined;
    
    if ( !isdefined( self.multiplicativedamagemodifierignorefuncs ) )
    {
        return;
    }
    
    self.multiplicativedamagemodifierignorefuncs[ id ] = undefined;
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 7
// Checksum 0x0, Offset: 0x5e3
// Size: 0x198
function getdamagemodifiertotal( inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc )
{
    additivetotal = 1;
    
    if ( isdefined( self.additivedamagemodifiers ) )
    {
        foreach ( index, modifier in self.additivedamagemodifiers )
        {
            ignoremodifier = 0;
            
            if ( isdefined( self.additivedamagemodifierignorefuncs ) && isdefined( self.additivedamagemodifierignorefuncs[ index ] ) )
            {
                ignoremodifier = [[ self.additivedamagemodifierignorefuncs[ index ] ]]( inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc );
            }
            
            if ( !ignoremodifier )
            {
                additivetotal += modifier - 1;
            }
        }
    }
    
    var_1cbf01d0df82cde7 = 1;
    
    if ( isdefined( self.multiplicativedamagemodifiers ) )
    {
        foreach ( index, modifier in self.multiplicativedamagemodifiers )
        {
            ignoremodifier = 0;
            
            if ( isdefined( self.multiplicativedamagemodifierignorefuncs ) && isdefined( self.multiplicativedamagemodifierignorefuncs[ index ] ) )
            {
                ignoremodifier = [[ self.multiplicativedamagemodifierignorefuncs[ index ] ]]( inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc );
            }
            
            if ( !ignoremodifier )
            {
                var_1cbf01d0df82cde7 *= modifier;
            }
        }
    }
    
    return additivetotal * var_1cbf01d0df82cde7;
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 0
// Checksum 0x0, Offset: 0x784
// Size: 0x2a
function cleardamagemodifiers()
{
    self.additivedamagemodifiers = [];
    self.multiplicativedamagemodifiers = [];
    self.additivedamagemodifierignorefuncs = [];
    self.multiplicativedamagemodifierignorefuncs = [];
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 16
// Checksum 0x0, Offset: 0x7b6
// Size: 0x1a3
function packdamagedata( attacker, victim, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, attachtagname, partname, tagname, idflags, eventid, hitloc, lightarmordamage )
{
    struct = spawnstruct();
    struct.attacker = attacker;
    struct.victim = victim;
    struct.damage = damage;
    struct.objweapon = objweapon;
    struct.meansofdeath = meansofdeath;
    struct.inflictor = inflictor;
    struct.point = point;
    struct.direction_vec = direction_vec;
    struct.modelname = modelname;
    struct.attachtagname = attachtagname;
    struct.partname = partname;
    struct.tagname = tagname;
    struct.idflags = idflags;
    struct.damageflags = idflags;
    struct.eventid = eventid;
    struct.hitloc = hitloc;
    struct.lightarmordamage = lightarmordamage;
    
    if ( isdefined( struct.attacker ) )
    {
        struct.attacker.assistedsuicide = 0;
    }
    
    return struct;
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 2
// Checksum 0x0, Offset: 0x962
// Size: 0x8f, Type: bool
function isstuckdamage( data, var_9b97f4ba6bdc58be )
{
    if ( istrue( self.forcestuckdamage ) )
    {
        return true;
    }
    
    if ( isdefined( self.stuckbygrenade ) )
    {
        if ( isdefined( data.inflictor ) && data.inflictor == self.stuckbygrenade )
        {
            if ( istrue( var_9b97f4ba6bdc58be ) )
            {
                return true;
            }
            else if ( isexplosivedamagemod( data.meansofdeath ) || data.meansofdeath == "MOD_FIRE" )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 1
// Checksum 0x0, Offset: 0x9fa
// Size: 0x1c, Type: bool
function iscrossbowdamage( objweapon )
{
    return objweapon.basename == "iw9_dm_crossbow_mp";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 1
// Checksum 0x0, Offset: 0xa1f
// Size: 0x2b, Type: bool
function function_6065fce6cdcad( objweapon )
{
    return objweapon.basename == "iw9_dm_crossbow_mp" && objweapon hasattachment( "ammo_bolt_he" );
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 1
// Checksum 0x0, Offset: 0xa53
// Size: 0x2b, Type: bool
function function_d49206e61ac4f6de( objweapon )
{
    return objweapon.basename == "iw9_dm_crossbow_mp" && objweapon hasattachment( "ammo_bolt_db" );
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 1
// Checksum 0x0, Offset: 0xa87
// Size: 0x110, Type: bool
function isstuckdamagekill( data )
{
    if ( istrue( self.nostuckdamagekill ) )
    {
        return false;
    }
    
    if ( !isstuckdamage( data, 0 ) )
    {
        return false;
    }
    
    if ( issubstr( data.objweapon.basename, "molotov_mp" ) )
    {
        return false;
    }
    else if ( issubstr( data.objweapon.basename, "thermite_mp" ) )
    {
        return false;
    }
    else if ( issubstr( data.objweapon.basename, "thermite_ap_mp" ) )
    {
        return false;
    }
    else if ( issubstr( data.objweapon.basename, "thermite_av_mp" ) )
    {
        return false;
    }
    else if ( issubstr( data.objweapon.basename, "bunkerbuster_mp" ) )
    {
        return false;
    }
    else if ( issubstr( data.objweapon.basename, "bunkerbuster_burrowed_mp" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 0
// Checksum 0x0, Offset: 0xba0
// Size: 0xd
function forcestuckdamage()
{
    self.forcestuckdamage = 1;
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 0
// Checksum 0x0, Offset: 0xbb5
// Size: 0xc
function forcestuckdamageclear()
{
    self.forcestuckdamage = undefined;
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0xbc9
// Size: 0x46, Type: bool
function isheadshot( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    if ( smeansofdeath == "MOD_GRENADE" )
    {
        return false;
    }
    
    return shitloc == "head" || shitloc == "helmet";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 1
// Checksum 0x0, Offset: 0xc18
// Size: 0x3a, Type: bool
function function_b656251147d7d40b( partname )
{
    if ( !isdefined( partname ) )
    {
        return false;
    }
    
    return partname == "j_head" || partname == "j_helmet" || partname == "j_neck" || partname == "tag_eye";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 2
// Checksum 0x0, Offset: 0xc5b
// Size: 0xcd, Type: bool
function validshotcheck( smeansofdeath, attacker )
{
    if ( isdefined( attacker ) )
    {
        if ( isdefined( attacker.owner ) )
        {
            switch ( attacker.code_classname )
            {
                case #"hash_3872eb7d97592cac":
                case #"hash_4af55147c6098215":
                case #"hash_81903cb95a447b8c":
                    return false;
            }
        }
    }
    
    switch ( smeansofdeath )
    {
        case #"hash_5535eab3e2a8ea5b":
        case #"hash_a5123f4d02745600":
        case #"hash_a911a1880d996edb":
        case #"hash_abb1587cdc6def23":
        case #"hash_b1078ff213fddba6":
        case #"hash_b8c93baeb44b5c94":
        case #"hash_c4e2346b247a4e57":
        case #"hash_d8646db4e6ee3658":
            return false;
    }
    
    return true;
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 0
// Checksum 0x0, Offset: 0xd31
// Size: 0x139
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
    function_8bba4c474cb4043a( "j_mainroot" );
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xe72
// Size: 0x1d
function private function_8bba4c474cb4043a( str )
{
    level.var_d43e78e513933216[ function_3db00f01cdba4538( str ) ] = str;
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 1
// Checksum 0x0, Offset: 0xe97
// Size: 0x41
function function_edefa1e693dd3c7d( var_f46544d32b6b992e )
{
    if ( !function_28eeffcb2337321e( var_f46544d32b6b992e ) )
    {
        return var_f46544d32b6b992e;
    }
    
    if ( !isdefined( level.var_d43e78e513933216 ) || !isdefined( level.var_d43e78e513933216[ var_f46544d32b6b992e ] ) )
    {
        return var_f46544d32b6b992e;
    }
    
    return level.var_d43e78e513933216[ var_f46544d32b6b992e ];
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0xee1
// Size: 0x3e, Type: bool
function istorsoshot( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return istorsouppershot( shitloc, smeansofdeath, attacker ) || function_77ed09d75c0c7165( shitloc, smeansofdeath, attacker );
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0xf28
// Size: 0x3a, Type: bool
function istorsouppershot( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "neck" || shitloc == "torso_upper";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 1
// Checksum 0x0, Offset: 0xf6b
// Size: 0xb2
function function_dcdde2598f1bdfc0( partname )
{
    var_ee272d22135e6099 = 0;
    
    if ( isdefined( partname ) )
    {
        switch ( partname )
        {
            case #"hash_52bdc7a0500be8b":
            case #"hash_58a0c7a054aabcd":
            case #"hash_270342211f93c022":
            case #"hash_274912211fcb218c":
            case #"hash_68e40995148f2457":
            case #"hash_a61118340cc1bc57":
            case #"hash_b68fa57896eba8d3":
            case #"hash_d332e6054003402b":
            case #"hash_d3921605404ec06d":
            case #"hash_d6c67a869aa3949f":
            case #"hash_d70b82869ad9bb31":
                var_ee272d22135e6099 = 1;
                break;
        }
    }
    
    return var_ee272d22135e6099;
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x1026
// Size: 0x2f, Type: bool
function function_77ed09d75c0c7165( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "torso_lower";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 1
// Checksum 0x0, Offset: 0x105e
// Size: 0x46
function function_255c1a4a52956161( partname )
{
    var_9a4f72b70e38d234 = 0;
    
    if ( isdefined( partname ) )
    {
        switch ( partname )
        {
            case #"hash_75d098324e281f06":
            case #"hash_9f7ecb3109291edc":
                var_9a4f72b70e38d234 = 1;
                break;
        }
    }
    
    return var_9a4f72b70e38d234;
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x10ad
// Size: 0x3e, Type: bool
function isarmshot( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return isrightarmshot( shitloc, smeansofdeath, attacker ) || isleftarmshot( shitloc, smeansofdeath, attacker );
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x10f4
// Size: 0x3e, Type: bool
function isrightarmshot( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return function_24278eb0ec1e2953( shitloc, smeansofdeath, attacker ) || function_bf1efc7185168448( shitloc, smeansofdeath, attacker );
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x113b
// Size: 0x3e, Type: bool
function isleftarmshot( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return function_82850161196df912( shitloc, smeansofdeath, attacker ) || function_d7395809e0049a49( shitloc, smeansofdeath, attacker );
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x1182
// Size: 0x2f, Type: bool
function function_24278eb0ec1e2953( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "right_arm_upper";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x11ba
// Size: 0x2f, Type: bool
function function_82850161196df912( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "left_arm_upper";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x11f2
// Size: 0x3a, Type: bool
function function_bf1efc7185168448( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "right_arm_lower" || shitloc == "right_hand";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x1235
// Size: 0x3a, Type: bool
function function_d7395809e0049a49( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "left_arm_lower" || shitloc == "left_hand";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x1278
// Size: 0x3e, Type: bool
function islegshot( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return isrightlegshot( shitloc, smeansofdeath, attacker ) || isleftlegshot( shitloc, smeansofdeath, attacker );
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x12bf
// Size: 0x3e, Type: bool
function isrightlegshot( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return function_4536856e83718dbd( shitloc, smeansofdeath, attacker ) || function_2eef344e0f951a1a( shitloc, smeansofdeath, attacker );
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x1306
// Size: 0x3e, Type: bool
function isleftlegshot( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return function_275e2a90a59b872c( shitloc, smeansofdeath, attacker ) || function_da1a82d3ae010f8b( shitloc, smeansofdeath, attacker );
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x134d
// Size: 0x2f, Type: bool
function function_4536856e83718dbd( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "right_leg_upper";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x1385
// Size: 0x2f, Type: bool
function function_275e2a90a59b872c( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "left_leg_upper";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x13bd
// Size: 0x3a, Type: bool
function function_2eef344e0f951a1a( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "right_leg_lower" || shitloc == "right_foot";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x1400
// Size: 0x3a, Type: bool
function function_da1a82d3ae010f8b( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "left_leg_lower" || shitloc == "left_foot";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x1443
// Size: 0x5b, Type: bool
function islefthandshot( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "right_hand" || shitloc == "left_hand" || shitloc == "right_arm_lower" || shitloc == "left_arm_lower" || shitloc == "gun";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x14a7
// Size: 0x5b, Type: bool
function function_6720f01c6abbcad4( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "right_hand" || shitloc == "left_hand" || shitloc == "right_arm_lower" || shitloc == "left_arm_lower" || shitloc == "gun";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x150b
// Size: 0x5b, Type: bool
function ishandshot( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "right_hand" || shitloc == "left_hand" || shitloc == "right_arm_lower" || shitloc == "left_arm_lower" || shitloc == "gun";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x156f
// Size: 0x2f, Type: bool
function function_8aea541c52417dfd( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "right_foot";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x15a7
// Size: 0x2f, Type: bool
function function_79daddb5d9b1b30( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "left_foot";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x15df
// Size: 0x3a, Type: bool
function isfootshot( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "right_foot" || shitloc == "left_foot";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x1622
// Size: 0x2f, Type: bool
function isneckshot( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    return shitloc == "neck";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x165a
// Size: 0xb9, Type: bool
function isupperbodyshot( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    switch ( shitloc )
    {
        case #"hash_da51cc36a471058":
        case #"hash_1cbc508a2fe01b79":
        case #"hash_51d5d0b9add9cc5a":
        case #"hash_5d5aac570f6fd382":
        case #"hash_810a7426c8bac3ac":
        case #"hash_92bbfe494d03d772":
        case #"hash_a7980c387477e7bb":
        case #"hash_b275b50677dcf6cb":
        case #"hash_d42e71cd9f1e822f":
        case #"hash_da2f35145aa58933":
        case #"hash_fbb61fc356f3c75e":
            return true;
    }
    
    return false;
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 3
// Checksum 0x0, Offset: 0x171c
// Size: 0x7d, Type: bool
function islowerbodyshot( shitloc, smeansofdeath, attacker )
{
    if ( !validshotcheck( smeansofdeath, attacker ) )
    {
        return false;
    }
    
    switch ( shitloc )
    {
        case #"hash_168c74e879f0ba11":
        case #"hash_1cbc508a2fe01b79":
        case #"hash_7b36142458a6c2d5":
        case #"hash_810a7426c8bac3ac":
        case #"hash_9536712388e65bce":
        case #"hash_a638fec9040cfcf4":
            return true;
    }
    
    return false;
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 1
// Checksum 0x0, Offset: 0x17a2
// Size: 0x32, Type: bool
function function_cb9ba92488b23c5( objweapon )
{
    return isdefined( objweapon ) && isdefined( objweapon.basename ) && objweapon.basename == "danger_circle_br";
}

// Namespace damage_utility / scripts\cp_mp\utility\damage_utility
// Params 1
// Checksum 0x0, Offset: 0x17dd
// Size: 0x3b
function register_vehicle_damage_callback( func )
{
    if ( !isdefined( level.var_2d3abe16d5e2ffe6 ) )
    {
        level.var_2d3abe16d5e2ffe6 = [];
    }
    
    level.var_2d3abe16d5e2ffe6 = array_add( level.var_2d3abe16d5e2ffe6, func );
}

