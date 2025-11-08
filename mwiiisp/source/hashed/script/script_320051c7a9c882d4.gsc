#using scripts\common\utility;

#namespace c_jup_sp_enemy_oligarch_patroller_01a;

// Namespace c_jup_sp_enemy_oligarch_patroller_01a / namespace_47bc9d906c60110
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xca
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_enemy_oligarch_patroller_01a";
    
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

// Namespace c_jup_sp_enemy_oligarch_patroller_01a / namespace_47bc9d906c60110
// Params 0
// Checksum 0x0, Offset: 0x16c
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"russian";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_enemy_oligarch_patroller_01a" );
    self attach( "head_c_jup_sc_m_kamalov", "", 1 );
    self.headmodel = "head_c_jup_sc_m_kamalov";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_enemy_oligarch_patroller_01a / namespace_47bc9d906c60110
// Params 0
// Checksum 0x0, Offset: 0x22e
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_enemy_oligarch_patroller_01a / namespace_47bc9d906c60110
// Params 0
// Checksum 0x0, Offset: 0x238
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_enemy_oligarch_patroller_01a" );
    precachemodel( "head_c_jup_sc_m_kamalov" );
}

// Namespace c_jup_sp_enemy_oligarch_patroller_01a / namespace_47bc9d906c60110
// Params 0
// Checksum 0x0, Offset: 0x25f
// Size: 0x9
function precache_cpmp()
{
    precache();
}

