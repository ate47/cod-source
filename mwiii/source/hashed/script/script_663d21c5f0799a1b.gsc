#using scripts\common\utility;

#namespace character_jup_zombie_base_armored_light;

// Namespace character_jup_zombie_base_armored_light / namespace_12a74bdc4e52d6df
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xf5
// Size: 0x9b
function private autoexec init()
{
    character = #"character_jup_zombie_base_armored_light";
    
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

// Namespace character_jup_zombie_base_armored_light / namespace_12a74bdc4e52d6df
// Params 0
// Checksum 0x0, Offset: 0x198
// Size: 0xba
function main()
{
    level.fncharacterprecache = undefined;
    self.animationarchetype = "zombie_base";
    self.voice = #"unitedstates";
    self.bhasthighholster = 0;
    self.animtree = "zombie_base";
    self setmodel( "c_jup_zmb_zombie_base_armored_light" );
    self attach( "c_jup_zmb_zombie_base_armored_light_head", "", 1 );
    self.headmodel = "c_jup_zmb_zombie_base_armored_light_head";
    self setclothtype( #"vestheavy" );
    self setgeartype( #"millghtgr" );
    self setbagtype( #"none" );
    
    if ( issentient( self ) )
    {
        self sethitlocdamagetable( %"hash_16c36cf98afe63cd" );
    }
}

// Namespace character_jup_zombie_base_armored_light / namespace_12a74bdc4e52d6df
// Params 0
// Checksum 0x0, Offset: 0x25a
// Size: 0x2
function precache()
{
    
}

// Namespace character_jup_zombie_base_armored_light / namespace_12a74bdc4e52d6df
// Params 0
// Checksum 0x0, Offset: 0x264
// Size: 0x1f
function precache_sp()
{
    precache();
    precachemodel( "c_jup_zmb_zombie_base_armored_light" );
    precachemodel( "c_jup_zmb_zombie_base_armored_light_head" );
}

// Namespace character_jup_zombie_base_armored_light / namespace_12a74bdc4e52d6df
// Params 0
// Checksum 0x0, Offset: 0x28b
// Size: 0x9
function precache_cpmp()
{
    precache();
}

