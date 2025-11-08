#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_civ_russian_male_body_1;
#using xmodelalias\civ_russian_male_head_1;

#namespace c_jup_civ_russian_male;

// Namespace c_jup_civ_russian_male / namespace_30f412333bb69ba3
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x10e
// Size: 0xb3
function private autoexec init()
{
    character = #"c_jup_civ_russian_male";
    
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
        level.fncharacterxmodelalias[ %"c_jup_civ_russian_male" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_civ_russian_male / namespace_30f412333bb69ba3
// Params 0
// Checksum 0x0, Offset: 0x1c9
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "c_jup_civ_russian_male_body_1", xmodelalias\c_jup_civ_russian_male_body_1::main() );
    scripts\code\character::attachhead( "civ_russian_male_head_1", xmodelalias\civ_russian_male_head_1::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_russian_male / namespace_30f412333bb69ba3
// Params 0
// Checksum 0x0, Offset: 0x282
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_russian_male / namespace_30f412333bb69ba3
// Params 0
// Checksum 0x0, Offset: 0x28c
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\c_jup_civ_russian_male_body_1::main() );
    scripts\code\character::precachemodelarray( xmodelalias\civ_russian_male_head_1::main() );
}

// Namespace c_jup_civ_russian_male / namespace_30f412333bb69ba3
// Params 0
// Checksum 0x0, Offset: 0x2b7
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace c_jup_civ_russian_male / namespace_30f412333bb69ba3
// Params 1
// Checksum 0x0, Offset: 0x2c8
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_8b901f50274024b8":
            return xmodelalias\c_jup_civ_russian_male_body_1::main();
        case #"hash_9741638f65b1ecbc":
            return xmodelalias\civ_russian_male_head_1::main();
    }
    
    assert( 0, "c_jup_civ_russian_male do not have any xmodelalias" );
}

