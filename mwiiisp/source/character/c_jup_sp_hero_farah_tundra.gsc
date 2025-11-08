#using scripts\common\utility;

#namespace c_jup_sp_hero_farah_tundra;

// Namespace c_jup_sp_hero_farah_tundra / character\c_jup_sp_hero_farah_tundra
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xca
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_hero_farah_tundra";
    
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

// Namespace c_jup_sp_hero_farah_tundra / character\c_jup_sp_hero_farah_tundra
// Params 0
// Checksum 0x0, Offset: 0x16c
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "farah";
    self.voice = #"fsafemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_hero_farah_tundra" );
    self attach( "c_jup_head_hero_farah_tundra_no_hair", "", 1 );
    self.headmodel = "c_jup_head_hero_farah_tundra_no_hair";
    self setclothtype( #"vestlight" );
    self setgeartype( #"strapsgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_hero_farah_tundra / character\c_jup_sp_hero_farah_tundra
// Params 0
// Checksum 0x0, Offset: 0x22e
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_hero_farah_tundra / character\c_jup_sp_hero_farah_tundra
// Params 0
// Checksum 0x0, Offset: 0x238
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_hero_farah_tundra" );
    precachemodel( "c_jup_head_hero_farah_tundra_no_hair" );
}

// Namespace c_jup_sp_hero_farah_tundra / character\c_jup_sp_hero_farah_tundra
// Params 0
// Checksum 0x0, Offset: 0x25f
// Size: 0x9
function precache_cpmp()
{
    precache();
}

