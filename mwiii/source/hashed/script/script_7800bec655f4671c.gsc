#using scripts\common\utility;

#namespace character_jup_zombie_base_female_skirt_yz;

// Namespace character_jup_zombie_base_female_skirt_yz / namespace_d7fd5db8f39ef374
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xff
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_zombie_base_female_skirt_yz";
    
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

// Namespace character_jup_zombie_base_female_skirt_yz / namespace_d7fd5db8f39ef374
// Params 0
// Checksum 0x0, Offset: 0x1a2
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_base";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_base";
    self setmodel( "c_jup_zmb_zombie_base_female_skirt_wrap" );
    self attach( "c_jup_zmb_zombie_base_female_skirt_head_01_yz", "", 1 );
    self.headmodel = "c_jup_zmb_zombie_base_female_skirt_head_01_yz";
    self setclothtype( #"vestheavy" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_base_female_skirt_yz / namespace_d7fd5db8f39ef374
// Params 0
// Checksum 0x0, Offset: 0x264
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_base_female_skirt_yz / namespace_d7fd5db8f39ef374
// Params 0
// Checksum 0x0, Offset: 0x26e
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "c_jup_zmb_zombie_base_female_skirt_wrap" );
    precachemodel( "c_jup_zmb_zombie_base_female_skirt_head_01_yz" );
}

// Namespace character_jup_zombie_base_female_skirt_yz / namespace_d7fd5db8f39ef374
// Params 0
// Checksum 0x0, Offset: 0x295
// Size: 0x9
function precache_cpmp()
{
    precache();
}

