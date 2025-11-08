#using scripts\common\utility;

#namespace character_jup_zombie_deathworm;

// Namespace character_jup_zombie_deathworm / namespace_8f265b90abfeff0d
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xb6
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_zombie_deathworm";
    
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

// Namespace character_jup_zombie_deathworm / namespace_8f265b90abfeff0d
// Params 0
// Checksum 0x0, Offset: 0x159
// Size: 0x99
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_deathworm";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_deathworm";
    self setmodel( "c_jup_zmb_worm" );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_deathworm / namespace_8f265b90abfeff0d
// Params 0
// Checksum 0x0, Offset: 0x1fa
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_deathworm / namespace_8f265b90abfeff0d
// Params 0
// Checksum 0x0, Offset: 0x204
// Size: 0x14
function precache_sp()
{
    precache();
    precachemodel( "c_jup_zmb_worm" );
}

// Namespace character_jup_zombie_deathworm / namespace_8f265b90abfeff0d
// Params 0
// Checksum 0x0, Offset: 0x220
// Size: 0x9
function precache_cpmp()
{
    precache();
}

