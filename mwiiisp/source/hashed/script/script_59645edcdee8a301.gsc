#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_asm_female_4;
#using xmodelalias\heads_civilian_asm_female_4;

#namespace character_civilian_ams_female_4_sitting;

// Namespace character_civilian_ams_female_4_sitting / namespace_4187fd331555ccd5
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x127
// Size: 0xb3
function private autoexec init()
{
    character = #"character_civilian_ams_female_4_sitting";
    
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
        level.fncharacterxmodelalias[ %"character_civilian_ams_female_4_sitting" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_civilian_ams_female_4_sitting / namespace_4187fd331555ccd5
// Params 0
// Checksum 0x0, Offset: 0x1e2
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react_loco";
    self.voice = #"unitednationsfemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "bodies_civilian_asm_female_4", xmodelalias\bodies_civilian_asm_female_4::main() );
    scripts\code\character::attachhead( "heads_civilian_asm_female_4", xmodelalias\heads_civilian_asm_female_4::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_civilian_ams_female_4_sitting / namespace_4187fd331555ccd5
// Params 0
// Checksum 0x0, Offset: 0x29b
// Size: 0x2
function precache()
{
    
}

// Namespace character_civilian_ams_female_4_sitting / namespace_4187fd331555ccd5
// Params 0
// Checksum 0x0, Offset: 0x2a5
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\bodies_civilian_asm_female_4::main() );
    scripts\code\character::precachemodelarray( xmodelalias\heads_civilian_asm_female_4::main() );
}

// Namespace character_civilian_ams_female_4_sitting / namespace_4187fd331555ccd5
// Params 0
// Checksum 0x0, Offset: 0x2d0
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_civilian_ams_female_4_sitting / namespace_4187fd331555ccd5
// Params 1
// Checksum 0x0, Offset: 0x2e1
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_331b224a38c32097":
            return xmodelalias\bodies_civilian_asm_female_4::main();
        case #"hash_c28e57e15f6edd2":
            return xmodelalias\heads_civilian_asm_female_4::main();
    }
    
    assert( 0, "character_civilian_ams_female_4_sitting do not have any xmodelalias" );
}

