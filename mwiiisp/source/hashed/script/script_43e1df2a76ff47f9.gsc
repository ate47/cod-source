#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_civilian_london_female_body_02_skintone_light;
#using xmodelalias\civilian_london_female_heads_skintone_light;

#namespace c_jup_civ_london_female_02_skintone_light;

// Namespace c_jup_civ_london_female_02_skintone_light / namespace_762ff6fc3a5bdeed
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x152
// Size: 0xb3
function private autoexec init()
{
    character = #"c_jup_civ_london_female_02_skintone_light";
    
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
        level.fncharacterxmodelalias[ %"c_jup_civ_london_female_02_skintone_light" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_civ_london_female_02_skintone_light / namespace_762ff6fc3a5bdeed
// Params 0
// Checksum 0x0, Offset: 0x20d
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react_female";
    self.voice = #"unitednationsfemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "c_jup_civilian_london_female_body_02_skintone_light", xmodelalias\c_jup_civilian_london_female_body_02_skintone_light::main() );
    scripts\code\character::attachhead( "civilian_london_female_heads_skintone_light", xmodelalias\civilian_london_female_heads_skintone_light::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_london_female_02_skintone_light / namespace_762ff6fc3a5bdeed
// Params 0
// Checksum 0x0, Offset: 0x2c6
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_london_female_02_skintone_light / namespace_762ff6fc3a5bdeed
// Params 0
// Checksum 0x0, Offset: 0x2d0
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\c_jup_civilian_london_female_body_02_skintone_light::main() );
    scripts\code\character::precachemodelarray( xmodelalias\civilian_london_female_heads_skintone_light::main() );
}

// Namespace c_jup_civ_london_female_02_skintone_light / namespace_762ff6fc3a5bdeed
// Params 0
// Checksum 0x0, Offset: 0x2fb
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace c_jup_civ_london_female_02_skintone_light / namespace_762ff6fc3a5bdeed
// Params 1
// Checksum 0x0, Offset: 0x30c
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_288e37b74a6cd951":
            return xmodelalias\c_jup_civilian_london_female_body_02_skintone_light::main();
        case #"hash_9baed28ada0ada1f":
            return xmodelalias\civilian_london_female_heads_skintone_light::main();
    }
    
    assert( 0, "c_jup_civ_london_female_02_skintone_light do not have any xmodelalias" );
}

