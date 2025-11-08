#using scripts\common\utility;

#namespace c_jup_warlord_chemist;

// Namespace c_jup_warlord_chemist / namespace_f6e904bdff535ba4
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xec
// Size: 0x9b
function private autoexec init()
{
    character = #"c_jup_warlord_chemist";
    
    if ( !isdefined( level.fncharacter ) )
    {
        level.fncharacter = [];
    }
    
    if ( !isdefined( level.fncharacterprecache ) )
    {
        level.fncharacterprecache = [];
    }
    
    if ( !isdefined( level.fncharacterxmodelalias ) )
    {
        level.fncharacterxmodelalias = [];
    }
    
    level.fncharacter[ character ] = &main;
    
    if ( issp() )
    {
        level.fncharacterprecache[ character ] = &precache_sp;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_warlord_chemist / namespace_f6e904bdff535ba4
// Params 0
// Checksum 0x0, Offset: 0x18f
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "warlord_chemist";
    self.voice = #"unitednationsfemale";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_ext_chemist" );
    self attach( "head_c_jup_ext_chemist", "", 1 );
    self.headmodel = "head_c_jup_ext_chemist";
    self setclothtype( #"vestlight" );
    self setgeartype( #"milmedgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_warlord_chemist / namespace_f6e904bdff535ba4
// Params 0
// Checksum 0x0, Offset: 0x252
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_warlord_chemist / namespace_f6e904bdff535ba4
// Params 0
// Checksum 0x0, Offset: 0x25c
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_ext_chemist" );
    precachemodel( "head_c_jup_ext_chemist" );
}

// Namespace c_jup_warlord_chemist / namespace_f6e904bdff535ba4
// Params 0
// Checksum 0x0, Offset: 0x283
// Size: 0x9
function precache_cpmp()
{
    precache();
}

