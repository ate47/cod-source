#using scripts\common\utility;

#namespace c_jup_sp_hero_price_london_tactical;

// Namespace c_jup_sp_hero_price_london_tactical / character\c_jup_sp_hero_price_london_tactical
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xca
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_hero_price_london_tactical";
    
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

// Namespace c_jup_sp_hero_price_london_tactical / character\c_jup_sp_hero_price_london_tactical
// Params 0
// Checksum 0x0, Offset: 0x16c
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"sas";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_hero_price_london_tactical" );
    self attach( "head_hero_price_nohat_lod", "", 1 );
    self.headmodel = "head_hero_price_nohat_lod";
    self setclothtype( #"vestlight" );
    self setgeartype( #"milmedgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_hero_price_london_tactical / character\c_jup_sp_hero_price_london_tactical
// Params 0
// Checksum 0x0, Offset: 0x22f
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_hero_price_london_tactical / character\c_jup_sp_hero_price_london_tactical
// Params 0
// Checksum 0x0, Offset: 0x239
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_hero_price_london_tactical" );
    precachemodel( "head_hero_price_nohat_lod" );
}

// Namespace c_jup_sp_hero_price_london_tactical / character\c_jup_sp_hero_price_london_tactical
// Params 0
// Checksum 0x0, Offset: 0x260
// Size: 0x9
function precache_cpmp()
{
    precache();
}

