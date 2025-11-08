#using scripts\common\utility;

#namespace character_iw9_enemy_pmc_no_goggles_1_1_gl;

// Namespace character_iw9_enemy_pmc_no_goggles_1_1_gl / namespace_e3af83f4594fd3c5
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xcb
// Size: 0x9a
function private autoexec init()
{
    character = #"character_iw9_enemy_pmc_no_goggles_1_1_gl";
    
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

// Namespace character_iw9_enemy_pmc_no_goggles_1_1_gl / namespace_e3af83f4594fd3c5
// Params 0
// Checksum 0x0, Offset: 0x16d
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"shadowcompany";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_sp_opforce_pmc_no_packs_1_1" );
    self attach( "head_sp_opforce_pmc_no_goggles_3_1", "", 1 );
    self.headmodel = "head_sp_opforce_pmc_no_goggles_3_1";
    self setclothtype( #"vestlight" );
    self setgeartype( #"milmedgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_iw9_enemy_pmc_no_goggles_1_1_gl / namespace_e3af83f4594fd3c5
// Params 0
// Checksum 0x0, Offset: 0x230
// Size: 0x2
function precache()
{
    
}

// Namespace character_iw9_enemy_pmc_no_goggles_1_1_gl / namespace_e3af83f4594fd3c5
// Params 0
// Checksum 0x0, Offset: 0x23a
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_sp_opforce_pmc_no_packs_1_1" );
    precachemodel( "head_sp_opforce_pmc_no_goggles_3_1" );
}

// Namespace character_iw9_enemy_pmc_no_goggles_1_1_gl / namespace_e3af83f4594fd3c5
// Params 0
// Checksum 0x0, Offset: 0x261
// Size: 0x9
function precache_cpmp()
{
    precache();
}

