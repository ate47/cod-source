#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_zmb_zombie_base_male_shortsleeves_body_gz;

#namespace character_jup_zombie_base_male_shortsleeve_gz;

// Namespace character_jup_zombie_base_male_shortsleeve_gz / namespace_d430a4dc6d501cae
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x10e
// Size: 0xb4
function private autoexec init()
{
    character = #"character_jup_zombie_base_male_shortsleeve_gz";
    
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
        level.fncharacterxmodelalias[ %"character_jup_zombie_base_male_shortsleeve_gz" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_jup_zombie_base_male_shortsleeve_gz / namespace_d430a4dc6d501cae
// Params 0
// Checksum 0x0, Offset: 0x1ca
// Size: 0xc0
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_base";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_base";
    self setcharactermodelfromarray( "c_jup_zmb_zombie_base_male_shortsleeves_body_gz", xmodelalias\c_jup_zmb_zombie_base_male_shortsleeves_body_gz::main() );
    self attach( "c_jup_zmb_zombie_base_male_head_1_gz", "", 1 );
    self.headmodel = "c_jup_zmb_zombie_base_male_head_1_gz";
    self setclothtype( #"vestheavy" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_base_male_shortsleeve_gz / namespace_d430a4dc6d501cae
// Params 0
// Checksum 0x0, Offset: 0x292
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_base_male_shortsleeve_gz / namespace_d430a4dc6d501cae
// Params 0
// Checksum 0x0, Offset: 0x29c
// Size: 0x21
function precache_sp()
{
    precache();
    scripts\code\character::precachemodelarray( xmodelalias\c_jup_zmb_zombie_base_male_shortsleeves_body_gz::main() );
    precachemodel( "c_jup_zmb_zombie_base_male_head_1_gz" );
}

// Namespace character_jup_zombie_base_male_shortsleeve_gz / namespace_d430a4dc6d501cae
// Params 0
// Checksum 0x0, Offset: 0x2c5
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_jup_zombie_base_male_shortsleeve_gz / namespace_d430a4dc6d501cae
// Params 1
// Checksum 0x0, Offset: 0x2d6
// Size: 0x36
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_9c6e573b6583ceac":
            return xmodelalias\c_jup_zmb_zombie_base_male_shortsleeves_body_gz::main();
    }
    
    assert( 0, "<dev string:x1c>" );
}

