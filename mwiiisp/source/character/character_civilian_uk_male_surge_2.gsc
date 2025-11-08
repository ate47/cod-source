#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_uk_male_surge_2;
#using xmodelalias\heads_civilian_uk_male_surge_2;

#namespace character_civilian_uk_male_surge_2;

// Namespace character_civilian_uk_male_surge_2 / character\character_civilian_uk_male_surge_2
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x123
// Size: 0xb3
function private autoexec init()
{
    character = #"character_civilian_uk_male_surge_2";
    
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
        level.fncharacterxmodelalias[ %"character_civilian_uk_male_surge_2" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_civilian_uk_male_surge_2 / character\character_civilian_uk_male_surge_2
// Params 0
// Checksum 0x0, Offset: 0x1de
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "bodies_civilian_uk_male_surge_2", xmodelalias\bodies_civilian_uk_male_surge_2::main() );
    scripts\code\character::attachhead( "heads_civilian_uk_male_surge_2", xmodelalias\heads_civilian_uk_male_surge_2::main() );
    self setclothtype( #"nylon" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_civilian_uk_male_surge_2 / character\character_civilian_uk_male_surge_2
// Params 0
// Checksum 0x0, Offset: 0x297
// Size: 0x2
function precache()
{
    
}

// Namespace character_civilian_uk_male_surge_2 / character\character_civilian_uk_male_surge_2
// Params 0
// Checksum 0x0, Offset: 0x2a1
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\bodies_civilian_uk_male_surge_2::main() );
    scripts\code\character::precachemodelarray( xmodelalias\heads_civilian_uk_male_surge_2::main() );
}

// Namespace character_civilian_uk_male_surge_2 / character\character_civilian_uk_male_surge_2
// Params 0
// Checksum 0x0, Offset: 0x2cc
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_civilian_uk_male_surge_2 / character\character_civilian_uk_male_surge_2
// Params 1
// Checksum 0x0, Offset: 0x2dd
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_b6b9e54d2702eb70":
            return xmodelalias\bodies_civilian_uk_male_surge_2::main();
        case #"hash_c629b5522a0f642b":
            return xmodelalias\heads_civilian_uk_male_surge_2::main();
    }
    
    assert( 0, "character_civilian_uk_male_surge_2 do not have any xmodelalias" );
}

