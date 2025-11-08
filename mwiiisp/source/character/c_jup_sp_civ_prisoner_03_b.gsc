#using scripts\common\utility;

#namespace c_jup_sp_civ_prisoner_03_b;

// Namespace c_jup_sp_civ_prisoner_03_b / character\c_jup_sp_civ_prisoner_03_b
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xcf
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_civ_prisoner_03_b";
    
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

// Namespace c_jup_sp_civ_prisoner_03_b / character\c_jup_sp_civ_prisoner_03_b
// Params 0
// Checksum 0x0, Offset: 0x171
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"russian";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_civ_prisoner_03_b" );
    self attach( "head_c_jup_russian_army_sharipov", "", 1 );
    self.headmodel = "head_c_jup_russian_army_sharipov";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_civ_prisoner_03_b / character\c_jup_sp_civ_prisoner_03_b
// Params 0
// Checksum 0x0, Offset: 0x233
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_civ_prisoner_03_b / character\c_jup_sp_civ_prisoner_03_b
// Params 0
// Checksum 0x0, Offset: 0x23d
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_civ_prisoner_03_b" );
    precachemodel( "head_c_jup_russian_army_sharipov" );
}

// Namespace c_jup_sp_civ_prisoner_03_b / character\c_jup_sp_civ_prisoner_03_b
// Params 0
// Checksum 0x0, Offset: 0x264
// Size: 0x9
function precache_cpmp()
{
    precache();
}

