#using scripts\common\utility;

#namespace c_jup_sp_hero_gaz_london_tactical;

// Namespace c_jup_sp_hero_gaz_london_tactical / character\c_jup_sp_hero_gaz_london_tactical
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xd5
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_hero_gaz_london_tactical";
    
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

// Namespace c_jup_sp_hero_gaz_london_tactical / character\c_jup_sp_hero_gaz_london_tactical
// Params 0
// Checksum 0x0, Offset: 0x177
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"sas";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_hero_gaz_london_tactical" );
    self attach( "head_c_jup_sp_hero_gaz_london_tactical", "", 1 );
    self.headmodel = "head_c_jup_sp_hero_gaz_london_tactical";
    self setclothtype( #"nylon" );
    self setgeartype( #"milmedgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_hero_gaz_london_tactical / character\c_jup_sp_hero_gaz_london_tactical
// Params 0
// Checksum 0x0, Offset: 0x23a
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_hero_gaz_london_tactical / character\c_jup_sp_hero_gaz_london_tactical
// Params 0
// Checksum 0x0, Offset: 0x244
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_hero_gaz_london_tactical" );
    precachemodel( "head_c_jup_sp_hero_gaz_london_tactical" );
}

// Namespace c_jup_sp_hero_gaz_london_tactical / character\c_jup_sp_hero_gaz_london_tactical
// Params 0
// Checksum 0x0, Offset: 0x26b
// Size: 0x9
function precache_cpmp()
{
    precache();
}

