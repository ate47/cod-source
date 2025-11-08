#using scripts\common\utility;

#namespace character_jup_zombie_abom_mega;

// Namespace character_jup_zombie_abom_mega / namespace_f14ed9739ed41d26
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xda
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_zombie_abom_mega";
    
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

// Namespace character_jup_zombie_abom_mega / namespace_f14ed9739ed41d26
// Params 0
// Checksum 0x0, Offset: 0x17d
// Size: 0x99
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_abom_mega";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_abom";
    self setmodel( "c_jup_zmb_abomination_megabomb_body" );
    self setclothtype( #"vestheavy" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_abom_mega / namespace_f14ed9739ed41d26
// Params 0
// Checksum 0x0, Offset: 0x21e
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_abom_mega / namespace_f14ed9739ed41d26
// Params 0
// Checksum 0x0, Offset: 0x228
// Size: 0x14
function precache_sp()
{
    precache();
    precachemodel( "c_jup_zmb_abomination_megabomb_body" );
}

// Namespace character_jup_zombie_abom_mega / namespace_f14ed9739ed41d26
// Params 0
// Checksum 0x0, Offset: 0x244
// Size: 0x9
function precache_cpmp()
{
    precache();
}

