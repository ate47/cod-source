#using scripts\common\utility;

#namespace test_character_dog;

// Namespace test_character_dog / character\test_character_dog
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x83
// Size: 0x9a
function private autoexec init()
{
    character = #"test_character_dog";
    
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
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace test_character_dog / character\test_character_dog
// Params 0
// Checksum 0x0, Offset: 0x125
// Size: 0x99
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "dog";
    self.voice = #"unitednations";
    self.bhasthighholster = 0;
    self.animtree = "dog";
    self setmodel( "fullbody_dog_c" );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace test_character_dog / character\test_character_dog
// Params 0
// Checksum 0x0, Offset: 0x1c6
// Size: 0x2
function precache()
{
    
}

// Namespace test_character_dog / character\test_character_dog
// Params 0
// Checksum 0x0, Offset: 0x1d0
// Size: 0x14
function precache_sp()
{
    precache();
    precachemodel( "fullbody_dog_c" );
}

// Namespace test_character_dog / character\test_character_dog
// Params 0
// Checksum 0x0, Offset: 0x1ec
// Size: 0x9
function precache_cpmp()
{
    precache();
}

