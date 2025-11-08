#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_zmb_zombie_base_male_merc_head;

#namespace character_jup_zombie_base_male_merc;

// Namespace character_jup_zombie_base_male_merc / namespace_d910f80f6cf1170d
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xff
// Size: 0xb4
function private autoexec init()
{
    character = #"character_jup_zombie_base_male_merc";
    
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
        level.fncharacterxmodelalias[ %"character_jup_zombie_base_male_merc" ] = &function_ecf17a96e49ab67;
        return;
    }
    
    level.fncharacterprecache[ character ] = &precache_cpmp;
}

// Namespace character_jup_zombie_base_male_merc / namespace_d910f80f6cf1170d
// Params 0
// Checksum 0x0, Offset: 0x1bb
// Size: 0xab
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_base";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_base";
    self setmodel( "c_jup_zmb_zombie_base_male_merc_body" );
    scripts\code\character::attachhead( "c_jup_zmb_zombie_base_male_merc_head", xmodelalias\c_jup_zmb_zombie_base_male_merc_head::main() );
    self setclothtype( #"vestheavy" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_base_male_merc / namespace_d910f80f6cf1170d
// Params 0
// Checksum 0x0, Offset: 0x26e
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_base_male_merc / namespace_d910f80f6cf1170d
// Params 0
// Checksum 0x0, Offset: 0x278
// Size: 0x21
function precache_sp()
{
    precache();
    precachemodel( "c_jup_zmb_zombie_base_male_merc_body" );
    scripts\code\character::precachemodelarray( xmodelalias\c_jup_zmb_zombie_base_male_merc_head::main() );
}

// Namespace character_jup_zombie_base_male_merc / namespace_d910f80f6cf1170d
// Params 0
// Checksum 0x0, Offset: 0x2a1
// Size: 0x9
function precache_cpmp()
{
    precache();
}

// Namespace character_jup_zombie_base_male_merc / namespace_d910f80f6cf1170d
// Params 1
// Checksum 0x0, Offset: 0x2b2
// Size: 0x36
function function_ecf17a96e49ab67( xmodelalias )
{
    switch ( xmodelalias )
    {
        case #"hash_36614506bb40610":
            return xmodelalias\c_jup_zmb_zombie_base_male_merc_head::main();
    }
    
    assert( 0, "<dev string:x1c>" );
}

