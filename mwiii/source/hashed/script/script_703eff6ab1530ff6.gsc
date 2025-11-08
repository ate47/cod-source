#using scripts\common\utility;

#namespace character_jup_zombie_mangler_hvt_emp;

// Namespace character_jup_zombie_mangler_hvt_emp / namespace_7afb46c568ae8e9c
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xbf
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_zombie_mangler_hvt_emp";
    
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

// Namespace character_jup_zombie_mangler_hvt_emp / namespace_7afb46c568ae8e9c
// Params 0
// Checksum 0x0, Offset: 0x162
// Size: 0x99
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_mangler";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_mangler";
    self setmodel( "c_jup_zmb_mangler_hvt_emp" );
    self setclothtype( #"vestheavy" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_mangler_hvt_emp / namespace_7afb46c568ae8e9c
// Params 0
// Checksum 0x0, Offset: 0x203
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_mangler_hvt_emp / namespace_7afb46c568ae8e9c
// Params 0
// Checksum 0x0, Offset: 0x20d
// Size: 0x14
function precache_sp()
{
    precache();
    precachemodel( "c_jup_zmb_mangler_hvt_emp" );
}

// Namespace character_jup_zombie_mangler_hvt_emp / namespace_7afb46c568ae8e9c
// Params 0
// Checksum 0x0, Offset: 0x229
// Size: 0x9
function precache_cpmp()
{
    precache();
}

