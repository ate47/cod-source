#using scripts\common\utility;

#namespace character_iw9_hero_nikolai;

// Namespace character_iw9_hero_nikolai / namespace_bdeae94dba9e77f5
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xb6
// Size: 0x9a
function private autoexec init()
{
    character = #"character_iw9_hero_nikolai";
    
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

// Namespace character_iw9_hero_nikolai / namespace_bdeae94dba9e77f5
// Params 0
// Checksum 0x0, Offset: 0x158
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"russian";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_sp_heroe_nikolai_convoy" );
    self attach( "head_hero_nikolai", "", 1 );
    self.headmodel = "head_hero_nikolai";
    self setclothtype( #"leather" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_iw9_hero_nikolai / namespace_bdeae94dba9e77f5
// Params 0
// Checksum 0x0, Offset: 0x21a
// Size: 0x2
function precache()
{
    
}

// Namespace character_iw9_hero_nikolai / namespace_bdeae94dba9e77f5
// Params 0
// Checksum 0x0, Offset: 0x224
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_sp_heroe_nikolai_convoy" );
    precachemodel( "head_hero_nikolai" );
}

// Namespace character_iw9_hero_nikolai / namespace_bdeae94dba9e77f5
// Params 0
// Checksum 0x0, Offset: 0x24b
// Size: 0x9
function precache_cpmp()
{
    precache();
}

