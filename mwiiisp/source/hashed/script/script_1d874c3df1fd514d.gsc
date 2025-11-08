#using scripts\common\utility;

#namespace c_jup_civ_london_male_embassy_ambassador;

// Namespace c_jup_civ_london_male_embassy_ambassador / namespace_b1c72fc9ddcfe1cf
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xcb
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_civ_london_male_embassy_ambassador";
    
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

// Namespace c_jup_civ_london_male_embassy_ambassador / namespace_b1c72fc9ddcfe1cf
// Params 0
// Checksum 0x0, Offset: 0x16d
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_civ_london_male_10_1" );
    self attach( "head_c_jup_sc_m_haghighi_civ", "", 1 );
    self.headmodel = "head_c_jup_sc_m_haghighi_civ";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_london_male_embassy_ambassador / namespace_b1c72fc9ddcfe1cf
// Params 0
// Checksum 0x0, Offset: 0x22f
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_london_male_embassy_ambassador / namespace_b1c72fc9ddcfe1cf
// Params 0
// Checksum 0x0, Offset: 0x239
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_civ_london_male_10_1" );
    precachemodel( "head_c_jup_sc_m_haghighi_civ" );
}

// Namespace c_jup_civ_london_male_embassy_ambassador / namespace_b1c72fc9ddcfe1cf
// Params 0
// Checksum 0x0, Offset: 0x260
// Size: 0x9
function precache_cpmp()
{
    precache();
}

