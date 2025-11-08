#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\test_alias_civilian_female_surge_body;
#using xmodelalias\test_alias_civilian_female_surge_head;

#namespace test_character_civilian_female_surge;

// Namespace test_character_civilian_female_surge / namespace_bf5341fc38c23b91
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x132
// Size: 0xb3
function private autoexec init()
{
    character = #"test_character_civilian_female_surge";
    
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
        level.fncharacterxmodelalias[ %"test_character_civilian_female_surge" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace test_character_civilian_female_surge / namespace_bf5341fc38c23b91
// Params 0
// Checksum 0x0, Offset: 0x1ed
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "test_alias_civilian_female_surge_body", xmodelalias\test_alias_civilian_female_surge_body::main() );
    scripts\code\character::attachhead( "test_alias_civilian_female_surge_head", xmodelalias\test_alias_civilian_female_surge_head::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace test_character_civilian_female_surge / namespace_bf5341fc38c23b91
// Params 0
// Checksum 0x0, Offset: 0x2a6
// Size: 0x2
function precache()
{
    
}

// Namespace test_character_civilian_female_surge / namespace_bf5341fc38c23b91
// Params 0
// Checksum 0x0, Offset: 0x2b0
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\test_alias_civilian_female_surge_body::main() );
    scripts\code\character::precachemodelarray( xmodelalias\test_alias_civilian_female_surge_head::main() );
}

// Namespace test_character_civilian_female_surge / namespace_bf5341fc38c23b91
// Params 0
// Checksum 0x0, Offset: 0x2db
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace test_character_civilian_female_surge / namespace_bf5341fc38c23b91
// Params 1
// Checksum 0x0, Offset: 0x2ec
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_917dd15b39af92a7":
            return xmodelalias\test_alias_civilian_female_surge_body::main();
        case #"hash_e904a03550281bb5":
            return xmodelalias\test_alias_civilian_female_surge_head::main();
    }
    
    assert( 0, "test_character_civilian_female_surge do not have any xmodelalias" );
}

