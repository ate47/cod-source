#using scripts\common\utility;

#namespace character_jup_zombie_base_abom_crawler_hvt;

// Namespace character_jup_zombie_base_abom_crawler_hvt / namespace_1f5a670849f389cf
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xe0
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_zombie_base_abom_crawler_hvt";
    
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

// Namespace character_jup_zombie_base_abom_crawler_hvt / namespace_1f5a670849f389cf
// Params 0
// Checksum 0x0, Offset: 0x183
// Size: 0x99
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_base_abom_crawler";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_base";
    self setmodel( "c_jup_zmb_abomination_crawler_hvt" );
    self setclothtype( #"vestheavy" );
    self setgeartype( #"none" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_base_abom_crawler_hvt / namespace_1f5a670849f389cf
// Params 0
// Checksum 0x0, Offset: 0x224
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_base_abom_crawler_hvt / namespace_1f5a670849f389cf
// Params 0
// Checksum 0x0, Offset: 0x22e
// Size: 0x14
function precache_sp()
{
    precache();
    precachemodel( "c_jup_zmb_abomination_crawler_hvt" );
}

// Namespace character_jup_zombie_base_abom_crawler_hvt / namespace_1f5a670849f389cf
// Params 0
// Checksum 0x0, Offset: 0x24a
// Size: 0x9
function precache_cpmp()
{
    precache();
}

