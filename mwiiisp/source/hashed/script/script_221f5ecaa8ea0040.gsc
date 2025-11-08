#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_london_male_body_skintone_light;
#using xmodelalias\civilian_uk_male_heads_skintone_light;

#namespace c_jup_civ_london_male_skintone_01;

// Namespace c_jup_civ_london_male_skintone_01 / namespace_8e394d93f190d294
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x132
// Size: 0xb3
function private autoexec init()
{
    character = #"c_jup_civ_london_male_skintone_01";
    
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
        level.fncharacterxmodelalias[ %"c_jup_civ_london_male_skintone_01" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_civ_london_male_skintone_01 / namespace_8e394d93f190d294
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
    self setcharactermodelfromarray( "civilian_london_male_body_skintone_light", xmodelalias\civilian_london_male_body_skintone_light::main() );
    scripts\code\character::attachhead( "civilian_uk_male_heads_skintone_light", xmodelalias\civilian_uk_male_heads_skintone_light::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_london_male_skintone_01 / namespace_8e394d93f190d294
// Params 0
// Checksum 0x0, Offset: 0x2a6
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_london_male_skintone_01 / namespace_8e394d93f190d294
// Params 0
// Checksum 0x0, Offset: 0x2b0
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\civilian_london_male_body_skintone_light::main() );
    scripts\code\character::precachemodelarray( xmodelalias\civilian_uk_male_heads_skintone_light::main() );
}

// Namespace c_jup_civ_london_male_skintone_01 / namespace_8e394d93f190d294
// Params 0
// Checksum 0x0, Offset: 0x2db
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace c_jup_civ_london_male_skintone_01 / namespace_8e394d93f190d294
// Params 1
// Checksum 0x0, Offset: 0x2ec
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_28ea34504bd829fd":
            return xmodelalias\civilian_london_male_body_skintone_light::main();
        case #"hash_7bbbf17f0d0279ce":
            return xmodelalias\civilian_uk_male_heads_skintone_light::main();
    }
    
    assert( 0, "c_jup_civ_london_male_skintone_01 do not have any xmodelalias" );
}

