#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_civilian_london_female_body_02_skintone_dark;
#using xmodelalias\civilian_london_female_heads_skintone_dark;

#namespace c_jup_civ_london_female_02_skintone_dark;

// Namespace c_jup_civ_london_female_02_skintone_dark / namespace_4d12fac695bdda3
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x14f
// Size: 0xb3
function private autoexec init()
{
    character = #"c_jup_civ_london_female_02_skintone_dark";
    
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
        level.fncharacterxmodelalias[ %"c_jup_civ_london_female_02_skintone_dark" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_civ_london_female_02_skintone_dark / namespace_4d12fac695bdda3
// Params 0
// Checksum 0x0, Offset: 0x20a
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react_female";
    self.voice = #"unitednationsfemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "c_jup_civilian_london_female_body_02_skintone_dark", xmodelalias\c_jup_civilian_london_female_body_02_skintone_dark::main() );
    scripts\code\character::attachhead( "civilian_london_female_heads_skintone_dark", xmodelalias\civilian_london_female_heads_skintone_dark::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_london_female_02_skintone_dark / namespace_4d12fac695bdda3
// Params 0
// Checksum 0x0, Offset: 0x2c3
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_london_female_02_skintone_dark / namespace_4d12fac695bdda3
// Params 0
// Checksum 0x0, Offset: 0x2cd
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\c_jup_civilian_london_female_body_02_skintone_dark::main() );
    scripts\code\character::precachemodelarray( xmodelalias\civilian_london_female_heads_skintone_dark::main() );
}

// Namespace c_jup_civ_london_female_02_skintone_dark / namespace_4d12fac695bdda3
// Params 0
// Checksum 0x0, Offset: 0x2f8
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace c_jup_civ_london_female_02_skintone_dark / namespace_4d12fac695bdda3
// Params 1
// Checksum 0x0, Offset: 0x309
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_32ab50c4a7c8d1ef":
            return xmodelalias\c_jup_civilian_london_female_body_02_skintone_dark::main();
        case #"hash_ce6562a382078a15":
            return xmodelalias\civilian_london_female_heads_skintone_dark::main();
    }
    
    assert( 0, "c_jup_civ_london_female_02_skintone_dark do not have any xmodelalias" );
}

