#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_civilian_london_female_body_02_skintone_med;
#using xmodelalias\civilian_london_female_heads_skintone_med;

#namespace c_jup_civ_london_female_02_skintone_med;

// Namespace c_jup_civ_london_female_02_skintone_med / namespace_29ad99355926eabb
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x14c
// Size: 0xb3
function private autoexec init()
{
    character = #"c_jup_civ_london_female_02_skintone_med";
    
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
        level.fncharacterxmodelalias[ %"c_jup_civ_london_female_02_skintone_med" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_civ_london_female_02_skintone_med / namespace_29ad99355926eabb
// Params 0
// Checksum 0x0, Offset: 0x207
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react_female";
    self.voice = #"unitednationsfemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "c_jup_civilian_london_female_body_02_skintone_med", xmodelalias\c_jup_civilian_london_female_body_02_skintone_med::main() );
    scripts\code\character::attachhead( "civilian_london_female_heads_skintone_med", xmodelalias\civilian_london_female_heads_skintone_med::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_london_female_02_skintone_med / namespace_29ad99355926eabb
// Params 0
// Checksum 0x0, Offset: 0x2c0
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_london_female_02_skintone_med / namespace_29ad99355926eabb
// Params 0
// Checksum 0x0, Offset: 0x2ca
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\c_jup_civilian_london_female_body_02_skintone_med::main() );
    scripts\code\character::precachemodelarray( xmodelalias\civilian_london_female_heads_skintone_med::main() );
}

// Namespace c_jup_civ_london_female_02_skintone_med / namespace_29ad99355926eabb
// Params 0
// Checksum 0x0, Offset: 0x2f5
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace c_jup_civ_london_female_02_skintone_med / namespace_29ad99355926eabb
// Params 1
// Checksum 0x0, Offset: 0x306
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_3c67083b0947dcef":
            return xmodelalias\c_jup_civilian_london_female_body_02_skintone_med::main();
        case #"hash_84a4bd3e2168a189":
            return xmodelalias\civilian_london_female_heads_skintone_med::main();
    }
    
    assert( 0, "c_jup_civ_london_female_02_skintone_med do not have any xmodelalias" );
}

