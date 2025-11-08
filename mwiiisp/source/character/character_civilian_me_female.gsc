#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_me_female_bodies;
#using xmodelalias\civilian_me_female_heads;

#namespace character_civilian_me_female;

// Namespace character_civilian_me_female / character\character_civilian_me_female
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x118
// Size: 0xb3
function private autoexec init()
{
    character = #"character_civilian_me_female";
    
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
        level.fncharacterxmodelalias[ %"character_civilian_me_female" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_civilian_me_female / character\character_civilian_me_female
// Params 0
// Checksum 0x0, Offset: 0x1d3
// Size: 0xb1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_react_female";
    self.voice = #"fsafemale";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "civilian_me_female_bodies", xmodelalias\civilian_me_female_bodies::main() );
    scripts\code\character::attachhead( "civilian_me_female_heads", xmodelalias\civilian_me_female_heads::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_civilian_me_female / character\character_civilian_me_female
// Params 0
// Checksum 0x0, Offset: 0x28c
// Size: 0x2
function precache()
{
    
}

// Namespace character_civilian_me_female / character\character_civilian_me_female
// Params 0
// Checksum 0x0, Offset: 0x296
// Size: 0x23
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\civilian_me_female_bodies::main() );
    scripts\code\character::precachemodelarray( xmodelalias\civilian_me_female_heads::main() );
}

// Namespace character_civilian_me_female / character\character_civilian_me_female
// Params 0
// Checksum 0x0, Offset: 0x2c1
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_civilian_me_female / character\character_civilian_me_female
// Params 1
// Checksum 0x0, Offset: 0x2d2
// Size: 0x49
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_2ea77bff67edb529":
            return xmodelalias\civilian_me_female_bodies::main();
        case #"hash_a5e3635a140ed050":
            return xmodelalias\civilian_me_female_heads::main();
    }
    
    assert( 0, "character_civilian_me_female do not have any xmodelalias" );
}

