#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_iw9_enemy_aq_ar_3;
#using xmodelalias\heads_iw9_enemy_aq_ar_3;

#namespace character_iw9_enemy_aq_ar_3;

// Namespace character_iw9_enemy_aq_ar_3 / namespace_fddc8068d2378c9e
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xf8
// Size: 0xb4
function private autoexec init()
{
    character = #"character_iw9_enemy_aq_ar_3";
    
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
        level.fncharacterxmodelalias[ %"character_iw9_enemy_aq_ar_3" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_iw9_enemy_aq_ar_3 / namespace_fddc8068d2378c9e
// Params 0
// Checksum 0x0, Offset: 0x1b4
// Size: 0xb2
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "rebel";
    self.voice = #"alqatala";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "bodies_iw9_enemy_aq_ar_3", xmodelalias\bodies_iw9_enemy_aq_ar_3::main() );
    scripts\code\character::attachhead( "heads_iw9_enemy_aq_ar_3", xmodelalias\heads_iw9_enemy_aq_ar_3::main() );
    self setclothtype( #"flowing" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_iw9_enemy_aq_ar_3 / namespace_fddc8068d2378c9e
// Params 0
// Checksum 0x0, Offset: 0x26e
// Size: 0x2
function precache()
{
    
}

// Namespace character_iw9_enemy_aq_ar_3 / namespace_fddc8068d2378c9e
// Params 0
// Checksum 0x0, Offset: 0x278
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\bodies_iw9_enemy_aq_ar_3::main() );
    scripts\code\character::precachemodelarray( xmodelalias\heads_iw9_enemy_aq_ar_3::main() );
}

// Namespace character_iw9_enemy_aq_ar_3 / namespace_fddc8068d2378c9e
// Params 0
// Checksum 0x0, Offset: 0x2a3
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_iw9_enemy_aq_ar_3 / namespace_fddc8068d2378c9e
// Params 1
// Checksum 0x0, Offset: 0x2b4
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_ad9bb4d039cebb57":
            return xmodelalias\bodies_iw9_enemy_aq_ar_3::main();
        case #"hash_1fa3687a475cb7ba":
            return xmodelalias\heads_iw9_enemy_aq_ar_3::main();
    }
    
    assert( 0, "<dev string:x1c>" );
}

