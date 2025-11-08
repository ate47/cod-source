#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\body_iw9_aq_lmg_1_white;

#namespace character_iw9_aq_lmg_1_white;

// Namespace character_iw9_aq_lmg_1_white / namespace_985945ae1c6758b2
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xfa
// Size: 0xb4
function private autoexec init()
{
    character = #"character_iw9_aq_lmg_1_white";
    
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
        level.fncharacterxmodelalias[ %"character_iw9_aq_lmg_1_white" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_iw9_aq_lmg_1_white / namespace_985945ae1c6758b2
// Params 0
// Checksum 0x0, Offset: 0x1b6
// Size: 0xc1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "rebel";
    self.voice = #"alqatala";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "body_iw9_aq_lmg_1_white", xmodelalias\body_iw9_aq_lmg_1_white::main() );
    self attach( "head_sp_opforce_al_qatala_lmg", "", 1 );
    self.headmodel = "head_sp_opforce_al_qatala_lmg";
    self setclothtype( #"flowing" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_iw9_aq_lmg_1_white / namespace_985945ae1c6758b2
// Params 0
// Checksum 0x0, Offset: 0x27f
// Size: 0x2
function precache()
{
    
}

// Namespace character_iw9_aq_lmg_1_white / namespace_985945ae1c6758b2
// Params 0
// Checksum 0x0, Offset: 0x289
// Size: 0x21
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\body_iw9_aq_lmg_1_white::main() );
    precachemodel( "head_sp_opforce_al_qatala_lmg" );
}

// Namespace character_iw9_aq_lmg_1_white / namespace_985945ae1c6758b2
// Params 0
// Checksum 0x0, Offset: 0x2b2
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_iw9_aq_lmg_1_white / namespace_985945ae1c6758b2
// Params 1
// Checksum 0x0, Offset: 0x2c3
// Size: 0x36
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_463df8106281068d":
            return xmodelalias\body_iw9_aq_lmg_1_white::main();
    }
    
    assert( 0, "<dev string:x1c>" );
}

