#using scripts\asm\asm_bb;
#using scripts\asm\cap;
#using scripts\engine\utility;

#namespace cap_use_armor_plate_solo;

// Namespace cap_use_armor_plate_solo / namespace_f8aba4f0ef4843d6
// Params 3
// Checksum 0x0, Offset: 0x1b5
// Size: 0x105
function function_6c3d4156dec73e1d( asmname, statename, params )
{
    stance = scripts\asm\asm_bb::bb_getrequestedstance();
    coverstate = scripts\asm\asm_bb::bb_getrequestedcoverstate();
    animname = "default";
    
    if ( coverstate == "exposed" )
    {
        animname = "exposed_" + stance;
    }
    else
    {
        covernode = scripts\asm\asm_bb::bb_getcovernode();
        
        if ( isdefined( covernode ) )
        {
            covertype = covernode.type;
            
            switch ( covertype )
            {
                case #"hash_cd3ffe799551db82":
                    animname = "cover_right_" + stance;
                    break;
                case #"hash_e1d8e1adebed5a61":
                    animname = "cover_left_" + stance;
                    break;
                case #"hash_c3b74422dec48736":
                    animname = "cover_crouch";
                    break;
                case #"hash_78b110033ccb68b0":
                    animname = "cover_stand";
                    break;
            }
        }
    }
    
    armoranim = scripts\asm\cap::cap_lookupanimfromalias( statename, animname );
    return armoranim;
}

// Namespace cap_use_armor_plate_solo / namespace_f8aba4f0ef4843d6
// Params 3
// Checksum 0x0, Offset: 0x2c3
// Size: 0x42
function function_45dc5e082d9a020f( asmname, statename, params )
{
    /#
        utility::issharedfuncdefined( "<dev string:x1c>", "<dev string:x22>", 1 );
    #/
    
    utility::callsharedfunc( "ai", "onUsedArmorPlate" );
}

// Namespace cap_use_armor_plate_solo / namespace_f8aba4f0ef4843d6
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x30d
// Size: 0x3f
function private isrighthand( note )
{
    res = 1;
    hand = getsubstr( note, 7 );
    
    if ( isdefined( hand ) && hand == "left" )
    {
        res = 0;
    }
    
    return res;
}

// Namespace cap_use_armor_plate_solo / namespace_f8aba4f0ef4843d6
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x355
// Size: 0x87
function private notehandler_armorplate( note, statename )
{
    self endon( "death" );
    self endon( statename + "_finished" );
    scriptablepart = "armor_plate";
    
    if ( isstartstr( note, "attach" ) )
    {
        if ( isrighthand( note ) )
        {
            self setscriptablepartstate( scriptablepart, "active_right" );
        }
        else
        {
            self setscriptablepartstate( scriptablepart, "active_left" );
        }
        
        return;
    }
    
    if ( isstartstr( note, "detach" ) )
    {
        self setscriptablepartstate( scriptablepart, "default" );
    }
}

// Namespace cap_use_armor_plate_solo / namespace_f8aba4f0ef4843d6
// Params 2
// Checksum 0x0, Offset: 0x3e4
// Size: 0x5a
function armorplatenotehandler( note, params )
{
    scriptablepart = "armor_plate";
    
    if ( self isscriptable() && self getscriptablehaspart( scriptablepart ) )
    {
        statename = self asmgetcurrentstate( self.asmname );
        notehandler_armorplate( note, statename );
    }
}

