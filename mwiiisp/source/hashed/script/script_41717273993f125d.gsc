#using scripts\common\utility;

#namespace character_civ_us_tx_male_3;

// Namespace character_civ_us_tx_male_3 / namespace_b17c60085b3248b
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xc0
// Size: 0x9a
function private autoexec init()
{
    character = #"character_civ_us_tx_male_3";
    
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

// Namespace character_civ_us_tx_male_3 / namespace_b17c60085b3248b
// Params 0
// Checksum 0x0, Offset: 0x162
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_civ_stpeterburg_male_5_1" );
    self attach( "head_sc_m_allen_hat", "", 1 );
    self.headmodel = "head_sc_m_allen_hat";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_civ_us_tx_male_3 / namespace_b17c60085b3248b
// Params 0
// Checksum 0x0, Offset: 0x224
// Size: 0x2
function precache()
{
    
}

// Namespace character_civ_us_tx_male_3 / namespace_b17c60085b3248b
// Params 0
// Checksum 0x0, Offset: 0x22e
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "body_civ_stpeterburg_male_5_1" );
    precachemodel( "head_sc_m_allen_hat" );
}

// Namespace character_civ_us_tx_male_3 / namespace_b17c60085b3248b
// Params 0
// Checksum 0x0, Offset: 0x255
// Size: 0x9
function precache_cpmp()
{
    precache();
}

