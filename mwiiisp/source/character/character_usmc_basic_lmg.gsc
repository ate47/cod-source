#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\heads_usmc_male;

#namespace character_usmc_basic_lmg;

// Namespace character_usmc_basic_lmg / character\character_usmc_basic_lmg
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x105
// Size: 0xb3
function private autoexec init()
{
    character = #"character_usmc_basic_lmg";
    
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
        level.fncharacterxmodelalias[ %"character_usmc_basic_lmg" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_usmc_basic_lmg / character\character_usmc_basic_lmg
// Params 0
// Checksum 0x0, Offset: 0x1c0
// Size: 0xca
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "soldier";
    self.voice = #"unitedstates";
    self.bhasthighholster = 1;
    self.animtree = "generic_human";
    self setmodel( "body_usmc_basic_lmg" );
    scripts\code\character::attachhead( "heads_usmc_male", xmodelalias\heads_usmc_male::main() );
    self.hatmodel = "helmet_usmc_basic_lmg";
    self attach( self.hatmodel );
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    }
}

// Namespace character_usmc_basic_lmg / character\character_usmc_basic_lmg
// Params 0
// Checksum 0x0, Offset: 0x292
// Size: 0x2
function precache()
{
    
}

// Namespace character_usmc_basic_lmg / character\character_usmc_basic_lmg
// Params 0
// Checksum 0x0, Offset: 0x29c
// Size: 0x2c
function precache_sp()
{
    precache();
    precachemodel( "body_usmc_basic_lmg" );
    scripts\code\character::precachemodelarray( xmodelalias\heads_usmc_male::main() );
    precachemodel( "helmet_usmc_basic_lmg" );
}

// Namespace character_usmc_basic_lmg / character\character_usmc_basic_lmg
// Params 0
// Checksum 0x0, Offset: 0x2d0
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_usmc_basic_lmg / character\character_usmc_basic_lmg
// Params 1
// Checksum 0x0, Offset: 0x2e1
// Size: 0x36
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_30cc94c91d3460bb":
            return xmodelalias\heads_usmc_male::main();
    }
    
    assert( 0, "character_usmc_basic_lmg do not have any xmodelalias" );
}

