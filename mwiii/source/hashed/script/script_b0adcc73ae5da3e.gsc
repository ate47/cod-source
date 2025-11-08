#using scripts\common\utility;

#namespace character_iw9_enemy_pmc_tier2_4_1;

// Namespace character_iw9_enemy_pmc_tier2_4_1 / namespace_7a33ad2ddc71d6f6
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xe2
// Size: 0x9b
function private autoexec init()
{
    character = #"character_iw9_enemy_pmc_tier2_4_1";
    
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

// Namespace character_iw9_enemy_pmc_tier2_4_1 / namespace_7a33ad2ddc71d6f6
// Params 0
// Checksum 0x0, Offset: 0x185
// Size: 0xbb
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"shadowcompany";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_sp_ally_mex_sf_d" );
    self attach( "head_sp_ally_mex_sf_d", "", 1 );
    self.headmodel = "head_sp_ally_mex_sf_d";
    self setclothtype( #"nylon" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_iw9_enemy_pmc_tier2_4_1 / namespace_7a33ad2ddc71d6f6
// Params 0
// Checksum 0x0, Offset: 0x248
// Size: 0x2
function precache()
{
    
}

// Namespace character_iw9_enemy_pmc_tier2_4_1 / namespace_7a33ad2ddc71d6f6
// Params 0
// Checksum 0x0, Offset: 0x252
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_sp_ally_mex_sf_d" );
    precachemodel( "head_sp_ally_mex_sf_d" );
}

// Namespace character_iw9_enemy_pmc_tier2_4_1 / namespace_7a33ad2ddc71d6f6
// Params 0
// Checksum 0x0, Offset: 0x279
// Size: 0x9
function precache_cpmp()
{
    precache();
}

