#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_spetsnaz_ar;

#namespace character_spetsnaz_ar;

// Namespace character_spetsnaz_ar / character\character_spetsnaz_ar
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xea
// Size: 0xb4
function private autoexec init()
{
    character = #"character_spetsnaz_ar";
    
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
        level.fncharacterxmodelalias[ %"character_spetsnaz_ar" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_spetsnaz_ar / character\character_spetsnaz_ar
// Params 0
// Checksum 0x0, Offset: 0x1a6
// Size: 0xc1
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"russian";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "bodies_spetsnaz_ar", xmodelalias\bodies_spetsnaz_ar::main() );
    self attach( "head_spetsnaz_ar", "", 1 );
    self.headmodel = "head_spetsnaz_ar";
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_spetsnaz_ar / character\character_spetsnaz_ar
// Params 0
// Checksum 0x0, Offset: 0x26f
// Size: 0x2
function precache()
{
    
}

// Namespace character_spetsnaz_ar / character\character_spetsnaz_ar
// Params 0
// Checksum 0x0, Offset: 0x279
// Size: 0x21
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\bodies_spetsnaz_ar::main() );
    precachemodel( "head_spetsnaz_ar" );
}

// Namespace character_spetsnaz_ar / character\character_spetsnaz_ar
// Params 0
// Checksum 0x0, Offset: 0x2a2
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_spetsnaz_ar / character\character_spetsnaz_ar
// Params 1
// Checksum 0x0, Offset: 0x2b3
// Size: 0x36
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_43375c8124717c70":
            return xmodelalias\bodies_spetsnaz_ar::main();
    }
    
    assert( 0, "<dev string:x1c>" );
}

