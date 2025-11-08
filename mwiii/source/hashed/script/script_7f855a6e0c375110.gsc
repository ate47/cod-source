#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_zmb_zombie_base_long_shirt_head_yz;
#using xmodelalias\c_jup_zmb_zombie_base_male_long_shirt_body_yz_safe;

#namespace character_jup_zombie_base_male_long_shirt_yz_lightweight;

// Namespace character_jup_zombie_base_male_long_shirt_yz_lightweight / namespace_b5d1eaa7e3f521f2
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x119
// Size: 0xb4
function private autoexec init()
{
    character = #"character_jup_zombie_base_male_long_shirt_yz_lightweight";
    
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
        level.fncharacterxmodelalias[ %"character_jup_zombie_base_male_long_shirt_yz_lightweight" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_jup_zombie_base_male_long_shirt_yz_lightweight / namespace_b5d1eaa7e3f521f2
// Params 0
// Checksum 0x0, Offset: 0x1d5
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_base";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_base";
    self setcharactermodelfromarray( "c_jup_zmb_zombie_base_male_long_shirt_body_yz_safe", xmodelalias\c_jup_zmb_zombie_base_male_long_shirt_body_yz_safe::main() );
    scripts\code\character::attachhead( "c_jup_zmb_zombie_base_long_shirt_head_yz", xmodelalias\c_jup_zmb_zombie_base_long_shirt_head_yz::main() );
    self setclothtype( #"vestheavy" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_base_male_long_shirt_yz_lightweight / namespace_b5d1eaa7e3f521f2
// Params 0
// Checksum 0x0, Offset: 0x28e
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_base_male_long_shirt_yz_lightweight / namespace_b5d1eaa7e3f521f2
// Params 0
// Checksum 0x0, Offset: 0x298
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\c_jup_zmb_zombie_base_male_long_shirt_body_yz_safe::main() );
    scripts\code\character::precachemodelarray( xmodelalias\c_jup_zmb_zombie_base_long_shirt_head_yz::main() );
}

// Namespace character_jup_zombie_base_male_long_shirt_yz_lightweight / namespace_b5d1eaa7e3f521f2
// Params 0
// Checksum 0x0, Offset: 0x2c3
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_jup_zombie_base_male_long_shirt_yz_lightweight / namespace_b5d1eaa7e3f521f2
// Params 1
// Checksum 0x0, Offset: 0x2d4
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_b1fd5c5c381b02f0":
            return xmodelalias\c_jup_zmb_zombie_base_male_long_shirt_body_yz_safe::main();
        case #"hash_b9da372d17774d90":
            return xmodelalias\c_jup_zmb_zombie_base_long_shirt_head_yz::main();
    }
    
    assert( 0, "<dev string:x1c>" );
}

