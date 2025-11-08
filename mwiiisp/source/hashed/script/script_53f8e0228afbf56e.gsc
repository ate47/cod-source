#using scripts\common\utility;

#namespace c_jup_sp_hero_price_jump;

// Namespace c_jup_sp_hero_price_jump / namespace_18e0fbbae60a2510
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xc4
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_hero_price_jump";
    
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

// Namespace c_jup_sp_hero_price_jump / namespace_18e0fbbae60a2510
// Params 0
// Checksum 0x0, Offset: 0x166
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"sas";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_hero_price_jump" );
    self attach( "c_jup_head_hero_price_chemical", "", 1 );
    self.headmodel = "c_jup_head_hero_price_chemical";
    self setclothtype( #"vestlight" );
    self setgeartype( #"milmedgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_hero_price_jump / namespace_18e0fbbae60a2510
// Params 0
// Checksum 0x0, Offset: 0x229
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_hero_price_jump / namespace_18e0fbbae60a2510
// Params 0
// Checksum 0x0, Offset: 0x233
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_hero_price_jump" );
    precachemodel( "c_jup_head_hero_price_chemical" );
}

// Namespace c_jup_sp_hero_price_jump / namespace_18e0fbbae60a2510
// Params 0
// Checksum 0x0, Offset: 0x25a
// Size: 0x9
function precache_cpmp()
{
    precache();
}

