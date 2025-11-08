#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_london_female_heads_skintone_med_nohair;

#namespace c_jup_civ_london_female_03_skintone_med;

// Namespace c_jup_civ_london_female_03_skintone_med / namespace_8fa6faeaa05e6346
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x13a
// Size: 0xb3
function private autoexec init()
{
    character = #"c_jup_civ_london_female_03_skintone_med";
    
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
        level.fncharacterxmodelalias[ %"c_jup_civ_london_female_03_skintone_med" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_civ_london_female_03_skintone_med / namespace_8fa6faeaa05e6346
// Params 0
// Checksum 0x0, Offset: 0x1f5
// Size: 0xab
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react_female";
    self.voice = #"unitednationsfemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "c_jup_body_civ_london_female_3_2" );
    scripts\code\character::attachhead( "civilian_london_female_heads_skintone_med_nohair", xmodelalias\civilian_london_female_heads_skintone_med_nohair::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_london_female_03_skintone_med / namespace_8fa6faeaa05e6346
// Params 0
// Checksum 0x0, Offset: 0x2a8
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_london_female_03_skintone_med / namespace_8fa6faeaa05e6346
// Params 0
// Checksum 0x0, Offset: 0x2b2
// Size: 0x21
function precache_sp()
{
    precache();
    precachemodel( "c_jup_body_civ_london_female_3_2" );
    scripts\code\character::precachemodelarray( xmodelalias\civilian_london_female_heads_skintone_med_nohair::main() );
}

// Namespace c_jup_civ_london_female_03_skintone_med / namespace_8fa6faeaa05e6346
// Params 0
// Checksum 0x0, Offset: 0x2db
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace c_jup_civ_london_female_03_skintone_med / namespace_8fa6faeaa05e6346
// Params 1
// Checksum 0x0, Offset: 0x2ec
// Size: 0x36
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_599b0f30decbff15":
            return xmodelalias\civilian_london_female_heads_skintone_med_nohair::main();
    }
    
    assert( 0, "c_jup_civ_london_female_03_skintone_med do not have any xmodelalias" );
}

