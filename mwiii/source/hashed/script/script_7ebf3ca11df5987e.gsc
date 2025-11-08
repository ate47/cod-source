#using scripts\common\utility;

#namespace character_jup_ravenov_base;

// Namespace character_jup_ravenov_base / namespace_d39d0a0e035b8064
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xc4
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_ravenov_base";
    
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

// Namespace character_jup_ravenov_base / namespace_d39d0a0e035b8064
// Params 0
// Checksum 0x0, Offset: 0x167
// Size: 0x99
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "c_jup_zmb_ravenov_fb" );
    self setclothtype( #"vestlight" );
    self setgeartype( #"milmedgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_jup_ravenov_base / namespace_d39d0a0e035b8064
// Params 0
// Checksum 0x0, Offset: 0x208
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_ravenov_base / namespace_d39d0a0e035b8064
// Params 0
// Checksum 0x0, Offset: 0x212
// Size: 0x14
function precache_sp()
{
    precache();
    precachemodel( "c_jup_zmb_ravenov_fb" );
}

// Namespace character_jup_ravenov_base / namespace_d39d0a0e035b8064
// Params 0
// Checksum 0x0, Offset: 0x22e
// Size: 0x9
function precache_cpmp()
{
    precache();
}

