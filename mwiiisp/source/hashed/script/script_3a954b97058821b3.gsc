#using scripts\common\utility;

#namespace character_civilian_me_male_5;

// Namespace character_civilian_me_male_5 / namespace_3bbdf53e8d9edc4d
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xbe
// Size: 0x9a
function private autoexec init()
{
    character = #"character_civilian_me_male_5";
    
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

// Namespace character_civilian_me_male_5 / namespace_3bbdf53e8d9edc4d
// Params 0
// Checksum 0x0, Offset: 0x160
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"fsa";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "civ_amsterdam_male_3_1" );
    self attach( "head_sc_m_vozhyuk_bg_civ", "", 1 );
    self.headmodel = "head_sc_m_vozhyuk_bg_civ";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_civilian_me_male_5 / namespace_3bbdf53e8d9edc4d
// Params 0
// Checksum 0x0, Offset: 0x222
// Size: 0x2
function precache()
{
    
}

// Namespace character_civilian_me_male_5 / namespace_3bbdf53e8d9edc4d
// Params 0
// Checksum 0x0, Offset: 0x22c
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "civ_amsterdam_male_3_1" );
    precachemodel( "head_sc_m_vozhyuk_bg_civ" );
}

// Namespace character_civilian_me_male_5 / namespace_3bbdf53e8d9edc4d
// Params 0
// Checksum 0x0, Offset: 0x253
// Size: 0x9
function precache_cpmp()
{
    precache();
}

