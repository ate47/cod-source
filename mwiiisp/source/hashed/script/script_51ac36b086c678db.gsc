#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civ_western_boy;
#using xmodelalias\heads_civ_western_boy;

#namespace c_jup_civ_western_boy;

// Namespace c_jup_civ_western_boy / namespace_fcec5c8f971576df
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x104
// Size: 0xb3
function private autoexec init()
{
    character = #"c_jup_civ_western_boy";
    
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
        level.fncharacterxmodelalias[ %"c_jup_civ_western_boy" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_civ_western_boy / namespace_fcec5c8f971576df
// Params 0
// Checksum 0x0, Offset: 0x1bf
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react";
    self.voice = #"fsa";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "bodies_civ_western_boy", xmodelalias\bodies_civ_western_boy::main() );
    scripts\code\character::attachhead( "heads_civ_western_boy", xmodelalias\heads_civ_western_boy::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_western_boy / namespace_fcec5c8f971576df
// Params 0
// Checksum 0x0, Offset: 0x278
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_western_boy / namespace_fcec5c8f971576df
// Params 0
// Checksum 0x0, Offset: 0x282
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\bodies_civ_western_boy::main() );
    scripts\code\character::precachemodelarray( xmodelalias\heads_civ_western_boy::main() );
}

// Namespace c_jup_civ_western_boy / namespace_fcec5c8f971576df
// Params 0
// Checksum 0x0, Offset: 0x2ad
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace c_jup_civ_western_boy / namespace_fcec5c8f971576df
// Params 1
// Checksum 0x0, Offset: 0x2be
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_f3b4e6d18ab745b8":
            return xmodelalias\bodies_civ_western_boy::main();
        case #"hash_6b40d71d2f95d25":
            return xmodelalias\heads_civ_western_boy::main();
    }
    
    assert( 0, "c_jup_civ_western_boy do not have any xmodelalias" );
}

