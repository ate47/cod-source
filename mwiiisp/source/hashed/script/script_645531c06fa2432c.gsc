#using scripts\common\utility;

#namespace civ_london_male_hijack_blocker_03;

// Namespace civ_london_male_hijack_blocker_03 / namespace_ea6de396d128f8e8
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xbd
// Size: 0x9a
function private autoexec init()
{
    character = #"civ_london_male_hijack_blocker_03";
    
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

// Namespace civ_london_male_hijack_blocker_03 / namespace_ea6de396d128f8e8
// Params 0
// Checksum 0x0, Offset: 0x15f
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_civ_london_male_8_1" );
    self attach( "head_sc_m_montano_civ", "", 1 );
    self.headmodel = "head_sc_m_montano_civ";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace civ_london_male_hijack_blocker_03 / namespace_ea6de396d128f8e8
// Params 0
// Checksum 0x0, Offset: 0x221
// Size: 0x2
function precache()
{
    
}

// Namespace civ_london_male_hijack_blocker_03 / namespace_ea6de396d128f8e8
// Params 0
// Checksum 0x0, Offset: 0x22b
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_civ_london_male_8_1" );
    precachemodel( "head_sc_m_montano_civ" );
}

// Namespace civ_london_male_hijack_blocker_03 / namespace_ea6de396d128f8e8
// Params 0
// Checksum 0x0, Offset: 0x252
// Size: 0x9
function precache_cpmp()
{
    precache();
}

