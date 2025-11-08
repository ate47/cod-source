#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_london_male_body_skintone_med;
#using xmodelalias\civilian_uk_male_heads_skintone_med;

#namespace c_jup_civ_london_male_skintone_med;

// Namespace c_jup_civ_london_male_skintone_med / namespace_5579395db6a5d327
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x12f
// Size: 0xb3
function private autoexec init()
{
    character = #"c_jup_civ_london_male_skintone_med";
    
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
        level.fncharacterxmodelalias[ %"c_jup_civ_london_male_skintone_med" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_civ_london_male_skintone_med / namespace_5579395db6a5d327
// Params 0
// Checksum 0x0, Offset: 0x1ea
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "civilian_london_male_body_skintone_med", xmodelalias\civilian_london_male_body_skintone_med::main() );
    scripts\code\character::attachhead( "civilian_uk_male_heads_skintone_med", xmodelalias\civilian_uk_male_heads_skintone_med::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_london_male_skintone_med / namespace_5579395db6a5d327
// Params 0
// Checksum 0x0, Offset: 0x2a3
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_london_male_skintone_med / namespace_5579395db6a5d327
// Params 0
// Checksum 0x0, Offset: 0x2ad
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\civilian_london_male_body_skintone_med::main() );
    scripts\code\character::precachemodelarray( xmodelalias\civilian_uk_male_heads_skintone_med::main() );
}

// Namespace c_jup_civ_london_male_skintone_med / namespace_5579395db6a5d327
// Params 0
// Checksum 0x0, Offset: 0x2d8
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace c_jup_civ_london_male_skintone_med / namespace_5579395db6a5d327
// Params 1
// Checksum 0x0, Offset: 0x2e9
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_f078727cd9c2a92b":
            return xmodelalias\civilian_london_male_body_skintone_med::main();
        case #"hash_bf18e3bb4e1e42cc":
            return xmodelalias\civilian_uk_male_heads_skintone_med::main();
    }
    
    assert( 0, "c_jup_civ_london_male_skintone_med do not have any xmodelalias" );
}

