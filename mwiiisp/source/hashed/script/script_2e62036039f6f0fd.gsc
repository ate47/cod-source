#using scripts\common\utility;

#namespace c_jup_sp_hero_nikolai;

// Namespace c_jup_sp_hero_nikolai / namespace_910b7c8d64def801
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xde
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_hero_nikolai";
    
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

// Namespace c_jup_sp_hero_nikolai / namespace_910b7c8d64def801
// Params 0
// Checksum 0x0, Offset: 0x180
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier_makarov_handcuffed";
    self.voice = #"russian";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "c_jup_body_sp_heroe_nikolai_convoy" );
    self attach( "head_hero_nikolai_blendshape_iw9", "", 1 );
    self.headmodel = "head_hero_nikolai_blendshape_iw9";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_hero_nikolai / namespace_910b7c8d64def801
// Params 0
// Checksum 0x0, Offset: 0x243
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_hero_nikolai / namespace_910b7c8d64def801
// Params 0
// Checksum 0x0, Offset: 0x24d
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "c_jup_body_sp_heroe_nikolai_convoy" );
    precachemodel( "head_hero_nikolai_blendshape_iw9" );
}

// Namespace c_jup_sp_hero_nikolai / namespace_910b7c8d64def801
// Params 0
// Checksum 0x0, Offset: 0x274
// Size: 0x9
function precache_cpmp()
{
    precache();
}

