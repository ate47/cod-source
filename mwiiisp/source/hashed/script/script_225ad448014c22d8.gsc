#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_uk_female_surge_2;
#using xmodelalias\heads_civilian_uk_female_surge_2;

#namespace character_civilian_uk_female_surge_2;

// Namespace character_civilian_uk_female_surge_2 / namespace_45725734a3b467ca
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x129
// Size: 0xb3
function private autoexec init()
{
    character = #"character_civilian_uk_female_surge_2";
    
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
        level.fncharacterxmodelalias[ %"character_civilian_uk_female_surge_2" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_civilian_uk_female_surge_2 / namespace_45725734a3b467ca
// Params 0
// Checksum 0x0, Offset: 0x1e4
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "bodies_civilian_uk_female_surge_2", xmodelalias\bodies_civilian_uk_female_surge_2::main() );
    scripts\code\character::attachhead( "heads_civilian_uk_female_surge_2", xmodelalias\heads_civilian_uk_female_surge_2::main() );
    self setclothtype( #"nylon" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_civilian_uk_female_surge_2 / namespace_45725734a3b467ca
// Params 0
// Checksum 0x0, Offset: 0x29d
// Size: 0x2
function precache()
{
    
}

// Namespace character_civilian_uk_female_surge_2 / namespace_45725734a3b467ca
// Params 0
// Checksum 0x0, Offset: 0x2a7
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\bodies_civilian_uk_female_surge_2::main() );
    scripts\code\character::precachemodelarray( xmodelalias\heads_civilian_uk_female_surge_2::main() );
}

// Namespace character_civilian_uk_female_surge_2 / namespace_45725734a3b467ca
// Params 0
// Checksum 0x0, Offset: 0x2d2
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_civilian_uk_female_surge_2 / namespace_45725734a3b467ca
// Params 1
// Checksum 0x0, Offset: 0x2e3
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_34f1952b13ba1785":
            return xmodelalias\bodies_civilian_uk_female_surge_2::main();
        case #"hash_f9c54281ea2ec526":
            return xmodelalias\heads_civilian_uk_female_surge_2::main();
    }
    
    assert( 0, "character_civilian_uk_female_surge_2 do not have any xmodelalias" );
}

