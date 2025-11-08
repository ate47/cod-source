#using scripts\common\utility;

#namespace c_jup_sp_npc_f_whiskey_hacker;

// Namespace c_jup_sp_npc_f_whiskey_hacker / namespace_9da1610ed9594fd3
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xdb
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_npc_f_whiskey_hacker";
    
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

// Namespace c_jup_sp_npc_f_whiskey_hacker / namespace_9da1610ed9594fd3
// Params 0
// Checksum 0x0, Offset: 0x17d
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react_female";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_npc_f_whiskey_hacker" );
    self attach( "head_c_jup_sc_f_miller_whiskey_hacker", "", 1 );
    self.headmodel = "head_c_jup_sc_f_miller_whiskey_hacker";
    self setclothtype( #"nylon" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_npc_f_whiskey_hacker / namespace_9da1610ed9594fd3
// Params 0
// Checksum 0x0, Offset: 0x23f
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_npc_f_whiskey_hacker / namespace_9da1610ed9594fd3
// Params 0
// Checksum 0x0, Offset: 0x249
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_npc_f_whiskey_hacker" );
    precachemodel( "head_c_jup_sc_f_miller_whiskey_hacker" );
}

// Namespace c_jup_sp_npc_f_whiskey_hacker / namespace_9da1610ed9594fd3
// Params 0
// Checksum 0x0, Offset: 0x270
// Size: 0x9
function precache_cpmp()
{
    precache();
}

