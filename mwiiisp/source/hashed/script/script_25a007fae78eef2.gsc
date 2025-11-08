#using scripts\common\utility;

#namespace c_jup_sp_civ_prisoner_02_b_riot_soldier;

// Namespace c_jup_sp_civ_prisoner_02_b_riot_soldier / namespace_d55df257a8ef9b66
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xc7
// Size: 0x9a
function private autoexec init()
{
    character = #"c_jup_sp_civ_prisoner_02_b_riot_soldier";
    
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

// Namespace c_jup_sp_civ_prisoner_02_b_riot_soldier / namespace_d55df257a8ef9b66
// Params 0
// Checksum 0x0, Offset: 0x169
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "rebel";
    self.voice = #"russian";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_civ_prisoner_02_b_riot" );
    self attach( "c_jup_head_sc_m_bansal_beard", "", 1 );
    self.headmodel = "c_jup_head_sc_m_bansal_beard";
    self setclothtype( #"cloth" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_sp_civ_prisoner_02_b_riot_soldier / namespace_d55df257a8ef9b66
// Params 0
// Checksum 0x0, Offset: 0x22b
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_sp_civ_prisoner_02_b_riot_soldier / namespace_d55df257a8ef9b66
// Params 0
// Checksum 0x0, Offset: 0x235
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_civ_prisoner_02_b_riot" );
    precachemodel( "c_jup_head_sc_m_bansal_beard" );
}

// Namespace c_jup_sp_civ_prisoner_02_b_riot_soldier / namespace_d55df257a8ef9b66
// Params 0
// Checksum 0x0, Offset: 0x25c
// Size: 0x9
function precache_cpmp()
{
    precache();
}

