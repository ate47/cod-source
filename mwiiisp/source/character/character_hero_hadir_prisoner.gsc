#using scripts\common\utility;

#namespace character_hero_hadir_prisoner;

// Namespace character_hero_hadir_prisoner / character\character_hero_hadir_prisoner
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xc0
// Size: 0x9a
function private autoexec init()
{
    character = #"character_hero_hadir_prisoner";
    
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

// Namespace character_hero_hadir_prisoner / character\character_hero_hadir_prisoner
// Params 0
// Checksum 0x0, Offset: 0x162
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"sas";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_hero_hadir_prisoner" );
    self attach( "head_hero_hadir_teen_blendshape", "", 1 );
    self.headmodel = "head_hero_hadir_teen_blendshape";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_hero_hadir_prisoner / character\character_hero_hadir_prisoner
// Params 0
// Checksum 0x0, Offset: 0x224
// Size: 0x2
function precache()
{
    
}

// Namespace character_hero_hadir_prisoner / character\character_hero_hadir_prisoner
// Params 0
// Checksum 0x0, Offset: 0x22e
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_hero_hadir_prisoner" );
    precachemodel( "head_hero_hadir_teen_blendshape" );
}

// Namespace character_hero_hadir_prisoner / character\character_hero_hadir_prisoner
// Params 0
// Checksum 0x0, Offset: 0x255
// Size: 0x9
function precache_cpmp()
{
    precache();
}

