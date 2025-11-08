#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civ_london_male_1;
#using xmodelalias\test_civ_picc_heads;

#namespace civ_london_male_1;

// Namespace civ_london_male_1 / character\civ_london_male_1
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xf3
// Size: 0xb3
function private autoexec init()
{
    character = #"civ_london_male_1";
    
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
        level.fncharacterxmodelalias[ %"civ_london_male_1" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace civ_london_male_1 / character\civ_london_male_1
// Params 0
// Checksum 0x0, Offset: 0x1ae
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "civ_london_male_1", xmodelalias\civ_london_male_1::main() );
    scripts\code\character::attachhead( "test_civ_picc_heads", xmodelalias\test_civ_picc_heads::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace civ_london_male_1 / character\civ_london_male_1
// Params 0
// Checksum 0x0, Offset: 0x267
// Size: 0x2
function precache()
{
    
}

// Namespace civ_london_male_1 / character\civ_london_male_1
// Params 0
// Checksum 0x0, Offset: 0x271
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\civ_london_male_1::main() );
    scripts\code\character::precachemodelarray( xmodelalias\test_civ_picc_heads::main() );
}

// Namespace civ_london_male_1 / character\civ_london_male_1
// Params 0
// Checksum 0x0, Offset: 0x29c
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace civ_london_male_1 / character\civ_london_male_1
// Params 1
// Checksum 0x0, Offset: 0x2ad
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_9f920eda3290e338":
            return xmodelalias\civ_london_male_1::main();
        case #"hash_9a07ec9827099f3c":
            return xmodelalias\test_civ_picc_heads::main();
    }
    
    assert( 0, "civ_london_male_1 do not have any xmodelalias" );
}

