#using script_24fbedba9a7a1ef4;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\engine\utility;

#namespace agent_juggernaut;

// Namespace agent_juggernaut / scripts\cp_mp\agents\agent_juggernaut
// Params 0
// Checksum 0x0, Offset: 0x248
// Size: 0x34
function function_a414fbf48ae645f4()
{
    level.var_a4123e1a53dea557 = getdvarint( @"hash_86c85cfc843c0b68", 1 );
    level.var_d49c99ad85354bd6 = getdvarint( @"hash_a433661e4f79e427", 100 );
}

// Namespace agent_juggernaut / scripts\cp_mp\agents\agent_juggernaut
// Params 0
// Checksum 0x0, Offset: 0x284
// Size: 0x175
function function_93288f91f5aabd02()
{
    juggcontext = spawnstruct();
    juggcontext.partshealth = [];
    juggcontext.partshealth[ "head_health" ] = 100;
    juggcontext.partshealth[ "damaged_helmet_health" ] = 100;
    juggcontext.partshealth[ "torso_upper_health" ] = 100;
    juggcontext.partshealth[ "torso_lower_health" ] = 100;
    juggcontext.partshealth[ "right_upper_arm_health" ] = 100;
    juggcontext.partshealth[ "right_lower_arm_health" ] = 100;
    juggcontext.partshealth[ "left_upper_arm_health" ] = 100;
    juggcontext.partshealth[ "left_lower_arm_health" ] = 100;
    juggcontext.partshealth[ "right_leg_health" ] = 100;
    juggcontext.partshealth[ "left_leg_health" ] = 100;
    juggcontext.var_5f03cad2b199e1bc = &function_f75bc5c067f4015;
    juggcontext.lastpaintime = 0;
    juggcontext.paindamage = 0;
    juggcontext.var_1bea7c00eb868a40 = 1000;
    juggcontext.paincooldown = 5000;
    juggcontext.paindecay = 10;
    juggcontext.paindecaytime = 0.1;
    juggcontext.lastdamagedtime = 0;
    juggcontext.var_a4dceeab66ec6a3c = 1000;
    self.juggcontext = juggcontext;
}

// Namespace agent_juggernaut / scripts\cp_mp\agents\agent_juggernaut
// Params 2
// Checksum 0x0, Offset: 0x401
// Size: 0xd7
function function_f75bc5c067f4015( part, damage )
{
    if ( isdefined( part ) && part == "head_health" && !isdefined( self.juggcontext.partshealth[ part ] ) )
    {
        if ( isdefined( self.juggcontext.partshealth[ "damaged_helmet_health" ] ) )
        {
            self.juggcontext.partshealth[ "damaged_helmet_health" ] = self.juggcontext.partshealth[ "damaged_helmet_health" ] - damage;
            
            if ( self.juggcontext.partshealth[ "damaged_helmet_health" ] <= 0 )
            {
                self.juggcontext.partshealth[ "damaged_helmet_health" ] = undefined;
                function_fd38d13ec4cf6449( "head_health", "destroyed" );
            }
        }
    }
}

// Namespace agent_juggernaut / scripts\cp_mp\agents\agent_juggernaut
// Params 2
// Checksum 0x0, Offset: 0x4e0
// Size: 0xc9
function function_fd38d13ec4cf6449( parts, state )
{
    if ( istrue( self.var_8081d864dc563057 ) )
    {
        return;
    }
    
    if ( !isdefined( state ) )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    partstoset = [];
    
    if ( isarray( parts ) )
    {
        partstoset = array_combine( partstoset, parts );
    }
    else
    {
        partstoset[ partstoset.size ] = parts;
    }
    
    foreach ( part in partstoset )
    {
        self setscriptablepartstate( part, state, 0 );
        
        /#
            iprintln( "<dev string:x41>" + part + "<dev string:x4a>" + state + "<dev string:x56>" );
        #/
    }
}

