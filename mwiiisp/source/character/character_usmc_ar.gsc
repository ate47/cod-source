#using scripts\common\utility;

#namespace character_usmc_ar;

// Namespace character_usmc_ar / character\character_usmc_ar
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xa2
// Size: 0x9a
function private autoexec init()
{
    character = #"character_usmc_ar";
    
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

// Namespace character_usmc_ar / character\character_usmc_ar
// Params 0
// Checksum 0x0, Offset: 0x144
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"unitedstates";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_usmc_ar" );
    self attach( "head_usmc_lmg", "", 1 );
    self.headmodel = "head_usmc_lmg";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_usmc_ar / character\character_usmc_ar
// Params 0
// Checksum 0x0, Offset: 0x207
// Size: 0x2
function precache()
{
    
}

// Namespace character_usmc_ar / character\character_usmc_ar
// Params 0
// Checksum 0x0, Offset: 0x211
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_usmc_ar" );
    precachemodel( "head_usmc_lmg" );
}

// Namespace character_usmc_ar / character\character_usmc_ar
// Params 0
// Checksum 0x0, Offset: 0x238
// Size: 0x9
function precache_cpmp()
{
    precache();
}

