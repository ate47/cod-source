#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_zmb_zombie_base_male_suit_body_gz;
#using xmodelalias\c_jup_zmb_zombie_base_male_suit_head_gz;

#namespace character_jup_zombie_base_male_suit_gz;

// Namespace character_jup_zombie_base_male_suit_gz / namespace_46bf59f0bbdfa2af
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x10c
// Size: 0xb4
function private autoexec init()
{
    character = #"character_jup_zombie_base_male_suit_gz";
    
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
        level.fncharacterxmodelalias[ %"character_jup_zombie_base_male_suit_gz" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_jup_zombie_base_male_suit_gz / namespace_46bf59f0bbdfa2af
// Params 0
// Checksum 0x0, Offset: 0x1c8
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_base";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_base";
    self setcharactermodelfromarray( "c_jup_zmb_zombie_base_male_suit_body_gz", xmodelalias\c_jup_zmb_zombie_base_male_suit_body_gz::main() );
    scripts\code\character::attachhead( "c_jup_zmb_zombie_base_male_suit_head_gz", xmodelalias\c_jup_zmb_zombie_base_male_suit_head_gz::main() );
    self setclothtype( #"vestheavy" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_base_male_suit_gz / namespace_46bf59f0bbdfa2af
// Params 0
// Checksum 0x0, Offset: 0x281
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_base_male_suit_gz / namespace_46bf59f0bbdfa2af
// Params 0
// Checksum 0x0, Offset: 0x28b
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\c_jup_zmb_zombie_base_male_suit_body_gz::main() );
    scripts\code\character::precachemodelarray( xmodelalias\c_jup_zmb_zombie_base_male_suit_head_gz::main() );
}

// Namespace character_jup_zombie_base_male_suit_gz / namespace_46bf59f0bbdfa2af
// Params 0
// Checksum 0x0, Offset: 0x2b6
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_jup_zombie_base_male_suit_gz / namespace_46bf59f0bbdfa2af
// Params 1
// Checksum 0x0, Offset: 0x2c7
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_ea014256a2b80b0a":
            return xmodelalias\c_jup_zmb_zombie_base_male_suit_body_gz::main();
        case #"hash_36de5511bc1826d0":
            return xmodelalias\c_jup_zmb_zombie_base_male_suit_head_gz::main();
    }
    
    assert( 0, "<dev string:x1c>" );
}

