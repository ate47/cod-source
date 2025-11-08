#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_iw9_enemy_aq_tier2_1;
#using xmodelalias\heads_iw9_enemy_aq_tier2_1;

#namespace character_iw9_enemy_aq_tier2_1;

// Namespace character_iw9_enemy_aq_tier2_1 / namespace_2e15a7f088ef4d1f
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x101
// Size: 0xb4
function private autoexec init()
{
    character = #"character_iw9_enemy_aq_tier2_1";
    
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
        level.fncharacterxmodelalias[ %"character_iw9_enemy_aq_tier2_1" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_iw9_enemy_aq_tier2_1 / namespace_2e15a7f088ef4d1f
// Params 0
// Checksum 0x0, Offset: 0x1bd
// Size: 0xb2
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"alqatala";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "bodies_iw9_enemy_aq_tier2_1", xmodelalias\bodies_iw9_enemy_aq_tier2_1::main() );
    scripts\code\character::attachhead( "heads_iw9_enemy_aq_tier2_1", xmodelalias\heads_iw9_enemy_aq_tier2_1::main() );
    self setclothtype( #"flowing" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_iw9_enemy_aq_tier2_1 / namespace_2e15a7f088ef4d1f
// Params 0
// Checksum 0x0, Offset: 0x277
// Size: 0x2
function precache()
{
    
}

// Namespace character_iw9_enemy_aq_tier2_1 / namespace_2e15a7f088ef4d1f
// Params 0
// Checksum 0x0, Offset: 0x281
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\bodies_iw9_enemy_aq_tier2_1::main() );
    scripts\code\character::precachemodelarray( xmodelalias\heads_iw9_enemy_aq_tier2_1::main() );
}

// Namespace character_iw9_enemy_aq_tier2_1 / namespace_2e15a7f088ef4d1f
// Params 0
// Checksum 0x0, Offset: 0x2ac
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_iw9_enemy_aq_tier2_1 / namespace_2e15a7f088ef4d1f
// Params 1
// Checksum 0x0, Offset: 0x2bd
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_67a91a02b6272370":
            return xmodelalias\bodies_iw9_enemy_aq_tier2_1::main();
        case #"hash_1f4d891f61d7ba03":
            return xmodelalias\heads_iw9_enemy_aq_tier2_1::main();
    }
    
    assert( 0, "<dev string:x1c>" );
}

