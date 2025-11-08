#using scripts\common\utility;

#namespace character_jup_zombie_hellhound;

// Namespace character_jup_zombie_hellhound / namespace_73a6cc0fc98dee97
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xbe
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_zombie_hellhound";
    
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

// Namespace character_jup_zombie_hellhound / namespace_73a6cc0fc98dee97
// Params 0
// Checksum 0x0, Offset: 0x161
// Size: 0x99
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_hellhound";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_hellhound";
    self setmodel( "c_jup_zmb_zod_hellhound" );
    self setclothtype( #"vestheavy" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_hellhound / namespace_73a6cc0fc98dee97
// Params 0
// Checksum 0x0, Offset: 0x202
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_hellhound / namespace_73a6cc0fc98dee97
// Params 0
// Checksum 0x0, Offset: 0x20c
// Size: 0x14
function precache_sp()
{
    precache();
    precachemodel( "c_jup_zmb_zod_hellhound" );
}

// Namespace character_jup_zombie_hellhound / namespace_73a6cc0fc98dee97
// Params 0
// Checksum 0x0, Offset: 0x228
// Size: 0x9
function precache_cpmp()
{
    precache();
}

