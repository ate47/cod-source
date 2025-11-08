#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_zmb_zombie_base_male_shortsleeve_head_yz;

#namespace character_jup_zombie_base_male_shortsleeve_yz;

// Namespace character_jup_zombie_base_male_shortsleeve_yz / namespace_d4b4a4dc6de14fe0
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x113
// Size: 0xb4
function private autoexec init()
{
    character = #"character_jup_zombie_base_male_shortsleeve_yz";
    
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
        level.fncharacterxmodelalias[ %"character_jup_zombie_base_male_shortsleeve_yz" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_jup_zombie_base_male_shortsleeve_yz / namespace_d4b4a4dc6de14fe0
// Params 0
// Checksum 0x0, Offset: 0x1cf
// Size: 0xab
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_base";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_base";
    self setmodel( "c_jup_zmb_zombie_base_male_shortsleeve_body_yz" );
    scripts\code\character::attachhead( "c_jup_zmb_zombie_base_male_shortsleeve_head_yz", xmodelalias\c_jup_zmb_zombie_base_male_shortsleeve_head_yz::main() );
    self setclothtype( #"vestheavy" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_base_male_shortsleeve_yz / namespace_d4b4a4dc6de14fe0
// Params 0
// Checksum 0x0, Offset: 0x282
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_base_male_shortsleeve_yz / namespace_d4b4a4dc6de14fe0
// Params 0
// Checksum 0x0, Offset: 0x28c
// Size: 0x21
function precache_sp()
{
    precache();
    precachemodel( "c_jup_zmb_zombie_base_male_shortsleeve_body_yz" );
    scripts\code\character::precachemodelarray( xmodelalias\c_jup_zmb_zombie_base_male_shortsleeve_head_yz::main() );
}

// Namespace character_jup_zombie_base_male_shortsleeve_yz / namespace_d4b4a4dc6de14fe0
// Params 0
// Checksum 0x0, Offset: 0x2b5
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_jup_zombie_base_male_shortsleeve_yz / namespace_d4b4a4dc6de14fe0
// Params 1
// Checksum 0x0, Offset: 0x2c6
// Size: 0x36
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_9f81095ee5027585":
            return xmodelalias\c_jup_zmb_zombie_base_male_shortsleeve_head_yz::main();
    }
    
    assert( 0, "<dev string:x1c>" );
}

