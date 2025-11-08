#using scripts\common\utility;

#namespace character_jup_zombie_base_charred_female;

// Namespace character_jup_zombie_base_charred_female / namespace_2d6ec402a80dacf2
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xfb
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_zombie_base_charred_female";
    
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

// Namespace character_jup_zombie_base_charred_female / namespace_2d6ec402a80dacf2
// Params 0
// Checksum 0x0, Offset: 0x19e
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_base";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_base";
    self setmodel( "c_jup_zmb_zombie_base_charred_female_body" );
    self attach( "c_jup_zmb_zombie_base_charred_female_head", "", 1 );
    self.headmodel = "c_jup_zmb_zombie_base_charred_female_head";
    self setclothtype( #"vestheavy" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_base_charred_female / namespace_2d6ec402a80dacf2
// Params 0
// Checksum 0x0, Offset: 0x260
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_base_charred_female / namespace_2d6ec402a80dacf2
// Params 0
// Checksum 0x0, Offset: 0x26a
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "c_jup_zmb_zombie_base_charred_female_body" );
    precachemodel( "c_jup_zmb_zombie_base_charred_female_head" );
}

// Namespace character_jup_zombie_base_charred_female / namespace_2d6ec402a80dacf2
// Params 0
// Checksum 0x0, Offset: 0x291
// Size: 0x9
function precache_cpmp()
{
    precache();
}

