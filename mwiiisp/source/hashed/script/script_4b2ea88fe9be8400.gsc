#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_london_female_heads;
#using xmodelalias\test_alias_civ_london_female_2_body;

#namespace c_jup_civ_london_female_02;

// Namespace c_jup_civ_london_female_02 / namespace_9ad82f9fcc42321a
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x124
// Size: 0xb3
function private autoexec init()
{
    character = #"c_jup_civ_london_female_02";
    
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
        level.fncharacterxmodelalias[ %"c_jup_civ_london_female_02" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_civ_london_female_02 / namespace_9ad82f9fcc42321a
// Params 0
// Checksum 0x0, Offset: 0x1df
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react_female";
    self.voice = #"unitednationsfemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "test_alias_civ_london_female_2_body", xmodelalias\test_alias_civ_london_female_2_body::main() );
    scripts\code\character::attachhead( "civilian_london_female_heads", xmodelalias\civilian_london_female_heads::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_london_female_02 / namespace_9ad82f9fcc42321a
// Params 0
// Checksum 0x0, Offset: 0x298
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_london_female_02 / namespace_9ad82f9fcc42321a
// Params 0
// Checksum 0x0, Offset: 0x2a2
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\test_alias_civ_london_female_2_body::main() );
    scripts\code\character::precachemodelarray( xmodelalias\civilian_london_female_heads::main() );
}

// Namespace c_jup_civ_london_female_02 / namespace_9ad82f9fcc42321a
// Params 0
// Checksum 0x0, Offset: 0x2cd
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace c_jup_civ_london_female_02 / namespace_9ad82f9fcc42321a
// Params 1
// Checksum 0x0, Offset: 0x2de
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_439d1e6fc1c0e413":
            return xmodelalias\test_alias_civ_london_female_2_body::main();
        case #"hash_cebfd7e97d870708":
            return xmodelalias\civilian_london_female_heads::main();
    }
    
    assert( 0, "c_jup_civ_london_female_02 do not have any xmodelalias" );
}

