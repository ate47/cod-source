#using scripts\common\utility;

#namespace c_jup_sp_hero_alex;

// Namespace c_jup_sp_hero_alex / namespace_11ebfb9340b0d542
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xb9
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_hero_alex";
    
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

// Namespace c_jup_sp_hero_alex / namespace_11ebfb9340b0d542
// Params 0
// Checksum 0x0, Offset: 0x15b
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"sas";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "c_jup_body_cp_alex_iw9_1_1" );
    self attach( "head_hero_alex_lod_iw9", "", 1 );
    self.headmodel = "head_hero_alex_lod_iw9";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_hero_alex / namespace_11ebfb9340b0d542
// Params 0
// Checksum 0x0, Offset: 0x21e
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_hero_alex / namespace_11ebfb9340b0d542
// Params 0
// Checksum 0x0, Offset: 0x228
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "c_jup_body_cp_alex_iw9_1_1" );
    precachemodel( "head_hero_alex_lod_iw9" );
}

// Namespace c_jup_sp_hero_alex / namespace_11ebfb9340b0d542
// Params 0
// Checksum 0x0, Offset: 0x24f
// Size: 0x9
function precache_cpmp()
{
    precache();
}

