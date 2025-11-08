#using scripts\common\utility;

#namespace c_jup_sp_enemy_pmc_hooded_02_jump;

// Namespace c_jup_sp_enemy_pmc_hooded_02_jump / character\c_jup_sp_enemy_pmc_hooded_02_jump
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xcc
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_enemy_pmc_hooded_02_jump";
    
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

// Namespace c_jup_sp_enemy_pmc_hooded_02_jump / character\c_jup_sp_enemy_pmc_hooded_02_jump
// Params 0
// Checksum 0x0, Offset: 0x16e
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"russian";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_enemy_pmc_hooded_02_jump" );
    self attach( "head_sc_m_fahselt_civ_no_hair", "", 1 );
    self.headmodel = "head_sc_m_fahselt_civ_no_hair";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_enemy_pmc_hooded_02_jump / character\c_jup_sp_enemy_pmc_hooded_02_jump
// Params 0
// Checksum 0x0, Offset: 0x230
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_enemy_pmc_hooded_02_jump / character\c_jup_sp_enemy_pmc_hooded_02_jump
// Params 0
// Checksum 0x0, Offset: 0x23a
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_enemy_pmc_hooded_02_jump" );
    precachemodel( "head_sc_m_fahselt_civ_no_hair" );
}

// Namespace c_jup_sp_enemy_pmc_hooded_02_jump / character\c_jup_sp_enemy_pmc_hooded_02_jump
// Params 0
// Checksum 0x0, Offset: 0x261
// Size: 0x9
function precache_cpmp()
{
    precache();
}

