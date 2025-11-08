#using scripts\common\utility;

#namespace c_jup_sp_civilian_pmc_undercover_civ_konni;

// Namespace c_jup_sp_civilian_pmc_undercover_civ_konni / namespace_62617e5891bca2c6
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xd3
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_civilian_pmc_undercover_civ_konni";
    
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

// Namespace c_jup_sp_civilian_pmc_undercover_civ_konni / namespace_62617e5891bca2c6
// Params 0
// Checksum 0x0, Offset: 0x175
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_enemy_pmc_undercover_civ_konni" );
    self attach( "c_jup_head_hero_donahoe", "", 1 );
    self.headmodel = "c_jup_head_hero_donahoe";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_civilian_pmc_undercover_civ_konni / namespace_62617e5891bca2c6
// Params 0
// Checksum 0x0, Offset: 0x237
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_civilian_pmc_undercover_civ_konni / namespace_62617e5891bca2c6
// Params 0
// Checksum 0x0, Offset: 0x241
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_enemy_pmc_undercover_civ_konni" );
    precachemodel( "c_jup_head_hero_donahoe" );
}

// Namespace c_jup_sp_civilian_pmc_undercover_civ_konni / namespace_62617e5891bca2c6
// Params 0
// Checksum 0x0, Offset: 0x268
// Size: 0x9
function precache_cpmp()
{
    precache();
}