// Namespace agent_juggernaut / scripts\cp_mp\agents\agent_juggernaut
// Params 1
// Checksum 0x0, Offset: 0x5b1
// Size: 0x156
function function_1cbb19fc0caeab00( subtype )
{
    weapon = undefined;
    function_93288f91f5aabd02();
    thread function_ca2d7204b750d78b();
    
    if ( !isdefined( level.var_ed61c38f5c8bb414 ) )
    {
        level.var_ed61c38f5c8bb414 = [ "pristine", "damaged" ];
    }
    
    if ( !isdefined( level.var_13819795c6ee9ff8 ) )
    {
        level.var_13819795c6ee9ff8 = [ "helmet", "neckguard", "backpack", "shoulderpad_l", "shoulderpad_r", "forearmpad_l", "forearmpad_r", "qamis", "thighpad_l", "thighpad_r" ];
    }
    
    if ( isdefined( subtype ) && subtype == "merc" )
    {
        partslist = [ "neckguard", "backpack", "shoulderpad_l", "shoulderpad_r", "forearmpad_l", "forearmpad_r", "qamis", "thighpad_l", "thighpad_r" ];
    }
    else
    {
        partslist = level.var_13819795c6ee9ff8;
    }
    
    function_fd38d13ec4cf6449( partslist, "pristine" );
    self setperk( "specialty_melee_invulnerable", 1 );
}

