#using scripts\common\utility;

#namespace c_jup_sp_villain_oligarch;

// Namespace c_jup_sp_villain_oligarch / namespace_b34ae68e2ccf81d6
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xbd
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_villain_oligarch";
    
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

// Namespace c_jup_sp_villain_oligarch / namespace_b34ae68e2ccf81d6
// Params 0
// Checksum 0x0, Offset: 0x15f
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"konni";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_villain_oligarch" );
    self attach( "c_jup_head_hero_milena", "", 1 );
    self.headmodel = "c_jup_head_hero_milena";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_villain_oligarch / namespace_b34ae68e2ccf81d6
// Params 0
// Checksum 0x0, Offset: 0x221
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_villain_oligarch / namespace_b34ae68e2ccf81d6
// Params 0
// Checksum 0x0, Offset: 0x22b
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_villain_oligarch" );
    precachemodel( "c_jup_head_hero_milena" );
}

// Namespace c_jup_sp_villain_oligarch / namespace_b34ae68e2ccf81d6
// Params 0
// Checksum 0x0, Offset: 0x252
// Size: 0x9
function precache_cpmp()
{
    precache();
}

