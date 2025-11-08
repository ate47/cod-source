#using scripts\common\utility;

#namespace c_jup_sp_hero_farah_nvm;

// Namespace c_jup_sp_hero_farah_nvm / namespace_706e5ba6713646c2
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xc0
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_hero_farah_nvm";
    
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

// Namespace c_jup_sp_hero_farah_nvm / namespace_706e5ba6713646c2
// Params 0
// Checksum 0x0, Offset: 0x162
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "farah";
    self.voice = #"fsafemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_hero_farah_nvm" );
    self attach( "c_jup_head_hero_farah_no_hair", "", 1 );
    self.headmodel = "c_jup_head_hero_farah_no_hair";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_hero_farah_nvm / namespace_706e5ba6713646c2
// Params 0
// Checksum 0x0, Offset: 0x224
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_hero_farah_nvm / namespace_706e5ba6713646c2
// Params 0
// Checksum 0x0, Offset: 0x22e
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_hero_farah_nvm" );
    precachemodel( "c_jup_head_hero_farah_no_hair" );
}

// Namespace c_jup_sp_hero_farah_nvm / namespace_706e5ba6713646c2
// Params 0
// Checksum 0x0, Offset: 0x255
// Size: 0x9
function precache_cpmp()
{
    precache();
}

