#using scripts\common\utility;

#namespace character_iw9_hero_kyle_marina;

// Namespace character_iw9_hero_kyle_marina / namespace_aab7f9598cf2bbf0
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xbf
// Size: 0x9a
function private autoexec init()
{
    character = #"character_iw9_hero_kyle_marina";
    
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

// Namespace character_iw9_hero_kyle_marina / namespace_aab7f9598cf2bbf0
// Params 0
// Checksum 0x0, Offset: 0x161
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "rebel";
    self.voice = #"sas";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_sp_hero_kyle_marina" );
    self attach( "head_hero_kyle_marina_blendshape", "", 1 );
    self.headmodel = "head_hero_kyle_marina_blendshape";
    self setclothtype( #"wetsuit" );
    self setgeartype( #"milmedgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_iw9_hero_kyle_marina / namespace_aab7f9598cf2bbf0
// Params 0
// Checksum 0x0, Offset: 0x223
// Size: 0x2
function precache()
{
    
}

// Namespace character_iw9_hero_kyle_marina / namespace_aab7f9598cf2bbf0
// Params 0
// Checksum 0x0, Offset: 0x22d
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_sp_hero_kyle_marina" );
    precachemodel( "head_hero_kyle_marina_blendshape" );
}

// Namespace character_iw9_hero_kyle_marina / namespace_aab7f9598cf2bbf0
// Params 0
// Checksum 0x0, Offset: 0x254
// Size: 0x9
function precache_cpmp()
{
    precache();
}

