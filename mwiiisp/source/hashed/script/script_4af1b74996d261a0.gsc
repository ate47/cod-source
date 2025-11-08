#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_russian_female_head;

#namespace c_jup_civ_russian_female_milbase;

// Namespace c_jup_civ_russian_female_milbase / namespace_4166c5ccc107d23e
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x11d
// Size: 0xb3
function private autoexec init()
{
    character = #"c_jup_civ_russian_female_milbase";
    
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
        level.fncharacterxmodelalias[ %"c_jup_civ_russian_female_milbase" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_civ_russian_female_milbase / namespace_4166c5ccc107d23e
// Params 0
// Checksum 0x0, Offset: 0x1d8
// Size: 0xab
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react_female";
    self.voice = #"alqatalafemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "body_c_jup_sp_hero_laswell_bdu" );
    scripts\code\character::attachhead( "civilian_russian_female_head", xmodelalias\civilian_russian_female_head::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_russian_female_milbase / namespace_4166c5ccc107d23e
// Params 0
// Checksum 0x0, Offset: 0x28b
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_russian_female_milbase / namespace_4166c5ccc107d23e
// Params 0
// Checksum 0x0, Offset: 0x295
// Size: 0x21
function precache_sp()
{
    precache();
    precachemodel( "body_c_jup_sp_hero_laswell_bdu" );
    scripts\code\character::precachemodelarray( xmodelalias\civilian_russian_female_head::main() );
}

// Namespace c_jup_civ_russian_female_milbase / namespace_4166c5ccc107d23e
// Params 0
// Checksum 0x0, Offset: 0x2be
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace c_jup_civ_russian_female_milbase / namespace_4166c5ccc107d23e
// Params 1
// Checksum 0x0, Offset: 0x2cf
// Size: 0x36
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_8d954660328473f6":
            return xmodelalias\civilian_russian_female_head::main();
    }
    
    assert( 0, "c_jup_civ_russian_female_milbase do not have any xmodelalias" );
}

