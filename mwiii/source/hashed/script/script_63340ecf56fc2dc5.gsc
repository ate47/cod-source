#using scripts\common\utility;

#namespace character_iw9_enemy_pmc_tier1_2_1;

// Namespace character_iw9_enemy_pmc_tier1_2_1 / namespace_8a4a56432c2b8411
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xf3
// Size: 0x9b
function private autoexec init()
{
    character = #"character_iw9_enemy_pmc_tier1_2_1";
    
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

// Namespace character_iw9_enemy_pmc_tier1_2_1 / namespace_8a4a56432c2b8411
// Params 0
// Checksum 0x0, Offset: 0x196
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"shadowcompany";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_sp_ally_mex_sf_tier_1_2_1" );
    self attach( "head_sp_ally_mex_sf_tier_1_2_1", "", 1 );
    self.headmodel = "head_sp_ally_mex_sf_tier_1_2_1";
    self setclothtype( #"cloth" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_iw9_enemy_pmc_tier1_2_1 / namespace_8a4a56432c2b8411
// Params 0
// Checksum 0x0, Offset: 0x259
// Size: 0x2
function precache()
{
    
}

// Namespace character_iw9_enemy_pmc_tier1_2_1 / namespace_8a4a56432c2b8411
// Params 0
// Checksum 0x0, Offset: 0x263
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_sp_ally_mex_sf_tier_1_2_1" );
    precachemodel( "head_sp_ally_mex_sf_tier_1_2_1" );
}

// Namespace character_iw9_enemy_pmc_tier1_2_1 / namespace_8a4a56432c2b8411
// Params 0
// Checksum 0x0, Offset: 0x28a
// Size: 0x9
function precache_cpmp()
{
    precache();
}

