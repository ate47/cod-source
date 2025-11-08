#using scripts\common\utility;

#namespace c_jup_sp_civ_worker_06_a_char_surge;

// Namespace c_jup_sp_civ_worker_06_a_char_surge / namespace_5590ba0f823b82bd
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xc7
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_civ_worker_06_a_char_surge";
    
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

// Namespace c_jup_sp_civ_worker_06_a_char_surge / namespace_5590ba0f823b82bd
// Params 0
// Checksum 0x0, Offset: 0x169
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_civ_worker_06_a" );
    self attach( "head_c_jup_sc_m_valladares", "", 1 );
    self.headmodel = "head_c_jup_sc_m_valladares";
    self setclothtype( #"nylon" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_civ_worker_06_a_char_surge / namespace_5590ba0f823b82bd
// Params 0
// Checksum 0x0, Offset: 0x22b
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_civ_worker_06_a_char_surge / namespace_5590ba0f823b82bd
// Params 0
// Checksum 0x0, Offset: 0x235
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_civ_worker_06_a" );
    precachemodel( "head_c_jup_sc_m_valladares" );
}

// Namespace c_jup_sp_civ_worker_06_a_char_surge / namespace_5590ba0f823b82bd
// Params 0
// Checksum 0x0, Offset: 0x25c
// Size: 0x9
function precache_cpmp()
{
    precache();
}

