#using scripts\common\utility;

#namespace c_jup_civ_western_boy_4_1;

// Namespace c_jup_civ_western_boy_4_1 / namespace_2c0607aed02a03f8
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xc5
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_civ_western_boy_4_1";
    
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

// Namespace c_jup_civ_western_boy_4_1 / namespace_2c0607aed02a03f8
// Params 0
// Checksum 0x0, Offset: 0x167
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"fsa";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "c_jup_body_civ_western_boy_1_1" );
    self attach( "head_sc_m_vozhyuk_child", "", 1 );
    self.headmodel = "head_sc_m_vozhyuk_child";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_western_boy_4_1 / namespace_2c0607aed02a03f8
// Params 0
// Checksum 0x0, Offset: 0x229
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_western_boy_4_1 / namespace_2c0607aed02a03f8
// Params 0
// Checksum 0x0, Offset: 0x233
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "c_jup_body_civ_western_boy_1_1" );
    precachemodel( "head_sc_m_vozhyuk_child" );
}

// Namespace c_jup_civ_western_boy_4_1 / namespace_2c0607aed02a03f8
// Params 0
// Checksum 0x0, Offset: 0x25a
// Size: 0x9
function precache_cpmp()
{
    precache();
}

