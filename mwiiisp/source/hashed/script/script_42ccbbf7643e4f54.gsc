#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_civilian_russian_female_body;
#using xmodelalias\civilian_russian_female_head;

#namespace c_jup_civ_russian_female;

// Namespace c_jup_civ_russian_female / namespace_728534d72cdd0bfa
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x121
// Size: 0xb3
function private autoexec init()
{
    character = #"c_jup_civ_russian_female";
    
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
        level.fncharacterxmodelalias[ %"c_jup_civ_russian_female" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace c_jup_civ_russian_female / namespace_728534d72cdd0bfa
// Params 0
// Checksum 0x0, Offset: 0x1dc
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react_female";
    self.voice = #"alqatalafemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "c_jup_civilian_russian_female_body", xmodelalias\c_jup_civilian_russian_female_body::main() );
    scripts\code\character::attachhead( "civilian_russian_female_head", xmodelalias\civilian_russian_female_head::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace c_jup_civ_russian_female / namespace_728534d72cdd0bfa
// Params 0
// Checksum 0x0, Offset: 0x295
// Size: 0x2
function precache()
{
    
}

// Namespace c_jup_civ_russian_female / namespace_728534d72cdd0bfa
// Params 0
// Checksum 0x0, Offset: 0x29f
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\c_jup_civilian_russian_female_body::main() );
    scripts\code\character::precachemodelarray( xmodelalias\civilian_russian_female_head::main() );
}

// Namespace c_jup_civ_russian_female / namespace_728534d72cdd0bfa
// Params 0
// Checksum 0x0, Offset: 0x2ca
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace c_jup_civ_russian_female / namespace_728534d72cdd0bfa
// Params 1
// Checksum 0x0, Offset: 0x2db
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_2efc6259ad8b666":
            return xmodelalias\c_jup_civilian_russian_female_body::main();
        case #"hash_8d954660328473f6":
            return xmodelalias\civilian_russian_female_head::main();
    }
    
    assert( 0, "c_jup_civ_russian_female do not have any xmodelalias" );
}

