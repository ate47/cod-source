#using scripts\common\utility;

#namespace civ_london_female_hijack_blocker_01;

// Namespace civ_london_female_hijack_blocker_01 / namespace_90d5e1606f98a21b
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xbf
// Size: 0x9a
function private autoexec init()
{
    character = #"civ_london_female_hijack_blocker_01";
    
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

// Namespace civ_london_female_hijack_blocker_01 / namespace_90d5e1606f98a21b
// Params 0
// Checksum 0x0, Offset: 0x161
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"unitednationsfemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_civ_london_female_9_2" );
    self attach( "head_sc_f_dizon_var_1", "", 1 );
    self.headmodel = "head_sc_f_dizon_var_1";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace civ_london_female_hijack_blocker_01 / namespace_90d5e1606f98a21b
// Params 0
// Checksum 0x0, Offset: 0x223
// Size: 0x2
function precache()
{
    
}

// Namespace civ_london_female_hijack_blocker_01 / namespace_90d5e1606f98a21b
// Params 0
// Checksum 0x0, Offset: 0x22d
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_civ_london_female_9_2" );
    precachemodel( "head_sc_f_dizon_var_1" );
}

// Namespace civ_london_female_hijack_blocker_01 / namespace_90d5e1606f98a21b
// Params 0
// Checksum 0x0, Offset: 0x254
// Size: 0x9
function precache_cpmp()
{
    precache();
}

