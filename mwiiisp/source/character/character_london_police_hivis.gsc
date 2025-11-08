#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\heads_london_police;

#namespace character_london_police_hivis;

// Namespace character_london_police_hivis / character\character_london_police_hivis
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x10e
// Size: 0xb3
function private autoexec init()
{
    character = #"character_london_police_hivis";
    
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
        level.fncharacterxmodelalias[ %"character_london_police_hivis" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_london_police_hivis / character\character_london_police_hivis
// Params 0
// Checksum 0x0, Offset: 0x1c9
// Size: 0xab
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier_pistol";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setmodel( "civilian_london_police_male_1_body" );
    scripts\code\character::attachhead( "heads_london_police", xmodelalias\heads_london_police::main() );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_london_police_hivis / character\character_london_police_hivis
// Params 0
// Checksum 0x0, Offset: 0x27c
// Size: 0x2
function precache()
{
    
}

// Namespace character_london_police_hivis / character\character_london_police_hivis
// Params 0
// Checksum 0x0, Offset: 0x286
// Size: 0x21
function precache_sp()
{
    precache();
    precachemodel( "civilian_london_police_male_1_body" );
    scripts\code\character::precachemodelarray( xmodelalias\heads_london_police::main() );
}

// Namespace character_london_police_hivis / character\character_london_police_hivis
// Params 0
// Checksum 0x0, Offset: 0x2af
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_london_police_hivis / character\character_london_police_hivis
// Params 1
// Checksum 0x0, Offset: 0x2c0
// Size: 0x36
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_e2135c17a101148e":
            return xmodelalias\heads_london_police::main();
    }
    
    assert( 0, "character_london_police_hivis do not have any xmodelalias" );
}

