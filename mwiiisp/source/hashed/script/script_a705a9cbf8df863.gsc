#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_civ_russian_male_body_flashback;
#using xmodelalias\civ_russian_male_head_1_flashback;

#namespace c_jup_civ_russian_male_flashback;

// Namespace c_jup_civ_russian_male_flashback / namespace_c28203d419e5a515
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x12a
// Size: 0xb3
function private autoexec init()
{
    character = #"c_jup_civ_russian_male_flashback";
    
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
        level.fncharacterxmodelalias[ %"c_jup_civ_russian_male_flashback" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_civ_russian_male_flashback / namespace_c28203d419e5a515
// Params 0
// Checksum 0x0, Offset: 0x1e5
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "c_jup_civ_russian_male_body_flashback", xmodelalias\c_jup_civ_russian_male_body_flashback::main() );
    scripts\code\character::attachhead( "civ_russian_male_head_1_flashback", xmodelalias\civ_russian_male_head_1_flashback::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_russian_male_flashback / namespace_c28203d419e5a515
// Params 0
// Checksum 0x0, Offset: 0x29e
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_russian_male_flashback / namespace_c28203d419e5a515
// Params 0
// Checksum 0x0, Offset: 0x2a8
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\c_jup_civ_russian_male_body_flashback::main() );
    scripts\code\character::precachemodelarray( xmodelalias\civ_russian_male_head_1_flashback::main() );
}

// Namespace c_jup_civ_russian_male_flashback / namespace_c28203d419e5a515
// Params 0
// Checksum 0x0, Offset: 0x2d3
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace c_jup_civ_russian_male_flashback / namespace_c28203d419e5a515
// Params 1
// Checksum 0x0, Offset: 0x2e4
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_1f0e8fb5797c9af2":
            return xmodelalias\c_jup_civ_russian_male_body_flashback::main();
        case #"hash_d1d30bfb5ae024f2":
            return xmodelalias\civ_russian_male_head_1_flashback::main();
    }
    
    assert( 0, "c_jup_civ_russian_male_flashback do not have any xmodelalias" );
}