// Namespace agent_juggernaut / scripts\cp_mp\agents\agent_juggernaut
// Params 13
// Checksum 0x0, Offset: 0x70f
// Size: 0x286
function function_1ab798a528080db2( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon )
{
    if ( isdefined( self.var_970170ffd4b081ac ) )
    {
        idamage = self [[ self.var_970170ffd4b081ac ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon );
    }
    
    if ( isdefined( level.var_d49c99ad85354bd6 ) )
    {
        if ( isdefined( level.var_a4123e1a53dea557 ) && level.var_a4123e1a53dea557 == 1 )
        {
            overflow = idamage - level.var_d49c99ad85354bd6;
            
            if ( overflow > 0 )
            {
                idamage = int( level.var_d49c99ad85354bd6 + sqrt( overflow ) );
            }
        }
        else
        {
            idamage = int( min( idamage, level.var_d49c99ad85354bd6 ) );
        }
    }
    
    remaininghealth = self.health - idamage;
    
    if ( remaininghealth <= 0 )
    {
        if ( isdefined( self.var_68c43b3ffee58999 ) )
        {
            self notify( self.var_68c43b3ffee58999 );
        }
    }
    
    if ( isdefined( self.juggcontext ) )
    {
        self.juggcontext.lastdamagedtime = gettime();
        
        if ( self.juggcontext.lastpaintime < gettime() )
        {
            if ( self.allowpain == 0 )
            {
                self.allowpain = 1;
            }
            
            self.juggcontext.paindamage += idamage;
        }
        
        if ( self.juggcontext.paindamage > self.juggcontext.var_1bea7c00eb868a40 )
        {
            self.juggcontext.lastpaintime = gettime() + self.juggcontext.paincooldown;
            self.juggcontext.paindamage = 0;
            self asmevalpaintransition( self.asmname );
            self.allowpain = 0;
        }
        
        function_fa4f1a412ab12028( idamage, shitloc, smeansofdeath, eattacker );
    }
    
    namespace_daa149ca485fd50a::function_dffac413ed66bcd0( einflictor, eattacker, int( idamage ), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon );
}

// Namespace agent_juggernaut / scripts\cp_mp\agents\agent_juggernaut
// Params 0
// Checksum 0x0, Offset: 0x99d
// Size: 0x96
function function_ca2d7204b750d78b()
{
    self endon( "death" );
    
    while ( true )
    {
        if ( gettime() - self.juggcontext.lastdamagedtime > self.juggcontext.var_a4dceeab66ec6a3c )
        {
            self.juggcontext.paindamage = max( self.juggcontext.paindamage - self.juggcontext.paindecay, 0 );
        }
        
        wait self.juggcontext.paindecaytime;
    }
}

// Namespace agent_juggernaut / scripts\cp_mp\agents\agent_juggernaut
// Params 4
// Checksum 0x0, Offset: 0xa3b
// Size: 0x69
function function_fa4f1a412ab12028( damage, shitloc, smeansofdeath, attacker )
{
    parttodamage = function_c0aa811f7b45687c( shitloc, smeansofdeath, attacker );
    
    if ( !isdefined( parttodamage ) )
    {
        if ( isdefined( attacker ) && isdefined( shitloc ) && isplayer( attacker ) )
        {
            attacker iprintln( "jugg_damageArmorParts: There are no valid parts to damage for hitloc " + shitloc );
        }
        
        return;
    }
    
    function_94b7ecf1273ba3c0( parttodamage, damage );
}

// Namespace agent_juggernaut / scripts\cp_mp\agents\agent_juggernaut
// Params 3
// Checksum 0x0, Offset: 0xaac
// Size: 0x111
function function_c0aa811f7b45687c( shitloc, smeansofdeath, attacker )
{
    parttodamage = undefined;
    
    if ( isheadshot( shitloc, smeansofdeath, attacker ) )
    {
        parttodamage = "head_health";
    }
    else if ( istorsouppershot( shitloc, smeansofdeath, attacker ) )
    {
        parttodamage = "torso_upper_health";
    }
    else if ( function_77ed09d75c0c7165( shitloc, smeansofdeath, attacker ) )
    {
        parttodamage = "torso_lower_health";
    }
    else if ( function_24278eb0ec1e2953( shitloc, smeansofdeath, attacker ) )
    {
        parttodamage = "right_upper_arm_health";
    }
    else if ( function_bf1efc7185168448( shitloc, smeansofdeath, attacker ) )
    {
        parttodamage = "right_lower_arm_health";
    }
    else if ( function_82850161196df912( shitloc, smeansofdeath, attacker ) )
    {
        parttodamage = "left_upper_arm_health";
    }
    else if ( function_d7395809e0049a49( shitloc, smeansofdeath, attacker ) )
    {
        parttodamage = "left_lower_arm_health";
    }
    else if ( isrightlegshot( shitloc, smeansofdeath, attacker ) )
    {
        parttodamage = "right_leg_health";
    }
    else if ( isleftlegshot( shitloc, smeansofdeath, attacker ) )
    {
        parttodamage = "left_leg_health";
    }
    
    /#
        if ( isdefined( shitloc ) && isdefined( attacker ) && isplayer( attacker ) )
        {
            attacker iprintlnbold( "<dev string:x58>" + shitloc );
        }
    #/
    
    return parttodamage;
}

// Namespace agent_juggernaut / scripts\cp_mp\agents\agent_juggernaut
// Params 2
// Checksum 0x0, Offset: 0xbc6
// Size: 0x212
function function_94b7ecf1273ba3c0( part, damage )
{
    if ( isdefined( self.juggcontext.var_5f03cad2b199e1bc ) )
    {
        self [[ self.juggcontext.var_5f03cad2b199e1bc ]]( part, damage );
    }
    
    if ( isdefined( self.juggcontext.partshealth[ part ] ) )
    {
        if ( part == "head_health" )
        {
            if ( isdefined( self.helmethealth ) && isdefined( self.var_cfc69e5588a5bed6 ) && self.var_cfc69e5588a5bed6 > 0 )
            {
                self.juggcontext.partshealth[ part ] = self.helmethealth / self.var_cfc69e5588a5bed6 * 10;
            }
            else
            {
                self.juggcontext.partshealth[ part ] -= damage;
            }
            
            if ( self.juggcontext.partshealth[ part ] <= 0 )
            {
                self.juggcontext.partshealth[ part ] = undefined;
                
                if ( issubstr( self.agent_type, "merc" ) )
                {
                    namespace_daa149ca485fd50a::function_59ea6b2f800cb082( self );
                }
                else
                {
                    function_fd38d13ec4cf6449( part, "destroyed" );
                }
            }
            else if ( self.juggcontext.partshealth[ part ] <= 50 )
            {
                if ( issubstr( self.agent_type, "merc" ) )
                {
                }
                else
                {
                    function_fd38d13ec4cf6449( part, "damaged" );
                }
            }
            
            return;
        }
        
        self.juggcontext.partshealth[ part ] -= damage;
        
        if ( self.juggcontext.partshealth[ part ] <= 0 )
        {
            self.juggcontext.partshealth[ part ] = undefined;
            
            if ( issubstr( self.agent_type, "merc" ) )
            {
                return;
            }
            
            function_fd38d13ec4cf6449( part, "damaged" );
        }
    }
}

