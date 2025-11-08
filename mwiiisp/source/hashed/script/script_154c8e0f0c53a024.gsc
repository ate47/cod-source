#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_asm_male_5;
#using xmodelalias\heads_civilian_asm_male_5;

#namespace character_civilian_ams_male_5;

// Namespace character_civilian_ams_male_5 / namespace_e0af649dc8acbafc
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x119
// Size: 0xb3
function private autoexec init()
{
    character = #"character_civilian_ams_male_5";
    
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
        level.fncharacterxmodelalias[ %"character_civilian_ams_male_5" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_civilian_ams_male_5 / namespace_e0af649dc8acbafc
// Params 0
// Checksum 0x0, Offset: 0x1d4
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react_loco";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "bodies_civilian_asm_male_5", xmodelalias\bodies_civilian_asm_male_5::main() );
    scripts\code\character::attachhead( "heads_civilian_asm_male_5", xmodelalias\heads_civilian_asm_male_5::main() );
    self setclothtype( #"cloth" );
    self setgeartype( #"wstlghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_civilian_ams_male_5 / namespace_e0af649dc8acbafc
// Params 0
// Checksum 0x0, Offset: 0x28d
// Size: 0x2
function precache()
{
    
}

// Namespace character_civilian_ams_male_5 / namespace_e0af649dc8acbafc
// Params 0
// Checksum 0x0, Offset: 0x297
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\bodies_civilian_asm_male_5::main() );
    scripts\code\character::precachemodelarray( xmodelalias\heads_civilian_asm_male_5::main() );
}

// Namespace character_civilian_ams_male_5 / namespace_e0af649dc8acbafc
// Params 0
// Checksum 0x0, Offset: 0x2c2
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_civilian_ams_male_5 / namespace_e0af649dc8acbafc
// Params 1
// Checksum 0x0, Offset: 0x2d3
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_72560441517a7c15":
            return xmodelalias\bodies_civilian_asm_male_5::main();
        case #"hash_8262918ebe19c858":
            return xmodelalias\heads_civilian_asm_male_5::main();
    }
    
    assert( 0, "character_civilian_ams_male_5 do not have any xmodelalias" );
}

