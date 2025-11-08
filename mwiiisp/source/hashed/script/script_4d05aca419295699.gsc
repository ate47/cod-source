#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_syrkistan_female_head;

#namespace c_jup_civ_london_female_01;

// Namespace c_jup_civ_london_female_01 / namespace_9ad82e9fcc422fe7
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x11b
// Size: 0xb3
function private autoexec init()
{
    character = #"c_jup_civ_london_female_01";
    
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
        level.fncharacterxmodelalias[ %"c_jup_civ_london_female_01" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_civ_london_female_01 / namespace_9ad82e9fcc422fe7
// Params 0
// Checksum 0x0, Offset: 0x1d6
// Size: 0xab
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react_female";
    self.voice = #"unitednationsfemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "c_jup_body_civ_london_female_1_1" );
    scripts\code\character::attachhead( "civilian_syrkistan_female_head", xmodelalias\civilian_syrkistan_female_head::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_london_female_01 / namespace_9ad82e9fcc422fe7
// Params 0
// Checksum 0x0, Offset: 0x289
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_london_female_01 / namespace_9ad82e9fcc422fe7
// Params 0
// Checksum 0x0, Offset: 0x293
// Size: 0x21
function precache_sp()
{
    precache();
    precachemodel( "c_jup_body_civ_london_female_1_1" );
    scripts\code\character::precachemodelarray( xmodelalias\civilian_syrkistan_female_head::main() );
}

// Namespace c_jup_civ_london_female_01 / namespace_9ad82e9fcc422fe7
// Params 0
// Checksum 0x0, Offset: 0x2bc
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace c_jup_civ_london_female_01 / namespace_9ad82e9fcc422fe7
// Params 1
// Checksum 0x0, Offset: 0x2cd
// Size: 0x36
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_e3145a0418a4fdd5":
            return xmodelalias\civilian_syrkistan_female_head::main();
    }
    
    assert( 0, "c_jup_civ_london_female_01 do not have any xmodelalias" );
}

