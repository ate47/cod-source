#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_me_male_body_3_hostage;

#namespace character_hostage_me_male_3_1_dmz;

// Namespace character_hostage_me_male_3_1_dmz / namespace_7a51c0ee935e060d
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x108
// Size: 0xb4
function private autoexec init()
{
    character = #"character_hostage_me_male_3_1_dmz";
    
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
        level.fncharacterxmodelalias[ %"character_hostage_me_male_3_1_dmz" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_hostage_me_male_3_1_dmz / namespace_7a51c0ee935e060d
// Params 0
// Checksum 0x0, Offset: 0x1c4
// Size: 0xc0
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "civilian_dmz_hostage";
    self.voice = #"fsa";
    self.bhasthighholster = 0;
    self.animtree = "generic_human";
    self setcharactermodelfromarray( "civilian_me_male_body_3_hostage", xmodelalias\civilian_me_male_body_3_hostage::main() );
    self attach( "head_hostage_hood_01", "", 1 );
    self.headmodel = "head_hostage_hood_01";
    self setclothtype( #"flowing" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_hostage_me_male_3_1_dmz / namespace_7a51c0ee935e060d
// Params 0
// Checksum 0x0, Offset: 0x28c
// Size: 0x2
function precache()
{
    
}

// Namespace character_hostage_me_male_3_1_dmz / namespace_7a51c0ee935e060d
// Params 0
// Checksum 0x0, Offset: 0x296
// Size: 0x21
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\civilian_me_male_body_3_hostage::main() );
    precachemodel( "head_hostage_hood_01" );
}

// Namespace character_hostage_me_male_3_1_dmz / namespace_7a51c0ee935e060d
// Params 0
// Checksum 0x0, Offset: 0x2bf
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_hostage_me_male_3_1_dmz / namespace_7a51c0ee935e060d
// Params 1
// Checksum 0x0, Offset: 0x2d0
// Size: 0x36
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_d00abb5d1c5e4de2":
            return xmodelalias\civilian_me_male_body_3_hostage::main();
    }
    
    assert( 0, "<dev string:x1c>" );
}

